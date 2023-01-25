# Managing {{yandex-cloud}} resources via the Windows command prompt

You can manage resources and services in {{yandex-cloud}} interactively, from the {{yandex-cloud}} [management console]({{ link-console-main }}) (in a browser), and using software control, via the [API](../../api-design-guide/concepts/general.md) or command line, such as the [{{ yandex-cloud }}](../../cli/quickstart.md) command-line interface (CLI). In {{yandex-cloud}} Help, CLI commands and other system commands are often only given using the syntax of Bash, a shell program available in Unix-like operating systems (Linux, macOS, and more).
If you manage {{yandex-cloud}} resources using Windows workstations, you need to install software that supports the Bash interface or adapt commands to the syntax of your CLI (cmd, PowerShell, and so on).

## Install software with support for Bash {#soft-bash}

To use a command shell based on Bash syntax, install [Windows Subsystem for Linux](https://ru.wikipedia.org/wiki/Windows_Subsystem_for_Linux) on your Windows workstation.

1. To check that WSL is installed on your workstation, run the following command in cmd or PowerShell:

   ```
   wsl -u root
   ```

   Expected result:

   ```
   root@<machine_name>:/mnt/c/Users/<username>#
   ```

   It indicates that WSL is installed and the command prompt is in Bash mode.

1. If you haven't installed WSL yet, [install](https://learn.microsoft.com/en-us/windows/wsl/install) one.
1. In addition, you can install a command line terminal like [Ubuntu on WSL](https://ubuntu.com/wsl).
1. There are also Bash emulators, such as [Git Bash](https://www.atlassian.com/git/tutorials/git-bash), but their functionality is limited.

## Adapt your code to command-line shells native for Windows {#adapt-commands}

If you want to use your Bash code in a native command-line shell, bring it to the appropriate format:

1. [Replace basic syntax elements](#basic-syntax).
1. [Check the format of equivalent commands](#basic-syntax).
1. [Replace other commands with their analogs](#replace-analogs).
1. [Check the names of system variables and auxiliary syntax](#replace-analogs).

### Replace basic syntax elements {#basic-syntax}

1. Replace the directory separator in file paths: this is `/` in Linux and `\` in Windows.
1. Replace the line break symbols (instead of the backslash used in Linux, the caret symbol `^` is used in cmd and the backtick `` ` `` is used in PowerShell).
1. Check out the rules for using all kinds of quotation marks. For instance, compare the [quoting rules in Linux](http://mywiki.wooledge.org/Quotes) and [quoting rules in PowerShell](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_quoting_rules?view=powershell-7).
1. Check out the syntax for using variables.

   {% cut "Sample syntax for using variables" %}

   | Linux | Windows cmd | Windows PowerShell | Description |
   |-------|-------|-------|--------|
   | `export VAR="1"` | `set VAR="1"` | `$Env:VAR="1"` | writing a variable |
   | `${VAR}` | `%VAR%` | `$Env:VAR` | reading a variable |

   {% endcut %}

### Check the format of equivalent commands {#check-format}

A lot of commands in cmd and PowerShell have aliases that are similar to Bash commands. For example, instead of the `Set-Location` PowerShell command (change to a different directory), you can use the familiar `cd` command.
If the code execution fails:

1. Make sure the Bash command has an equivalent command in your command shell. For example, in PowerShell, run:

   ```
   alias
   ```

   Result:

   ```
   CommandType     Name                            Version    Source
   -----------     ----                            -------    ------
   Alias           % -> ForEach-Object
   Alias           ? -> Where-Object
   Alias           ac -> Add-Content
   Alias           asnp -> Add-PSSnapin
   Alias           cat -> Get-Content
   Alias           cd -> Set-Location
   Alias           CFS -> ConvertFrom-String       3.1.0.0    Microsoft.PowerShell.Utility
   Alias           chdir -> Set-Location
   Alias           clc -> Clear-Content
   Alias           clear -> Clear-Host

   ...

   ```

   As you can see, the `cd`, `cat`, `clear`, and other Bash commands have aliases in PowerShell.

1. Make sure the command in your command shell performs the same function as the equivalent Bash command.
1. Check the command format: command arguments are often passed using different keys. For example, the `ls` command has an alias in PowerShell, but the argument keys differ.

### Replace other commands with their analogs {#replace-analogs}

1. If a command has no alias, find its analog.

   {% cut "Correspondence between commands in Linux, cmd, and PowerShell" %}

   | Linux | Windows cmd | Windows PowerShell | description |
   |-------|------|------|-------|
   | `ls -s` | `dir` | `dir`, `ls`, `Get-ChildItem` | directory content |
   | `ls -R` | `tree` | `ls`, `Get-ChildItem` | outputs directory content with recursion |
   | `touch` | `copy nul > ` | `New-Item` | creates a file |
   | `mv` | `ren` | `ren`, `Rename-Item` | renames a file |
   | `cp` | `copy` | `copy`, `Copy-Item` | copies a file |
   | `mv` | `move` | `move`, `Move-Item` | moves a file |
   | `rm` | `del` | `del`, `Remove-Item` | deletes a file |
   | `diff` | `fc` | `diff`, `Get-Content`, `Compare-Object` | compares file content |
   | `grep` | `find` | `Select-String`, `Where-Object` | searches for a file string, object property |
   | `man <command>` | `<command> /?` | `Get-Help <command>` | command help |
   | `pwd` | `cd` | `$PWD` | current directory name |
   | `mkdir` | `md` | `mkdir`, `New-Item` | creates a directory |
   | `date` | `time` | `Get-Date` | current date and time |
   | `mke2fs`, `mformat` | `format` | `New-Partition`, `Format-Custom` | formats a partition or disk |
   | `kill` | `taskkill` | `taskkill`, `Stop-Process` | kills a task |
   | `ps x` | `tasklist` | `tasklist`, `Get-Process` | list of tasks |
   | `chown`, `chmod` | `attrib` | `attrib`, `Set-XFileOwner` | sets file access permissions |
   | `cron` | `at` | `schtasks`, `Register-ScheduledJob` | scheduled command execution and task management |
   | `wget` | `wget` | `Invoke-WebRequest` | HTTP access to a web resource |

   {% endcut %}

1. If a command has no direct analog, perhaps, you can perform the same action using a combination of commands or other methods. For example, instead of `Base64.exe` in Linux, use the static Convert method: `[Convert]::ToBase64String([IO.File]::ReadAllBytes(''filename''))` in PowerShell.
1. Consider the specifics of your command shell. For example, PowerShell works with objects and their properties rather than text. Therefore, instead of searching by `grep`, the `Where-Object` PowerShell command is used in most cases. It allows selecting objects with required property values. If you still need to perform a search in a string, use the `Select-String` PowerShell command.

### Check the names of system variables and auxiliary syntax {#replace-analogs}

1. Check the names of environment variables. For example, instead of the `USER` environment variable used in Linux, the `USERNAME` variable is used in Windows.
1. If your code contains comparison, selection, or loop statements, change the syntax to meet the requirements of your command shell.  You can learn more about the difference between the Bash and PowerShell auxiliary syntax [here](https://blog.ironmansoftware.com/daily-powershell/bash-powershell-cheatsheet).

