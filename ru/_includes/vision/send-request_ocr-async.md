Отправьте запрос с помощью метода [recognize](../../vision/ocr/api-ref/TextRecognitionAsync/recognize.md):

```bash
export IAM_TOKEN=<IAM-токен>
curl \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --header "x-folder-id: <идентификатор_каталога>" \
  --header "x-data-logging-enabled: true" \
  --data "@body.json" \
  https://ocr.{{ api-host }}/ocr/v1/recognizeTextAsync
```

Где:
* `<IAM-токен>` — полученный ранее IAM-токен.
* `<идентификатор_каталога>` — полученный ранее идентификатор каталога.
