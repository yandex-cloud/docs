# Установка CLI


Вы можете установить [CLI](../../glossary/cli.md) следующими способами: 
* [Интерактивная установка CLI с помощью скрипта](#interactive)
* [Неинтерактивная установка CLI с помощью скрипта](#non-interactive)
* [Установка без использования скрипта](#bin)

## Интерактивная установка CLI с помощью скрипта {#interactive}

{% include [interactive-install-cli-intro](../../_includes/cli/interactive-install-cli-intro.md) %}

{% include [install-cli](../../_includes/cli/install-cli.md) %}

{% include [next-step-cli-profile](../../_includes/cli/next-step-cli-profile.md) %}

## Неинтерактивная установка CLI с помощью скрипта {#non-interactive}

Для использования CLI в скриптах можно использовать флаги для неинтерактивной установки:

{% list tabs group=programming_language %}

- Bash {#bash}

    Выполните команду:

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

    Примеры использования:
    - Установка CLI в `/opt/yc`, без изменений в файле `.bashrc`:

        ```bash
        curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | \
            bash -s -- -i /opt/yc -n
        ```

    - Установка CLI в директорию по умолчанию, в файл `.bashrc` добавляются `completion` и `PATH`:

        ```bash
        curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | \
            bash -s -- -a
        ```

{% endlist %}

{% include [next-step-cli-profile](../../_includes/cli/next-step-cli-profile.md) %}


## Установка без использования скрипта {#bin}

Если возможность запускать скрипты на целевой системе отсутствует, вы можете напрямую загрузить и установить исполняемый файл с последней стабильной версией CLI.

Выберите инструкцию, исходя из вашей операционной системы и архитектуры процессора:

{% list tabs group=operating_system %}

- Linux AMD64 {#linux}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Скачайте и распакуйте файл [yc_linux_amd64.tar.gz](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_linux_amd64.tar.gz):

      ```bash
      curl -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_linux_amd64.tar.gz
      tar -xzf yc_linux_amd64.tar.gz
      ```

  1. {% include [cli-bin-chmod](../../_includes/cli/cli-bin-chmod.md) %}
  1. {% include [cli-bin-path-unix](../../_includes/cli/cli-bin-path-unix.md) %}

- Linux x86 {#linux-x86}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Скачайте и распакуйте файл [yc_linux_386.tar.gz](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_linux_386.tar.gz):

      ```bash
      curl -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_linux_386.tar.gz
      tar -xzf yc_linux_386.tar.gz
      ```

  1. {% include [cli-bin-chmod](../../_includes/cli/cli-bin-chmod.md) %}
  1. {% include [cli-bin-path-unix](../../_includes/cli/cli-bin-path-unix.md) %}

- Linux ARM64 {#linux-arm64}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Скачайте и распакуйте файл [yc_linux_arm64.tar.gz](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_linux_arm64.tar.gz):

      ```bash
      curl -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_linux_arm64.tar.gz
      tar -xzf yc_linux_arm64.tar.gz
      ```

  1. {% include [cli-bin-chmod](../../_includes/cli/cli-bin-chmod.md) %}
  1. {% include [cli-bin-path-unix](../../_includes/cli/cli-bin-path-unix.md) %}

- macOS AMD64 {#macos-amd64}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Скачайте и распакуйте файл [yc_darwin_amd64.tar.gz](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_darwin_amd64.tar.gz):

      ```bash
      curl -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_darwin_amd64.tar.gz
      tar -xzf yc_darwin_amd64.tar.gz
      ```

  1. {% include [cli-bin-chmod](../../_includes/cli/cli-bin-chmod.md) %}
  1. {% include [cli-bin-path-unix](../../_includes/cli/cli-bin-path-unix.md) %}

- macOS ARM64 {#macos}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Скачайте и распакуйте файл [yc_darwin_arm64.tar.gz](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_darwin_arm64.tar.gz):

      ```bash
      curl -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_darwin_arm64.tar.gz
      tar -xzf yc_darwin_arm64.tar.gz
      ```

  1. {% include [cli-bin-chmod](../../_includes/cli/cli-bin-chmod.md) %}
  1. {% include [cli-bin-path-unix](../../_includes/cli/cli-bin-path-unix.md) %}

- Windows AMD64 {#windows}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Скачайте и распакуйте файл [yc_windows_amd64.zip](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_windows_amd64.zip):

      ```powershell
      curl.exe -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_windows_amd64.zip
      Expand-Archive yc_windows_amd64.zip -DestinationPath .
      ```

  1. {% include [cli-bin-path-windows](../../_includes/cli/cli-bin-path-windows.md) %}
  1. Перезапустите PowerShell.

- Windows x86 {#windows-x86}

  1. {% include [cli-bin-go-to-directory](../../_includes/cli/cli-bin-go-to-directory.md) %}
  1. Скачайте и распакуйте файл [yc_windows_386.zip](https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_windows_386.zip):

      ```powershell
      curl.exe -O https://{{ s3-storage-host-cli }}/yandexcloud-yc/release/yc_windows_386.zip
      Expand-Archive yc_windows_386.zip -DestinationPath .
      ```

  1. {% include [cli-bin-path-windows](../../_includes/cli/cli-bin-path-windows.md) %}
  1. Перезапустите PowerShell.

{% endlist %}

{% include [next-step-cli-profile](../../_includes/cli/next-step-cli-profile.md) %}


### См. также {#see-also}

* [{#T}](profile/profile-create.md)
* [{#T}](update-cli.md)
