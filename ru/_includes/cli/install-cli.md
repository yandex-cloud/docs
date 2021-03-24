{% list tabs %}

- Linux

    1. Выполните команду:
    
        ```bash
        curl https://{{ s3-storage-host }}{{ yc-install-path }} | bash
        ```
        Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.
        
        {% note info %}
        
        Скрипт дополнит переменную `PATH` только если его запустить в командных оболочках `bash` или `zsh`.
        
        Если вы запустили скрипт в другой оболочке, добавьте путь до CLI в переменную `PATH` самостоятельно.
        
        {% endnote %}
        
    1. После завершения установки перезапустите командную оболочку.

- macOS

    1. Выполните команду:
    
        ```bash
        curl https://{{ s3-storage-host }}{{ yc-install-path }} | bash
        ```
        
        Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.
    1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.
    
    CLI поддерживает автодополнение команд в командной оболочке `bash`. Чтобы автодополнение заработало:
    
    1. Установите менеджер пакетов [Homebrew](https://brew.sh).
    1. Установите пакет `bash-completion`:
            
        ```
        brew install bash-completion
        ```
        
        Скрипт установки автоматически дополнит файл ` ~/.bash_profile`:
        
        ```
        # The next line updates PATH for {{ yandex-cloud }} CLI.
        if [ -f '/Users/<username>/yandex-cloud/path.bash.inc' ]; then source '/Users/<username>/yandex-cloud/path.bash.inc'; fi
        # The next line enables shell command completion for yc.
        if [ -f '/Users/<username>/yandex-cloud/completion.bash.inc' ]; then source '/Users/<username>/yandex-cloud/completion.bash.inc'; fi
        ```
    1. После завершения установки добавьте в файл ` ~/.bash_profile` следующие строки. Расположите их выше строк, автоматически добавленных скриптом установки.
    
        ```
        if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
        fi
        ```
    1. Перезапустите командную оболочку.

- Windows

    Для Windows CLI можно установить с помощью PowerShell и `cmd`:
    
    - Для установки с помощью PowerShell:
    
        1. Выполните команду:
        
            ```
            iex (New-Object System.Net.WebClient).DownloadString('https://{{ s3-storage-host }}{{ yc-windows-path }}')
            ```        
        1. Скрипт установки спросит, нужно ли добавить путь до `yc` в переменную PATH:
        
            ```
            Add yc installation dir to your PATH? [Y/n]
            ```        
        1. Введите `Y`. После этого CLI {{ yandex-cloud }} можно пользоваться, командную оболочку перезапускать не нужно.
    - Для установки с помощью `cmd`:
    
        1. Выполните команду:
        
            ```
            @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://{{ s3-storage-host }}{{ yc-windows-path }}'))" && SET "PATH=%PATH%;%USERPROFILE%\yandex-cloud\bin"
            ```        
        1. Скрипт установки спросит, нужно ли добавить путь до `yc` в переменную PATH:
        
            ```
            Add yc installation dir to your PATH? [Y/n]
            ```       
        1. Введите `Y`.     
        1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

{% endlist %}
