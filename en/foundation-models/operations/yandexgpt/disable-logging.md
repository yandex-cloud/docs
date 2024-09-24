# Disabling request logging

{{ yagpt-full-name }} logs all request data by default. If you provide personal data, confidential information, or any kind of sensitive information in your requests, disable logging. To do this, add the `x-data-logging-enabled: false` option to the REST request header or gRPC call metadata. Requests transmitted with logging disabled will not be saved on {{ yandex-cloud }} servers.

Request example:

{% list tabs group=programming_language %}

- Bash {#bash}

  {% include [curl](../../../_includes/curl.md) %}
  
  {% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

  ```bash
  export FOLDER_ID=<folder_ID>
  export IAM_TOKEN=<IAM_token>

  curl --request POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -H "x-data-logging-enabled: false" \
    -H "x-folder-id: ${FOLDER_ID}" \
    -d "@<path_to_JSON_file>" \
    "https://llm.{{ api-host }}/foundationModels/v1/completion"
  ```

  Where:

  * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
  * `IAM_TOKEN`: [IAM token](../../../iam/operations/iam-token/create.md) used for authentication.
  * `@<path_to_JSON_file>`: Path to the JSON file containing a request to {{ yagpt-full-name }}.

{% endlist %}