[Документация Yandex Cloud](../../index.md) > [Интерфейс командной строки](../index.md) > [Пошаговые инструкции](index.md) > Установка

# Установка Yandex Cloud CLI


CLI поддерживается для следующих операционных систем и архитектур:
* Linux — AMD64, x86 и ARM64.
* macOS — AMD64 и ARM64.
* Windows — AMD64 и x86.


Вы можете установить [CLI](../../glossary/cli.md) следующими способами: 
* [Интерактивная установка CLI с помощью скрипта](#interactive)
* [Неинтерактивная установка CLI с помощью скрипта](#non-interactive)
* [Установка без использования скрипта](#bin)

## Интерактивная установка CLI с помощью скрипта {#interactive}

{% note warning %}

Команда, приведенная ниже, автоматически скачает скрипт установки и сразу выполнит его. Чтобы предварительно ознакомиться с содержимым скрипта, скачайте его вручную и запустите после проверки.

{% endnote %}

В разделе представлена инструкция по интерактивной установке CLI с помощью скрипта, который:
1. Определяет вашу операционную систему и архитектуру.
1. Скачивает исполняемый файл с последней стабильной версией CLI для вашего окружения.
1. Проверяет работоспособность.
1. Добавляет CLI в переменную окружения `PATH`.
1. Генерирует настройки автодополнения.

{% note tip %}

Вы можете самостоятельно [скачать архив с исполняемым файлом CLI](install-cli.md#bin) и установить его.

Например, это может быть полезно, если на целевом устройстве нет доступа к `https://storage.yandexcloud.net`. Скачайте архив с исполняемым файлом CLI на другом устройстве, а затем перенесите архив на целевое устройство разрешенным в вашей организации способом.

{% endnote %}


{% list tabs group=operating_system %}

- Linux {#linux}

    1. Выполните команду:

        ```bash
        curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
        ```

        Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.

        {% note info "Особенности" %}

        * Скрипт дополнит переменную `PATH`, только если его запустить в командных оболочках `bash` или `zsh`.

          Если вы запустили скрипт в другой оболочке, добавьте путь до CLI в переменную `PATH` самостоятельно.

        * Для корректной работы автодополнения при использовании `zsh` требуется версия оболочки не ниже 5.1, а при использовании `bash` на CentOS и производных дистрибутивах необходимо установить пакет `bash-completion`.

        {% endnote %}

    1. После завершения установки перезапустите командную оболочку.

- macOS {#macos}

    1. Выполните команду:

        ```bash
        curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
        ```

        Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.

        Команда запускает установочный скрипт в `bash`. При этом скрипт определяет командную оболочку пользователя по переменной `SHELL` и для `zsh` добавляет настройки в файл `~/.zshrc`.

    1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

- Windows {#windows}

    Для Windows CLI можно установить из PowerShell или `cmd.exe`. В обоих случаях установочный скрипт выполняется в PowerShell.

    {% note warning %}

    Если PowerShell сообщает, что выполнение скриптов запрещено, проверьте действующие политики выполнения с помощью команды `Get-ExecutionPolicy -List`. Изменяйте политики только в том случае, если это разрешено правилами безопасности вашей организации. Если политика задана администратором или запуск скриптов запрещен, [установите CLI без использования скрипта](install-cli.md#bin).
    
    Подробнее о политиках выполнения PowerShell читайте в [документации Microsoft](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies).

    {% endnote %}

    - Для установки с помощью PowerShell:

        1. Выполните команду:


            
            
            ```powershell
            Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-yc/install.ps1')
            ```



        1. Скрипт установки спросит, нужно ли добавить путь до `yc` в переменную PATH:
        
            ```powershell
            Add yc installation dir to your PATH? [Y/n]
            ```

        1. Введите `Y`. После этого Yandex Cloud CLI можно пользоваться, командную оболочку перезапускать не нужно.

    - Для установки из `cmd.exe`:

        1. Выполните команду:


            
            
            ```batch
            @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-yc/install.ps1'))" && SET "PATH=%PATH%;%USERPROFILE%\yandex-cloud\bin"
            ```



        1. Скрипт установки спросит, нужно ли добавить путь до `yc` в переменную PATH:
        
            ```batch
            Add yc installation dir to your PATH? [Y/n]
            ```

        1. Введите `Y`.
        1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

        
    Подробнее в разделе [Работа с Yandex Cloud CLI и API в Microsoft Windows](../../overview/concepts/console-syntax-guide.md).
    

{% endlist %}

### Включить автодополнение {#enable-completion}

CLI поддерживает автодополнение команд в командных оболочках `bash`, `zsh` и PowerShell. Чтобы включить автодополнение:

{% list tabs group=operating_system %}

- Linux {#linux}

    В `bash` автодополнение работает сразу после установки. На CentOS и производных дистрибутивах предварительно установите пакет `bash-completion`.

    Чтобы включить автодополнение в `zsh`:

    1. Откройте `~/.zshrc` и добавьте в начало файла следующие строки:

        ```bash
        autoload -Uz compinit
        compinit
        ```

        Скрипт установки `yc` добавляет строки инициализации CLI и автодополнения в конец `~/.zshrc`. Разместите вызовы `autoload` и `compinit` выше этих строк, иначе при запуске терминала появится ошибка `command not found: compdef`.

        Итоговый `~/.zshrc` должен выглядеть так:

        ```bash
        autoload -Uz compinit
        compinit

        # Строки ниже добавлены скриптом установки yc автоматически.
        if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
        if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi
        ```

    1. Перезапустите командную оболочку или выполните команду `exec -l $SHELL`.

    1. Проверьте, что автодополнение работает: введите `yc` и нажмите **Tab** дважды. Должен появиться список доступных команд.

- macOS {#macos}

    {% note info %}

    Ниже приведена инструкция для настройки автодополнения в командной оболочке `zsh`, которая используется в macOS по умолчанию.

    Если вы используете `bash` или macOS 10.14 Mojave и более ранних версий, где по умолчанию установлен `bash`, вносите изменения в файл `~/.bash_profile`.

    {% endnote %}

    Чтобы включить автодополнение:
    1. Откройте `~/.zshrc` и добавьте в начало файла следующие строки:

        ```bash
        autoload -Uz compinit
        compinit
        ```

        Скрипт установки `yc` добавляет строки инициализации CLI и автодополнения в конец `~/.zshrc`. Разместите вызовы `autoload` и `compinit` выше этих строк, иначе при запуске терминала появится ошибка `command not found: compdef`.

        Итоговый `~/.zshrc` должен выглядеть так:

        ```bash
        autoload -Uz compinit
        compinit

        # Строки ниже добавлены скриптом установки yc автоматически.
        if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
        if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi
        ```

        {% cut "Установка расширенных автодополнений" %}

        Пакет `zsh-completions` расширяет базовые автодополнения системы. Для автодополнения `yc` он не обязателен.

        Чтобы установить пакет:
        1. Установите [Homebrew](https://brew.sh).
        1. Установите пакет `zsh-completions`:

            ```bash
            brew install zsh-completions
            ```

            {% note tip %}

            Если вы используете `bash`, вместо `zsh-completions` установите пакет `bash-completion`.

            {% endnote %}

        1. Добавьте блок с `FPATH` перед строками `autoload` и `compinit`. Итоговый `~/.zshrc` должен выглядеть так:

            ```bash
            if type brew &>/dev/null; then
              FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
            fi
            autoload -Uz compinit
            compinit

            # Строки ниже добавлены скриптом установки yc автоматически.
            if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
            if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi
            ```

        {% endcut %}

    1. Перезапустите командную оболочку или выполните команду `exec -l $SHELL`.
    1. Проверьте, что автодополнение работает: введите `yc` и нажмите **Tab** дважды. Должен появиться список доступных команд.

- Windows {#windows}

    {% note warning %}

    Автодополнение поддерживается только в PowerShell 7 и выше. Проверьте версию командой `$PSVersionTable.PSVersion`. Если версия ниже 7, установите актуальную версию:

    ```powershell
    winget install Microsoft.PowerShell
    ```

    Или скачайте установщик вручную со [страницы релизов PowerShell](https://github.com/PowerShell/PowerShell/releases).

    {% endnote %}

    Чтобы включить автодополнение в PowerShell:

    1. Если у вас нет профиля PowerShell, создайте его и откройте в текстовом редакторе:

        ```powershell
        New-Item -Path $PROFILE -Type File -Force
        notepad $PROFILE
        ```

        Вместо `notepad` можно использовать любой удобный редактор. Например, для VS Code используйте команду `code $PROFILE`.

    1. Добавьте в файл следующий код и сохраните:

        ```powershell
        Register-ArgumentCompleter -Native -CommandName yc -ScriptBlock {
            param($wordToComplete, $commandAst, $cursorPosition)

            $elements = $commandAst.CommandElements
            $allTokens = $elements | Select-Object -Skip 1 | ForEach-Object { $_.ToString() }
            $allTokens = $allTokens | Where-Object { $_ -match '^[\x20-\x7E]+$' }

            if ($wordToComplete -ne '') {
                $completedTokens = $allTokens | Select-Object -SkipLast 1
                $queryTokens = @($completedTokens) + @("")
            } else {
                $queryTokens = @($allTokens) + @("")
            }

            $result = yc __completeNoDesc @queryTokens 2>$null

            $completions = $result | Where-Object {
                $_ -notmatch '^\:' -and $_ -notmatch '^Completion'
            } | Where-Object {
                $_.StartsWith($wordToComplete)
            }

            if ($completions.Count -eq 0 -and $wordToComplete -ne '') {
                $queryTokensFallback = @($completedTokens) + @($wordToComplete)
                $resultFallback = yc __completeNoDesc @queryTokensFallback 2>$null

                $completions = $resultFallback | Where-Object {
                    $_ -notmatch '^\:' -and $_ -notmatch '^Completion'
                } | Where-Object {
                    $_.StartsWith($wordToComplete)
                }
            }

            $completions | ForEach-Object {
                $parts = $_ -split '\t'
                [System.Management.Automation.CompletionResult]::new(
                    $parts[0], $parts[0], 'ParameterValue', $parts[0]
                )
            }
        }
        ```

        {% note info %}

        По умолчанию при нажатии **Tab** в PowerShell варианты подставляются по очереди. Чтобы вместо этого открывалось меню со всеми вариантами и всплывающими подсказками, добавьте в начало файла следующие строки:

        ```powershell
        Set-PSReadLineOption -ShowToolTips
        Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
        ```

        Эти строки меняют поведение **Tab** во всех командах PowerShell, не только в `yc`.

        {% endnote %}

    1. Перезапустите PowerShell. Проверьте, что автодополнение работает: введите `yc` и нажмите **Tab**. Должны появиться варианты доступных команд.

{% endlist %}

Если в процессе установки CLI возникла ошибка, воспользуйтесь рекомендациями из раздела [Проблемы при установке CLI](../error.md#installation-errors).

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


#### Полезные ссылки {#see-also}

* [Создание профиля Yandex Cloud CLI](profile/profile-create.md)
* [Обновление Yandex Cloud CLI](update-cli.md)