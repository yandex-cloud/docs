---
title: Подписывание запросов к {{ postbox-full-name }}
description: Многие запросы к {{ postbox-name }} аутентифицируются на стороне сервиса, поэтому запросы нужно подписывать при отправке.
---

# Подписывание запросов

Многие запросы к {{ postbox-name }} аутентифицируются на стороне сервиса, поэтому запросы нужно подписывать при отправке. {{ postbox-name }} поддерживает подпись [Amazon Signature Version 4](https://docs.amazonaws.cn/en_us/IAM/latest/UserGuide/reference_aws-signing.html). Она используется в заголовке `Authorization`.

{% note tip %}

Чтобы не подписывать запросы, используйте [аутентификацию с помощью IAM-токена](../api-ref/authentication.md#iam-ses-example).

{% endnote %}

Чтобы получить подпись:

1. [Составьте канонический запрос](#canonical-request).
1. [Сгенерируйте строку для подписи](#string-to-sign-gen).
1. [Сгенерируйте подписывающий ключ](#signing-key-gen).
1. [Подпишите строку с помощью ключа](#signing).
1. (Опционально) [Отладьте полученные данные с помощью AWS CLI](#debugging).
1. [Составьте заголовок Authorization](#authorization-header).

Для подписи используйте механизм [HMAC](https://ru.wikipedia.org/wiki/HMAC) с хеширующей функцией [SHA256](https://ru.wikipedia.org/wiki/SHA-2). Этот механизм поддерживают многие языки программирования. В примерах ниже предполагается, что в коде используются функции для кодирования и хеширования строк с нужным механизмом.

## Составьте канонический запрос {#canonical-request}

Сформируйте канонический запрос по следующему формату:

```text
<HTTPVerb>\n
<CanonicalURI>\n
<CanonicalQueryString>\n
<CanonicalHeaders>\n
<SignedHeaders>\n
UNSIGNED-PAYLOAD
```

Где:

* `HTTPVerb` — HTTP-метод.
* `CanonicalURI` — эндпоинт.

   Список эндпоинтов и нужных для них HTTP-методов приведен в [Справочнике API](api-ref/index.md). Например, в запросе `GET /v2/email/configuration-sets HTTP/2` эндпоинт — это `/v2/email/configuration-sets`.

* `CanonicalQueryString` — query-параметры конечного URL. Укажите все возможные и поддержанные в запросе параметры. Они должны быть URL-кодированы и отсортированы по алфавиту.

   Пример: `NextToken=my%2Ftoken&PageSize=10`.

* `CanonicalHeaders` — список заголовков запроса со значениями. 

   Требования:

   * Каждый заголовок отделяется символом новой строки `\n`.
   * Имена заголовков должны быть в нижнем регистре.
   * Заголовки должны быть отсортированы по алфавиту.
   * Не должно быть лишних пробелов.
   * Список должен содержать заголовок `host` и все заголовки `x-amz-*`, которые используются в запросе.

   Дополнительно в список можно добавить любой из заголовков запроса. Чем больше вы подпишете заголовков, тем безопаснее будет запрос.

   Пример: 

   ```
   host:{{ postbox-host }}
   x-amz-date:20240920T091646Z
   ```

* `SignedHeaders` — список названий заголовков, которые используются для составления подписи запроса. Укажите заголовки в нижнем регистре, отсортируйте их по алфавиту и разделите точками с запятыми.

   Пример: `content-type;host;x-amz-date`.

В конце канонического запроса добавьте строку `UNSIGNED-PAYLOAD`.

## Сгенерируйте строку для подписи {#string-to-sign-gen}

Строка для подписи — это конкатенация следующих строк:

```text
"AWS4-HMAC-SHA256" + "\n" +
"<время_в_формате_ISO_8601>" + "\n" +
"<дата_в_формате_YYYYMMDD>/{{ region-id }}/ses/aws4_request" + "\n" +
Hex(SHA256Hash(<канонический_запрос>))
```

Пример времени в формате [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html): `20240920T091646Z`.

## Сгенерируйте подписывающий ключ {#signing-key-gen}

Перед началом работы [подготовьте статический ключ доступа](index.md#before-you-begin).

{% include [generate-signing-key](../../_includes/storage/generate-signing-key.md) %}

## Подпишите строку с помощью ключа {#signing}

Подпишите строку и преобразуйте ее в шестнадцатеричное представление:

```text
signature = Hex(sign(SigningKey, StringToSign))
```

## (Опционально) Отладьте полученные данные с помощью AWS CLI {#debugging}

Чтобы отладить подписывание запросов, используйте утилиту [AWS CLI](../tools/aws-cli.md) с параметром `--debug`. Он добавляет в вывод команды канонический запрос `CanonicalRequest`, строку для подписи `StringToSign` и подпись запроса `Signature`. Вы можете сравнить их с вашими значениями.

{% list tabs group=instructions %}

* AWS CLI {#aws-cli}

   В терминале выполните команду для [создания конфигурации](../operations/create-configuration.md) и посмотрите, как генерируются параметры для запроса:

   ```bash
   aws sesv2 create-configuration-set \
      --endpoint-url={{ postbox-endpoint }} \
      --profile default \
      --configuration-set-name <имя_конфигурации> \
      --debug
   ```

   {% note info %}

   Для этого примера сервисному аккаунту, от имени которого вы выполняете команды `aws`, должна быть назначена [роль](../security/index.md#postbox-editor) `postbox.editor` или выше.

   {% endnote %}

   Результат:

   ```text
   ...
   2024-09-02 13:16:46,063 - MainThread - botocore.auth - DEBUG - CanonicalRequest:
   POST
   /v2/email/configuration-sets

   content-type:application/json
   host:{{ postbox-host }}
   x-amz-date:20240920T091646Z

   content-type;host;x-amz-date
   e9cc542601e782471dc41e9c1aa0a6c9e55cf6b926c0e2b200e461d0********
   2024-09-02 13:16:46,063 - MainThread - botocore.auth - DEBUG - StringToSign:
   AWS4-HMAC-SHA256
   20240920T091646Z
   20240902/{{ region-id }}/ses/aws4_request
   bcbaab5d2a5f44555276ec63a07e4141a04d72b886b419fe280ca07d********
   2024-09-02 13:16:46,063 - MainThread - botocore.auth - DEBUG - Signature:
   d88f587982912662d886c77de0c110aad8fa2899bc2e733ff4f03f7e********
   ...
   ```

{% endlist %}

## Составьте заголовок Authorization {#authorization-header}

Сформируйте заголовок `Authorization` по следующему формату:

```text
Authorization: AWS4-HMAC-SHA256 Credential=<идентификатор_статического_ключа>/<дата>/{{ region-id }}/ses/aws4_request SignedHeaders=<подписанные_заголовки> Signature=<подпись>
```

Используйте такой заголовок, если обращаетесь к API напрямую, без [AWS CLI](../tools/aws-cli.md) и приложений.

В заголовке укажите:

* Идентификатор статического ключа доступа, полученный во время [подготовки к работе](index.md#before-you-begin).
* Дату в формате `YYYYMMDD`.
* Подписанные заголовки, например `content-type;host;x-amz-date`. [Подробнее о подписанных заголовках](api-ref/request-headers.md).
* Подпись для запроса.
