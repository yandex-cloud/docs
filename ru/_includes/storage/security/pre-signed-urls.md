# Подписанные (pre-signed) URL

{% include [full-overview](./full-overview.md) %}

С помощью подписанных URL произвольный пользователь интернета может выполнять в {{ objstorage-name }} различные операции, например:

* Скачать объект.
* Загрузить объект.
* Создать бакет.

Подписанный URL — это URL, содержащий в своих параметрах данные для авторизации запроса. Составить подписанный URL может пользователь, обладающий статическими ключами доступа.

Раздел содержит общие принципы построения подписанного URL с использованием [AWS Signature V4](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html).

{% note info %}

SDK для различных языков программирования и другие инструменты для работы с AWS S3 содержат готовые методы генерирования подписанного URL, которые можно использовать и для {{ objstorage-name }}.

{% endnote %}

## Общий вид подписанного URL {#presigned-url-preview}

```
https://<имя_бакета>.{{ s3-storage-host }}/<ключ_объекта>?
     X-Amz-Algorithm=AWS4-HMAC-SHA256
    &X-Amz-Credential=<access_key-id>%2F<YYYYMMDD>%2F{{ region-id }}%2Fs3%2Faws4_request
    &X-Amz-Date=<время_в_формате_ISO_8601>
    &X-Amz-Expires=<время_жизни_ссылки>
    &X-Amz-SignedHeaders=<список_подписанных_заголовков>
    &X-Amz-Signature=<подпись>
```

Параметры подписанного URL:

