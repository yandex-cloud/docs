Send a request using the [recognize](../../vision/ocr/api-ref/TextRecognitionAsync/recognize.md) method:

```bash
export IAM_TOKEN=<IAM_token>
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -H "x-folder-id: <folder_ID>" \
    -H "x-data-logging-enabled: true" \
    -d "@body.json" \
    https://ocr.{{ api-host }}/ocr/v1/recognizeTextAsync
```

Where:
* `<IAM_token>`: Previously obtained IAM token.
* `<folder_ID>`: Previously obtained folder ID.
