```bash
export API_KEY=<API-ключ>
curl \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Api-Key ${API_KEY}" \
  --data '@<путь_до_файла_json>' \
  "https://translate.{{ api-host }}/translate/v2/translate"
```