Параметр | Описание
---------|---------
`X-Amz-Algorithm` | Идентифицирует версию подписи и алгоритм ее вычисления. Значение — `AWS4-HMAC-SHA256`.
`X-Amz-Credential` | Идентификатор для подписи.<br/><br/>Строка формата `<access-key-id>/<YYYYMMDD>/{{ region-id }}/s3/aws4_request`, где `<YYYYMMDD>` должна совпадать с датой, установленной в заголовке `X-Amz-Date`.
`X-Amz-Date` | Время в формате [ISO8601](https://ru.wikipedia.org/wiki/ISO_8601), например, `20180719T000000Z`. Указанная дата должна по значению (не по формату) совпадать с датой в параметре `X-Amz-Credential`.
`X-Amz-Expires` | Время в секундах, в течение которого ссылка действительна. Начало отсчета — момент, указанный в `X-Amz-Date`. Максимальное значение — 2592000 секунд (30 дней).
`X-Amz-SignedHeaders` | Заголовки запроса, которые вы хотите подписать, разделенные точкой с запятой (`;`).<br/><br/>Обязательно подписывайте заголовок `Host` и все заголовки `X-Amz-*`, которые используются в запросе. Другие заголовки подписывать не обязательно, однако чем больше вы подпишете заголовков, тем безопаснее будет запрос.
`X-Amz-Signature` | Подпись запроса.

## Составление подписанного URL {#creating-presigned-url}

{% note info %}

Для публичных бакетов необязательно генерировать подписанные ссылки. Из бакета с публичным доступом файлы можно получить как по протоколу HTTP, так и по протоколу HTTPS, даже если для бакета не настроен [хостинг сайта](../../../storage/concepts/hosting.md).

{% endnote %}

Чтобы получить подписанный URL:

1. [Составьте канонический запрос](#canonical-request).
1. [Составьте строку для подписи](#composing-string-to-sign).
1. [Сформируйте подписывающий ключ](#signing-key-gen).
1. [Вычислите подпись с помощью ключа](#signing).
1. [Сформируйте подписанный URL](#composing-signed-url).

Для составления подписанного URL необходимо обладать [статическими ключами](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) доступа.

### Канонический запрос {#canonical-request}

Общий вид канонического запроса:

```
<HTTPVerb>\n
<CanonicalURL>\n
<CanonicalQueryString>\n
<CanonicalHeaders>\n
<SignedHeaders>\n
UNSIGNED-PAYLOAD
```

#### HTTPVerb {#http-verb}

HTTP метод, которым будет отправлен запрос: `GET`, `PUT`, `HEAD` или `DELETE`.

#### CanonicalURL {#canonical-url}

URL-кодированный ключ объекта. Например, `/folder/object.ext`.

{% note info %}

Не нормализуйте путь. Например, объект может иметь ключ `some//strange//key//example` и нормализация пути `/<bucket-name>/some/strange/key/example` сделает ключ некорректным.

{% endnote %}

#### CanonicalQueryString {#canonical-query-string}

Каноническая строка запроса должна включать все query параметры конечного URL, кроме `X-Amz-Signature`. Параметры в строке должны быть URL-кодированы и отсортированы по алфавиту.

Пример:

```
X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=JK38EXAMPLEAKDID8%2F20190801%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20190801T000000Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host
```

#### CanonicalHeaders {#canonical-headers}

Список заголовков запроса со значениями. 

Требования:

* Каждый заголовок отделяется символом новой строки `\n`.
* Имена заголовков должны быть в нижнем регистре.
* Заголовки должны быть отсортированы по алфавиту.
* Не должно быть лишних пробелов.
* Список должен содержать заголовок `host` и все заголовки `x-amz-*`, которые используются в запросе.

Дополнительно в список можно добавить любой из заголовков запроса. Чем больше вы подпишете заголовков, тем безопаснее будет запрос.

Пример: 

```
host:sample-bucket.{{ s3-storage-host }}
x-amz-date:20190801T000000Z
```

#### SignedHeaders {#signed-headers}

Список имен заголовков запроса в нижнем регистре, отсортированный по алфавиту и разделенный точками с запятыми.

Пример:

```
host;x-amz-date
```

#### Завершение канонического запроса {#end-canonical-request}

Завершать канонический запрос всегда должна строка `UNSIGNED-PAYLOAD`.

### Строка для подписи {#composing-string-to-sign}

Общий вид строки для подписи:

```
"AWS4-HMAC-SHA256" + "\n" +
<timestamp> + "\n" +
<scope> + "\n" +
Hex(Hash-SHA256(<CanonicalRequest>))
```

Где:

* `AWS4-HMAC-SHA256` — алгоритм хэширования. 
* `timestamp` — текущее время в формате ISO 8601, например, `20190801T000000Z`. Указанная дата должна по значению (не по формату) совпадать с датой в `scope`.
* `scope` — `<YYYYMMDD>/{{ region-id }}/s3/aws4_request`.
* `CanonicalRequest` — сформированный ранее [канонический запрос](#canonical-request). В строку для подписи помещается [SHA256](https://ru.wikipedia.org/wiki/SHA-2)-хэш канонического запроса в шестнадцатеричном представлении.

### Подписывающий ключ {#signing-key-gen}

{% include [generate-signing-key](../generate-signing-key.md) %}

### Подпись строки с помощью ключа {#signing}

Чтобы получить подпись строки, необходимо использовать механизм `HMAC` с хэширующей функцией `SHA256`, а полученный результат преобразовать в шестнадцатеричное представление.

```
signature = Hex(sign(SigningKey, StringToSign))
```

### Подписанный URL {#composing-signed-url}

Чтобы составить подписанный URL, к URL ресурса {{ objstorage-name }} добавьте [параметры](#presigned-url-preview), необходимые для авторизации запроса, в том числе параметр `X-Amz-Signature` с вычисленной подписью в значении.

Значения остальных параметров должны совпадать с аналогичными значениями, указанными ранее в [каноническом запросе](#canonical-request) и в [строке для подписи](#composing-string-to-sign).

#### Пример составления подписанного URL для скачивания объекта {#example-for-object-download}

Составим подписанный URL для скачивания объекта `object-for-share.txt` из бакета в течение часа:

- Статический ключ:

    ```
    access_key_id = 'JK38EXAMP********'
    secret_access_key = 'ExamP1eSecReTKeykdo********'
    ```

- Канонический запрос:

    ```
    GET
    /object-for-share.txt
    X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEK0Iv6x********eLTAdg%2F20231208%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20231208T184504Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host 
    host:<имя_бакета>.{{ s3-storage-host }}

    host
    UNSIGNED-PAYLOAD
    ```

- Строка для подписи:

    ```
    AWS4-HMAC-SHA256
    20231208T184504Z
    20231208/{{ region-id }}/s3/aws4_request
    e823d75aad02c1317589bd5373fe9e20d5ef44499237703ff23e5600********
    ```

- Подписывающий ключ:

    ```
    sign(sign(sign(sign("AWS4" + "ExamP1eSecReTKeykdokKK38800","20190801"),"{{ region-id }}"),"s3"),"aws4_request")
    ```

    Функция `sign` введена для обозначения способа вычисления ключа с помощью механизма [HMAC](https://ru.wikipedia.org/wiki/HMAC) с хэширующей функцией [SHA256](https://ru.wikipedia.org/wiki/SHA-2).

- Подпись:

    ```
    b10c16a1997bb524bf59974512f1a6561cf2953c29dc3efbdb920790********
    ```

- Подписанный URL:

    ```
    https://<имя_бакета>.{{ s3-storage-host }}/object-for-share.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=YCAJEK0Iv6xqy-pEQcueLTAdg%2F20231208%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20231208T195434Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=b10c16a1997bb524bf59974512f1a6561cf2953c29dc3efbdb920790********
    ```

{% include [s3api-debug-and-curl](../s3api-debug-and-curl.md) %}

#### Примеры кода для генерации подписанных URL {#code-examples}

В подразделе приведены примеры кода для генерации подписанных URL.

Чтобы показать принцип формирования и подписи запросов к {{ objstorage-name }}, в примерах не используются [AWS SDK](../../../storage/tools/sdk/index.md). Примеры с использованием AWS SDK и прочих инструментов см. в подразделе [Примеры получения подписанной ссылки в инструментах {{ objstorage-name }}](#example-for-getting-in-tools).

{% list tabs %}

- Python

  ```python
  import datetime
  import hashlib
  import hmac

  access_key = '<идентификатор_статического_ключа>'
  secret_key = '<содержимое_статического_ключа>'
  object_key = '<ключ_объекта>'
  bucket = '<имя_бакета>'
  host = '{{ s3-storage-host }}'
  now = datetime.datetime.now(datetime.UTC)
  datestamp = now.strftime('%Y%m%d')
  timestamp = now.strftime('%Y%m%dT%H%M%SZ')

  def sign(key, msg):
      return hmac.new(key, msg.encode('utf-8'), hashlib.sha256).digest()

  canonical_request = """GET
  /{bucket}/{object_key}
  X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential={access_key}%2F{datestamp}%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date={timestamp}&X-Amz-Expires=3600&X-Amz-SignedHeaders=host
  host:{host}

  host
  UNSIGNED-PAYLOAD""".format(
      bucket=bucket,
      object_key=object_key,
      access_key=access_key,
      datestamp=datestamp,
      timestamp=timestamp,
      host=host)

  print()
  print("Canonical request:\n" + canonical_request)
  print()

  string_to_sign = """AWS4-HMAC-SHA256
  {timestamp}
  {datestamp}/{{ region-id }}/s3/aws4_request
  {request_hash}""".format(
      timestamp=timestamp,
      datestamp=datestamp,
      request_hash=hashlib.sha256(canonical_request.encode('utf-8')).hexdigest())

  print()
  print("String to be signed:\n" + string_to_sign)
  print()

  signing_key = sign(sign(sign(sign(('AWS4' + secret_key).encode('utf-8'), datestamp), '{{ region-id }}'), 's3'), 'aws4_request')
  signature = hmac.new(signing_key, string_to_sign.encode('utf-8'), hashlib.sha256).hexdigest()

  print()
  print("Signature: " + signature)
  print()

  signed_link = "https://" + host + '/' + bucket + '/' + object_key + "?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=" + access_key + "%2F" + datestamp + "%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=" + timestamp + "&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=" + signature + "\n"

  print()
  print("Signed Link:\n" + signed_link)
  ```

- PHP

  ```php
  <?php

    date_default_timezone_set('UTC');
    $keyid = "<идентификатор_статического_ключа>";
    $secretkey = "<содержимое_статического_ключа>";
    $path = "<ключ_объекта>";
    $objectname = "/".implode("/", array_map("rawurlencode", explode("/", $path)));
    $host = "<имя_бакета>.{{ s3-storage-host }}";
    $region = "{{ region-id }}";
    $timestamp = time();
    $dater = strval(date('Ymd', $timestamp));
    $dateValue = strval(date('Ymd', $timestamp))."T".strval(date('His', $timestamp))."Z";

    // Generate the canonical request
    $canonical_request = "GET\n".$objectname."\nX-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=".$keyid."%2F".$dater."%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=".$dateValue."&X-Amz-Expires=3600&X-Amz-SignedHeaders=host\nhost:".$host."\n\nhost\nUNSIGNED-PAYLOAD";

    echo "<b>Canonical request: </b><br>".$canonical_request."<br><br>";

    // Generate the string to be signed
    $string_to_sign = "AWS4-HMAC-SHA256\n".$dateValue."\n".$dater."/".$region."/s3/aws4_request\n".openssl_digest($canonical_request, "sha256", $binary = false);

    echo "<b>String to be signed: </b><br>".$string_to_sign."<br><br>";

    // Generate the signing key
    $signing_key = hash_hmac('sha256', 'aws4_request', hash_hmac('sha256', 's3', hash_hmac('sha256', '{{ region-id }}', hash_hmac('sha256', $dater, 'AWS4'.$secretkey, true), true), true), true);

    echo "<b>Signing key: </b><br>".$signing_key."<br><br>";

    // Generate the signature
    $signature = hash_hmac('sha256', $string_to_sign, $signing_key);

    echo "<b>Signature: </b><br>".$signature."<br><br>";

    // Generate the pre-signed link
    $signed_link = "https://".$host.$objectname."?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=".$keyid."%2F".$dater."%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=".$dateValue."&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=".$signature."\n";

    echo '<b>Signed link: </b><br>'.'<a href = "'.$signed_link.'" target = "_blank">'.$signed_link.'</a>';

  ?>
  ```

{% endlist %}

## Примеры получения подписанной ссылки в инструментах {{ objstorage-name }} {#example-for-getting-in-tools}

В подразделе приведены примеры генерации подписанных URL c помощь различных [инструментов {{ objstorage-name }}](../../../storage/tools/index.md).

### Скачивание объектов {#downloading-examples}

{% list tabs %}

- Консоль управления
  
  {% include [storage-get-link-for-download](../../../storage/_includes_service/storage-get-link-for-download.md) %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [storage-get-link-for-download-cli](../../../storage/_includes_service/storage-get-link-for-download-cli.md) %}

- AWS CLI

    Ссылку на скачивание объекта можно сгенерировать с помощью AWS CLI. Для этого выполните команду:

    ```bash
    aws s3 presign s3://<имя_бакета>/<ключ_объекта> \
      --expires-in <время_жизни_ссылки> \
      --endpoint-url "https://{{ s3-storage-host }}/"
    ```

    Чтобы ссылка сформировалась корректно, обязательно укажите параметр `--endpoint-url` с указанием на доменное имя {{ objstorage-name }}. Подробнее см. в [разделе об особенностях работы AWS CLI](../../../storage/tools/aws-cli.md#specifics).

- SDK для Python (boto3)
    
    Пример генерирует подписанный URL для скачивания объекта `object-for-share` из бакета `bucket-with-objects`. URL действителен в течение 100 секунд.

    ```python
    # coding=utf-8

    import boto3
    from botocore.client import Config


    ENDPOINT = "https://{{ s3-storage-host }}"

    ACCESS_KEY = "JK38EXAMP********"
    SECRET_KEY = "ExamP1eSecReTKeykdo********"

    session = boto3.Session(
        aws_access_key_id=ACCESS_KEY,
        aws_secret_access_key=SECRET_KEY,
        region_name="{{ region-id }}",
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

- SDK для JavaScript

    Пример генерирует подписанный URL для скачивания объекта `object-for-share` из бакета `bucket-with-objects`. URL действителен в течение 100 секунд.

    В примере используются библиотеки [@aws-sdk/client-s3](https://www.npmjs.com/package/@aws-sdk/client-s3) и [@aws-sdk/s3-request-presigner](https://www.npmjs.com/package/@aws-sdk/s3-request-presigner).

    ```js
    import { S3Client, GetObjectCommand } from "@aws-sdk/client-s3";
    import { getSignedUrl } from "@aws-sdk/s3-request-presigner";

    const S3_ENDPOINT = "https://{{ s3-storage-host }}";

    const ACCESS_KEY_ID = "JK38EXAMP********";
    const SECRET_ACCESS_KEY = "ExamP1eSecReTKeykdo********";

    const s3Client = new S3Client({
      region: "{{ region-id }}",
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

### Загрузка объектов {#uploading-examples}

Перед использованием примеров сохраните необходимые аутентификационные данные в переменные окружения:

```bash
export AWS_ACCESS_KEY_ID="<идентификатор_статического_ключа>"
export AWS_SECRET_ACCESS_KEY="<секретный_ключ>"
export AWS_DEFAULT_REGION="{{ region-id }}"
export AWS_REGION="{{ region-id }}"
export AWS_ENDPOINT_URL="https://{{ s3-storage-host }}"
```

Где:
* `AWS_ACCESS_KEY_ID` — [идентификатор](../../../iam/concepts/authorization/access-key.md#key-id) статического ключа доступа.
* `AWS_SECRET_ACCESS_KEY` — [секретный ключ](../../../iam/concepts/authorization/access-key.md#private-key).

Код в примерах генерирует подписанный URL для загрузки объекта с заданным [ключом](../../../storage/concepts/object.md#key) в заданный бакет. Полученный URL действителен в течение одного часа.

В данном примере размер загружаемого объекта ограничен и не может превышать заданного в коде значения — 5 МБ.

{% list tabs group=programming_language %}

- SDK для Python (boto3) {#python}

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
  * `bucket_name` — [имя бакета](../../../storage/concepts/bucket.md#naming), в который загружается файл.
  * `object_name` — [ключ](../../../storage/concepts/object.md#key), который будет присвоен объекту в бакете. Например: `new-prefix/sample-object.txt`.
  * `max_size` — максимально допустимый размер загружаемого файла в байтах.

  Результат:

  ```json
  Подписанная ссылка и данные для загрузки созданы успешно:
  {
      "url": "https://{{ s3-storage-host }}/my-sample-bucket",
      "fields": {
          "key": "new-prefix/sample-object.txt",
          "x-amz-algorithm": "AWS4-HMAC-SHA256",
          "x-amz-credential": "YCAJE98uTrKJwAtqw********/20250516/{{ region-id }}/s3/aws4_request",
          "x-amz-date": "20250516T145901Z",
          "policy": "eyJleHBpcmF0aW9uIjogIjIwMjUtMDUtMTZUMTU6NTk6MDFaIiwgImNvbmRpdGlvbnMiOiBbWyJjb250ZW50LWxlbmd0aC1yYW5nZSIsIDEsIDUyNDI4ODBdLCB7ImJ1Y2tldCI6ICJhbHRhcmFza2luLXRlc3Rlci1idWNrZXQifSwgeyJrZXkiOiAiZmlsZS50eHQifSwgeyJ4LWFtei1hbGdvcml0aG0iOiAiQVdTNC1ITUFDLVNIQTI1NiJ9LCB7IngtYW16LWNyZWRlbnRpYWwiOiAiWUNBSkU5OHVUcktKd0F0cXdySEpYTmg1TC8yMDI1MDUxNi9ydS1jZW50cmFsMS9zMy9hd3M0X3JlcXVlc3QifSwgeyJ4LWFtei1kYXRlIjogIjIwMjUwNTE2VDE0NTkw********",
          "x-amz-signature": "c2e1783095d20d89a7683fc582527740541de16156569d9950cfb1b7********"
      }
  }
  ```

- SDK для JavaScript {#node}

  В примере используются библиотеки [@aws-sdk/client-s3](https://www.npmjs.com/package/@aws-sdk/client-s3) и [@aws-sdk/@aws-sdk/s3-presigned-post](https://www.npmjs.com/package/@aws-sdk/s3-presigned-post).

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
  * `Bucket` — [имя бакета](../../../storage/concepts/bucket.md#naming), в который загружается файл.
  * `Key` — [ключ](../../../storage/concepts/object.md#key), который будет присвоен объекту в бакете. Например: `new-prefix/sample-object.txt`.
  * `max_size` — максимально допустимый размер загружаемого файла в байтах.

  Результат:

  ```txt
  {
    url: 'https://my-sample-bucket.{{ s3-storage-host }}/',
    fields: {
      bucket: 'my-sample-bucket',
      'X-Amz-Algorithm': 'AWS4-HMAC-SHA256',
      'X-Amz-Credential': 'YCAJE98uTrKJwAtqw********/20250516/{{ region-id }}/s3/aws4_request',
      'X-Amz-Date': '20250516T210215Z',
      key: 'new-prefix/sample-object.txt',
      Policy: 'eyJleHBpcmF0aW9uIjoiMjAyNS0wNS0xNlQyMjowMjoxNVoiLCJjb25kaXRpb25zIjpbWyJjb250ZW50LWxlbmd0aC1yYW5nZSIsMSw1MjQyODgwXSx7ImJ1Y2tldCI6ImFsdGFyYXNraW4tdGVzdGVyLWJ1Y2tldCJ9LHsiWC1BbXotQWxnb3JpdGhtIjoiQVdTNC1ITUFDLVNIQTI1NiJ9LHsiWC1BbXotQ3JlZGVudGlhbCI6IllDQUpFOTh1VHJLSndBdHF3ckhKWE5oNUwvMjAyNTA1MTYvcnUtY2VudHJhbDEvczMvYXdzNF9yZXF1ZXN0In0seyJYLUFtei1EYXRlIjoiMjAyNTA1MTZUMjEwMjE1WiJ9LHsia2V5IjoiZmlsZS50********',
      'X-Amz-Signature': '2a8be28a4e2a72de98bd258a8362dd895dd0fdb1886a1764e7085282********'
    }
  }
  ```

- SDK для Go {#go}

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
  * `bucket` — [имя бакета](../../../storage/concepts/bucket.md#naming), в который загружается файл.
  * `key` — [ключ](../../../storage/concepts/object.md#key), который будет присвоен объекту в бакете. Например: `new-prefix/sample-object.txt`.
  * `max_size` — максимально допустимый размер загружаемого файла в байтах.

  Результат:

  ```text
  url: https://my-sample-bucket.{{ s3-storage-host }}
  values:
  X-Amz-Algorithm=AWS4-HMAC-SHA256
  X-Amz-Date=20250516T152552Z
  X-Amz-Credential=YCAJE98uTrKJwAtqw********/20250516/{{ region-id }}/s3/aws4_request
  X-Amz-Signature=9371b1924dd468a9be6b57868565ad5f99cdc7edc3b56589bea3dbfa********
  key=new-prefix/sample-object.txt
  policy=eyJjb25kaXRpb25zIjpbeyJYLUFtei1BbGdvcml0aG0iOiJBV1M0LUhNQUMtU0hBMjU2In0seyJidWNrZXQiOiJhbHRhcmFza2luLXRlc3Rlci1idWNrZXQifSx7IlgtQW16LUNyZWRlbnRpYWwiOiJZQ0FKRTk4dVRyS0p3QXRxd3JISlhOaDVMLzIwMjUwNTE2L3J1LWNlbnRyYWwxL3MzL2F3czRfcmVxdWVzdCJ9LHsiWC1BbXotRGF0ZSI6IjIwMjUwNTE2VDE1MjU1MloifSxbImNvbnRlbnQtbGVuZ3RoLXJhbmdlIiwxLDUyNDI4ODBdLHsia2V5IjoiZmlsZS50eHQifV0sImV4cGlyYXRpb24iOiIyMDI1LTA1LTE2VDE2OjI1********
  ```

{% endlist %}

Используя полученные компоненты подписанной ссылки, отправьте HTTP-запрос на загрузку файла в бакет {{ objstorage-full-name }}:

```bash
curl \
  --request POST \
  --form "X-Amz-Date=20250516T152552Z" \
  --form "X-Amz-Credential=YCAJE98uTrKJwAtqw********/20250516/{{ region-id }}/s3/aws4_request" \
  --form "X-Amz-Signature=9371b1924dd468a9be6b57868565ad5f99cdc7edc3b56589bea3dbfa********" \
  --form "key=new-prefix/sample-object.txt" \
  --form "policy=eyJjb25kaXRpb25zIjpbeyJYLUFtei1BbGdvcml0aG0iOiJBV1M0LUhNQUMtU0hBMjU2In0seyJidWNrZXQiOiJhbHRhcmFza2luLXRlc3Rlci1idWNrZXQifSx7IlgtQW16LUNyZWRlbnRpYWwiOiJZQ0FKRTk4dVRyS0p3QXRxd3JISlhOaDVMLzIwMjUwNTE2L3J1LWNlbnRyYWwxL3MzL2F3czRfcmVxdWVzdCJ9LHsiWC1BbXotRGF0ZSI6IjIwMjUwNTE2VDE1MjU1MloifSxbImNvbnRlbnQtbGVuZ3RoLXJhbmdlIiwxLDUyNDI4ODBdLHsia2V5IjoiZmlsZS50eHQifV0sImV4cGlyYXRpb24iOiIyMDI1LTA1LTE2VDE2OjI1********" \
  --form "X-Amz-Algorithm=AWS4-HMAC-SHA256" \
  --form "file=./sample-object.txt" \
  https://my-sample-bucket.{{ s3-storage-host }}
```

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


## Примеры использования {#examples}

* [{#T}](../../../tutorials/security/protected-access-to-content/index.md)
