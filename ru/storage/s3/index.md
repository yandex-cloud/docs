# Как пользоваться API

## Подготовка к работе {#preparations}

Чтобы воспользоваться API:

1. [Создайте сервисный аккаунт](../security/service-account.md).
1. [Получите необходимые роли](../security/index.md).
1. [Получите статический ключ](../operations/security/get-static-key.md). Авторизация статическими ключами необходима для обращения напрямую к HTTP API и поддерживается инструментами, перечисленными в разделе [[!TITLE]](../instruments/index.md).

Перечень поддерживаемых методов Amazon S3 HTTP API смотрите в [Справочнике API](api-ref/index.md).

## Общий вид запроса к API

Общий вид запроса:

```
{GET|HEAD|PUT|DELETE} {path} HTTP/1.1
Host: storage.cloud.yandex.net
Content-Length: length
Date: date
Authorization: authorization string (AWS Signature Version 4)

Request_body
```

Про заголовки читайте в разделе [[!TITLE]](api-ref/common-request-headers.md). Набор заголовков зависит от конкретного запроса.

Если вы используете API напрямую (без SDK и приложений), то для подписи запросов вам придется самостоятельно генерировать заголовок `Authorization`. О том, как это сделать, читайте в разделе [Authenticating Requests (AWS Signature Version 4) ](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html) документации Amazon S3.




