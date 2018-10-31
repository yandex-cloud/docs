# s3fs

[s3fs](https://github.com/s3fs-fuse/s3fs-fuse) — программа для Linux и macOS, позволяющая монтировать корзины [!KEYREF objstorage-name] через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).

> [!NOTE]
>
> Рекомендуется использовать s3fs с версией не ниже 1.84.

## Подготовка к работе {#preparations}

[!INCLUDE [storage-s3-http-api-preps](../_includes_service/storage-s3-http-api-preps.md)]

## Установка {#installation}

Для установки s3fs воспользуйтесь [инструкцией](https://github.com/s3fs-fuse/s3fs-fuse#installation) в репозитории проекта.

## Настройка {#setup}

Для настройки s3fs сохраните идентификатор ключа и секретный ключ в файле `~/.passwd-s3fs` в формате `<идентификатор ключа>:<секретный ключ>`, а также ограничьте доступ к файлу `~/.passwd-s3fs` следующим образом:

```
echo <идентификатор ключа>:<секретный ключ> >  ~/.passwd-s3fs
chmod 600  ~/.passwd-s3fs
```

## Монтирование корзины

1. Выберите каталог, в который вы будете монтировать корзину и убедитесь, что у вас достаточно прав для операции монтирования.
2. Выполните команду вида:

    ```
    s3fs <имя корзины> /mount/<путь к папке> -o passwd_file=~/.passwd-s3fs -o url=http://storage.yandexcloud.net -o use_path_request_style -o nocopyapi
    ```

Можно настроить монтирование корзины при запуске системы, для этого добавьте в файл `/etc/fstab` строку вида:

```
s3fs#<имя корзины> /mount/<путь к папке> fuse _netdev,allow_other,use_path_request_style,nocopyapi,url=http://storage.yandexcloud.net 0 0
```

> [!NOTE]
> 
> Обязательно используйте параметр `nocopyapi`, он обеспечивает корректное взаимодействие с HTTP API, совместимым с Amazon S3.

Описание всех параметров s3fs смотрите в [вики проекта](https://github.com/s3fs-fuse/s3fs-fuse/wiki/Fuse-Over-Amazon) на GitHub.
