```bash
export IAM_TOKEN=<IAM_token>
curl \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data '@<path_to_JSON_file>' \
  "https://translate.{{ api-host }}/translate/v2/translate"
```
