# Подписанные (pre-signed) URL

С помощью подписанных URL произвольный пользователь интернета может выполнять в {{ objstorage-name }} различные операции, например:

- Скачать объект
- Загрузить объект
- Создать бакет

Подписанный URL — это URL, содержащий данные для авторизации запроса в своих параметрах. Составить подписанный URL может пользователь, владеющий статическими ключами доступа.

Раздел содержит общие принципы построения подписанного URL с использованием AWS Signature V4.

{% note info %}

SDK для различных языков программирования и другие инструменты для работы с AWS S3 содержат готовые методы генерирования подписанного URL, которые можно использовать и для {{ objstorage-name }}.

{% endnote %}

## Общий вид подписанного URL {#presigned-url-preview}

```
https://{{ s3-storage-host }}/<имя бакета>/<ключ объекта>?
     X-Amz-Algorithm=AWS4-HMAC-SHA256
    &X-Amz-Expires=<интервал времени в секундах>
    &X-Amz-SignedHeaders=<список заголовков разделенный символами ";">
    &X-Amz-Signature=<подпись>
    &X-Amz-Date=<время в формате ISO 8601>
    &X-Amz-Credential=<access-key-id>%2F<YYYYMMDD>%2F{{ region-id }}%2Fs3%2Faws4_request
```

Параметры подписанного URL:

