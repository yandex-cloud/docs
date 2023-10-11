Here is a sample request using [cURL](https://curl.haxx.se):

```bash
export FOLDER_ID=<folder_ID>
export IAM_TOKEN=<IAM token>

curl -X POST \
    -H "x-client-request-id: fa18fa9b-176d-4ae0-92b8-bd78********" \
    -H "x-data-logging-enabled: true" \
    -H "authorization: Bearer ${IAM_TOKEN}" \
    --data-binary "@speech.ogg" \
    "https://stt.{{ api-host }}/speech/v2/stt:recognize?folderId=${FOLDER_ID}"
```

Where:

* `FOLDER_ID`: [ID of a folder](../../resource-manager/operations/folder/get-id.md) for which your account has the `editor` role or higher.
* `IAM_TOKEN`: [IAM token](../../iam/operations/iam-token/create.md) required for authentication.