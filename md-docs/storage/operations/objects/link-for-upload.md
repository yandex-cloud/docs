[Документация Yandex Cloud](../../../index.md) > [Yandex Object Storage](../../index.md) > [Пошаговые инструкции](../index.md) > Объекты > Загрузка объекта по подписанной ссылке (pre-signed URL)

# Получение подписанной ссылки (pre-signed URL) на загрузку объекта

Если у вас публичный бакет, загрузка объектов доступна всегда, даже если для бакета не настроен [хостинг сайта](../../concepts/hosting.md). Ссылку можно получить по этой инструкции либо сформировать самостоятельно. [Подробнее про формат ссылки](../../concepts/object.md#object-url).

Если у вас бакет с ограниченным доступом, то Object Storage позволяет сгенерировать подписанную ссылку на загрузку объекта. Любой человек, получивший эту ссылку, сможет загрузить объект даже в бакет с ограниченным доступом. [Подробнее про подписанные ссылки, их генерацию и использование](../../concepts/pre-signed-urls.md).

{% note info %}

Если для бакета настроена [политика доступа](../buckets/policy.md), запрещающая создание подписанных ссылок, создать ссылку не получится. 

{% endnote %}

{% list tabs group=instructions %}

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
  
  1. Сгенерируйте подписанную ссылку. Вы можете сделать это либо с помощью API Yandex Cloud от имени [аккаунта](../../../iam/concepts/users/accounts.md), аутентифицированного в текущий момент в профиле Yandex Cloud CLI, либо локально от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), передав в команде данные его [статического ключа доступа](../../../iam/concepts/authorization/access-key.md).
  
      {% list tabs %}
  
      - С помощью API Yandex Cloud
  
        Чтобы сгенерировать подписанную ссылку на загрузку объекта от имени аккаунта, аутентифицированного в текущий момент в профиле Yandex Cloud CLI, выполните команду:
  
        ```bash
        yc storage s3 presign \
          s3://<имя_бакета>/<ключ_объекта> \
          --expires-in <срок_действия_ссылки> \
          --http-method PUT
        ```
  
        Где:
  
        * `<имя_бакета>` — [имя бакета](../../concepts/bucket.md#naming), в который будет загружен объект. Например: `first-bucket`.
        * `<ключ_объекта>` — имя объекта (файла), которое будет использовано в бакете. Например: `sample.txt`.
        * `--expires-in` — срок действия ссылки в секундах.
        * `--http-method PUT` — HTTP-метод для загрузки объекта в бакет. Обязательный параметр для генерации ссылки на загрузку.
  
        Результат:
  
        ```text
        https://storage.yandexcloud.net/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEwkbVN5BKvE2wqYiZCzlQ%2F20260205%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20260205T131200Z&X-Amz-Expires=3600&X-Amz-Signature=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&X-Amz-SignedHeaders=host
        ```
  
      - Локально
  
        Чтобы сгенерировать подписанную ссылку на загрузку объекта локально от имени сервисного аккаунта, выполните команду:
  
        ```bash
        yc storage s3 presign \
          s3://<имя_бакета>/<ключ_объекта> \
          --expires-in <срок_действия_ссылки> \
          --http-method PUT \
          --local \
          --access-key <идентификатор_ключа> \
          --secret-key <секретный_ключ>
        ```
  
        Где:
  
        * `<имя_бакета>` — [имя бакета](../../concepts/bucket.md#naming), в который будет загружен объект. Например: `first-bucket`.
        * `<ключ_объекта>` — имя объекта (файла), которое будет использовано в бакете. Например: `sample.txt`.
        * `--expires-in` — срок действия ссылки в секундах.
        * `--http-method PUT` — HTTP-метод для загрузки объекта в бакет. Обязательный параметр для генерации ссылки на загрузку.
  
        * `--access-key` — идентификатор статического ключа доступа сервисного аккаунта.
        * `--secret-key` — секретный ключ статического ключа доступа сервисного аккаунта.
  
        Результат:
  
        ```text
        https://storage.yandexcloud.net/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJE98uTrKJwAtqwrHJXNh5L%2F20250904%2Fdefault%2Fs3%2Faws4_request&X-Amz-Date=20250904T072650Z&X-Amz-Expires=36000&X-Amz-SignedHeaders=host&x-id=PutObject&X-Amz-Signature=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        ```
  
      {% endlist %}
  
  1. Чтобы загрузить файл по полученной подписанной ссылке, выполните команду:
  
     ```bash
     curl --request PUT \
       --upload-file <путь_к_файлу> \
       "<полученная_подписанная_ссылка>"
     ```
  
     Где:
     * `<путь_к_файлу>` — путь к файлу на локальном компьютере, который нужно загрузить в бакет. Например: `~/sample.txt` или `./sample.txt`.
     * `<полученная_подписанная_ссылка>` — URL, полученный на предыдущем шаге.
  
     Пример:
  
     ```bash
     curl --request PUT \
       --upload-file ~/sample.txt \
       "https://storage.yandexcloud.net/first-bucket/sample.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEwkbVN5BKvE2wqYiZCzlQ%2F20260205%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20260205T131200Z&X-Amz-Expires=3600&X-Amz-Signature=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX&X-Amz-SignedHeaders=host"
     ```
  
     Если файл успешно загружен, команда не выведет никакого сообщения. Чтобы увидеть детали запроса, добавьте флаг `--verbose`.

- SDK для Python (boto3) {#sdk-python}

  Перед использованием примеров сохраните необходимые аутентификационные данные в переменные окружения:
  
  ```bash
  export AWS_ACCESS_KEY_ID="<идентификатор_статического_ключа>"
  export AWS_SECRET_ACCESS_KEY="<секретный_ключ>"
  export AWS_DEFAULT_REGION="ru-central1"
  export AWS_REGION="ru-central1"
  export AWS_ENDPOINT_URL="https://storage.yandexcloud.net"
  ```
  
  Где:
  * `AWS_ACCESS_KEY_ID` — [идентификатор](../../../iam/concepts/authorization/access-key.md#key-id) статического ключа доступа.
  * `AWS_SECRET_ACCESS_KEY` — [секретный ключ](../../../iam/concepts/authorization/access-key.md#private-key).
  
  Код в примерах генерирует подписанный URL для загрузки объекта с заданным [ключом](../../concepts/object.md#key) в заданный бакет. Полученный URL действителен в течение одного часа.
  
  В данном примере размер загружаемого объекта ограничен и не может превышать заданного в коде значения — 5 МБ.
  
  [Установите](https://github.com/boto/boto3/blob/develop/README.rst#quick-start) boto3 и выполните код:
  
  ```python
  import logging
  import boto3
  from botocore.exceptions import ClientError
  import json
  
  
  def create_presigned_post(bucket_name, object_name, max_size, expiration, fields=None):
  
      conditions = [["content-length-range", 1, max_size]]
  
      s3_client = boto3.client("s3")
      try:
          response = s3_client.generate_presigned_post(
              bucket_name,
              object_name,
              Fields=fields,
              Conditions=conditions,
              ExpiresIn=expiration,
          )
      except ClientError as e:
          logging.error(e)
          return None
  
      return response
  
  
  def main():
  
      bucket_name = "<имя_бакета>"
      object_name = "<ключ_загружаемого_объекта>"
      max_size = 5 * 1024 * 1024  # Максимальный размер загружаемого объекта в байтах
      lifespan = 3600 # Срок действия ссылки в секундах
  
      response = create_presigned_post(bucket_name, object_name, max_size, lifespan)
  
      print("Подписанная ссылка и данные для загрузки созданы успешно:")
      print(json.dumps(response, indent=4))
  
  
  if __name__ == "__main__":
      main()
  ```
  
  Где:
  * `bucket_name` — [имя бакета](../../concepts/bucket.md#naming), в который загружается файл.
  * `object_name` — [ключ](../../concepts/object.md#key), который будет присвоен объекту в бакете. Например: `new-prefix/sample-object.txt`.
  * `max_size` — максимально допустимый размер загружаемого файла в байтах.
  
  Результат:
  
  ```json
  Подписанная ссылка и данные для загрузки созданы успешно:
  {
      "url": "https://storage.yandexcloud.net/my-sample-bucket",
      "fields": {
          "key": "new-prefix/sample-object.txt",
          "x-amz-algorithm": "AWS4-HMAC-SHA256",
          "x-amz-credential": "YCAJE98uTrKJwAtqw********/20250516/ru-central1/s3/aws4_request",
          "x-amz-date": "20250516T145901Z",
          "policy": "eyJleHBpcmF0aW9uIjogIjIwMjUtMDUtMTZUMTU6NTk6MDFaIiwgImNvbmRpdGlvbnMiOiBbWyJjb250ZW50LWxlbmd0aC1yYW5nZSIsIDEsIDUyNDI4ODBdLCB7ImJ1Y2tldCI6ICJhbHRhcmFza2luLXRlc3Rlci1idWNrZXQifSwgeyJrZXkiOiAiZmlsZS50eHQifSwgeyJ4LWFtei1hbGdvcml0aG0iOiAiQVdTNC1ITUFDLVNIQTI1NiJ9LCB7IngtYW16LWNyZWRlbnRpYWwiOiAiWUNBSkU5OHVUcktKd0F0cXdySEpYTmg1TC8yMDI1MDUxNi9ydS1jZW50cmFsMS9zMy9hd3M0X3JlcXVlc3QifSwgeyJ4LWFtei1kYXRlIjogIjIwMjUwNTE2VDE0NTkw********",
          "x-amz-signature": "c2e1783095d20d89a7683fc582527740541de16156569d9950cfb1b7********"
      }
  }
  ```
  
  Используя полученные компоненты, отправьте HTTP-запрос на загрузку файла методом POST:
  
  ```bash
  curl \
    --request POST \
    --form "key=new-prefix/sample-object.txt" \
    --form "x-amz-algorithm=AWS4-HMAC-SHA256" \
    --form "x-amz-credential=YCAJE98uTrKJwAtqw********/20250516/ru-central1/s3/aws4_request" \
    --form "x-amz-date=20250516T145901Z" \
    --form "policy=eyJleHBpcmF0aW9uIjogIjIwMjUtMDUtMTZUMTU6NTk6MDFaIiwgImNvbmRpdGlvbnMiOiBbWyJjb250ZW50LWxlbmd0aC1yYW5nZSIsIDEsIDUyNDI4ODBdLCB7ImJ1Y2tldCI6ICJhbHRhcmFza2luLXRlc3Rlci1idWNrZXQifSwgeyJrZXkiOiAiZmlsZS50eHQifSwgeyJ4LWFtei1hbGdvcml0aG0iOiAiQVdTNC1ITUFDLVNIQTI1NiJ9LCB7IngtYW16LWNyZWRlbnRpYWwiOiAiWUNBSkU5OHVUcktKd0F0cXdySEpYTmg1TC8yMDI1MDUxNi9ydS1jZW50cmFsMS9zMy9hd3M0X3JlcXVlc3QifSwgeyJ4LWFtei1kYXRlIjogIjIwMjUwNTE2VDE0NTkw********" \
    --form "x-amz-signature=c2e1783095d20d89a7683fc582527740541de16156569d9950cfb1b7********" \
    --form "file=@sample-object.txt" \
    https://storage.yandexcloud.net/my-sample-bucket
  ```
  
  Где `@sample-object.txt` — путь к файлу, который нужно загрузить.
  
  В результате файл будет загружен в бакет, если размер файла не превышает заданное в коде значение. Если файл больше установленного максимума, сервис вернет ошибку:
  
  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <Error>
      <Code>EntityTooLarge</Code>
      <Message>Your proposed upload exceeds the maximum allowed object size.</Message>
      <Resource>/</Resource>
      <RequestId>5575e8faa94e02b2</RequestId>
      <MaxSizeAllowed>5242880</MaxSizeAllowed>
      <ProposedSize>15728640</ProposedSize>
  </Error>
  ```

- SDK для JavaScript {#sdk-javascript}

  Перед использованием примеров сохраните необходимые аутентификационные данные в переменные окружения:
  
  ```bash
  export AWS_ACCESS_KEY_ID="<идентификатор_статического_ключа>"
  export AWS_SECRET_ACCESS_KEY="<секретный_ключ>"
  export AWS_DEFAULT_REGION="ru-central1"
  export AWS_REGION="ru-central1"
  export AWS_ENDPOINT_URL="https://storage.yandexcloud.net"
  ```
  
  Где:
  * `AWS_ACCESS_KEY_ID` — [идентификатор](../../../iam/concepts/authorization/access-key.md#key-id) статического ключа доступа.
  * `AWS_SECRET_ACCESS_KEY` — [секретный ключ](../../../iam/concepts/authorization/access-key.md#private-key).
  
  Код в примерах генерирует подписанный URL для загрузки объекта с заданным [ключом](../../concepts/object.md#key) в заданный бакет. Полученный URL действителен в течение одного часа.
  
  В данном примере размер загружаемого объекта ограничен и не может превышать заданного в коде значения — 5 МБ.
  
  В примере используются библиотеки [@aws-sdk/client-s3](https://www.npmjs.com/package/@aws-sdk/client-s3) и [@aws-sdk/s3-presigned-post](https://www.npmjs.com/package/@aws-sdk/s3-presigned-post).
  
  Выполните код:
  
  ```js
  import { S3Client } from "@aws-sdk/client-s3";
  import { createPresignedPost } from "@aws-sdk/s3-presigned-post";
  
  const client = new S3Client();
  const Bucket = "<имя_бакета>";
  const Key = "<ключ_загружаемого_объекта>";
  const max_size = 5 * 1024 * 1024;  // Максимальный размер загружаемого объекта в байтах
  
  const Conditions = [["content-length-range", 1, max_size]];
  
  const url = await createPresignedPost(client, {
    Bucket,
    Key,
    Conditions,
    Expires: 3600, // Срок действия ссылки в секундах
  });
  
  console.log(url)
  ```
  
  Где:
  * `Bucket` — [имя бакета](../../concepts/bucket.md#naming), в который загружается файл.
  * `Key` — [ключ](../../concepts/object.md#key), который будет присвоен объекту в бакете. Например: `new-prefix/sample-object.txt`.
  * `max_size` — максимально допустимый размер загружаемого файла в байтах.
  
  Результат:
  
  ```txt
  {
    url: 'https://my-sample-bucket.storage.yandexcloud.net/',
    fields: {
      bucket: 'my-sample-bucket',
      'X-Amz-Algorithm': 'AWS4-HMAC-SHA256',
      'X-Amz-Credential': 'YCAJE98uTrKJwAtqw********/20250516/ru-central1/s3/aws4_request',
      'X-Amz-Date': '20250516T210215Z',
      key: 'new-prefix/sample-object.txt',
      Policy: 'eyJleHBpcmF0aW9uIjoiMjAyNS0wNS0xNlQyMjowMjoxNVoiLCJjb25kaXRpb25zIjpbWyJjb250ZW50LWxlbmd0aC1yYW5nZSIsMSw1MjQyODgwXSx7ImJ1Y2tldCI6ImFsdGFyYXNraW4tdGVzdGVyLWJ1Y2tldCJ9LHsiWC1BbXotQWxnb3JpdGhtIjoiQVdTNC1ITUFDLVNIQTI1NiJ9LHsiWC1BbXotQ3JlZGVudGlhbCI6IllDQUpFOTh1VHJLSndBdHF3ckhKWE5oNUwvMjAyNTA1MTYvcnUtY2VudHJhbDEvczMvYXdzNF9yZXF1ZXN0In0seyJYLUFtei1EYXRlIjoiMjAyNTA1MTZUMjEwMjE1WiJ9LHsia2V5IjoiZmlsZS50********',
      'X-Amz-Signature': '2a8be28a4e2a72de98bd258a8362dd895dd0fdb1886a1764e7085282********'
    }
  }
  ```
  
  Используя полученные компоненты, отправьте HTTP-запрос на загрузку файла методом POST:
  
  ```bash
  curl \
    --request POST \
    --form "key=new-prefix/sample-object.txt" \
    --form "x-amz-algorithm=AWS4-HMAC-SHA256" \
    --form "x-amz-credential=YCAJE98uTrKJwAtqw********/20250516/ru-central1/s3/aws4_request" \
    --form "x-amz-date=20250516T145901Z" \
    --form "policy=eyJleHBpcmF0aW9uIjogIjIwMjUtMDUtMTZUMTU6NTk6MDFaIiwgImNvbmRpdGlvbnMiOiBbWyJjb250ZW50LWxlbmd0aC1yYW5nZSIsIDEsIDUyNDI4ODBdLCB7ImJ1Y2tldCI6ICJhbHRhcmFza2luLXRlc3Rlci1idWNrZXQifSwgeyJrZXkiOiAiZmlsZS50eHQifSwgeyJ4LWFtei1hbGdvcml0aG0iOiAiQVdTNC1ITUFDLVNIQTI1NiJ9LCB7IngtYW16LWNyZWRlbnRpYWwiOiAiWUNBSkU5OHVUcktKd0F0cXdySEpYTmg1TC8yMDI1MDUxNi9ydS1jZW50cmFsMS9zMy9hd3M0X3JlcXVlc3QifSwgeyJ4LWFtei1kYXRlIjogIjIwMjUwNTE2VDE0NTkw********" \
    --form "x-amz-signature=c2e1783095d20d89a7683fc582527740541de16156569d9950cfb1b7********" \
    --form "file=@sample-object.txt" \
    https://storage.yandexcloud.net/my-sample-bucket
  ```
  
  Где `@sample-object.txt` — путь к файлу, который нужно загрузить.
  
  В результате файл будет загружен в бакет, если размер файла не превышает заданное в коде значение. Если файл больше установленного максимума, сервис вернет ошибку:
  
  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <Error>
      <Code>EntityTooLarge</Code>
      <Message>Your proposed upload exceeds the maximum allowed object size.</Message>
      <Resource>/</Resource>
      <RequestId>5575e8faa94e02b2</RequestId>
      <MaxSizeAllowed>5242880</MaxSizeAllowed>
      <ProposedSize>15728640</ProposedSize>
  </Error>
  ```

- SDK для Go {#go}

  Перед использованием примеров сохраните необходимые аутентификационные данные в переменные окружения:
  
  ```bash
  export AWS_ACCESS_KEY_ID="<идентификатор_статического_ключа>"
  export AWS_SECRET_ACCESS_KEY="<секретный_ключ>"
  export AWS_DEFAULT_REGION="ru-central1"
  export AWS_REGION="ru-central1"
  export AWS_ENDPOINT_URL="https://storage.yandexcloud.net"
  ```
  
  Где:
  * `AWS_ACCESS_KEY_ID` — [идентификатор](../../../iam/concepts/authorization/access-key.md#key-id) статического ключа доступа.
  * `AWS_SECRET_ACCESS_KEY` — [секретный ключ](../../../iam/concepts/authorization/access-key.md#private-key).
  
  Код в примерах генерирует подписанный URL для загрузки объекта с заданным [ключом](../../concepts/object.md#key) в заданный бакет. Полученный URL действителен в течение одного часа.
  
  В данном примере размер загружаемого объекта ограничен и не может превышать заданного в коде значения — 5 МБ.
  
  [Установите](https://docs.aws.amazon.com/sdk-for-go/v2/developer-guide/getting-started.html#install-the-aws-sdk-for-go-v2) AWS SDK для Go и выполните код:
  
  ```go
  package main
  
  import (
    "context"
    "fmt"
    "log"
    "time"
  
    "github.com/aws/aws-sdk-go-v2/config"
    "github.com/aws/aws-sdk-go-v2/service/s3"
  )
  
  func main() {
    cfg, err := config.LoadDefaultConfig(context.TODO())
    if err != nil {
      log.Fatal(err)
    }
  
    client := s3.NewFromConfig(cfg)
  
    psClient := s3.NewPresignClient(client)
  
    bucket := "<имя_бакета>"
    key := "<ключ_загружаемого_объекта>"
    max_size := 5 * 1024 * 1024  // Максимальный размер загружаемого объекта в байтах
  
    req, err := psClient.PresignPostObject(
      context.TODO(),
      &s3.PutObjectInput{
        Bucket: &bucket,
        Key:    &key,
      },
      func(opts *s3.PresignPostOptions) {
        opts.Expires = time.Hour // Срок действия ссылки
        opts.Conditions = []interface{}{
          []interface{}{"content-length-range", 1, max_size},
        }
      },
    )
    if err != nil {
      log.Fatal(err)
    }
  
    fmt.Printf("url: %v\n", req.URL)
    fmt.Println("values:")
    for k, v := range req.Values {
      fmt.Printf("%v=%v\n", k, v)
    }
  }
  ```
  
  Где:
  * `bucket` — [имя бакета](../../concepts/bucket.md#naming), в который загружается файл.
  * `key` — [ключ](../../concepts/object.md#key), который будет присвоен объекту в бакете. Например: `new-prefix/sample-object.txt`.
  * `max_size` — максимально допустимый размер загружаемого файла в байтах.
  
  Результат:
  
  ```text
  url: https://my-sample-bucket.storage.yandexcloud.net
  values:
  X-Amz-Algorithm=AWS4-HMAC-SHA256
  X-Amz-Date=20250516T152552Z
  X-Amz-Credential=YCAJE98uTrKJwAtqw********/20250516/ru-central1/s3/aws4_request
  X-Amz-Signature=9371b1924dd468a9be6b57868565ad5f99cdc7edc3b56589bea3dbfa********
  key=new-prefix/sample-object.txt
  policy=eyJjb25kaXRpb25zIjpbeyJYLUFtei1BbGdvcml0aG0iOiJBV1M0LUhNQUMtU0hBMjU2In0seyJidWNrZXQiOiJhbHRhcmFza2luLXRlc3Rlci1idWNrZXQifSx7IlgtQW16LUNyZWRlbnRpYWwiOiJZQ0FKRTk4dVRyS0p3QXRxd3JISlhOaDVMLzIwMjUwNTE2L3J1LWNlbnRyYWwxL3MzL2F3czRfcmVxdWVzdCJ9LHsiWC1BbXotRGF0ZSI6IjIwMjUwNTE2VDE1MjU1MloifSxbImNvbnRlbnQtbGVuZ3RoLXJhbmdlIiwxLDUyNDI4ODBdLHsia2V5IjoiZmlsZS50eHQifV0sImV4cGlyYXRpb24iOiIyMDI1LTA1LTE2VDE2OjI1********
  ```
  
  Используя полученные компоненты, отправьте HTTP-запрос на загрузку файла методом POST:
  
  ```bash
  curl \
    --request POST \
    --form "key=new-prefix/sample-object.txt" \
    --form "x-amz-algorithm=AWS4-HMAC-SHA256" \
    --form "x-amz-credential=YCAJE98uTrKJwAtqw********/20250516/ru-central1/s3/aws4_request" \
    --form "x-amz-date=20250516T145901Z" \
    --form "policy=eyJleHBpcmF0aW9uIjogIjIwMjUtMDUtMTZUMTU6NTk6MDFaIiwgImNvbmRpdGlvbnMiOiBbWyJjb250ZW50LWxlbmd0aC1yYW5nZSIsIDEsIDUyNDI4ODBdLCB7ImJ1Y2tldCI6ICJhbHRhcmFza2luLXRlc3Rlci1idWNrZXQifSwgeyJrZXkiOiAiZmlsZS50eHQifSwgeyJ4LWFtei1hbGdvcml0aG0iOiAiQVdTNC1ITUFDLVNIQTI1NiJ9LCB7IngtYW16LWNyZWRlbnRpYWwiOiAiWUNBSkU5OHVUcktKd0F0cXdySEpYTmg1TC8yMDI1MDUxNi9ydS1jZW50cmFsMS9zMy9hd3M0X3JlcXVlc3QifSwgeyJ4LWFtei1kYXRlIjogIjIwMjUwNTE2VDE0NTkw********" \
    --form "x-amz-signature=c2e1783095d20d89a7683fc582527740541de16156569d9950cfb1b7********" \
    --form "file=@sample-object.txt" \
    https://storage.yandexcloud.net/my-sample-bucket
  ```
  
  Где `@sample-object.txt` — путь к файлу, который нужно загрузить.
  
  В результате файл будет загружен в бакет, если размер файла не превышает заданное в коде значение. Если файл больше установленного максимума, сервис вернет ошибку:
  
  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <Error>
      <Code>EntityTooLarge</Code>
      <Message>Your proposed upload exceeds the maximum allowed object size.</Message>
      <Resource>/</Resource>
      <RequestId>5575e8faa94e02b2</RequestId>
      <MaxSizeAllowed>5242880</MaxSizeAllowed>
      <ProposedSize>15728640</ProposedSize>
  </Error>
  ```

{% endlist %}

{% note info %}

Продлить срок действия подписанной ссылки на объект в бакете с ограниченным доступом нельзя. Если срок действия ссылки истек, сформируйте новую ссылку.

{% endnote %}

#### Полезные ссылки {#see-also}

* [Получение подписанной ссылки (pre-signed URL) на скачивание объекта](link-for-download.md)