---
title: How to uninstall the {{ yandex-cloud }} CLI
description: Follow this guide to uninstall the {{ yandex-cloud }} CLI.
---

# Uninstalling the CLI

To fully uninstall the CLI, delete the installation folder, user settings, and environment variables.

{% list tabs group=operating_system %}

- Linux/MacOS {#linux-macos}

  1. Remove the CLI:

      ```bash
      rm -rf <installation_folder_path>
      ```

      By default, the the installation folder path is `~/yandex-cloud`.

      ```bash
      rm -rf ~/yandex-cloud
      ```

  1. Remove your CLI user settings:

      ```bash
      rm -rf ~/.config/yandex-cloud
      ```

  1. Delete lines referencing `yandex-cloud` from the shell configuration file (e.g., `~/.zshrc`, `~/.bashrc`, or `~/.bash_profile`):

      ```bash
      if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
      if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi
      ```

  1. Restart the terminal.

- Windows {#windows}

  1. Uninstall the CLI via the explorer or using this command:

      ```bash
      rmdir /S /Q "%USERPROFILE%\yandex-cloud"
      ```

  1. Remove your CLI user settings:

      ```bash
      rmdir /S /Q "%USERPROFILE%\.config\yandex-cloud"
      ```

  1. If the CLI was added to your `PATH` environment variable:

      1. Click **Start** and type **Change system environment variables** in the Windows search bar.
      1. Click **Environment variables...** at the bottom right.
      1. In the window that opens, find the `PATH` parameter and click **Edit**.
      1. In the list, select `...\yandex-cloud\bin`.
      1. Click **Delete**.
      1. Click **OK**.

  1. Restart the terminal.

{% endlist %}