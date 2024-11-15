---
title: Подписывание запросов
description: Следуя данной инструкции, вы сможете настроить подпись запросов.
---

# Подписывание запросов


Многие запросы к {{ objstorage-name }} аутентифицируются на стороне сервиса и пользователь, отправляющий запрос, должен его подписать.

{{ objstorage-name }} поддерживает подпись [AWS Signature V4](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html).

Процесс подписывания состоит из этапов:

1. [Генерирование строки для подписи](#string-to-sign-gen).
1. [Генерирование подписывающего ключа](#signing-key-gen).
1. [Подпись строки с помощью ключа](#signing).

Для подписи необходимо использовать механизм [HMAC](https://ru.wikipedia.org/wiki/HMAC) с хэширующей функцией [SHA256](https://ru.wikipedia.org/wiki/SHA-2). Поддержка соответствующих методов есть во многих языках программирования. В примерах предполагается, что существует функция `sign(KEY, STRING)`, которая выполняет кодирование входной строки по заданному ключу.

## Генерирование строки для подписи {#string-to-sign-gen}

Строка для подписи (`StringToSign`) зависит от сценария использования {{ objstorage-name }}:

* [Обращение к API](./index.md), совместимому с Amazon S3, без помощи SDK или специализированных утилит.
* [Загрузка объектов с помощью HTML-формы](../concepts/presigned-post-forms.md).
* [Подписывание URL с помощью query-параметров](../concepts/pre-signed-urls.md).

## Генерирование подписывающего ключа {#signing-key-gen}

Чтобы сгенерировать подписывающий ключ, вам необходимо иметь статические ключи доступа к {{ objstorage-name }}. О том, как их получить, читайте в статье [Подготовка к работе](index.md#before-you-begin).

{% include [generate-signing-key](../../_includes/storage/generate-signing-key.md) %}

## Подпись строки с помощью ключа {#signing}

Чтобы получить подпись строки, необходимо использовать механизм `HMAC` с хэширующей функцией `SHA256`, а полученный результат преобразовать в шестнадцатеричное представление.

```text
signature = Hex(sign(SigningKey, StringToSign))
```

## Отладка с помощью AWS CLI {#debugging}

Чтобы отладить процесс формирования [канонического запроса](../concepts/pre-signed-urls.md#canonical-request), [строки для подписи](../concepts/pre-signed-urls.md#composing-string-to-sign) и [подписывающего ключа](../concepts/pre-signed-urls.md#signing-key-gen), используйте утилиту [AWS CLI](../tools/aws-cli.md) с параметром `--debug`. 

{% note info %}

Убедитесь, что сервисный аккаунт, от имени которого вы выполняете команды `aws`, имеет необходимые права для выполнения запрашиваемых действий. Например, для создания бакета [назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../security/index.md#storage-uploader) `storage.editor` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Подробнее см. [{#T}](../security/overview.md).

{% endnote %}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  В терминале выполните команду для создания бакета и посмотрите, как генерируются параметры для запроса:

  ```bash
  aws s3api create-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <имя_бакета> \
    --debug
  ```

  Результат:

  ```text
  2024-06-03 13:02:36,238 - MainThread - botocore.auth - DEBUG - CanonicalRequest:
  PUT
  /<имя_бакета>

  host:{{ s3-storage-host }}
  x-amz-content-sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b********
  x-amz-date:20240603T100236Z

  host;x-amz-content-sha256;x-amz-date
  e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b********

  2024-06-03 13:02:36,238 - MainThread - botocore.auth - DEBUG - StringToSign:
  AWS4-HMAC-SHA256
  20240603T100236Z
  20240603/{{ region-id }}/s3/aws4_request
  7877a13bafaa45f9751e7f345b64a63acc6de279ff927736e906d7c5********

  2024-06-03 13:02:36,238 - MainThread - botocore.auth - DEBUG - Signature:
  90545034742d1e057c8eeb2cca3c23a38a3ced5ef847f61ac80cb8e1********
  ```

{% endlist %}

#### См. также {#see-also}

* [Пример отправки подписанного запроса с помощью утилиты curl](../api-ref/authentication.md#s3-api-example)
* [Пример кода для генерации подписи](../concepts/pre-signed-urls.md#code-examples)
