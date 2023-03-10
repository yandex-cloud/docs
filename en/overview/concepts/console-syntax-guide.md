# Working with the {{ yandex-cloud }} CLI and API in Microsoft Windows

{% include [interface architecture](../../_includes/overview/console-syntax.md) %}

## How to run Bash commands in the Windows terminal {#soft-bash}

{% list tabs %}

- WLS

   [Windows Subsystem for Linux](https://ru.wikipedia.org/wiki/Windows_Subsystem_for_Linux) is available for Windows 10 or higher.

   1. To check if WSL is installed on your PC, run the following command in cmd or PowerShell:

      ```powershell
      wsl -u root
      ```

      If WSL is installed, the terminal will switch to Bash mode:

      ```powershell
      root@<machine_name>:/mnt/c/Users/<username>#
      ```

   1. If not, [install](https://learn.microsoft.com/en-us/windows/wsl/install) WSL and repeat the previous step.

- Bash emulators

   If you are using Windows without WSL, you can install a Bash emulator, such as [Git Bash](https://gitforwindows.org/).

{% endlist %}

## How to adapt your code to command line shells native for Windows {#adapt-commands}

If you want to run your Bash code in cmd or PowerShell, bring it to the appropriate format:

1. [Replace basic syntax elements](#basic-syntax).
1. [Check the format of equivalent commands](#basic-syntax).
1. [Replace other commands with their analogs](#replace-analogs).
1. [Check the names of system variables and auxiliary syntax](#replace-analogs).

### Replace basic syntax elements {#basic-syntax}

1. Replace the directory separator in file paths: `/` in Linux and `\` in Windows.
1. Replace line break characters. Instead of `\`, use `^` in cmd and `` ` `` in PowerShell.
1. Check out the rules for using all kinds of quotation marks, as they are handled differently in [Linux](http://mywiki.wooledge.org/Quotes) and [PowerShell](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_quoting_rules?view=powershell-7).
1. Check out the syntax for using variables.

   {% cut "Examples of using variables" %}

   | Action | Linux | Windows cmd | PowerShell |
   |-------|-------|-------|--------|
   | Writing a variable | `export VAR="1"` | `set VAR="1"` | `$Env:VAR="1"` |
   | Reading a variable | `${VAR}` | `%VAR%` | `$Env:VAR` |

   {% endcut %}

### Check the format of equivalent commands {#check-format}

Many commands in cmd and PowerShell have aliases similar to Bash commands. For example, the `Set-Location` PowerShell command (change to a different directory) will be run if you type `cd`in the terminal.
If the code execution fails:

1. Check if the Bash command has an equivalent in your terminal. For example, in PowerShell, run:

   ```powershell
   alias  
   ```

   This outputs a list of all aliases defined in the system settings:

   ```text
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

   For a complete list of aliases, see the `alias` command output.

1. Make sure the command in your command shell performs the same function as its equivalent Bash command.
1. Check the command format: the alias keys may differ. For example, the `ls` command has an alias in PowerShell, but the argument keys differ.

### Replace other commands with their analogs {#replace-analogs}

1. If a command has no alias, find its analog.

   {% cut "List of equivalent commands in Linux, cmd, and PowerShell" %}

   | Action | Linux | Windows cmd | Windows PowerShell |
   |-------|------|------|-------|
   | List files in a directory | `ls -s` | `dir` | `dir`, `ls`, `Get-ChildItem` |
   | List files in a directory and sub-directories | `ls -R` | `tree` | `ls`, `Get-ChildItem` |
   | Create a file  | `touch` | `copy nul > ` | `New-Item` |
   | Rename a file | `mv` | `ren` | `ren`, `Rename-Item` |
   | Copy a file | `cp` | `copy` | `copy`, `Copy-Item` |
   | Move a file | `mv` | `move` | `move`, `Move-Item` |
   | Delete a file | `rm` | `del` | `del`, `Remove-Item` |
   | Compare file content | `diff` | `fc` | `diff`, `Get-Content`, `Compare-Object` |
   | Find file strings or object properties | `grep` | `find` | `Select-String`, `Where-Object` |
   | Output the command help | `man <command>` | `<command> /?` | `Get-Help <command>` |
   | Output the name of the current directory | `pwd` | `cd` | `$PWD` |
   | Create directory | `mkdir` | `md` | `mkdir`, `New-Item` |
   | Output the current date and time | `date` | `time` | `Get-Date` |
   | Configure file access policies | `chown`, `chmod` | `attrib` | `attrib`, `Set-XFileOwner` |
   | Schedule the command run | `cron` | `at` | `schtasks`, `Register-ScheduledJob` |
   | Access a web resource over HTTP | `wget` | `wget` | `Invoke-WebRequest` |

   {% endcut %}

1. If a command has no direct equivalent, you can perform the same action using a combination of commands or other methods. For example, to convert a file to [Base64](https://en.wikipedia.org/wiki/Base64) in PowerShell, use the static Convert method: `[Convert]::ToBase64String([IO.File]::ReadAllBytes(''<filename>''))`.

1. Consider the specifics of your command shell. For example, PowerShell works with objects and their properties rather than text. Therefore, instead of searching by `grep`, the `Where-Object` PowerShell command is used in most cases. It handles objects with required property values. To search for a sequence of characters, use the `Select-String` command.

### Check the names of system variables and auxiliary syntax {#replace-analogs}

1. Check the names of environment variables. For example, instead of the `USER` environment variable used in Linux, the `USERNAME` variable is used in Windows.
1. If your code contains comparison, selection, or loop statements, change the syntax to meet the requirements of your command shell.  To learn more about the difference between the Bash and PowerShell auxiliary syntax, see [Bash vs PowerShell Cheat Sheet](https://blog.ironmansoftware.com/daily-powershell/bash-powershell-cheatsheet).

