# goofys

[goofys](https://github.com/kahing/goofys) — программа для Linux и macOS, позволяющая монтировать бакеты {{ objstorage-name }} через [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)).

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

## Установка {#installation}

Для установки `goofys` воспользуйтесь [инструкцией](https://github.com/kahing/goofys#installation) в репозитории проекта.

## Настройка {#setup}

`goofys` использует секретный ключ из настроек [AWS CLI](aws-cli.md), хранящихся в файле `.aws/credentials`. Также можно поместить ключ в переменные окружения `AWS_ACCESS_KEY_ID` и `AWS_SECRET_ACCESS_KEY`.

## Монтирование бакета {#bucket-mounting}

1. Выберите каталог, в который вы будете монтировать бакет, и убедитесь, что у вас достаточно прав для операции монтирования.
1. Для разового монтирования бакета выполните команду вида:

    ```
    goofys --endpoint=https://{{ s3-storage-host }} <имя бакета> <точка монтирования>
    ```

Чтобы настроить монтирование бакета при запуске системы, добавьте в файл `/etc/fstab` строку вида:

```
goofys#<имя бакета>  <точка монтирования>  fuse  _netdev,allow_other,--file-mode=0666,--dir-mode=0777,--endpoint=https://{{ s3-storage-host }}  0  0
```
