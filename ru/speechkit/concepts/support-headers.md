# Диагностика ошибок в {{ speechkit-full-name }}

{% include [ask-for-support](../../_includes/ai-common/ask-for-support.md) %}

Техническая поддержка сможет быстрее решить вашу проблему, если вы будете использовать дополнительные заголовки HTTP-запросов и ответов.

## Заголовки запросов {#request-headers}

При отправке HTTP-запросов используйте следующие заголовки:

* {% include [x-client-request-id](../../_includes/ai-common/x-client-request-id.md) %}
* `x-data-logging-enabled` — флаг, разрешающий сохранять данные, переданные пользователем в запросе.

    По умолчанию мы не сохраняем переданные вами аудио или текст. Если вы передадите значение `true` в этом заголовке, то ваши данные сохранятся. Вместе с идентификатором запроса это поможет технической поддержке решить вашу проблему.

### Примеры {#examples}

Например, используйте эти заголовки, чтобы потом сообщить, что ваше аудио распозналось плохо и помочь нам доработать модель распознавания.

Пример использования заголовков с помощью [cURL](https://curl.haxx.se):

```bash
export FOLDER_ID=<идентификатор каталога>
export IAM_TOKEN=<IAM-токен>

curl -X POST \
    -H "x-client-request-id: fa18fa9b-176d-4ae0-92b8-bd7897f7c00c" \
    -H "x-data-logging-enabled: true" \
    -H "authorization: Bearer ${IAM_TOKEN}" \
    --data-binary "@speech.ogg" \
    "https://stt.{{ api-host }}/speech/v2/stt:recognize?folderId=${FOLDER_ID}"
```

Где:

* `FOLDER_ID` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `editor` или выше.
* `IAM_TOKEN` — [IAM-токен](../../iam/operations/iam-token/create.md), необходимый для аутентификации.

## Заголовки ответов {#response-headers}

Каждый ответ сервера {{ speechkit-short-name }} содержит заголовки, которые позволят получить еще больше информации о ходе выполнения запроса:

* `x-request-id` — уникальный идентификатор ответа.
* `x-server-trace-id` — уникальный идентификатор логов выполнения запроса.

Чтобы получить значения `x-request-id` и `x-server-trace-id`, ваше приложение должно логировать заголовки ответов сервера. 

Пример реализации доступа к заголовкам протокола [gRPC](../../glossary/grpc) приведен в [документации библиотеки `grpc-go`](https://github.com/grpc/grpc-go/blob/master/Documentation/grpc-metadata.md).
