# Как пользоваться API

## Подготовка к работе {#preparations}

Чтобы воспользоваться API:

[!INCLUDE [storage-s3-http-api-preps](../_includes_service/storage-s3-http-api-preps.md)]

Авторизация статическими ключами необходима для обращения напрямую к HTTP API и поддерживается инструментами, перечисленными в разделе [[!TITLE]](../instruments/index.md).

Перечень поддерживаемых методов Amazon S3 HTTP API смотрите в [Справочнике API](api-ref/index.md).

## Общий вид запроса к API

```
{GET|HEAD|PUT|DELETE} {path} HTTP/1.1
Host: [!KEYREF s3-storage-host]
Content-Length: length
Date: date
Authorization: authorization string (AWS Signature Version 4)

Request_body
```

Про заголовки читайте в разделе [[!TITLE]](api-ref/common-request-headers.md). Набор заголовков зависит от конкретного запроса.

Если вы используете API напрямую (без SDK и приложений), то для подписи запросов вам придется самостоятельно генерировать заголовок `Authorization`. О том, как это сделать, читайте в разделе [Authenticating Requests (AWS Signature Version 4) ](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html) документации Amazon S3.




