# Как пользоваться API

## Подготовка к работе {#preparations}

Чтобы воспользоваться API:

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

Авторизация статическими ключами необходима для обращения напрямую к HTTP API и поддерживается инструментами, перечисленными в разделе [{#T}](../instruments/index.md).

Перечень поддерживаемых методов Amazon S3 HTTP API смотрите в [Справочнике API](api-ref/index.md).

## Общий вид запроса к API {#common-request-form}

```
{GET|HEAD|PUT|DELETE} /<bucket>/<key> HTTP/1.1
Host: {{ s3-storage-host }}
Content-Length: length
Date: date
Authorization: authorization string (AWS Signature Version 4)

Request_body
```

Имя бакета можно указать как часть имени хоста. В этом случае запрос примет вид:

```
{GET|HEAD|PUT|DELETE} /<key>} HTTP/1.1
Host: <bucket>.{{ s3-storage-host }}
...
```

Набор заголовков зависит от конкретного запроса и описан в документации на соответствующий запрос.

Если вы используете API напрямую (без SDK и приложений), то для подписи запросов вам придется самостоятельно генерировать заголовок `Authorization`. О том, как это сделать, читайте в разделе [Authenticating Requests (AWS Signature Version 4) ](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html) документации Amazon S3.

### URL для запроса {#request-url}

URL может иметь одну из следующих форм:

- `https://{{ s3-storage-host }}/<bucket>/<key>?<parameters>`
- `https://<bucket>.{{ s3-storage-host }}/<key>?<parameters>`

## CORS запросы

Кросс-доменные запросы доступны для всех методов API, которые управляют объектами.

Для проверки разрешений, CORS подразумевает предварительный запрос [options](api-ref/object/options.md) к ресурсу. {{ objstorage-name }} позволяет отправлять кросс-доменные запросы к ресурсам без предварительного запроса, при этом в запросе должны быть те же [заголовки](api-ref/object/options.md#request-headers), что и у предварительного запроса.
