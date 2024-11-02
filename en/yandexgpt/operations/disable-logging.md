# Disabling request logging

{{ yagpt-full-name }} logs all request data by default. If you provide personal data, confidential information, or any kind of sensitive information in your requests, disable logging. To do this, add the `x-data-logging-enabled: false` option to the REST request header or gRPC call metadata. Requests submitted with logging disabled will not be saved on {{ yandex-cloud }} servers.

Here is a sample request using [cURL](https://curl.haxx.se):


```bash
   export FOLDER_ID=<folder_ID>
   export IAM_TOKEN=<IAM_token>

   curl \
     --request POST \
     --header "Content-Type: application/json" \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     --header "x-data-logging-enabled: false" \
     --header "x-folder-id: ${FOLDER_ID}" \
     --data "@<path_to_JSON_file>" \
     "https://llm.{{ api-host }}/foundationModels/v1/completion"
   ```

   Where:

   * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
   * `IAM_TOKEN`: [IAM token](../../iam/operations/iam-token/create.md) used for authentication.
   * `@<path_to_JSON_file>`: Path to the JSON file containing a request to {{ yagpt-full-name }}.