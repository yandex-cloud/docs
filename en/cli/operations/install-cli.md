# CLI installation


You can install the CLI in any of the following ways: 
* [Interactive CLI installation using a script](#interactive)
* [Non-interactive CLI installation using a script](#non-interactive)
* [Installation without using a script](#bin)

## Interactive CLI installation using a script {#interactive}

{% include [interactive-install-cli-intro](../../_includes/cli/interactive-install-cli-intro.md) %}

{% include [install-cli](../../_includes/cli/install-cli.md) %}

{% include [next-step-cli-profile](../../_includes/cli/next-step-cli-profile.md) %}

## Non-interactive CLI installation using a script {#non-interactive}

To use the CLI in scripts, you can use flags for a non-interactive installation:

{% list tabs group=programming_language %}

- Bash {#bash}

    Run this command:

    ```bash
    curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash -s -- -h
    Usage: install [options...]
    Options:
     -i [INSTALL_DIR]    Installs to specified dir.
     -r [RC_FILE]        Automatically modify RC_FILE with PATH modification and shell completion.
     -n                  Don't modify rc file and don't ask about it.
     -a                  Automatically modify default rc file with PATH modification and shell completion.
     -h                  Prints help.
    ```

    Examples of use:
    - Installing the CLI to `/opt/yc` without changing the `.bashrc` file:

        ```bash
        curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | \
            bash -s -- -i /opt/yc -n
        ```

    - Installing the CLI to the default directory with `completion` and `PATH` added to `.bashrc`:

        ```bash
        curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | \
            bash -s -- -a
        ```

{% endlist %}

{% include [next-step-cli-profile](../../_includes/cli/next-step-cli-profile.md) %}


## Installation without using a script {#bin}

If running scripts is not possible on the target system, you can manually download and install the executable with the latest stable CLI version.

Select instructions based on your OS and processor architecture:

{% list tabs group=operating_system %}

- Linux AMD64 {#linux}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Download and unpack the [yc_linux_amd64.tar.gz](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_linux_amd64.tar.gz) file:

      ```bash
      curl -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_linux_amd64.tar.gz
      tar -xzf yc_linux_amd64.tar.gz
      ```

  1. {% include [cli-bin-chmod](../../_includes/cli/cli-bin-chmod.md) %}
  1. {% include [cli-bin-path-unix](../../_includes/cli/cli-bin-path-unix.md) %}

- Linux x86 {#linux-x86}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Download and unpack the [yc_linux_386.tar.gz](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_linux_386.tar.gz) file:

      ```bash
      curl -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_linux_386.tar.gz
      tar -xzf yc_linux_386.tar.gz
      ```

  1. {% include [cli-bin-chmod](../../_includes/cli/cli-bin-chmod.md) %}
  1. {% include [cli-bin-path-unix](../../_includes/cli/cli-bin-path-unix.md) %}

- Linux ARM64 {#linux-arm64}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Download and unpack the [yc_linux_arm64.tar.gz](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_linux_arm64.tar.gz) file:

      ```bash
      curl -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_linux_arm64.tar.gz
      tar -xzf yc_linux_arm64.tar.gz
      ```

  1. {% include [cli-bin-chmod](../../_includes/cli/cli-bin-chmod.md) %}
  1. {% include [cli-bin-path-unix](../../_includes/cli/cli-bin-path-unix.md) %}

- macOS AMD64 {#macos-amd64}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Download and unpack the [yc_darwin_amd64.tar.gz](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_darwin_amd64.tar.gz) file:

      ```bash
      curl -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_darwin_amd64.tar.gz
      tar -xzf yc_darwin_amd64.tar.gz
      ```

  1. {% include [cli-bin-chmod](../../_includes/cli/cli-bin-chmod.md) %}
  1. {% include [cli-bin-path-unix](../../_includes/cli/cli-bin-path-unix.md) %}

- macOS ARM64 {#macos}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Download and unpack the [yc_darwin_arm64.tar.gz](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_darwin_arm64.tar.gz) file:

      ```bash
      curl -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_darwin_arm64.tar.gz
      tar -xzf yc_darwin_arm64.tar.gz
      ```

  1. {% include [cli-bin-chmod](../../_includes/cli/cli-bin-chmod.md) %}
  1. {% include [cli-bin-path-unix](../../_includes/cli/cli-bin-path-unix.md) %}

- Windows AMD64 {#windows}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Download and unpack the [yc_windows_amd64.zip](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_windows_amd64.zip) file:

      ```powershell
      curl.exe -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_windows_amd64.zip
      Expand-Archive yc_windows_amd64.zip -DestinationPath .
      ```

  1. {% include [cli-bin-path-windows](../../_includes/cli/cli-bin-path-windows.md) %}
  1. Restart PowerShell.

- Windows x86 {#windows-x86}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Download and unpack the [yc_windows_386.zip](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_windows_386.zip) file:

      ```powershell
      curl.exe -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_windows_386.zip
      Expand-Archive yc_windows_386.zip -DestinationPath .
      ```

  1. {% include [cli-bin-path-windows](../../_includes/cli/cli-bin-path-windows.md) %}
  1. Restart PowerShell.

{% endlist %}

{% include [next-step-cli-profile](../../_includes/cli/next-step-cli-profile.md) %}


### See also {#see-also}

* [{#T}](profile/profile-create.md)
* [{#T}](update-cli.md)
