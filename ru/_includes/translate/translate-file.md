```bash
export IAM_TOKEN=<IAM-токен>
curl \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data '@<путь_до_файла_json>' \
  "https://translate.{{ api-host }}/translate/v2/translate"
```
