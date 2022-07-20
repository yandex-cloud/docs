```bash
export IAM_TOKEN=CggaATEVAgA...
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d '@<path_to_json_file>' \
    "https://translate.{{ api-host }}/translate/v2/translate"
```