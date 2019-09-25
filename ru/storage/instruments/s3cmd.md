# S3cmd

[S3cmd](https://s3tools.org/s3cmd) — это интерфейс командной строки (Linux, Mac) для работы с сервисами, поддерживающими HTTP API Amazon S3. Общий [порядок вызова команд](https://s3tools.org/usage) смотрите в официальной документации S3cmd.

## Подготовка к работе {#preparations}

{% include [storage-s3-http-api-preps](../_includes_service/storage-s3-http-api-preps.md) %}

## Установка {#installation}

Чтобы узнать как скачать и установить S3cmd, ознакомьтесь с разделом [Download](https://s3tools.org/download) на официальном сайте проекта.

## Настройка {#setup}

Для настройки S3cmd используйте команду `s3cmd --configure`. Команда запросит значения для следующих параметров:

1. `Access Key` — введите идентификатор ключа, который вы получили при генерации статического ключа.
1. `Secret Key` — введите секретный ключ, который вы получили при генерации статического ключа.
1. `Default Region` — введите `ru-central1`.

   {% note info %}

   Для работы с {{ objstorage-name }} всегда указывайте регион `ru-central1`. Другие значения региона могут привести к ошибке авторизации.

   {% endnote %}
1. `S3 Endpoint` - введите `{{ s3-storage-host }}`.
1. `DNS-style bucket+hostname:port template for accessing a bucket` — введите  `%(bucket)s.{{ s3-storage-host }}`.
1. Значения остальных параметров оставьте без изменений.

Программа попытается установить соединение с {{ objstorage-name }} и получить список бакетов. В случае успеха, программа выведет `Success. Your access key and secret key worked fine :-)`.

Команда `s3cmd --configure` сохранит настройки в файле `~/.s3cfg` в формате:

```
[default]
access_key = id
secret_key = secretKey
bucket_location = ru-central1
host_base = {{ s3-storage-host }}
host_bucket = %(bucket)s.{{ s3-storage-host }}
```

При необходимости эти настройки можно изменить напрямую в файле. Также можно указать настройки при запуске программы с помощью соответствующих параметров.

Для корректной работы команд, управляющих хостингом статических сайтов, в конфигурационный файл необходимо вручную добавить параметр

```
website_endpoint = http://%(bucket)s.{{ s3-web-host }}
```

## Особенности {#specifics}

Помните, что S3cmd работает с {{ objstorage-name }} как с иерархической файловой системой и ключи объектов имеют вид пути к файлу.

## Примеры операций {#s3cmd-examples}

### Создать бакет

   ```bash
   s3cmd  mb s3://bucket
   ```

{% note info %}

При создании бакета помните об [ограничениях на имя](../concepts/bucket.md#naming).

{% endnote %}

### Загрузить объект

```
s3cmd put local_file s3://bucket/object
```

### Получить список объектов

```bash
s3cmd ls s3://bucket
```

### Получить объект

```bash
s3cmd get s3://bucket/object local_file
```

### Удалить объект

```bash
s3cmd del s3://bucket/object
```
