{% list tabs group=operating_system %}

- Debian/Ubuntu {#linux}

  1. Make sure the FUSE utilities are installed in the distribution:

     ```bash
     apt list --installed | grep fuse
     ```

     {% include [fuse-warning](../../_includes/storage/fuse-warning.md) %}

  1. If the FUSE utilities are not installed, run this command:

     ```bash
     sudo apt-get install fuse
     ```

  1. Download and install GeeseFS:

     {% include [geesefs-install-linux](../../_includes/storage/geesefs-install-linux.md) %}

- CentOS {#centos}

  1. Make sure the FUSE utilities are installed in the distribution:

     ```bash
     yum list installed | grep fuse
     ```

     {% include [fuse-warning](../../_includes/storage/fuse-warning.md) %}

  1. If the FUSE utilities are not installed, run this command:

     ```bash
     sudo yum install fuse
     ```

  1. Download and install GeeseFS:

     {% include [geesefs-install-linux](../../_includes/storage/geesefs-install-linux.md) %}

- macOS {#macos}

  1. Install the [macFUSE](https://osxfuse.github.io/) package.
  1. [Enable](https://github.com/macfuse/macfuse/wiki/Getting-Started#enabling-support-for-third-party-kernel-extensions-apple-silicon-macs) support for third-party core extensions. This step is only required the first time you use MacFUSE on an Apple Silicon Mac.
  1. [Allow](https://github.com/macfuse/macfuse/wiki/Getting-Started#allow-the-macfuse-kernel-extension-to-load-apple-silicon-and-intel-macs) loading the MacFUSE core extension (Apple Silicon and Intel Mac).

      For more information on installing macFUSE, see [this installation guide](https://github.com/osxfuse/osxfuse/wiki/FAQ#2-installuninstall-questions) in the macFUSE GitHub repository.

  1. Download and install GeeseFS:

     ```bash
     platform='arm64'
     if [[ $(uname -m) == 'x86_64' ]]; then platform='amd64'; fi
     wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-mac-$platform
     chmod a+x geesefs-mac-$platform
     sudo cp geesefs-mac-$platform /usr/local/bin/geesefs
     ```

- Windows {#windows}

  1. [Download](https://winfsp.dev/rel/) and install WinFSP.
  1. [Download](https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-win-x64.exe) the `geesefs-win-x64.exe` file.
  1. Rename `geesefs-win-x64.exe` to `geesefs.exe` for convenience.
  1. Create a folder named `geesefs` and move the `geesefs.exe` file there.
  1. Add `geesefs` to the `PATH` variable:

      {% include [windows-environment-vars](../../_includes/windows-environment-vars.md) %}

{% endlist %}

You can also build GeeseFS yourself using its source code. For more information, see [this guide](https://github.com/yandex-cloud/geesefs#installation) in the GeeseFS repository on GitHub.