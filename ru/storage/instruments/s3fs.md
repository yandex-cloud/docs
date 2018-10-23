# s3fs

[s3fs](https://github.com/s3fs-fuse/s3fs-fuse) — программа для Linux и MacOS, позволяющая монтировать корзины [!KEYREF objstorage-name] через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).

## Подготовка к работе {#preparations}

[!INCLUDE [storage-s3-http-api-preps](../_includes_service/storage-s3-http-api-preps.md)]

## Установка {#installation}

Для установки s3fs воспользуйтесь [инструкцией](https://github.com/s3fs-fuse/s3fs-fuse#installation) в репозитории проекта.

## Настройка {#setup}

Для настройки s3fs сохраните идентификатор ключа и секретный ключ в файле `~/.passwd-s3fs` в формате `ACCESS_KEY_ID:SECRET_ACCESS_KEY`, а также ограничьте доступ к файлу `~/.passwd-s3fs` следующим образом:

```
echo ACCESS_KEY_ID:SECRET_ACCESS_KEY >  ~/.passwd-s3fs
chmod 600  ~/.passwd-s3fs
```

## Монтирование корзины

1. Выберите каталог, в который вы будете монтировать корзину и убедитесь, что у вас достаточно прав для операции монтирования.
2. Выполните команду вида:

    ```
    s3fs bucket-name /mount/folder/name -o passwd_file=~/.passwd-s3fs -o url=http://storage.yandexcloud.net -o use_path_request_style
    ```

Можно настроить монтирование корзины при запуске системы для этого добавьте в файл `/etc/fstab` строку вида:

```
s3fs#bucket-name /mount/folder/name fuse _netdev,allow_other,use_path_request_style,url=http://storage.yandexcloud.net 0 0
```
