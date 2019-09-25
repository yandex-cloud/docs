# s3fs

[s3fs](https://github.com/s3fs-fuse/s3fs-fuse) — программа для Linux и macOS, позволяющая монтировать бакеты {{ objstorage-name }} через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).

{% note info %}

Рекомендуется использовать s3fs с версией не ниже 1.84.

{% endnote %}

Если у вас возникнут вопросы, обратитесь к [официальной документации](https://github.com/s3fs-fuse/s3fs-fuse/wiki) проекта, в частности к разделу [FAQ](https://github.com/s3fs-fuse/s3fs-fuse/wiki/FAQ), который содержит решения для многих проблем, возникающих при использовании s3fs.

## Подготовка к работе {#preparations}

{% include [storage-s3-http-api-preps](../_includes_service/storage-s3-http-api-preps.md) %}

## Установка {#installation}

Для установки s3fs воспользуйтесь [инструкцией](https://github.com/s3fs-fuse/s3fs-fuse#installation) в репозитории проекта.

## Настройка {#setup}

Для настройки s3fs сохраните идентификатор ключа и секретный ключ в файле `~/.passwd-s3fs` в формате `<идентификатор ключа>:<секретный ключ>`, а также ограничьте доступ к файлу `~/.passwd-s3fs` следующим образом:

```
echo <идентификатор ключа>:<секретный ключ> >  ~/.passwd-s3fs
chmod 600  ~/.passwd-s3fs
```

## Монтирование бакета

1. Выберите каталог, в который вы будете монтировать бакет и убедитесь, что у вас достаточно прав для операции монтирования.
2. Выполните команду вида:

    ```
    s3fs <имя бакета> /mount/<путь к папке> -o passwd_file=~/.passwd-s3fs \
        -o url=http://storage.yandexcloud.net -o use_path_request_style
    ```

Можно настроить монтирование бакета при запуске системы, для этого добавьте в файл `/etc/fstab` строку вида:

```
s3fs#<имя бакета> /mount/<путь к папке> fuse _netdev,allow_other,use_path_request_style,url=http://storage.yandexcloud.net 0 0
```

Описание всех параметров s3fs смотрите в [вики проекта](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Fuse-Over-Amazon) на GitHub.

