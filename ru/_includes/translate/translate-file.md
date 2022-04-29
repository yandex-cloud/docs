```bash
export IAM_TOKEN=<IAM-токен>
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${IAM_TOKEN}" \
  -d '<путь_до_файла_json>' \
  "https://translate.api.cloud.yandex.net/translate/v2/translate"
```