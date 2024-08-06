{% list tabs group=operating_system %}

- Linux {#linux}

   1. Run this command:

      ```bash
      curl -sSL https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
      ```

      The script will install the CLI and add the executable file path to the `PATH` environment variable.

      {% note info %}

      The script will update `PATH` only if you run it in the `bash` or `zsh` command shell.

      If you run the script in a different shell, add the CLI path to the `PATH` variable yourself.

      {% endnote %}

      {% note warning %}

      For correct operation of the autocompletion feature when using `zsh`, you need the shell version 5.1 or higher. If using `bash` on CentOS and derivative distributions, install the `bash-completion` package.

      {% endnote %}

   1. After installation is complete, restart your terminal.

- macOS {#macos}

   1. Run this command:

      ```bash
      curl -sSL https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash
      ```

      The script will install the CLI and add the executable file path to the `PATH` environment variable.
   1. Restart your terminal for the changes to take effect.

   The CLI supports command autocompletion for the `bash` and `zsh` command shells. To enable command autocompletion:

   1. Install the [Homebrew](https://brew.sh) package manager.
   1. Install the `zsh-completion` package:

      {% note warning %}

      If you installed bash instead of zsh or have macOS Mojave 10.14 or earlier with bash as the default shell, use the `bash-completion` package instead of `zsh-completion` and the `~/.bash_profile` configuration file instead of `~/.zshrc` at the current and next step.

      {% endnote %}

      ```
      brew install zsh-completion
      ```

      The installation script will update the `~/.zshrc` configuration file:

      ```
      # The next line updates PATH for {{ yandex-cloud }} CLI.
      if [ -f '/Users/<username>/yandex-cloud/path.bash.inc' ]; then source '/Users/<username>/yandex-cloud/path.bash.inc'; fi
      # The next line enables shell command completion for yc.
      if [ -f '/Users/<username>/yandex-cloud/completion.zsh.inc' ]; then source '/Users/<username>/yandex-cloud/completion.zsh.inc'; fi
      ```

   1. After the installation is complete, add the following lines to the `~/.zshrc` configuration file. Insert them above the lines automatically added by the installation script.

      ```
      if [ -f $(brew --prefix)/etc/zsh_completion ]; then
      . $(brew --prefix)/etc/zsh_completion
      fi
      ```
   1. Restart your terminal.

- Windows {#windows}

   For Windows, you can install the CLI using PowerShell or command line:

   - To install using PowerShell:

      1. Run this command:


         
         
         ```bash
         iex (New-Object System.Net.WebClient).DownloadString('https://{{ s3-storage-host }}{{ yc-windows-path }}')
         ```



      1. The installation script will ask whether to add the path to `yc` to the PATH variable:

         ```
         Add yc installation dir to your PATH? [Y/n]
         ```
      1. Enter `Y`. After this, you can use the {{ yandex-cloud }} CLI without restarting the command shell.

   - To install using the command line:

      1. Run this command:


         
         
         ```bash
         @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://{{ s3-storage-host }}{{ yc-windows-path }}'))" && SET "PATH=%PATH%;%USERPROFILE%\yandex-cloud\bin"
         ```



      1. The installation script will ask whether to add the path to `yc` to the PATH variable:

         ```
         Add yc installation dir to your PATH? [Y/n]
         ```
      1. Enter `Y`.
      1. Restart your terminal for the changes to take effect.

{% endlist %}




