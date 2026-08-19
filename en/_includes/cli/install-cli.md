
{% note tip %}

{% include [cli-install-without-access](cli-install-without-access.md) %}

{% endnote %}


{% list tabs group=operating_system %}

- Linux {#linux}

    1. Run this command:

        ```bash
        curl -sSL https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
        ```

        The script will install the CLI and add the executable file path to the `PATH` environment variable.

        {% note info "Features" %}

        * The script will update the `PATH` variable only if you run it in the `bash` or `zsh` command shell.

          If you run the script in a different shell, add the CLI path to the `PATH` variable yourself.

        * For autocompletion to work correctly when using `zsh`, you need the shell version 5.1 or higher. If using `bash` on CentOS and derivative distributions, install the `bash-completion` package.

        {% endnote %}

    1. After installation is complete, restart your terminal.

- macOS {#macos}

    1. Run this command:

        ```bash
        curl -sSL https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
        ```

        The script will install the CLI and add the executable file path to the `PATH` environment variable.

        This command runs the installation script using `bash`. The script detects the user's command shell via the `SHELL` variable and adds the configurations for `zsh` to `~/.zshrc`.

    1. Restart your terminal for the changes to take effect.

- Windows {#windows}

    For Windows, you can install the CLI using PowerShell or `cmd.exe`. In both cases, the installation script runs in PowerShell.

    {% note warning %}

    {% include [cli-powershell-execution-policy](cli-powershell-execution-policy.md) %}

    {% endnote %}

    - Installation using PowerShell:

        1. Run this command:


            
            
            ```powershell
            Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://{{ s3-storage-host }}{{ yc-windows-path }}')
            ```



        1. The installation script will ask whether to add the path to `yc` to the PATH variable:
        
            ```powershell
            Add yc installation dir to your PATH? [Y/n]
            ```

        1. Enter `Y`. After this, you can use the {{ yandex-cloud }} CLI without restarting the command shell.

    - Installation from `cmd.exe`:

        1. Run this command:


            
            
            ```batch
            @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://{{ s3-storage-host }}{{ yc-windows-path }}'))" && SET "PATH=%PATH%;%USERPROFILE%\yandex-cloud\bin"
            ```



        1. When prompted by the installation script, confirm whether to add the `yc` path to the PATH variable:
        
            ```batch
            Add yc installation dir to your PATH? [Y/n]
            ```

        1. Enter `Y`.
        1. Restart your terminal for the changes to take effect.

        
    For more information, see [{#T}](../../overview/concepts/console-syntax-guide.md).
    

{% endlist %}

### Enabling autocompletion {#enable-completion}

The CLI supports command autocompletion for the `bash`, `zsh`, and PowerShell command shells. To enable autocompletion:

{% list tabs group=operating_system %}

- Linux {#linux}

    In `bash`, autocompletion works immediately after installation. On CentOS and derivative distributions, first install the `bash-completion` package.

    To enable autocompletion in `zsh`:

    1. Open `~/.zshrc` and add the following lines to the beginning of the file:

        ```bash
        autoload -Uz compinit
        compinit
        ```

        The `yc` installation script adds CLI initialization and autocompletion lines to the end of `~/.zshrc`. Place the `autoload` and `compinit` calls above these lines; otherwise, you will get the `command not found: compdef` error when you start the terminal.

        The final `~/.zshrc` should look as follows:

        ```bash
        autoload -Uz compinit
        compinit

        # The lines below were added automatically by the yc installation script.
        if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
        if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi
        ```

    1. Restart the command shell or run the `exec -l $SHELL` command.

    1. Check that autocompletion works: type `yc` and press **Tab** twice. A list of available commands should appear.

- macOS {#macos}

    {% note info %}

    Below are instructions for setting up autocompletion in the `zsh` command shell, which is the default shell on macOS.

    If you are using `bash` or macOS 10.14 Mojave or earlier, where `bash` is installed by default, edit the `~/.bash_profile` file.

    {% endnote %}

    To enable autocompletion:
    1. Open `~/.zshrc` and add the following lines to the beginning of the file:

        ```bash
        autoload -Uz compinit
        compinit
        ```

        The `yc` installation script adds CLI initialization and autocompletion lines to the end of `~/.zshrc`. Place the `autoload` and `compinit` calls above these lines; otherwise, you will get the `command not found: compdef` error when you start the terminal.

        The final `~/.zshrc` should look as follows:

        ```bash
        autoload -Uz compinit
        compinit

        # The lines below were added automatically by the yc installation script.
        if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
        if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi
        ```

        {% cut "Installing extended autocompletions" %}

        The `zsh-completions` package extends the system's basic autocompletions. It is not required for the `yc` autocompletion.

        To install the package:
        1. Install [Homebrew](https://brew.sh).
        1. Install the `zsh-completions` package:

            ```bash
            brew install zsh-completions
            ```

            {% note tip %}

            If using `bash`, install the `bash-completion` package instead of `zsh-completions`.

            {% endnote %}

        1. Add a section with `FPATH` before the `autoload` and `compinit` lines. The final `~/.zshrc` should look as follows:

            ```bash
            if type brew &>/dev/null; then
              FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
            fi
            autoload -Uz compinit
            compinit

            # The lines below were added automatically by the yc installation script.
            if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
            if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi
            ```

        {% endcut %}

    1. Restart the command shell or run the `exec -l $SHELL` command.
    1. Check that autocompletion works: type `yc` and press **Tab** twice. A list of available commands should appear.

- Windows {#windows}

    {% note warning %}

    Autocompletion is only supported in PowerShell 7 and above. Check the version using the `$PSVersionTable.PSVersion` command. If the version is lower than 7, install the latest version:

    ```powershell
    winget install Microsoft.PowerShell
    ```

    Or download the installer manually from the [PowerShell releases page](https://github.com/PowerShell/PowerShell/releases).

    {% endnote %}

    To enable autocompletion in PowerShell:

    1. If you do not have a PowerShell profile, create one and open it in a text editor:

        ```powershell
        New-Item -Path $PROFILE -Type File -Force
        notepad $PROFILE
        ```

        Instead of `notepad`, you can use any editor you prefer. For example, for VS Code, use the `code $PROFILE` command.

    1. Add the following code to the file and save it:

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

        By default, pressing **Tab** in PowerShell suggests the options one by one. To open a menu with all options and tooltips instead, add the following lines to the top of the file:

        ```powershell
        Set-PSReadLineOption -ShowToolTips
        Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
        ```

        These lines change the **Tab** behavior in all PowerShell commands, not just `yc`.

        {% endnote %}

    1. Restart PowerShell. Check that autocompletion works: type `yc` and press **Tab**. A list of available commands should appear.

{% endlist %}

If you get an error during CLI installation, refer to [{#T}](../../cli/error.md#installation-errors).
