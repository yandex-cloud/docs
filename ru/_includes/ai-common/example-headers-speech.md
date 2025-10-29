{% list tabs group=programming_language %}

- cURL {#curl}

  ```bash
  export FOLDER_ID=<идентификатор_каталога>
  export IAM_TOKEN=<IAM-токен>

  curl \
    --verbose \
    --insecure \
    --header "x-client-request-id: fa18fa9b-176d-4ae0-92b8-bd78********" \
    --header "x-data-logging-enabled: true" \
    --header "authorization: Bearer ${IAM_TOKEN}" \
    --header "x-folder-id: ${FOLDER_ID}" \
    --data @request.json https://{{ api-host-sk-stt }}:443/stt/v3/recognizeFileAsync
  ```

  Где:

  * `FOLDER_ID` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `editor` или выше.
  * `IAM_TOKEN` — [IAM-токен](../../iam/operations/iam-token/create.md), необходимый для аутентификации.
  * `request.json` — файл с телом запроса на [распознавание](../../speechkit/stt/api/transcribation-api-v3.md).

  {% note tip %}

  Используйте флаг `-v` или `--verbose`, чтобы вывести в терминал полный лог выполнения команды.

  {% endnote %}

{% endlist %}