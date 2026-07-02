{% list tabs group=operating_system %}

- Linux {#linux}

    {% include [cli-prepare-step-tip](cli-prepare-step-tip.md) %}

    1. Выполните команду:

        ```bash
        curl -sSL https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
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

    {% include [cli-prepare-step-tip](cli-prepare-step-tip.md) %}

    1. Выполните команду:

        ```bash
        curl -sSL https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
        ```

        Скрипт установит CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.
    1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

- Windows {#windows}

    {% include [cli-prepare-step-tip](cli-prepare-step-tip.md) %}

    Для Windows CLI можно установить с помощью PowerShell или командной строки:

    - Для установки с помощью PowerShell:

        1. Выполните команду:


            
            
            ```powershell
            iex (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net{{ yc-windows-path }}')
            ```



        1. Скрипт установки спросит, нужно ли добавить путь до `yc` в переменную PATH:
        
            ```powershell
            Add yc installation dir to your PATH? [Y/n]
            ```

        1. Введите `Y`. После этого {{ yandex-cloud }} CLI можно пользоваться, командную оболочку перезапускать не нужно.

    - Для установки с помощью командной строки:

        1. Выполните команду:


            
            
            ```batch
            @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net{{ yc-windows-path }}'))" && SET "PATH=%PATH%;%USERPROFILE%\yandex-cloud\bin"
            ```



        1. Скрипт установки спросит, нужно ли добавить путь до `yc` в переменную PATH:
        
            ```batch
            Add yc installation dir to your PATH? [Y/n]
            ```

        1. Введите `Y`.
        1. Перезапустите командную оболочку, чтобы перезагрузить переменные окружения.

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

Если в процессе установки CLI возникла ошибка, смотрите раздел [Решение проблем CLI](../../cli/error.md#failure-writing-output-to-destination).
