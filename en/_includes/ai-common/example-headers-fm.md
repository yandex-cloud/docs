{% list tabs group=programming_language %}

- cURL {#curl}  
     
  ```bash
  export FOLDER_ID=<folder_ID>
  export IAM_TOKEN=<IAM_token>
  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer ${IAM_TOKEN}" \
    --header "x-folder-id: ${FOLDER_ID}" \
    --data "@<path_to_JSON_file>" \
    "https://llm.{{ api-host }}/foundationModels/v1/completionAsync"
  ```

  Where:

  * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
  * `IAM_TOKEN`: IAM token you got [before you started](#before-begin).

{% endlist %}