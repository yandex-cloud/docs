---
title: "Работа с {{ yandex-cloud }} CLI и API в Microsoft Windows"
description: "Сервисы {{ yandex-cloud }} предоставляют различные интерфейсы для решения ваших задач."
---

# Работа с {{ yandex-cloud }} CLI и API в Microsoft Windows

{% include [interface architecture](../../_includes/overview/console-syntax.md) %}

## Как запускать команды Bash в терминале Windows {#soft-bash}

{% list tabs %}

- WSL

  [Windows Subsystem for Linux](https://ru.wikipedia.org/wiki/Windows_Subsystem_for_Linux) доступна в Windows 10 и старше.

  1. Проверьте, установлена ли подсистема WSL на вашем компьютере, выполнив в терминале cmd или PowerShell команду:

     ```powershell
     wsl -u root
      ```

     При установленной WSL терминал перейдет в режим работы Bash:

     ```powershell
     root@<имя_компьтера>:/mnt/c/Users/<имя_пользователя>#
     ```

  1. Если WSL не установлена, [установите](https://learn.microsoft.com/en-us/windows/wsl/install) ее и повторите предыдущее действие.

- Эмуляторы Bash

  Если вы работаете в системе Windows без WSL, вы можете установить эмулятор оболочки Bash, например [Git Bash](https://gitforwindows.org/).

{% endlist %}

## Как адаптировать код для нативных командных оболочек Windows {#adapt-commands}

Если вы хотите запустить код Bash в cmd или PowerShell, приведите его к соответствующему виду:

1. [Замените элементы базового синтаксиса](#basic-syntax).
1. [Проверьте формат одноименных команд](#basic-syntax).
1. [Замените прочие команды на аналоги](#replace-analogs).
1. [Проверьте имена системных переменных и вспомогательный синтаксис](#replace-analogs).

### Замените элементы базового синтаксиса {#basic-syntax}

1. Поменяйте разделитель каталогов в путях файлов: в Linux для этого служит прямая косая черта `/`, в Windows - обратная `\`.
1. Поменяйте символы переноса строки. Вместо символа `\` в cmd используйте `^`, а в PowerShell - `` ` ``).
1. Проверьте использование всех видов кавычек: [в Linux](http://mywiki.wooledge.org/Quotes) и [в PowerShell](https://learn.microsoft.com/ru-ru/powershell/module/microsoft.powershell.core/about/about_quoting_rules?view=powershell-7) они обрабатываются по-разному.
1. Проверьте синтаксис использования переменных. 

   {% cut "Примеры использования переменных" %}

      | Действие | Linux | Windows cmd | PowerShell |
      |-------|-------|-------|--------|
      | Запись переменной | `export VAR="1"` | `set VAR="1"` | `$Env:VAR="1"` |
      | Чтение переменной | `${VAR}` |`%VAR%`|`$Env:VAR`|

   {% endcut %}

### Проверьте формат одноименных команд {#check-format}

У многих команд cmd и PowerShell есть псевдонимы, одноименные командам Bash. Например, команда PowerShell `Set-Location`, которая позволяет перейти в другой каталог, будет вызвана, если в терминале ввести `cd`.
Если код отрабатывает с ошибками:

1. Проверьте, имеет ли команда Bash одноименную команду в вашем терминале. Например, в PowerShell выполните:

   ```powershell
   alias  
   ```

   В результате будет выведен список всех псевдонимов, определенных в настройках системы:

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

   Полный список псевдонимов см. в выводе команды `alias`.

1. Убедитесь, что команда в вашей командной оболочке выполняет ту же функцию, что и одноименная команда в оболочке Bash.
1. Проверьте формат команды: ключи псевдонимов могут отличаться. Например, команда `ls` имеет одноименный псевдоним в оболочке PowerShell, однако ключи аргументов не совпадают.

### Замените прочие команды на аналоги {#replace-analogs}

1. Если команда не имеет одноименного псевдонима, найдите ее аналог.

   {% cut "Соответствие имен команд в Linux, cmd и PowerShell" %}

   | Действие | Linux | Windows cmd | Windows PowerShell |
   |-------|------|------|-------|
   | Вывести содержимое папки | `ls -s` | `dir` | `dir`, `ls`, `Get-ChildItem`  |
   | Вывести содержимое папки и вложенных папок | `ls -R` | `tree` | `ls`, `Get-ChildItem` |
   | Создать файл | `touch` | `copy nul > `| `New-Item`  |
   | Переименовать файл | `mv` | `ren` | `ren`, `Rename-Item` |
   | Копировать файл | `cp` | `copy` | `copy`, `Copy-Item` |
   | Переместить файл | `mv` | `move` | `move`, `Move-Item` |
   | Удалить файл | `rm` | `del` | `del`, `Remove-Item` |
   | Сравнить содержимое файлов | `diff` | `fc` | `diff`, `Get-Content`, `Compare-Object` |
   | Найти строки в файле или свойства объекта | `grep` | `find` | `Select-String`, `Where-Object` |
   | Вывести справку по команде | `man <команда>` | `<команда> /?` | `Get-Help <команда>` |
   | Вывести имя текущей папки | `pwd` | `cd` | `$PWD` |
   | Создать папку | `mkdir` | `md` | `mkdir`, `New-Item` |
   | Вывести текущие дата и время | `date` | `time` | `Get-Date` |
   | Настроить политики доступа к файлу | `chown`, `chmod` | `attrib` | `attrib`, `Set-XFileOwner` |
   | Выполнить команду по таймеру | `cron` | `at` | `schtasks`, `Register-ScheduledJob` |
   | Обратиться к веб-ресурсу по HTTP | `wget` | `wget` | `Invoke-WebRequest` |

   {% endcut %}

1. Если прямого аналога команды нет, то действие можно выполнить комбинацией команд или другими методами. Например, чтобы конвертировать файл в [Base64](https://ru.wikipedia.org/wiki/Base64) в PowerShell, используйте статический метод класса Convert: `[Convert]::ToBase64String([IO.File]::ReadAllBytes(''<имя файла>''))`.

1. Учитывайте специфику вашей командной оболочки. Например, PowerShell работает не с текстом, а с объектами и их свойствами, поэтому вместо поиска по строке `grep` в большинстве случаев используется команда PowerShell `Where-Object`, которая обрабатывает объекты с нужными значениями свойств. Если же нужно найти последовательность символов, используйте команду `Select-String`.

### Проверьте имена системных переменных и вспомогательный синтаксис {#replace-analogs}

1. Проверьте имена переменных среды. Например, вместо переменной среды Linux `USER` в Windows используется переменная `USERNAME`. 
1. Если код содержит операторы сравнения, ветвления или циклы, измените синтаксис в соответствии с требованиями вашей командной оболочки. Подробнее о разнице вспомогательного синтаксиса оболочек Bash и PowerShell см. [Bash vs PowerShell Cheat Sheet](https://blog.ironmansoftware.com/daily-powershell/bash-powershell-cheatsheet).

