# Disabling request logging

{{ yagpt-full-name }} logs all request data by default. If you provide personal data, confidential information, or any kind of sensitive information in your requests, disable logging. To do this, add `x-data-logging-enabled: false` to the header of a REST API request or gRPC call metadata. Requests transmitted with logging disabled will not be saved on {{ yandex-cloud }} servers.

Here is a sample request using [cURL](https://curl.haxx.se):


```bash
   export FOLDER_ID=<folder_ID>
   export IAM_TOKEN=<IAM_token>

   curl --request POST \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     -H "x-data-logging-enabled: false" \
     -H "x-folder-id: ${FOLDER_ID}" \
     -d "@<path_to_json_file>" \
     "https://llm.{{ api-host }}/foundationModels/v1/completion"
```

Where:

* `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
* `IAM_TOKEN`: [IAM token](../../../iam/operations/iam-token/create.md) required for authentication.
* `@<JSON_file_path>`: Path to the JSON file containing a request to {{ yagpt-full-name }}.