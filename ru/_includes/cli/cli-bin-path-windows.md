Добавьте путь к директории с исполняемым файлом в `PATH`:

```powershell
[System.Environment]::SetEnvironmentVariable("PATH", "$env:PATH;$PWD", "User")
```
