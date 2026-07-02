[Документация Yandex Cloud](../../../index.md) > [Yandex Object Storage](../../index.md) > [Пошаговые инструкции](../index.md) > Объекты > Скачивание объекта по подписанной ссылке (pre-signed URL)

# Получение подписанной ссылки (pre-signed URL) на скачивание объекта

Если у вас публичный бакет, объекты доступны всегда, даже если для бакета не настроен [хостинг сайта](../../concepts/hosting.md). Ссылку можно получить по этой инструкции либо сформировать самостоятельно. [Подробнее про формат ссылки](../../concepts/object.md#object-url).

Если у вас бакет с ограниченным доступом, то Object Storage позволяет сгенерировать подписанную ссылку на объект. Любой человек, получивший эту ссылку, сможет скачать объект даже из бакета с ограниченным доступом. [Подробнее про подписанные ссылки, их генерацию и использование](../../concepts/pre-signed-urls.md).

{% note info %}

Если для бакета настроена [политика доступа](../buckets/policy.md), запрещающая создание подписанных ссылок, создать ссылку не получится. 

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Нажмите на имя необходимого бакета.
  1. Нажмите на имя объекта.
  1. Нажмите ![link](../../../_assets/storage/link.svg) **Получить ссылку** в правом верхнем углу.
  1. Для бакета с ограниченным доступом укажите **Время жизни** ссылки в часах или днях (максимум 30 дней).
  1. Нажмите **Получить ссылку**.
  1. Скопируйте полученную ссылку.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Посмотрите описание команды CLI для получения подписанной ссылки на объект:
  
      ```bash
      yc storage s3 presign --help
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
  1. Посмотрите список объектов в бакете, указав его [имя](../../concepts/bucket.md#naming):
  
      ```bash
      yc storage s3api list-objects \
        --bucket <имя_бакета>
      ```
  
      Результат:
  
      ```text
      contents:
        - key: sample.txt
          last_modified: "2025-09-04T06:02:16.884Z"
          etag: '"7bd56d2f6096d582420e8a01********"'
          size: "17"
          owner:
            id: ajeol2afu1js********
            display_name: ajeol2afu1js********
          storage_class: STANDARD
      name: first-bucket
      max_keys: "1000"
      key_count: "1"
      request_id: 338862e1********
      ```
  
  1. Сгенерируйте подписанную ссылку. Вы можете сделать это либо с помощью API Yandex Cloud от имени [аккаунта](../../../iam/concepts/users/accounts.md), аутентифицированного в текущий момент в профиле Yandex Cloud CLI, либо локально от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), передав в команде данные его [статического ключа доступа](../../../iam/concepts/authorization/access-key.md).
  
      {% list tabs %}
  
      - С помощью API Yandex Cloud
  
        Чтобы сгенерировать подписанную ссылку на скачивание объекта от имени аккаунта, аутентифицированного в текущий момент в профиле Yandex Cloud CLI, выполните команду:
  
        ```bash
        yc storage s3 presign \
          s3://<имя_бакета>/<ключ_объекта> \
          --expires-in <срок_действия_ссылки> \
          --as-attachment
        ```
  
        Где:
  
        * `<имя_бакета>` — [имя бакета](../../concepts/bucket.md#naming), в котором содержится нужный объект. Например: `first-bucket`.
        * `<ключ_объекта>` — [ключ объекта](../../concepts/object.md#key) в бакете, для которого нужно сгенерировать подписанную ссылку. Например: `sample.txt`.
        * `--expires-in` — срок действия ссылки в секундах.
        * `--as-attachment` — опция, вызывающая принудительное скачивание объекта при переходе по полученной ссылке в браузере. Необязательный параметр. Если опция не задана, при переходе по ссылке вместо скачивания браузер может попытаться отобразить содержимое текстового объекта.
  
        Результат:
  
        ```text
        https://storage.yandexcloud.net/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEIUp_5V5nBFDgIgh-NLc2%2F20250904%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20250904T063033Z&X-Amz-Expires=36000&X-Amz-Signature=d661b64566753dba1ef66b467e56db0e7f7c69581b0ddd2c8a0a7b505bc3ff61&X-Amz-SignedHeaders=host&response-content-disposition=attachment
        ```
  
      - Локально
  
        Чтобы сгенерировать подписанную ссылку на скачивание объекта локально от имени сервисного аккаунта, выполните команду:
  
        ```bash
        yc storage s3 presign \
          s3://<имя_бакета>/<ключ_объекта> \
          --expires-in <срок_действия_ссылки> \
          --as-attachment \
          --local \
          --access-key <идентификатор_ключа> \
          --secret-key <секретный_ключ>
        ```
  
        Где:
  
        * `<имя_бакета>` — [имя бакета](../../concepts/bucket.md#naming), в котором содержится нужный объект. Например: `first-bucket`.
        * `<ключ_объекта>` — [ключ объекта](../../concepts/object.md#key) в бакете, для которого нужно сгенерировать подписанную ссылку. Например: `sample.txt`.
        * `--expires-in` — срок действия ссылки в секундах.
        * `--as-attachment` — опция, вызывающая принудительное скачивание объекта при переходе по полученной ссылке в браузере. Необязательный параметр. Если опция не задана, при переходе по ссылке вместо скачивания браузер может попытаться отобразить содержимое текстового объекта.
  
        * `--access-key` — идентификатор статического ключа доступа сервисного аккаунта.
        * `--secret-key` — секретный ключ статического ключа доступа сервисного аккаунта.
  
        Результат:
  
        ```text
        https://storage.yandexcloud.net:443/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJE98uTrKJwAtqwrHJXNh5L%2F20250904%2Fdefault%2Fs3%2Faws4_request&X-Amz-Date=20250904T072650Z&X-Amz-Expires=36000&X-Amz-SignedHeaders=host&response-content-disposition=attachment&x-id=GetObject&X-Amz-Signature=e60562ef242588eec44916ad9e97d2864b250a73f4e5a70e29bb2bd8926249b0
        ```
  
      {% endlist %}

- AWS CLI {#aws-cli}

  Ссылку на скачивание объекта можно сгенерировать с помощью AWS CLI. Для этого выполните команду:
  
  ```bash
  aws s3 presign s3://<имя_бакета>/<ключ_объекта> \
    --expires-in <время_жизни_ссылки> \
    --endpoint-url "https://storage.yandexcloud.net/"
  ```
  
  Чтобы ссылка сформировалась корректно, обязательно укажите параметр `--endpoint-url` с указанием доменного имени Object Storage. Подробнее в [разделе об особенностях работы AWS CLI](../../tools/aws-cli.md#specifics).

- SDK для Python (boto3) {#sdk-python}

  Пример генерирует подписанный URL для скачивания объекта `object-for-share` из бакета `bucket-with-objects`. URL действителен в течение 100 секунд.
  
  ```python
  # coding=utf-8
  
  import boto3
  from botocore.client import Config
  
  
  ENDPOINT = "https://storage.yandexcloud.net"
  
  ACCESS_KEY = "JK38EXAMP********"
  SECRET_KEY = "ExamP1eSecReTKeykdo********"
  
  session = boto3.Session(
       aws_access_key_id=ACCESS_KEY,
       aws_secret_access_key=SECRET_KEY,
       region_name="ru-central1",
  )
  s3 = session.client(
       "s3", endpoint_url=ENDPOINT, config=Config(signature_version="s3v4")
  )
  
  presigned_url = s3.generate_presigned_url(
       "get_object",
       Params={"Bucket": "bucket-with-objects", "Key": "object-for-share"},
       ExpiresIn=100,
  )
  
  print(presigned_url)
  ```

- SDK для JavaScript {#sdk-javascript}

  Пример генерирует подписанный URL для скачивания объекта `object-for-share` из бакета `bucket-with-objects`. URL действителен в течение 100 секунд.
  
  В примере используются библиотеки [@aws-sdk/client-s3](https://www.npmjs.com/package/@aws-sdk/client-s3) и [@aws-sdk/s3-request-presigner](https://www.npmjs.com/package/@aws-sdk/s3-request-presigner).
  
  ```js
  import { S3Client, GetObjectCommand } from "@aws-sdk/client-s3";
  import { getSignedUrl } from "@aws-sdk/s3-request-presigner";
  
  const S3_ENDPOINT = "https://storage.yandexcloud.net";
  
  const ACCESS_KEY_ID = "JK38EXAMP********";
  const SECRET_ACCESS_KEY = "ExamP1eSecReTKeykdo********";
  
  const s3Client = new S3Client({
    region: "ru-central1",
    endpoint: S3_ENDPOINT,
    credentials: {
       accessKeyId: ACCESS_KEY_ID,
       secretAccessKey: SECRET_ACCESS_KEY,
    },
  });
  
  const command = new GetObjectCommand({
    Bucket: "bucket-with-objects",
    Key: "object-for-share",
  });
  const objectPresignedUrl = await getSignedUrl(s3Client, command, {
    expiresIn: 100,
  });
  
  console.log(objectPresignedUrl);
  ```

{% endlist %}

{% note info %}

Продлить срок действия подписанной ссылки на объект в бакете с ограниченным доступом нельзя. Если срок действия ссылки истек, сформируйте новую ссылку.

{% endnote %}

#### Полезные ссылки {#see-also}

* [Получение подписанной ссылки (pre-signed URL) на загрузку объекта](link-for-upload.md)