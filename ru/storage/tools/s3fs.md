# s3fs

[s3fs](https://github.com/s3fs-fuse/s3fs-fuse) — программа для Linux и macOS, позволяющая монтировать бакеты {{ objstorage-name }} через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).

{% note info %}

Рекомендуется использовать s3fs версии не ниже 1.84.

{% endnote %}

Если у вас возникнут вопросы, обратитесь к [официальной документации](https://github.com/s3fs-fuse/s3fs-fuse/wiki) проекта, в частности к разделу [FAQ](https://github.com/s3fs-fuse/s3fs-fuse/wiki/FAQ), который содержит решения для многих проблем, возникающих при использовании s3fs.

Производительность s3fs зависит от производительности локального диска. Используйте высокопроизводительные диски, особенно если вы храните много маленьких (сотни килобайт и меньше) файлов. Производительность s3fs можно увеличить, включив кэширование (ключ `--use_cache <directory>`). Кэш s3fs растет неограниченно и вам необходимо позаботиться о его регулярной очистке. Подробности читайте в [документации s3fs](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Fuse-Over-Amazon#details).

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Установка {#installation}

Для установки s3fs воспользуйтесь [инструкцией](https://github.com/s3fs-fuse/s3fs-fuse#installation) в репозитории проекта.

## Настройка {#setup}

Для настройки s3fs сохраните идентификатор ключа и секретный ключ в файле `~/.passwd-s3fs` в формате `<идентификатор ключа>:<секретный ключ>`, а также ограничьте доступ к файлу `~/.passwd-s3fs` следующим образом:

```
echo <идентификатор ключа>:<секретный ключ> > ~/.passwd-s3fs
chmod 600 ~/.passwd-s3fs
```

## Монтирование бакета {#mounting-bucket}

1. Выберите каталог, в который вы будете монтировать бакет, и убедитесь, что у вас достаточно прав для операции монтирования.
2. Выполните команду вида:

    ```
    s3fs <имя бакета> /mount/<путь к папке> -o passwd_file=$HOME/.passwd-s3fs \
        -o url=https://{{ s3-storage-host }} -o use_path_request_style
    ```

Можно настроить монтирование бакета при запуске системы, для этого добавьте в файл `/etc/fstab` строку вида:

```
s3fs#<имя бакета> /mount/<путь к папке> fuse _netdev,allow_other,use_path_request_style,url=https://{{ s3-storage-host }},passwd_file=/home/<имя пользователя>/.passwd-s3fs 0 0
```

Описание всех параметров s3fs смотрите в [вики проекта](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Fuse-Over-Amazon) на GitHub.

