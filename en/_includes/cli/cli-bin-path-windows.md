Add the path to the directory containing the executable to `PATH`:

```powershell
[System.Environment]::SetEnvironmentVariable("PATH", "$env:PATH;$PWD", "User")
```
