# S3cmd

[S3cmd](https://s3tools.org/s3cmd) — это интерфейс командной строки для работы с сервисами провайдров, поддерживающих работу по протоколу S3. Общий [порядок вызова команд](https://s3tools.org/usage) смотрите в официальной документации S3cmd.

Для работы с [!KEYREF objstorage-full-name] с помощью S3cmd вы можете использовать следующие наборы команд:
...

## Подготовка к работе {#preparations}

1. Создайте сервисный аккаунт.
1. [Получите необходимые роли](../security/index.md).
1. [Получите статический ключ](../operations/security/get-static-key.md).

## Установка {#installation}

Для устновки S3cmd воспользуйтесь [инструкцией](https://github.com/s3tools/s3cmd/blob/master/INSTALL).

## Настройка {#setup}

Для настройки S3cmd используйте команду `s3cmd --configure`. Команда запросит значения для следующих параметров:

1. `Access Key` — введите значение `id`, которое вы получили при генерации статического ключа.
1. `Secret Key` — введите значение `secretKey`, которое вы получили при генерации секретного ключа.
1. `Default Region` — введите значение `us-east-1`.
   
   > [!NOTE]
   >
   > Для работы с Yandex Object Storage всегда указывайте регион — `us-east-1`. Другие значения региона могут привести к ошибке авторизации.
   >
1. `S3 Endpoint` - введите значение `storage.cloud.yandex.net`.
1. `DNS-style bucket+hostname:port template for accessing a bucket` - введите значение `%(bucket)s.storage.cloud.yandex.net`.
1. Значения остальных параметров оставьте без изменений.

### Конфигурационные файлы {#config-files}

В результате своей работы команда `s3cmd --configure` сохранит настройки в файле:

- Значения параметров в `~/.s3cfg` в формате:
    ```
    [default]
    access_key = id
    secret_key = secretKey
    bucket_location = us-east-1
    host_base = s3.mds.yandex.net
    host_bucket = %(bucket)s.s3.mds.yandex.net
    ```

//// далее нужны правки

## Особенности {#specifics}

При использовании S3cmd для работы с [!KEYREF objstorage-name] учитывайте следующие особенности этого инструмента:
- S3cmd работает с [!KEYREF objstorage-name] как с иерархической файловой системой и ключи объектов имеют вид пути к файлу.
- При запуске команды `aws` для работы с [!KEYREF objstorage-name] обязателен параметр `--endpoint-url`, поскольку по умолчанию клиент настроен на работу с серверами Amazon.
- При работе в Mac OS, в некоторых случаях требуется запуск вида:
    ```
    export PYTHONPATH=/Library/Python/2.7/site-packages; aws --endpoint-url=https://[!KEYREF s3-storage-host] s3 ls
    ```


## Примеры операций {#aws-cli-examples}

### Создать корзину

   ```bash
   aws --endpoint-url=https://[!KEYREF s3-storage-host] s3 mb s3://bucket-name
   ```
   
> [!NOTE]
>
> При создании корзины помните об [ограничениях на имя](../concepts/bucket.md#naming).

### Загрузить объекты

Загрузить объекты можно разными способами, например:

- Загрузить все объекты из локальной директории:
   ```bash
   aws --endpoint-url=https://[!KEYREF s3-storage-host] \
       s3 cp --recursive local_files/ s3://bucket-name/path_style_prefix/
   ```
- Загрузить объекты, описанные в фильтре `--include`, и пропустить объекты, описанные в фильтре`--exclude`:
   ```bash
   aws --endpoint-url=https://[!KEYREF s3-storage-host] \
       s3 cp --recursive --exclude "*" --include "*.log" \
       local_files/ s3://bucket-name/path_style_prefix/
   ```
- Загрузить объекты по одному, запуская для каждого объекта команду следующего вида:
   ```bash
   aws --endpoint-url=https://[!KEYREF s3-storage-host] \
       s3 cp testfile.txt s3://bucket-name/path_style_prefix/textfile.txt
   ```

### Получить список объектов

   ```bash
   aws --endpoint-url=https://[!KEYREF s3-storage-host] \
       s3 ls --recursive s3://bucket-name
   ```

### Удалить объекты

Удалить объекты можно разными способами, например:

- Удалить все объекты с заданным префиксом.
   ```bash
   aws --endpoint-url=https://[!KEYREF s3-storage-host] \
       s3 rm s3://bucket-name/path_style_prefix/ --recursive 
   ```
- Удалить объекты, описанные в фильтре `--include`, и пропустить объекты, описанные в фильтре`--exclude`:
   ```bash
   aws --endpoint-url=https://[!KEYREF s3-storage-host] \
       s3 rm s3://bucket-name/path_style_prefix/ --recursive \
       --exclude "*" --include "*.log"
   ```
- Удалить объекты по одному, запуская для каждого объекта команду следующего вида:
   ```bash
   aws --endpoint-url=https://[!KEYREF s3-storage-host] \
       s3 rm s3://bucket-name/path_style_prefix/textfile.txt
   ```

### Получить объект

   ```bash
   aws --endpoint-url=https://[!KEYREF s3-storage-host] \
       s3 cp s3://bucket-name/textfile.txt textfile.txt
   ```

