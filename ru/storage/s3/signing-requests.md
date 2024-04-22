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

{% include [generate-signing-key](../../_includes/storage/generate-signing-key.md) %}

## Подпись строки с помощью ключа {#signing}

Чтобы получить подпись строки, необходимо использовать механизм `HMAC` с хэширующей функцией `SHA256`, а полученный результат преобразовать в шестнадцатеричное представление.

```text
signature = Hex(sign(SigningKey, StringToSign))
```

[Примеры кода](../concepts/pre-signed-urls.md#code-examples) для генерирования подписи см. в статье [{#T}](../concepts/pre-signed-urls.md).