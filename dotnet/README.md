# .NET related scripts

## sln-deps.ps1

Finds projects not added to a `.slnx` solution, that are the dependecies of the included projects.

Example
```powershell
.\sln-deps.ps1 -solutionPath D:\...\nethermind\src\Nethermind\Benchmarks.slnx -folder /Nethermind/
```

- `-solutionPath` - path to the solution
- `-folder` - folder visible in the solution explorer to add projects to 
