Send a request using the [batchAnalyze](../../vision/vision/api-ref/Vision/batchAnalyze.md) and save the response to a file, for example, `output.json`:

```bash
export IAM_TOKEN=CggaATEVAgA...
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d '@body.json' \
    https://vision.{{ api-host }}/vision/v1/batchAnalyze > output.json
```