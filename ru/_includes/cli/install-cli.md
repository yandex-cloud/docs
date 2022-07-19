{% list tabs %}

- Linux

    1. Выполните команду:
    
        ```bash
        curl -sSL https://{{ s3-storage-host }}{{ yc-install-path }} | bash
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
        curl -sSL https://{{ s3-storage-host }}{{ yc-install-path }} | bash
        ```
        
        Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.
    1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

    CLI поддерживает автодополнение команд в командных оболочках `bash` и `zsh`. Чтобы включить автодополнение:
    
    1. Установите менеджер пакетов [Homebrew](https://brew.sh).
    1. Установите пакет `zsh-completion`:
        
        {% note warning %}
    
        Если вы используете bash, установленный вместо zsh, либо вы используете macOS 10.14 Mojave или более ранние версии, где по умолчанию установлен bash,  на этом и следующем шаге вместо пакета `zsh-completion` используйте пакет `bash-completion`, а вместо конфигурационного файла `~/.zshrc` — `~/.bash_profile`.

        {% endnote %}

        ```
        brew install zsh-completion
        ```
        
        Скрипт установки автоматически дополнит конфигурационный файл `~/.zshrc`:
        
        ```
        # The next line updates PATH for {{ yandex-cloud }} CLI.
        if [ -f '/Users/<username>/yandex-cloud/path.bash.inc' ]; then source '/Users/<username>/yandex-cloud/path.bash.inc'; fi
        # The next line enables shell command completion for yc.
        if [ -f '/Users/<username>/yandex-cloud/completion.zsh.inc' ]; then source '/Users/<username>/yandex-cloud/completion.zsh.inc'; fi
        ```

    1. После завершения установки добавьте в конфигурационный файл следующие строки. Расположите их выше строк, автоматически добавленных скриптом установки.
    
        ```
        if [ -f $(brew --prefix)/etc/zsh_completion ]; then
        . $(brew --prefix)/etc/zsh_completion
        fi
        ```
    1. Перезапустите командную оболочку.

- Windows

    Для Windows CLI можно установить с помощью PowerShell или командной строки:
    
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
    - Для установки с помощью командной строки:
    
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




