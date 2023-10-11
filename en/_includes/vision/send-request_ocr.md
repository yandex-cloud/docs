Send a request using the [recognize](../../vision/ocr/api-ref/TextRecognition/recognize.md) method and save the response to a file, e.g., `output.json`:

```bash
export IAM_TOKEN=<IAM_token>
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -H "x-folder-id: <folder_ID>" \
    -H "x-data-logging-enabled: true" \
    -d "@body.json" \
    https://ocr.{{ api-host }}/ocr/v1/recognizeText \
    -o output.json
```

Where:
* `<IAM_token>`: Previously obtained IAM token
* `<folder_ID>`: Previously obtained folder ID
