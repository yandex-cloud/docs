Send a request using the [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md) method and save the response in a file, such as `output.json`:

```bash
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d '@body.json' \
    https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze > output.json
```

