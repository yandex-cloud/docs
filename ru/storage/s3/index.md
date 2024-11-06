---
title: Как пользоваться S3 API. {{ objstorage-name }}
description: Из статьи вы узнаете, как подготовиться к работе с API, что представляет собой запрос к {{ objstorage-name }} API и как использовать кросс-доменные запросы.
keywords:
  - s3
  - s3 storage
  - s3 api
  - api
  - s3 api object storage
  - object storage
  - апи s3
  - объектное хранилище
---

# Как пользоваться S3 API

## Подготовка к работе {#before-you-start}

Чтобы воспользоваться API:

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

Авторизация статическими ключами необходима для обращения напрямую к HTTP API и поддерживается инструментами, перечисленными в разделе [{#T}](../tools/index.md).


{% include [store-aws-key-in-lockbox](../../_includes/storage/store-aws-key-in-lockbox.md) %}


Перечень поддерживаемых методов Amazon S3 HTTP API смотрите в [Справочнике API](api-ref/index.md).

## Общий вид запроса к API {#common-request-form}

{% note info %}

Для работы с S3 API в {{ objstorage-name }} лучше использовать [AWS CLI](../tools/aws-cli.md) или [AWS SDK](../tools/sdk/index.md), подходящий для вашей среды разработки.

{% endnote %}

Общий вид запроса к {{ objstorage-name }} API:

```
{GET|HEAD|PUT|DELETE} /<имя_бакета>/<ключ_объекта> HTTP/2
Host: {{ s3-storage-host }}
Content-Length: length
Date: date
Authorization: authorization string (AWS Signature Version 4)

Request_body
```

Запрос содержит HTTP-метод, имя бакета и [ключ объекта](../concepts/object.md).

Имя бакета можно указать как часть имени хоста. В этом случае запрос примет вид:

```
{GET|HEAD|PUT|DELETE} /<ключ_объекта> HTTP/2
Host: <имя_бакета>.{{ s3-storage-host }}
...
```

Набор заголовков зависит от конкретного запроса и описан в документации на соответствующий запрос.

Если вы используете [API](../../glossary/rest-api.md) напрямую (без SDK и приложений), то для подписи запросов вам придется самостоятельно генерировать заголовок `Authorization`. О том, как это сделать, читайте в разделе [Authenticating Requests (AWS Signature Version 4) ](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html) документации Amazon S3.

{% include [s3api-debug-and-curl](../../_includes/storage/s3api-debug-and-curl.md) %}

### URL для запроса {#request-url}

URL может иметь одну из следующих форм:

* `http(s)://{{ s3-storage-host }}/<имя_бакета>/<ключ_объекта>?<query-параметры>`
* `http(s)://<имя_бакета>.{{ s3-storage-host }}/<ключ_объекта>?<query-параметры>`

{% note info %}

Для бакетов с точками в имени, например `example.ru`, протокол HTTPS доступен только c URL в формате `https://{{ s3-storage-host }}/<имя_бакета>/<ключ_объекта>?<query-параметры>`. Подробнее см. в [Обращение к бакету по HTTPS](../concepts/bucket.md#bucket-https).

{% endnote %}

URL содержит имя бакета, ключ объекта и query-параметры. Пример возможных query-параметров см. в [описании метода для получения объекта](api-ref/object/get.md).

{% include [storage-dotnet-host](../_includes_service/storage-dotnet-host.md) %}

## CORS запросы {#cors-requests}

[Кросс-доменные запросы](../concepts/cors.md) доступны для всех методов API, которые управляют объектами.

Для проверки разрешений CORS подразумевает предварительный запрос [options](api-ref/object/options.md) к ресурсу. {{ objstorage-name }} позволяет отправлять кросс-доменные запросы к ресурсам без предварительного запроса, при этом в запросе должны быть те же [заголовки](api-ref/object/options.md#request-headers), что и у предварительного запроса.

{% include [the-s3-api-see-also-include](../../_includes/storage/the-s3-api-see-also-include.md) %}