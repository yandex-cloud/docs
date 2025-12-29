{% list tabs group=operating_system %}

- Debian/Ubuntu {#linux}

  1. Проверьте, что в дистрибутиве установлены утилиты для работы с FUSE:

     ```bash
     apt list --installed | grep fuse
     ```

     {% include [fuse-warning](../../_includes/storage/fuse-warning.md) %}

  1. Если утилиты для работы с FUSE не установлены, то выполните команду:

     ```bash
     sudo apt-get install fuse
     ```

  1. Скачайте и установите GeeseFS:

     {% include [geesefs-install-linux](../../_includes/storage/geesefs-install-linux.md) %}

- CentOS {#centos}

  1. Проверьте, что в дистрибутиве установлены утилиты для работы с FUSE:

     ```bash
     yum list installed | grep fuse
     ```

     {% include [fuse-warning](../../_includes/storage/fuse-warning.md) %}

  1. Если утилиты для работы с FUSE не установлены, то выполните команду:

     ```bash
     sudo yum install fuse
     ```

  1. Скачайте и установите GeeseFS:

     {% include [geesefs-install-linux](../../_includes/storage/geesefs-install-linux.md) %}

- macOS {#macos}

  1. Установите пакет [macFUSE](https://osxfuse.github.io/).
  1. [Включите](https://github.com/macfuse/macfuse/wiki/Getting-Started#enabling-support-for-third-party-kernel-extensions-apple-silicon-macs) поддержку сторонних расширений ядра. Этот шаг необходим только при первом использовании MacFUSE на Apple Silicon Mac.
  1. [Разрешите](https://github.com/macfuse/macfuse/wiki/Getting-Started#allow-the-macfuse-kernel-extension-to-load-apple-silicon-and-intel-macs) загрузку расширения ядра MacFUSE (Apple Silicon и Intel Mac).

      Подробнее об установке macFUSE см. в [инструкции по установке](https://github.com/osxfuse/osxfuse/wiki/FAQ#2-installuninstall-questions) в репозитории macFUSE на GitHub.

  1. Скачайте и установите GeeseFS:

     ```bash
     platform='arm64'
     if [[ $(uname -m) == 'x86_64' ]]; then platform='amd64'; fi
     wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-mac-$platform
     chmod a+x geesefs-mac-$platform
     sudo cp geesefs-mac-$platform /usr/local/bin/geesefs
     ```

- Windows {#windows}

  1. [Скачайте](https://winfsp.dev/rel/) и установите WinFSP.
  1. [Скачайте](https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-win-x64.exe) файл `geesefs-win-x64.exe`.
  1. Для удобства работы переименуйте файл `geesefs-win-x64.exe` в `geesefs.exe`.
  1. Создайте папку `geesefs` и перенесите в нее файл `geesefs.exe`.
  1. Добавьте папку `geesefs` в переменную `PATH`:

      {% include [windows-environment-vars](../../_includes/windows-environment-vars.md) %}

{% endlist %}

Также вы можете самостоятельно собрать GeeseFS из исходного кода. Подробнее см. в [инструкции](https://github.com/yandex-cloud/geesefs#installation) в репозитории GeeseFS на GitHub.