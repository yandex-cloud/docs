Пример запроса с помощью [cURL](https://curl.haxx.se):

```bash
export FOLDER_ID=<идентификатор_каталога>
export IAM_TOKEN=<IAM-токен>

curl -v -X POST \
    -H "x-client-request-id: fa18fa9b-176d-4ae0-92b8-bd78********" \
    -H "x-data-logging-enabled: true" \
    -H "authorization: Bearer ${IAM_TOKEN}" \
    --data-binary "@speech.ogg" \
    "https://stt.{{ api-host }}/speech/v2/stt:recognize?folderId=${FOLDER_ID}"
```

Где:

* `FOLDER_ID` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `editor` или выше.
* `IAM_TOKEN` — [IAM-токен](../../iam/operations/iam-token/create.md), необходимый для аутентификации.

{% note tip %}

Используйте флаг `-v` или `--verbose`, чтобы вывести в терминал полный лог выполнения команды.

{% endnote %}
