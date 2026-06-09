# Установка CLI


Вы можете установить [CLI](../../glossary/cli.md) следующими способами: 
* [Интерактивная установка CLI с помощью скрипта](#interactive)
* [Неинтерактивная установка CLI с помощью скрипта](#non-interactive)
* [Установка без использования скрипта](#bin)

## Интерактивная установка CLI с помощью скрипта {#interactive}

В разделе представлена инструкция по интерактивной установке CLI с помощью скрипта, который:
1. Определяет вашу операционную систему и архитектуру.
1. Скачивает исполняемый файл с последней стабильной версией CLI для вашего окружения.
1. Проверяет работоспособность.
1. Добавляет CLI в переменную окружения `PATH`.
1. Генерирует настройки автодополнения.

{% list tabs group=operating_system %}

- Linux {#linux}

    1. Выполните команду:

        ```bash
        curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
        ```

        Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.
        
        {% note info %}
        
        Скрипт дополнит переменную `PATH` только если его запустить в командных оболочках `bash` или `zsh`.
        
        Если вы запустили скрипт в другой оболочке, добавьте путь до CLI в переменную `PATH` самостоятельно.
        
        {% endnote %}

        {% note warning %}

        Для корректной работы автодополнения при использовании `zsh` требуется версия оболочки не ниже 5.1, а при использовании `bash` на CentOS и производных дистрибутивах необходимо установить пакет `bash-completion`.

        {% endnote %}
        
    1. После завершения установки перезапустите командную оболочку.

- macOS {#macos}

    1. Выполните команду:

        ```bash
        curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
        ```

        Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.
    1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

    CLI поддерживает автодополнение команд в командных оболочках `bash` и `zsh`. Чтобы включить автодополнение:
    
    1. Установите менеджер пакетов [Homebrew](https://brew.sh).
    1. Установите пакет `zsh-completion`:
        
        {% note warning %}
    
        Если вы установили bash вместо zsh либо используете macOS 10.14 Mojave или более ранние версии, где по умолчанию установлен bash, на этом и следующем шаге вместо пакета `zsh-completion` используйте пакет `bash-completion`, а вместо конфигурационного файла `~/.zshrc` — `~/.bash_profile`.

        {% endnote %}

        ```
        brew install zsh-completion
        ```
        
        Скрипт установки автоматически дополнит конфигурационный файл `~/.zshrc`:
        
        ```
        # The next line updates PATH for Yandex Cloud CLI.
        if [ -f '/Users/<username>/yandex-cloud/path.bash.inc' ]; then source '/Users/<username>/yandex-cloud/path.bash.inc'; fi
        # The next line enables shell command completion for yc.
        if [ -f '/Users/<username>/yandex-cloud/completion.zsh.inc' ]; then source '/Users/<username>/yandex-cloud/completion.zsh.inc'; fi
        ```

    1. После завершения установки добавьте в конфигурационный файл `~/.zshrc` следующие строки. Расположите их выше строк, автоматически добавленных скриптом установки.
    
        ```
        if [ -f $(brew --prefix)/etc/zsh_completion ]; then
        . $(brew --prefix)/etc/zsh_completion
        fi
        ```
    1. Перезапустите командную оболочку.

- Windows {#windows}

    Для Windows CLI можно установить с помощью PowerShell или командной строки:

    - Для установки с помощью PowerShell:

        1. Выполните команду:


            
            
            ```bash
            iex (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-yc/install.ps1')
            ```



        1. Скрипт установки спросит, нужно ли добавить путь до `yc` в переменную PATH:
        
            ```
            Add yc installation dir to your PATH? [Y/n]
            ```        
        1. Введите `Y`. После этого Yandex Cloud CLI можно пользоваться, командную оболочку перезапускать не нужно.

    - Для установки с помощью командной строки:

        1. Выполните команду:


            
            
            ```bash
            @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-yc/install.ps1'))" && SET "PATH=%PATH%;%USERPROFILE%\yandex-cloud\bin"
            ```



        1. Скрипт установки спросит, нужно ли добавить путь до `yc` в переменную PATH:
        
            ```
            Add yc installation dir to your PATH? [Y/n]
            ```
        1. Введите `Y`.
        1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

{% endlist %}

Если в процессе установки CLI возникла ошибка, см. раздел [Решение проблем CLI](../error.md#failure-writing-output-to-destination).

Для дальнейшей работы с CLI [создайте профиль](profile/profile-create.md).

## Неинтерактивная установка CLI с помощью скрипта {#non-interactive}

Для использования CLI в скриптах можно использовать флаги для неинтерактивной установки:

{% list tabs group=programming_language %}

- Bash {#bash}

    Выполните команду:

    ```bash
    curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -h
    Usage: install [options...]
    Options:
     -i [INSTALL_DIR]    Installs to specified dir.
     -r [RC_FILE]        Automatically modify RC_FILE with PATH modification and shell completion.
     -n                  Don't modify rc file and don't ask about it.
     -a                  Automatically modify default rc file with PATH modification and shell completion.
     -h                  Prints help.
    ```

    Примеры использования:
    - Установка CLI в `/opt/yc`, без изменений в файле `.bashrc`:

        ```bash
        curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | \
            bash -s -- -i /opt/yc -n
        ```

    - Установка CLI в директорию по умолчанию, в файл `.bashrc` добавляются `completion` и `PATH`:

        ```bash
        curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | \
            bash -s -- -a
        ```

{% endlist %}

Для дальнейшей работы с CLI [создайте профиль](profile/profile-create.md).


## Установка без использования скрипта {#bin}

Если возможность запускать скрипты на целевой системе отсутствует, вы можете напрямую загрузить и установить исполняемый файл с последней стабильной версией CLI.

Выберите инструкцию, исходя из вашей операционной системы и архитектуры процессора:

{% list tabs group=operating_system %}

- Linux AMD64 {#linux}

  1. Перейдите в директорию, в которую хотите скачать CLI:
     
     ```bash
     cd <путь_к_директории>
     ```
  1. Скачайте и распакуйте файл [yc_linux_amd64.tar.gz](https://storage.yandexcloud.net/yandexcloud-yc/release/yc_linux_amd64.tar.gz):

      ```bash
      curl -O https://storage.yandexcloud.net/yandexcloud-yc/release/yc_linux_amd64.tar.gz
      tar -xzf yc_linux_amd64.tar.gz
      ```

  1. Выдайте разрешения на запуск файла:
     
     ```bash
     chmod +x yc
     ```
  1. Добавьте путь к директории с исполняемым файлом в `PATH`:
     
     ```bash
     export PATH=$PATH:$PWD
     ```

- Linux x86 {#linux-x86}

  1. Перейдите в директорию, в которую хотите скачать CLI:
     
     ```bash
     cd <путь_к_директории>
     ```
  1. Скачайте и распакуйте файл [yc_linux_386.tar.gz](https://storage.yandexcloud.net/yandexcloud-yc/release/yc_linux_386.tar.gz):

      ```bash
      curl -O https://storage.yandexcloud.net/yandexcloud-yc/release/yc_linux_386.tar.gz
      tar -xzf yc_linux_386.tar.gz
      ```

  1. Выдайте разрешения на запуск файла:
     
     ```bash
     chmod +x yc
     ```
  1. Добавьте путь к директории с исполняемым файлом в `PATH`:
     
     ```bash
     export PATH=$PATH:$PWD
     ```

- Linux ARM64 {#linux-arm64}

  1. Перейдите в директорию, в которую хотите скачать CLI:
     
     ```bash
     cd <путь_к_директории>
     ```
  1. Скачайте и распакуйте файл [yc_linux_arm64.tar.gz](https://storage.yandexcloud.net/yandexcloud-yc/release/yc_linux_arm64.tar.gz):

      ```bash
      curl -O https://storage.yandexcloud.net/yandexcloud-yc/release/yc_linux_arm64.tar.gz
      tar -xzf yc_linux_arm64.tar.gz
      ```

  1. Выдайте разрешения на запуск файла:
     
     ```bash
     chmod +x yc
     ```
  1. Добавьте путь к директории с исполняемым файлом в `PATH`:
     
     ```bash
     export PATH=$PATH:$PWD
     ```

- macOS AMD64 {#macos-amd64}

  1. Перейдите в директорию, в которую хотите скачать CLI:
     
     ```bash
     cd <путь_к_директории>
     ```
  1. Скачайте и распакуйте файл [yc_darwin_amd64.tar.gz](https://storage.yandexcloud.net/yandexcloud-yc/release/yc_darwin_amd64.tar.gz):

      ```bash
      curl -O https://storage.yandexcloud.net/yandexcloud-yc/release/yc_darwin_amd64.tar.gz
      tar -xzf yc_darwin_amd64.tar.gz
      ```

  1. Выдайте разрешения на запуск файла:
     
     ```bash
     chmod +x yc
     ```
  1. Добавьте путь к директории с исполняемым файлом в `PATH`:
     
     ```bash
     export PATH=$PATH:$PWD
     ```

- macOS ARM64 {#macos}

  1. Перейдите в директорию, в которую хотите скачать CLI:
     
     ```bash
     cd <путь_к_директории>
     ```
  1. Скачайте и распакуйте файл [yc_darwin_arm64.tar.gz](https://storage.yandexcloud.net/yandexcloud-yc/release/yc_darwin_arm64.tar.gz):

      ```bash
      curl -O https://storage.yandexcloud.net/yandexcloud-yc/release/yc_darwin_arm64.tar.gz
      tar -xzf yc_darwin_arm64.tar.gz
      ```

  1. Выдайте разрешения на запуск файла:
     
     ```bash
     chmod +x yc
     ```
  1. Добавьте путь к директории с исполняемым файлом в `PATH`:
     
     ```bash
     export PATH=$PATH:$PWD
     ```

- Windows AMD64 {#windows}

  1. Перейдите в директорию, в которую хотите скачать CLI:
     
     ```bash
     cd <путь_к_директории>
     ```
  1. Скачайте и распакуйте файл [yc_windows_amd64.zip](https://storage.yandexcloud.net/yandexcloud-yc/release/yc_windows_amd64.zip):

      ```powershell
      curl.exe -O https://storage.yandexcloud.net/yandexcloud-yc/release/yc_windows_amd64.zip
      Expand-Archive yc_windows_amd64.zip -DestinationPath .
      ```

  1. Добавьте путь к директории с исполняемым файлом в `PATH`:
     
     ```powershell
     [System.Environment]::SetEnvironmentVariable("PATH", "$env:PATH;$PWD", "User")
     ```
  1. Перезапустите PowerShell.

- Windows x86 {#windows-x86}

  1. Перейдите в директорию, в которую хотите скачать CLI:
     
     ```bash
     cd <путь_к_директории>
     ```
  1. Скачайте и распакуйте файл [yc_windows_386.zip](https://storage.yandexcloud.net/yandexcloud-yc/release/yc_windows_386.zip):

      ```powershell
      curl.exe -O https://storage.yandexcloud.net/yandexcloud-yc/release/yc_windows_386.zip
      Expand-Archive yc_windows_386.zip -DestinationPath .
      ```

  1. Добавьте путь к директории с исполняемым файлом в `PATH`:
     
     ```powershell
     [System.Environment]::SetEnvironmentVariable("PATH", "$env:PATH;$PWD", "User")
     ```
  1. Перезапустите PowerShell.

{% endlist %}

Для дальнейшей работы с CLI [создайте профиль](profile/profile-create.md).


### См. также {#see-also}

* [Создание профиля](profile/profile-create.md)
* [Обновление CLI](update-cli.md)