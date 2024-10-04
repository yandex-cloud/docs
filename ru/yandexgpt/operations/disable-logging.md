# Отключить логирование запросов

По умолчанию {{ yagpt-full-name }} сохраняет все данные запросов. Если в запросах вы передаете персональные или конфиденциальные данные или другую чувствительную информацию, отключите логирование. Для этого добавьте в заголовок запроса REST или метаинформацию вызова gRPC опцию `x-data-logging-enabled: false`. Запросы, переданные с отключенной опцией логирования, не будут сохраняться на серверах {{ yandex-cloud }}.

Пример запроса с помощью [cURL](https://curl.haxx.se):


```bash
   export FOLDER_ID=<идентификатор_каталога>
   export IAM_TOKEN=<IAM-токен>

   curl \
     --request POST \
     --header "Content-Type: application/json" \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     --header "x-data-logging-enabled: false" \
     --header "x-folder-id: ${FOLDER_ID}" \
     --data "@<путь_до_файла_json>" \
     "https://llm.{{ api-host }}/foundationModels/v1/completion"
   ```

   Где:

   * `FOLDER_ID`— идентификатор каталога, на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
   * `IAM_TOKEN` — [IAM-токен](../../iam/operations/iam-token/create.md), необходимый для аутентификации.
   * `@<путь_до_файла_json>` — путь к файлу JSON, содержащему запрос к {{ yagpt-full-name }}.