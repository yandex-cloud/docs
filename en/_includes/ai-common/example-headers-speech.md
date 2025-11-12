{% list tabs group=programming_language %}

- cURL {#curl}

  ```bash
  export FOLDER_ID=<folder_ID>
  export IAM_TOKEN=<IAM_token>

  curl \
    --verbose \
    --insecure \
    --header "x-client-request-id: fa18fa9b-176d-4ae0-92b8-bd78********" \
    --header "x-data-logging-enabled: true" \
    --header "authorization: Bearer ${IAM_TOKEN}" \
    --header "x-folder-id: ${FOLDER_ID}" \
    --data @request.json https://{{ api-host-sk-stt }}:443/stt/v3/recognizeFileAsync
  ```

  Where:

  * `FOLDER_ID`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) for which your account has the `editor` role or higher.
  * `IAM_TOKEN`: [IAM token](../../iam/operations/iam-token/create.md) used for authentication.
  * `request.json`: File with the [recognition](../../speechkit/stt/api/transcribation-api-v3.md) request body.

  {% note tip %}

  Use the `-v` or `--verbose` flag to output the full command execution log to the terminal.

  {% endnote %}

{% endlist %}