Параметр | Описание
---------|---------
`X-Amz-Algorithm` | Идентифицирует версию подписи и алгоритм ее вычисления. Значение — `AWS4-HMAC-SHA256`.
`X-Amz-Expires` | Время в секундах в течение которого ссылка действительна. Начало отсчета — момент, указанный в `X-Amz-Date`. Максимальное значение — 604800 секунд (7 дней).
`X-Amz-SignedHeaders` | Заголовки запроса, которые вы хотите подписать.<br/><br/>Обязательно подписывайте заголовок `Host` и все заголовки `X-Amz-*`, которые используются в запросе. Другие заголовки подписывать не обязательно, однако чем больше вы подпишете заголовков, тем безопаснее будет запрос.
`X-Amz-Signature` | Подпись запроса.
`X-Amz-Date` | Время в формате [ISO8601](https://ru.wikipedia.org/wiki/ISO_8601), например, `20180719T000000Z`. Указанная дата должна по значению (не по формату) совпадать с датой в параметре `X-Amz-Credential`.
`X-Amz-Credential` | Идентификатор для подписи.<br/><br/>Строка формата `<access-key-id>/<YYYYMMDD>/{{ region-id }}/s3/aws4_request`, где `<YYYYMMDD>` должна совпадать с датой, установленной в заголовке `X-Amz-Date`.


## Составление подписанного URL {#creating-presigned-url}

Чтобы получить подписанный URL необходимо:

1. Вычислить подпись.
    1. [Составьте строку для подписи](#composing-string-to-sign).
    2. Вычислите подпись с помощью [алгоритма подписи строк](../s3/signing-requests.md).
2. [Составить подписанный URL](#composing-signed-url) для своего запроса.

Для составления подписанного URL необходимо владеть {% if audience != "internal" %}[статическими ключами](../../iam/operations/sa/create-access-key.md){% else %}статическими ключами{% endif %} доступа. 

### Строка для подписи {#composing-string-to-sign}

Строка для подписи:

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
* `CanonicalRequest` — [канонический запрос](#canonical-request). Чтобы включить запрос в строку, захэшируйте его по алгоритму SHA256 и преобразуйте в шестнадцатеричное представление.

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

Строка `UNSIGNED-PAYLOAD` всегда должна завершать канонический запрос.

#### HTTPVerb {#http-verb}

HTTP метод, которым будет отправлен запрос: `GET`, `PUT`, `HEAD` или `DELETE`.

#### CanonicalURL {#canonical-url}

URL-кодированный путь к ресурсу. Например, `/<bucket-name>/<object-key>`.

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

- Каждый заголовок отделяется символом новой строки "\n".
- Имена заголовков должны быть в нижнем регистре.
- Заголовки должны быть отсортированы по алфавиту.
- Не должно быть лишних пробелов.
- Список должен содержать заголовок `host` и все заголовки `x-amz-*`, которые используются в запросе.

Дополнительно в список можно добавить любой из заголовков запроса. Чем больше вы подпишете заголовков, тем безопаснее будет запрос.

Пример: 

```
host:{{ s3-storage-host }}
x-amz-date:20190801T000000Z
```


#### SignedHeaders {#signed-headers}

Список имен заголовков запроса в нижнем регистре, отсортированный по алфавиту и разделенный точками с запятыми.

Пример:

```
host;x-amz-date
```


### Подписанный URL {#composing-signed-url}

Чтобы составить подписанный URL, к URL ресурса {{ objstorage-name }} добавьте [параметры](#presigned-url-preview), необходимые для авторизации запроса, в том числе параметр `X-Amz-Signature` с вычисленной подписью.


#### Пример составления подписанного URL для скачивания объекта {#example-for-object-download}

Составим подписанный URL для скачивания объекта `object-for-share.txt` из бакета `example-bucket` в течение часа.

- Статический ключ:

    ```
    access_key_id = 'JK38EXAMPLEAKDID8'
    secret_access_key = 'ExamP1eSecReTKeykdokKK38800'
    ```

- Канонический запрос:

    ```
    GET
    /example-bucket/object-for-share.txt
    X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=JK38EXAMPLEAKDID8%2F20190801%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20190801T000000Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host
    host:{{ s3-storage-host }}

    host
    UNSIGNED-PAYLOAD
    ```

- Строка для подписи:

    ```
    AWS4-HMAC-SHA256
    20190801T000000Z
    20190801/{{ region-id }}/s3/aws4_request
    2d2b4efefa9072d90a646afbc0fbaef4618c81396b216969ddfc2869db5aa356
    ```

- Подписывающий ключ:

    ```
    sign(sign(sign(sign("AWS4" + "ExamP1eSecReTKeykdokKK38800","20190801"),"{{ region-id }}"),"s3"),"aws4_request")

    ```

    Функция `sign` введена для обозначения способа вычисления ключа с помощью механизма [HMAC](https://ru.wikipedia.org/wiki/HMAC) с хэширующей функцией [SHA256](https://ru.wikipedia.org/wiki/SHA-2).

- Подпись:

    ```
    56bdf53a1f10c078c2b4fb5a26cefa670b3ea796567d85489135cf33e77783f0
    ```

- Подписанный URL:

    ```
    https://{{ s3-storage-host }}/example-bucket/object-for-share.txt?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=JK38EXAMPLEAKDID8%2F20190801%2F{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20190801T000000Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=56bdf53a1f10c078c2b4fb5a26cefa670b3ea796567d85489135cf33e77783f0
    ```

## Примеры получения подписанной ссылки в инструментах {{ objstorage-name }} {#example-for-getting-in-tools}

{% list tabs %}

- Консоль управления
  
  {% include [storage-get-link-for-download](../_includes_service/storage-get-link-for-download.md) %}

- AWS CLI

    Ссылку на скачивание объекта также можно сгенерировать с помощью AWS CLI. Для этого выполните команду вида:

    ```
    aws s3 presign s3://<bucket-name>/<object-key> --endpoint-url "https://{{ s3-storage-host }}/" [--expires-in <value>]
    ```
  
    Чтобы ссылка сформировалась корректно, обязательно укажите параметр `--endpoint-url` с указанием на доменное имя {{ objstorage-name }}. Подробнее см. в [разделе об особенностях работы AWS CLI](../tools/aws-cli.md#specifics).

- boto3
    
    Пример генерирует подписанный URL для скачивания объекта `object-for-share` из бакета `bucket-with-objects`. URL действителен в течение 100 секунд.

    ```python
    # coding=utf-8
    
    import boto3
    from botocore.client import Config


    ENDPOINT = "https://{{ s3-storage-host }}"

    ACCESS_KEY = "JK38EXAMPLEAKDID8"
    SECRET_KEY = "ExamP1eSecReTKeykdokKK38800"

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
          
{% endlist %}
