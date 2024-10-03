---
__system:
  dislikeVariants:
    - Нет ответа на мой вопрос
    - Рекомендации не помогли
    - Содержание не соответствует заголовку
    - Другое
---
# Загрузка файла с помощью HTML формы


Раздел содержит информацию о том, как из браузера загрузить файлы в {{ objstorage-name }} с помощью HTML формы.

{% note info %}

Через форму нельзя загрузить объекты размером более 5 ГБ (см. [{#T}](limits.md)).
Поля в форме после “file” игнорируются.

{% endnote %}


## Общее описание {#common-dscr}

Если вы хотите, чтобы пользователи вашего сервиса могли загружать файлы в ваш бакет напрямую из браузера, то:

1. Вы разрабатываете HTML-форму, в которой есть все необходимое для отправки запроса в {{ objstorage-name }} и помещаете ее на страницу вашего сервиса.
2. Пользователь открывает в браузере страницу вашего сервиса и с помощью формы загружает файл в хранилище.

Чтобы устанавливать правила и ограничения на загрузку файлов, к форме необходимо приложить политику безопасности. Политика не нужна только в том случае, если ваш бакет доступен для публичной записи без ограничений.

Для создания формы выполните следующие действия:

1. Разработайте [политику безопасности](#policy), которая описывает параметры запроса к {{ objstorage-name }}. Например, политика может ограничивать размер загружаемого объекта.
2. На основании политики безопасности сгенерируйте [подпись](#signing-policy).
3. Создайте [HTML-форму](#html-form) с подписанной политикой безопасности, которую вы будете предлагать пользователям для загрузки файлов.

## HTML-форма {#html-form}

Общий вид HTML страницы с формой для загрузки файла:

```html
<html>
    <head>
        ...
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        ...
    </head>
    <body>
        ...
        <form action="https://{{ s3-storage-host }}/{bucket-name}" method="post" enctype="multipart/form-data">
            ...
            <input .../>
            ...
        </form>
        ...
    </body>
</html>
```

HTML-форма описывается тегом `<form>` и состоит из объявления и полей.

Объявление формы содержит атрибуты:

* `action` — URL бакета, в который необходимо загрузить объект.
* `method` — HTTP метод. Значение — `POST`.
* `enctype` — Тип содержимого запроса. Значение — `multipart/form-data`.

[Поля формы](#form-fields) содержат подробное описание запроса к {{ objstorage-name }} и [ограничений](#policy), которые применяются к этому запросу.

Форма и ее поля должны быть в кодировке UTF-8. Установите атрибут `charset` тега `<meta>` страницы в значение `UTF-8`.

```html
<html>
    <head>
        ...
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        ...
```

### Поля формы {#form-fields}

{{ objstorage-name }} поддерживает механизмы подписи формы AWS Signature V2 и V4. От механизма подписи зависят названия и состав полей формы. AWS Signature V2 поддержана только для совместимости, по возможности не используйте ее.

Общий вид формы:

{% list tabs %}

- AWS Signature V4

     ```html
     <form action="https://{{ s3-storage-host }}/{bucket-name}" method="post" enctype="multipart/form-data">
        Ключ в хранилище:
        <input type="input" name="key" value="object_key" /><br />
        <!-- Свойства запроса -->
        <input type="hidden" name="X-Amz-Credential" value="access_key_id/date/{{ region-id }}/s3/aws4_request" />
        <input type="hidden" name="acl" value="predefined-acl-name" />
        <input type="hidden" name="X-Amz-Algorithm" value="AWS4-HMAC-SHA256" />
        <input type="hidden" name="X-Amz-Date" value="date" />
        <input type="hidden" name="success_action_redirect" value="some-URL" />
        <input type="hidden" name="policy" value="base64-encoded-policy-document" />
        <input type="hidden" name="X-Amz-Signature" value="signature-string" />
        <!-- Прочие необходимые поля -->
        Файл для загрузки:
        <input type="file" name="file" /> <br />
        <!-- Поля после “file” игнорируются -->
        <input type="submit" name="submit" value="Загрузить" />
    </form>
    ```

- AWS Signature V2

  ```html
   <form action="https://{{ s3-storage-host }}/{bucket-name}" method="post" enctype="multipart/form-data">
        Ключ в хранилище:
        <input type="input" name="key" value="object_key" />
        <!-- Свойства запроса -->
        <input type="hidden" name="AWSAccessKeyId" value="access_key_id" />
        <input type="hidden" name="acl" value="access_type" />
        <input type="hidden" name="success_action_redirect" value="url" />
        <input type="hidden" name="policy" value="base64-encoded-policy-document" />
        <input type="hidden" name="signature" value="signature_string" />
        <input type="hidden" name="Content-Type" value="content/type" />
        <!-- Прочие необходимые поля -->
        Файл для загрузки:
        <input type="file" name="file" /> <br />
        <!-- Поля после “file” игнорируются -->
        <br />
        <input type="submit" value="Загрузить файл" />
  </form>
  ```

{% endlist %}

{% note info %}

Дальнейшее описание актуально только при использовании AWS Signature V4.

{% endnote %}

Описание полей формы:

Поле | Описание | Обязательное
-----|----------|--------------
`acl` | ACL для объекта. Можно установить один из [предопределенных ACL](acl.md#predefined-acls). Например, если вы хотите сделать объект публичным, используйте значение `public-read`. | Нет
`Cache-Control` | Набор директив для кэширования данных согласно [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9). | Нет
`Content-​Disposition` | Имя, под которым {{ objstorage-name }} предложит сохранить объект как файл при выгрузке. Соответствует [RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.5.1). | Нет
`Content-Encoding` | Определяет кодировку содержимого согласно [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.11). | Нет
`Content-Type` | MIME тип загружаемого файла. Если не указать `Content-Type`, то {{ objstorage-name }} сохраняет объект с типом `application/octet-stream`. В дальнейшем это может создать сложности для пользовательских программ, поскольку они не будут понимать формат файла, например браузер не сможет отобразить изображение. | Нет
`Expires` | Срок устаревания ответа. Соответствует [RFC 2616](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.21). | Нет
`key` | [Ключ объекта](object.md#key).<br/><br/>Можно указать ключ целиком или шаблон вида `prefix/${filename}`, т.е. если вы загружаете файл `some_file.jpg`, то итоговый ключ объекта будет `prefix/some_file.jpg`. | Да
`policy` | [Политика безопасности](#policy), описывающая разрешения запроса. Запросы без политики рассматриваются как анонимные и обрабатываются только для бакетов с публичным доступом на запись. | Условно
`X-Amz-Signature` | Подпись политики, которую необходимо сгенерировать с помощью секретного ключа.<br/><br/>Необходимо, если в форме есть политика безопасности. | Условно
`success_action_redirect` | URL, на который перенаправляется пользователь после успешной загрузки файла. Если значение не установлено, то {{ objstorage-name }} возвращает ответ, установленный в поле `success_action_status`. | Нет
`success_action_status` | Статус ответа при успешной загрузке.<br/><br/>Если не указан `success_action_redirect`, то {{ objstorage-name }} возвращает значение `success_action_status`. Тело ответа пустое.<br/><br/>Допустимые значения: 200, 204 (по умолчанию). | Нет
`X-Amz-Algorithm` | Алгоритм для подписи политики безопасности. Значение — `AWS4-HMAC-SHA256`.<br/><br/>Необходимо, если в форме есть политика безопасности. | Условно
`X-Amz-Credential` | Идентификатор для подписи.<br/><br/>Строка формата `<access-key-id>/<date>/{{ region-id }}/s3/aws4_request`, где `<date>` должна совпадать со значением поля `X-Amz-Date` и той датой, которая используется для подписи политики.<br/><br/>Необходимо, если в форме есть политика безопасности. | Условно
`X-Amz-Date` | Дата в формате ISO8601, например, `20180719T000000Z`. Должна по значению (не по формату) совпадать с датой в поле `X-Amz-Credential`, а также с датой, которая используется для подписи политики.<br/><br/>Необходимо, если в форме есть политика безопасности. | Условно
`X-Amz-Storage-Class` | [Класс хранилища](storage-class.md) для объекта. С помощью HTML-формы вы можете поместить объект только в стандартное хранилище. | Нет
`X-Amz-Meta-*` | Пользовательские метаданные объекта.<br/><br/>Все заголовки, начинающиеся с `X-Amz-Meta-` {{ objstorage-name }} воспринимает как пользовательские, не обрабатывает их и сохраняет в том виде, в котором они переданы.<br/><br/>Общий размер пользовательских заголовков не должен превышать 2KB. Размер пользовательских данных определяется как длина строки в кодировке UTF-8. В размере учитываются и названия заголовков и их значения. | Нет
`X-Amz-Website-` `redirect-location` | Если бакет сконфигурирован как [веб-сайт](hosting.md), то это поле устанавливает редирект с заданного объекта на какой-либо другой в этом бакете или на произвольный URL в интернете. Редирект сохраняется в метаданных объекта. | Нет
`file` | Поле ввода, позволяющее пользователю выбрать файл для загрузки. Поле должно быть последним в форме. Все поля, указанные после `file`, игнорируются. Нельзя загрузить более одного файла в одном запросе. | Да


## Политика безопасности {#policy}

HTML-форма содержит политику безопасности, которая накладывает ограничения на файлы, которые можно загрузить.

Политика безопасности представляет собой документ JSON и может выглядеть, например, следующим образом:

```json
{
    "expiration": "timestamp",
    "conditions": [
        {"bucket": "bucket-name"},
        ["starts-with", "$key", "users-uploads/"],
        {"acl": "public-read"},
        {"success_action_redirect": "http://localhost/"},
        ["starts-with", "$Content-Type", ""],
        ["content-length-range", 0, 1048576]
    ]
}
```

Поле `expiration` содержит срок действия политики в формате [ISO8601](https://ru.wikipedia.org/wiki/ISO_8601), например, `2019-07-22T15:39:36Z`. По истечению срока действия политики {{ objstorage-name }} перестает принимать файлы, загружаемые с помощью формы.

Поле `conditions` содержит набор правил для полей формы. Хотя бы одно правило должно быть указано для каждого поля формы.

Правила политики безопасности могут быть следующих типов:

Тип правила | Описание
------------|-----------
Точное совпадение | Поле в форме должно иметь в точности то значение, которое указано в политике.<br/><br/>Например, `{"acl": "public-read"}`. Также возможна альтернативная форма записи: `[ "eq", "$acl", "public-read" ]`.
Частичное совпадение | Значение поля в форме должно начинаться с указанной в политике строки.<br/><br/>Например, `["starts-with", "$key", "key_prefix"]`. Если в качестве значения указана пустая строка, то соответствующее поле может принимать любое значение.<br/><br/>Например, `["starts-with", "$Content-Type", ""]`.
`content-length-range` | Ограничение размера загружаемого объекта.<br/><br/>Например, `["content-length-range", 0, 1048576]`.

Возможные ограничения:

Элемент | Тип ограничения | Область ограничения
--------|-----------------|---------------------
`acl` | Полное и частичное совпадение. | Поле формы `acl`.
`bucket` | Полное и частичное совпадение. | Имя бакета.
`content-length-range` | `content-length-range` | `content-length-range`
`key` |  Полное и частичное совпадение. | Поле формы `key`. Позволяет задать ключ объекта или префикс.
`success_action_redirect` |  Полное и частичное совпадение. | Поле формы `success_action_redirect`.
`success_action_status` | Полное и частичное совпадение. | Поле формы `success_action_status`.
`X-Amz-*` | Полное совпадение. | Поля формы `X-Amz-*`, кроме `X-Amz-Meta-*`.
`X-Amz-Meta-*` |  Полное и частичное совпадение. | Поля формы `X-Amz-Meta-*`.
`Cache-Control`<br/>`Content-Disposition`<br/>`Content-Encoding`<br/>`Content-Type`<br/>`Expires` | Полное и частичное совпадение. | Одноименные поля формы.

Если поле `key` имеет форму шаблона, то политика применяется после подстановки в шаблон заданного пользователем имени файла.

### Подпись политики безопасности {#signing-policy}

Общий алгоритм [подписи политики](../s3/signing-requests.md):

1. Закодировать JSON-документ политики в [base64](https://ru.wikipedia.org/wiki/Base64).
2. [Сгенерировать подписывающий ключ](../s3/signing-requests.md#signing-key-gen).
3. [Сгенерировать подпись политики](../s3/signing-requests.md#signing).


## Пример генерирования формы с помощью boto3 {#example-generating-form}

Входные условия:

- Файлы должны сохраняться в бакет `user-data` с префиксом `/users/upload/`.
- Загруженные объекты открыты для публичного чтения.
- В случае успешной загрузки происходит перенаправление на страницу `https://example.com`.

Для генерирования полей формы воспользуемся [boto3](../tools/boto.md) Python SDK:

```python
aws_access_key_id = 'JK38EXAMP********'
aws_secret_access_key = 'ExamP1eSecReTKeykdo********'
endpoint = 'https://{{ s3-storage-host }}'

s3 = boto3.client('s3',
                  aws_access_key_id=aws_access_key_id,
                  aws_secret_access_key=aws_secret_access_key,
                  region_name='{{ region-id }}',
                  endpoint_url=endpoint,
                  config=botocore.client.Config(signature_version='s3v4'),
                  )

key = 'users/uploads/${filename}'
bucket = 'user-data'
conditions = [{"acl":"public-read"}, ["starts-with", "$key", "users/uploads"], {'success_action_redirect': 'https://example.com'}]
fields = {'success_action_redirect': 'https://example.com'}

prepared_form_fields = s3.generate_presigned_post(Bucket=bucket,
                                                  Key=key,
                                                  Conditions=conditions,
                                                  Fields=fields,
                                                  ExpiresIn=60 * 60)


print(prepared_form_fields)
```


Скрипт вернет документ JSON следующего вида:

```json
{
    'url': u'https://{{ s3-storage-host }}/user-data',
    'fields': {
        'X-Amz-Algorithm': 'AWS4-HMAC-SHA256',
        'X-Amz-Date': '20190722T153936Z',
        'success_action_redirect': 'https://example.com',
        'X-Amz-Signature': '4bdfb2209fc30744458be10bc3b99361f2f50add20f2ca2425587a27********',
        'key': 'users/uploads/${filename}',
        'policy': u'eyJjb25kaXRpb25zIj...M5OjM2WiJ9',
        'X-Amz-Credential': u'JK38EXAMP********/20190722/{{ region-id }}/s3/aws4_request'}
}
```

Используя значения из выданного документа, можно построить HTML-страницу с формой для отправки файла:

```html
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    </head>
    <body>
        <form action="https://{{ s3-storage-host }}/user-data" method="post" enctype="multipart/form-data">
            Ключ в хранилище:
            <input type="input"    name="key" value="users/uploads/${filename}" /><br />
            <input type="hidden"   name="X-Amz-Credential" value="JK38EXAMP********/20190722/{{ region-id }}/s3/aws4_request" />
            <input type="hidden"   name="acl" value="public-read" />
            <input type="hidden"   name="X-Amz-Algorithm" value="AWS4-HMAC-SHA256" />
            <input type="hidden"   name="X-Amz-Date" value="20190722T153936Z" />
            <input type="hidden"   name="success_action_redirect" value="https://example.com" />
            <input type="hidden"   name="policy" value="eyJjb25kaXRpb25zIj...M5OjM2WiJ9" />
            <input type="hidden" name="X-Amz-Signature" value="4bdfb2209fc30744458be10bc3b99361f2f50add20f2ca2425587a2722859f96" />
            Файл для загрузки:
            <input type="file"   name="file" /> <br />
            <input type="submit" name="submit" value="Загрузить" />
        </form>
    </body>
</html>
```
