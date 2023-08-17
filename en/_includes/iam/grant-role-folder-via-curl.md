```bash
export FOLDER_ID=b1gvmob95yysaplct...
export IAM_TOKEN=CggaATEVAgA...
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${IAM_TOKEN}" \
  -d '@body.json' \
  "https://resource-manager.{{ api-host }}/resource-manager/v1/folders/${FOLDER_ID}:updateAccessBindings"
```