Пример запроса с помощью [cURL](https://curl.haxx.se):

```bash
export IAM_TOKEN=<IAM-токен>

curl \
  --request POST \
  --header "x-client-request-id: fa18fa9b-176d-4ae0-92b8-bd78********" \
  --header "x-data-logging-enabled: true" \
  --header "authorization: Bearer ${IAM_TOKEN}" \
  --data '@body.json' \
  https://vision.{{ api-host }}/vision/v1/batchAnalyze
```

Где `IAM_TOKEN` — [IAM-токен](../../iam/operations/iam-token/create.md), необходимый для аутентификации.
