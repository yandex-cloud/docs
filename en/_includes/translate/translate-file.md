```bash
export API_KEY=<API_key>
curl \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Api-Key ${API_KEY}" \
  --data '@<path_to_JSON_file>' \
  "https://translate.{{ api-host }}/translate/v2/translate"
```
