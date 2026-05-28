# s3fs

[s3fs](https://github.com/s3fs-fuse/s3fs-fuse) — программа для Linux и macOS, позволяющая монтировать бакеты {{ objstorage-name }} через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).

{% note info %}

Рекомендуется использовать s3fs версии не ниже 1.84.

{% endnote %}

Если у вас возникнут вопросы, обратитесь к [официальной документации](https://github.com/s3fs-fuse/s3fs-fuse/wiki) проекта, в частности к разделу [FAQ](https://github.com/s3fs-fuse/s3fs-fuse/wiki/FAQ), который содержит решения для многих проблем, возникающих при использовании s3fs.

Производительность s3fs зависит от производительности локального диска. Используйте высокопроизводительные диски, особенно если вы храните много маленьких (сотни килобайт и меньше) файлов. Производительность s3fs можно увеличить, включив кеширование (параметр `--use_cache <directory>`). Кеш s3fs растет неограниченно, и вам необходимо позаботиться о его регулярной очистке. Подробности читайте в [документации s3fs](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Fuse-Over-Amazon#details).

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

{% list tabs group=operating_system %}

- Ubuntu/Debian {#ubuntu}

  1. Проверьте, что в дистрибутиве установлены утилиты для работы с FUSE:

     ```bash
     apt list --installed | grep fuse
     ```

     {% include [fuse-warning](../../_includes/storage/fuse-warning.md) %}

  1. Если утилиты для работы с FUSE не установлены, то выполните команду:

     ```bash
     sudo apt-get install fuse
     ```
  
  1. Для установки s3fs воспользуйтесь [инструкцией](https://github.com/s3fs-fuse/s3fs-fuse#installation) в репозитории проекта.

- CentOS/Fedora/Red Hat {#centos}

  1. Проверьте, что в дистрибутиве установлены утилиты для работы с FUSE:

     ```bash
     dnf list installed | grep fuse
     ```

     {% include [fuse-warning](../../_includes/storage/fuse-warning.md) %}

  1. Если утилиты для работы с FUSE не установлены, то выполните команду:

     ```bash
     sudo dnf install fuse
     ```
  
  1. Для установки s3fs воспользуйтесь [инструкцией](https://github.com/s3fs-fuse/s3fs-fuse#installation) в репозитории проекта.

- macOS {#macos}

  1. Установите пакет [macFUSE](https://osxfuse.github.io/).
  1. [Включите](https://github.com/macfuse/macfuse/wiki/Getting-Started#enabling-support-for-third-party-kernel-extensions-apple-silicon-macs) поддержку сторонних расширений ядра. Этот шаг необходим только при первом использовании MacFUSE на Apple Silicon Mac.
  1. [Разрешите](https://github.com/macfuse/macfuse/wiki/Getting-Started#allow-the-macfuse-kernel-extension-to-load-apple-silicon-and-intel-macs) загрузку расширения ядра MacFUSE (Apple Silicon и Intel Mac).

      Подробнее об установке macFUSE см. в [инструкции по установке](https://github.com/osxfuse/osxfuse/wiki/FAQ#2-installuninstall-questions) в репозитории macFUSE на GitHub.
  
  1. Для установки s3fs воспользуйтесь [инструкцией](https://github.com/s3fs-fuse/s3fs-fuse#installation) в репозитории проекта.

   {% endlist %}

## Настройка {#setup}

Для настройки s3fs сохраните идентификатор ключа и секретный ключ, [полученные ранее](#before-you-begin), в файле `~/.passwd-s3fs` в формате `<идентификатор_ключа>:<секретный_ключ>`, а также ограничьте доступ к файлу `~/.passwd-s3fs` следующим образом:

```bash
echo <идентификатор_ключа>:<секретный_ключ> > ~/.passwd-s3fs
chmod 600 ~/.passwd-s3fs
```

## Монтирование бакета {#mounting-bucket}

1. Выберите папку, в которую вы будете монтировать бакет, и убедитесь, что у вас достаточно прав для операции монтирования.
1. Выполните команду:

    ```bash
    s3fs <имя_бакета> /mount/<путь_к_папке> -o passwd_file=$HOME/.passwd-s3fs \
        -o url=https://{{ s3-storage-host }} -o use_path_request_style
    ```

   Чтобы выдать доступ к этой папке другим пользователям компьютера, укажите опцию `-o allow_other`.
   
   Чтобы задать права доступа к папке, в которую будет смонтирован бакет, при монтировании укажите опцию `-o mp_umask=<нужные_права>`.

Можно настроить монтирование бакета при запуске системы, для этого добавьте в файл `/etc/fstab` строку вида:

```bash
s3fs#<имя_бакета> /mount/<путь_к_папке> fuse _netdev,allow_other,use_path_request_style,url=https://{{ s3-storage-host }},passwd_file=/home/<имя_пользователя>/.passwd-s3fs 0 0
```

Описание всех параметров s3fs смотрите в [вики проекта](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Fuse-Over-Amazon) на GitHub.

