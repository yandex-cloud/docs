{% list tabs %}

- Linux
  
    Чтобы установить {{ ydb-short-name }} CLI, выполните команду:

    ```bash
    curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
    ```

    Скрипт установит {{ ydb-short-name }} CLI и добавит путь к исполняемому файлу в переменную окружения `PATH`.

    {% note info %}

    Скрипт дополнит переменную `PATH` только если его запустить в командной оболочке bash или zsh.

    Если вы запустили скрипт в другой оболочке, добавьте путь до CLI в переменную `PATH` самостоятельно.

    {% endnote %}

    Чтобы обновить переменные окружения, перезапустите командную оболочку.

- macOS

    Чтобы установить {{ ydb-short-name }} CLI, выполните команду:

    ```bash
    curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
    ```

    Скрипт установит {{ ydb-short-name }} CLI и добавит путь до исполняемого файла в переменную окружения `PATH`.

    Чтобы обновить переменные окружения, перезапустите командную оболочку.

- Windows

    {{ ydb-short-name }} CLI можно установить с помощью PowerShell или cmd.

    * Чтобы установить через PowerShell, выполните команду:

        ```powershell
        iex (New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-ydb/install.ps1')
        ```

        Укажите, нужно ли добавить путь к исполняемому файлу в переменную окружения `PATH`:

        ```text
        Add ydb installation dir to your PATH? [Y/n]
        ```

    * Чтобы установить через cmd, выполните команду:

        ```cmd
        @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://storage.yandexcloud.net/yandexcloud-ydb/install.ps1'))"
        ```

        Укажите, нужно ли добавить путь к исполняемому в переменную окружения `PATH`:

        ```text
        Add ydb installation dir to your PATH? [Y/n]
        ```

        Чтобы обновить переменные окружения, перезапустите командную оболочку.

    {% note info %}

    {{ ydb-short-name }} CLI использует символы юникода в выводе некоторых команд. При некорректном отображении таких символов в консоли Windows, переключите кодировку на UTF-8:

    ```cmd
    chcp 65001
    ```

    {% endnote %}

{% endlist %}
