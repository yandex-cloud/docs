Отправьте запрос с помощью метода [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md) и сохраните ответ в файл, например `output.json`:

```bash
export IAM_TOKEN=CggaATEVAgA...
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d '@body.json' \
    https://vision.{{ api-host }}/vision/v1/batchAnalyze > output.json
```