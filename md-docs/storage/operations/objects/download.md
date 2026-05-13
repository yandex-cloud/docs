# Скачивание объекта


Чтобы работать с объектами в [зашифрованном](../../concepts/encryption.md) бакете, у пользователя или [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) вместе с [ролью](../../security/index.md#storage-configurer) `storage.configurer` должны быть следующие [роли на ключ шифрования](../../../kms/operations/key-access.md):

* `kms.keys.encrypter` — для чтения ключа, [шифрования](../../../kms/security/index.md#kms-keys-encrypter) и загрузки объектов;
* `kms.keys.decrypter` — для чтения ключа, [расшифровки](../../../kms/security/index.md#kms-keys-decrypter) и скачивания объектов;
* `kms.keys.encrypterDecrypter` — включает [разрешения](../../../kms/security/index.md#kms-keys-encrypterDecrypter), предоставляемые ролями `kms.keys.encrypter` и `kms.keys.decrypter`.

Подробнее см. [Сервисные роли Key Management Service](../../../kms/security/index.md#service-roles).


{% note info %}

Чтобы скачать группу объектов с определенным префиксом ([папку](../../concepts/object.md#folder) с объектами) или все объекты из бакета, используйте AWS CLI или совместимые с Amazon S3 API файловые браузеры, например [CyberDuck](../../tools/cyberduck.md) и [WinSCP](../../tools/winscp.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Выберите бакет, из которого вы хотите скачать объект.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **Объекты**, найдите в списке нужный объект.
  1. Напротив объекта, который вы хотите скачать, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) → **Скачать** или откройте объект и на панели сверху нажмите ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **Скачать**.

  {% note info %}

  Также чтобы скачать или загрузить объекты с помощью графического интерфейса, вы можете использовать инструменты [CyberDuck](../../tools/cyberduck.md) или [WinSCP](../../tools/winscp.md).

  {% endnote %}

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для скачивания объекта из бакета:
  
      ```bash
      yc storage s3api get-object --help
      ```
  
  1. Получите список бакетов в каталоге по умолчанию:
     
     ```bash
     yc storage bucket list
     ```
     
     Результат:
     
     ```text
     +------------------+----------------------+-------------+-----------------------+---------------------+
     |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     ```
  1. Выполните команду:
  
      ```bash
      yc storage s3api get-object \
        --bucket <имя_бакета> \
        --key <ключ_объекта> \
        <путь_для_скачивания>
      ```
  
      Где:
  
      * `--bucket` — имя вашего бакета.
      * `--key` — [ключ](../../concepts/object.md#key) объекта.
      * `<путь_для_скачивания>` — локальный путь для скачивания.
  
      Результат:
  
      ```bash
      etag: '"d41d8cd98f00b204e9800998********"'
      request_id: af194b83********
      accept_ranges: bytes
      content_type: application/octet-stream
      last_modified_at: "2024-10-08T12:36:36Z"
      server_side_encryption: aws:kms
      sse_kms_key_id: abj497vtg3h0********
      ```
  
      Альтернативная команда:
  
      ```bash
      yc storage s3 cp \
        s3://<имя_бакета>/<ключ_объекта> \
        <путь_для_скачивания>
      ```
  
      Результат:
  
      ```text
      download: s3://my-bucket/object.txt to object.txt
      ```
  
      {% cut "Настройка параметров для команды `yc storage s3 cp`" %}
  
      Вы можете настроить следующие параметры для команды `yc storage s3 cp`:
      
      * `s3.max-queue-size` — максимальное количество задач в очереди. Значение по умолчанию — `1000`.
      * `s3.max-concurrent-requests` — максимальное количество одновременных запросов. Значение по умолчанию — `10`.
      * `s3.multipart-threshold` — пороговый размер объекта, при превышении которого будет использоваться составная (multipart) загрузка. Значение по умолчанию — `8MB`.
      * `s3.multipart-chunksize` — размер частей, на которые будет делиться объект при составной (multipart) загрузке. Значение по умолчанию — `8MB`.
      
      Чтобы задать эти параметры, используйте команду `yc config set <параметр> <значение>`.
  
      {% endcut %}

- AWS CLI {#aws-cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  **Скачать один объект**

  ```bash
  aws s3 cp \
    --endpoint-url=https://storage.yandexcloud.net \
    s3://<имя_бакета>/<ключ_объекта> \
    <локальный_путь>
  ```

  Где:

  * `--endpoint-url` — эндпоинт Object Storage.
  * `<имя_бакета>` — имя бакета, из которого вы хотите скачать объект.
  * `<ключ_объекта>` — [ключ](../../concepts/object.md#key) объекта, который вы хотите скачать.
  * `<локальный_путь>` — путь к папке, в которую будет сохранен скачанный объект. Например, `~/downloads/`.

  **Скачать папку (все объекты с определенным префиксом)**

  Подробнее о папках в Object Storage см. в разделе [Папка](../../concepts/object.md#folder).

  ```bash
  aws s3 cp \
    --endpoint-url=https://storage.yandexcloud.net \
    --recursive \
    s3://<имя_бакета>/<префикс>/ \
    <локальный_путь>
  ```

  Где:

  * `--endpoint-url` — эндпоинт Object Storage.
  * `--recursive` — параметр для скачивания всех объектов с указанным префиксом.
  * `<имя_бакета>` — имя бакета, из которого вы хотите скачать объекты.
  * `<префикс>` — префикс (папка) объектов, которые вы хотите скачать, например `test/folder`.
  * `<локальный_путь>` — путь к папке, в которую будут сохранены скачанные объекты, например `~/downloads/`.

  **Скачать все объекты из бакета**

  ```bash
  aws s3 cp \
    --endpoint-url=https://storage.yandexcloud.net \
    --recursive \
    s3://<имя_бакета> \
    <локальный_путь>
  ```

  Где:

  * `--endpoint-url` — эндпоинт Object Storage.
  * `--recursive` — параметр для скачивания всех объектов бакета в локальную папку.
  * `<имя_бакета>` — имя бакета, из которого вы хотите скачать объекты.
  * `<локальный_путь>` — путь к папке, в которую будут сохранены скачанные объекты. Например, `~/downloads/`.

  Команда `aws s3 cp` — высокоуровневая, ее функциональность ограничена. Подробнее см. в [справочнике AWS CLI](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html).

  Объекты из бакета можно скачать выборочно с помощью команды `aws s3api` и шаблона запроса в формате JMESPath. Для скачивания объектов по шаблону выполните команду:

  * **Bash**:

      ```bash
      aws s3api list-objects \
          --endpoint-url https://storage.yandexcloud.net \
          --bucket <имя_бакета> \
          --query '<запрос>' \
          --output text | xargs -I {} aws s3api get-object --endpoint-url https://storage.yandexcloud.net --bucket <имя_бакета> --key {} <локальный_путь>{}
      ```

      Где:

      * `--endpoint-url` — эндпоинт Object Storage.
      * `--bucket` — имя бакета, из которого вы хотите скачать объекты.
      * `--query` — запрос в формате [JMESPath](https://jmespath.org/).
      * `<локальный_путь>` — путь к папке, в которую будут сохранены скачанные объекты. Например, `~/downloads/`.

      Пример команды для скачивания из бакета `sample-bucket` в локальную папку `~/downloads/` всех объектов, имена файлов которых начинаются с `date-20231002`:

      ```bash
      aws s3api list-objects \
        --endpoint-url https://storage.yandexcloud.net \
        --bucket sample-bucket \
        --query 'Contents[?starts_with(Key, `date-20231002`) == `true`].[Key]' \
        --output text | xargs -I {} aws s3api get-object --endpoint-url https://storage.yandexcloud.net --bucket sample-bucket --key {} ~/downloads/{}
      ```

  * **PowerShell**:

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://storage.yandexcloud.net `
        --bucket <имя_бакета> `
        --query '<запрос>' `
        --output text)) `
        {aws s3api get-object --endpoint-url https://storage.yandexcloud.net --bucket <имя_бакета> --key $x <локальный_путь>$x}
      ```

      Где:

      * `--endpoint-url` — эндпоинт Object Storage.
      * `--bucket` — имя бакета, из которого вы хотите скачать объекты.
      * `--query` — запрос в формате [JMESPath](https://jmespath.org/).
      * `<локальный_путь>` — путь к папке, в которую будут сохранены скачанные объекты. Например, `d:\downloads\`.

      Пример команды для скачивания из бакета `sample-bucket` в локальную папку `d:\downloads\` всех объектов, имена файлов которых начинаются с `date-20231002`:

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://storage.yandexcloud.net `
        --bucket sample-bucket `
        --query 'Contents[?starts_with(Key, `date-20231002`) == `true`].[Key]' `
        --output text)) `
        {aws s3api get-object --endpoint-url https://storage.yandexcloud.net --bucket sample-bucket --key $x d:\downloads\$x}
      ```

- API {#api}

  Чтобы скачать объект, воспользуйтесь методом S3 API [get](../../s3/api-ref/object/get.md).

{% endlist %}

#### См. также {#see-also}


* [Получение подписанной ссылки (pre-signed URL) на скачивание объекта](link-for-download.md)
* [Обзор способов управления доступом в Object Storage](../../security/overview.md)