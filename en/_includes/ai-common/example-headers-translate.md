Here is a sample request using [cURL](https://curl.haxx.se):

```bash
export IAM_TOKEN=<IAM token>

curl --request POST \
  --header "x-client-request-id: fa18fa9b-176d-4ae0-92b8-bd78********" \
  --header "x-data-logging-enabled: true" \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data '@<json_file_path>' \
  "https://translate.api.cloud.yandex.net/translate/v2/translate"
```
Where `IAM_TOKEN` is the [IAM token](../../iam/operations/iam-token/create.md) required for authentication.