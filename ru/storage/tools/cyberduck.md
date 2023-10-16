# CyberDuck

[CyberDuck](https://cyberduck.io/) — это графический клиент для работы с облачными хранилищами, в том числе совместимыми с [Amazon S3 API](../../glossary/s3.md). CyberDuck доступен для macOS и Windows, а также в виде [консольного клиента](https://duck.sh/) для Linux.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare-with-bucket](../../_includes/aws-tools/aws-tools-prepare-with-bucket.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

[Скачайте](https://cyberduck.io/download/) дистрибутив CyberDuck для вашей операционной системы и запустите его.

## Подключение {#connection}

1. Запустите CyberDuck.
1. Нажмите кнопку **Open Connection**.
1. Выберите тип подключения — **Amazon S3**.
1. Укажите параметры подключения:
    * **Server** — `{{ s3-storage-host }}`.
    * **Port** — `443`.
    * **Access Key ID** — идентификатор статического ключа, полученный ранее.
    * **Secret Access Key** — секретный ключ, полученный ранее.
1. Нажмите кнопку **Connect**.

После подключения откроется бакет, созданный ранее.

{% note info %}

CyberDuck работает с {{ objstorage-name }} как с иерархической файловой системой. Это значит, что ключи объектов, загруженных через CyberDuck, будут иметь вид пути к файлу, например `prefix/subprefix/picture.jpg`.

{% endnote %}

Подробности о работе CyberDuck с S3-совместимыми хранилищами см. в [документации CyberDuck](https://docs.cyberduck.io/protocols/s3/).
