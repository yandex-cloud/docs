# S3cmd

[S3cmd](https://s3tools.org/s3cmd) — это консольный клиент (Linux, Mac) для сервисов, поддерживающими HTTP API Amazon S3. Общий порядок вызова команд смотрите в [официальной документации](https://s3tools.org/usage) S3cmd.

## Подготовка к работе {#before-you-begin}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

## Установка {#installation}

Чтобы установить S3cmd, ознакомьтесь с [разделом установки](https://github.com/s3tools/s3cmd/blob/master/INSTALL.md) в репозитории S3cmd на GitHub.

## Настройка {#setup}

Для настройки S3cmd используйте команду `s3cmd --configure`. При запросе укажите значения для следующих параметров:

1. `Access Key` — введите идентификатор ключа, который вы получили при генерации [статического ключа](../../iam/concepts/authorization/access-key.md).
1. `Secret Key` — введите секретный ключ, который вы получили при генерации [статического ключа](../../iam/concepts/authorization/access-key.md).
1. `Default Region` — введите `{{ region-id }}`.

   Для работы с {{ objstorage-name }} всегда указывайте регион `{{ region-id }}`. Другие значения региона могут привести к ошибке авторизации.

1. `S3 Endpoint` — введите `{{ s3-storage-host }}`.
1. `DNS-style bucket+hostname:port template for accessing a bucket` — введите `%(bucket)s.{{ s3-storage-host }}`.
1. Значения остальных параметров оставьте без изменений.

Программа попытается установить соединение с {{ objstorage-name }} и получить список бакетов. В случае успеха, программа выведет `Success. Your access key and secret key worked fine :-)`.

Команда `s3cmd --configure` сохранит настройки в файле `~/.s3cfg` в формате:

```
[default]
access_key = id
secret_key = secretKey
bucket_location = {{ region-id }}
host_base = {{ s3-storage-host }}
host_bucket = %(bucket)s.{{ s3-storage-host }}
```

При необходимости эти настройки можно изменить напрямую в файле. Также можно указать настройки при запуске программы с помощью соответствующих параметров.

Для корректной работы команд, управляющих хостингом статических сайтов, в конфигурационный файл необходимо вручную добавить параметр

```
website_endpoint = http://%(bucket)s.{{ s3-web-host }}
```

## Особенности {#specifics}

- S3cmd работает с {{ objstorage-name }} как с иерархической файловой системой и ключи объектов имеют вид пути к файлу.
- По умолчанию S3cmd загружает объекты в стандартное хранилище. Чтобы указать [класс хранилища](../concepts/storage-class.md), при загрузке объекта используйте ключ `--storage-class`.
- По умолчанию при загрузке объекта S3cmd может отправлять дополнительный заголовок `X-Amz-Meta-S3cmd-Attrs` с атрибутами вашего файла (права доступа, владельцы файла, временны́е метки). Значение заголовка сохраняется в [метаданных](../concepts/object.md#metadata) объекта. Отключить отправку атрибутов можно с помощью параметра `preserve_attrs = False` в конфигурационном файле `~/.s3cfg` или ключа `--no-preserve`.

## Примеры операций {#s3cmd-examples}

{% note info %}

Для включения отладочного вывода в консоли используйте ключ `--debug`.

{% endnote %}

### Получить список бакетов {#listing-buckets}

{% include [sa-acl-bucket-list-note](../../_includes/storage/sa-acl-bucket-list-note.md) %}

```bash
s3cmd ls
```

### Создать бакет {#creating-bucket}

```bash
s3cmd mb s3://bucket
```

При создании бакета помните об [ограничениях на имя](../concepts/bucket.md#naming).

### Загрузить объект в холодное хранилище {#uploading-object}

```
s3cmd --storage-class COLD put local_file s3://bucket/object
```

### Получить список объектов {#getting-object-list}

```bash
s3cmd ls s3://bucket
```

### Получить объект {#retrieving-object}

```bash
s3cmd get s3://bucket/object local_file
```

### Удалить объект {#deleting-object}

```bash
s3cmd del s3://bucket/object
```
