{% list tabs %}

- Linux

    1. Run the command:

        ```
        curl https://{{ s3-storage-host }}{{ yc-install-path }} | bash
        ```

        The script will install the CLI and add the executable file path to the environment variable `PATH`.

        {% note info %}

        The script will update `PATH` only if you run it in the `bash` or `zsh` command shell.

        If you run the script in a different shell, add the path to the CLI to the variable `PATH` yourself.

        {% endnote %}

    1. After installation is complete, restart your terminal.

- macOS

    1. Run the command:

        ```
        curl https://{{ s3-storage-host }}{{ yc-install-path }} | bash
        ```

        The script will install the CLI and add the executable file path to the environment variable `PATH`.

    1. Restart your terminal for the changes to take effect.

    The CLI supports command completion for the `bash` shell. For command completion to work:

    1. Install the [Homebrew](https://brew.sh) package manager.

    1. Install the `bash-completion` package:

        ```
        brew install bash-completion
        ```

        The installation script will update the ` ~/.bash_profile` file:

        ```
        # The next line updates PATH for Yandex Cloud CLI.
        if [ -f '/Users/<username>/yandex-cloud/path.bash.inc' ]; then source '/Users/<username>/yandex-cloud/path.bash.inc'; fi
        # The next line enables shell command completion for yc.
        if [ -f '/Users/<username>/yandex-cloud/completion.bash.inc' ]; then source '/Users/<username>/yandex-cloud/completion.bash.inc'; fi
        ```

    1. After the installation is complete, add the following lines to the ` ~/.bash_profile` file. Insert them above the lines automatically added by the installation script.

        ```
        if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
        fi
        ```

    1. Restart your terminal.

- Windows

    For Windows, the CLI can be installed using PowerShell and `cmd`:

    - To install using PowerShell:

        1. Run the command:

            ```
            iex (New-Object System.Net.WebClient).DownloadString('https://{{ s3-storage-host }}{{ yc-windows-path }}')
            ```

        1. The installation script will ask whether to add the path to `yc` to the PATH variable:

            ```
            Add yc installation dir to your PATH? [Y/n]
            ```

        1. Enter `Y`. After this, you can use the {{ yandex-cloud }} CLI without restarting the command shell.

    - To install using `cmd`:

        1. Run the command:

            ```
            @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://{{ s3-storage-host }}{{ yc-windows-path }}'))" && SET "PATH=%PATH%;%USERPROFILE%\yandex-cloud\bin"
            ```

        1. The installation script will ask whether to add the path to `yc` to the PATH variable:

            ```
            Add yc installation dir to your PATH? [Y/n]
            ```

        1. Enter `Y`.

        1. Restart your terminal for the changes to take effect.

{% endlist %}

