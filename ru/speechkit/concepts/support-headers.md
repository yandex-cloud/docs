# Диагностика ошибок

[!INCLUDE [ask-for-support](../../_includes/ai-common/ask-for-support.md)]

Чтобы помочь технической поддержке решить вашу проблему, вы можете использовать следующие заголовки при отправке HTTP-запросов:

* [!INCLUDE [x-client-request-id](../../_includes/ai-common/x-client-request-id.md)]
* `X-Data-Logging-Enabled` — флаг, разрешающий сохранять данные, переданные пользователем в запросе.

    По умолчанию мы не сохраняем переданные вами аудио или текст. Если вы передадите значение `true` в этом заголовке, то ваши данные сохранятся. Вместе с идентификатором запроса это поможет технической поддержке решить вашу проблему.

## Примеры

Например, используйте эти заголовки, чтобы потом сообщить, что ваше аудио распозналось плохо и помочь нам доработать модель распознавания.

Пример использования заголовков с помощью [cURL](https://curl.haxx.se):

```bash
$ curl -X POST \
    -H "X-Client-Request-ID: fa18fa9b-176d-4ae0-92b8-bd7897f7c00c" \
    -H "X-Data-Logging-Enabled: true" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    --data-binary "@speech.ogg" \
    "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize?folderId=${FOLDER_ID}"
```