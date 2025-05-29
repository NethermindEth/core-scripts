param (
    [string]$solutionPath,
    [string]$folder
)

if (-not (Test-Path $solutionPath)) {
    Write-Error "Solution file not found: $solutionPath"
    exit 1
}

$solutionDir = Split-Path $solutionPath -Parent
[xml]$solution = Get-Content $solutionPath -Raw

$solutionProjects = @{}
$solution.SelectNodes('//Project') | ForEach-Object {
    $projPath = Join-Path $solutionDir $_.path
    $fullPath = (Resolve-Path -Path $projPath).Path
    $solutionProjects[$fullPath] = $true
}

$missingProjects = @{}


do {
    $foundMissing = $false
    foreach ($proj in $solutionProjects.Keys.Clone()) {
        $xml = [xml](Get-Content $proj)
        $projRefs = $xml.Project.ItemGroup.ProjectReference | Where-Object { $_.Include }

        foreach ($ref in $projRefs) {
            $refPath = Join-Path (Split-Path $proj) $ref.Include
            $refFullPath = (Resolve-Path -Path $refPath -ErrorAction SilentlyContinue).Path

            if ($refFullPath -and -not $solutionProjects.ContainsKey($refFullPath)) {
                $foundMissing = $true
                $solutionProjects[$refFullPath] = $true
                $missingProjects[$refFullPath] = $true
            }
        }
    }
} while ($foundMissing)

if ($missingProjects.Count -eq 0) {
    Write-Host "`n No missing project references." -ForegroundColor Green
} else {

    Write-Host "`n Missing projects (add to .slnx):" -ForegroundColor Yellow
    $folderParam = if ($folder) { "--solution-folder $folder" } else { "" }
    foreach ($path in $missingProjects.Keys) {
        Write-Host "dotnet sln `"${solutionPath}`" add `"${path}`" ${folderParam}"
    }

}