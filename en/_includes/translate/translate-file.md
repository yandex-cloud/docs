```bash
export IAM_TOKEN=CggaATEVAgA...
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d '@body.json' \
    "https://translate.{{ api-host }}/translate/v2/translate"
```