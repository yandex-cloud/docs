{% list tabs group=programming_language %}

- cURL {#curl}  
     
  ```bash
  export FOLDER_ID=<идентификатор_каталога>
  export IAM_TOKEN=<IAM-токен>
  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer ${IAM_TOKEN}" \
    --header "x-folder-id: ${FOLDER_ID}" \
    --data "@<путь_до_файла_json>" \
    "https://llm.{{ api-host }}/foundationModels/v1/completionAsync"
  ```

  Где:

  * `FOLDER_ID`— идентификатор каталога, на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
  * `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

{% endlist %}