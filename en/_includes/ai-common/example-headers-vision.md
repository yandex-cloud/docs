Here is a sample request using [cURL](https://curl.haxx.se):

```bash
export IAM_TOKEN=<IAM_token>

curl \
  --request POST \
  --header "x-client-request-id: fa18fa9b-176d-4ae0-92b8-bd78********" \
  --header "x-data-logging-enabled: true" \
  --header "authorization: Bearer ${IAM_TOKEN}" \
  --data '@body.json' \
  https://vision.{{ api-host }}/vision/v1/batchAnalyze
```

Where `IAM_TOKEN` is the [IAM token](../../iam/operations/iam-token/create.md) required for authentication.
