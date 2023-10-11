Here is a sample request using [cURL](https://curl.haxx.se):

```bash
export IAM_TOKEN=<IAM token>

curl -X POST \
    -H "x-client-request-id: fa18fa9b-176d-4ae0-92b8-bd78********" \
    -H "x-data-logging-enabled: true" \
    -H "authorization: Bearer ${IAM_TOKEN}" \
    -d '@body.json' \
    https://vision.{{ api-host }}/vision/v1/batchAnalyze
```

Where `IAM_TOKEN` is the [IAM token](../../iam/operations/iam-token/create.md) required for authentication.
