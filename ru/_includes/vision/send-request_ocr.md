Отправьте запрос с помощью метода [recognize](../../vision/ocr/api-ref/TextRecognition/recognize.md) и сохраните ответ в файл, например `output.json`:

```bash
export IAM_TOKEN=<IAM_токен>
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -H "x-folder-id: <идентификатор_каталога>" \
    -H "x-data-logging-enabled: true" \
    -d "@body.json" \
    https://ocr.{{ api-host }}/ocr/v1/recognizeText \
    -o output.json
```

Где:
* `<IAM_токен>` — полученный ранее IAM-токен.
* `<идентификатор_каталога>` — полученный ранее идентификатор каталога.
