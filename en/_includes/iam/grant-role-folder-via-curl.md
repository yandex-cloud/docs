```bash
export FOLDER_ID=b1gvmob95yys********
export IAM_TOKEN=CggaAT********
curl \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data '@body.json' \
  "https://resource-manager.{{ api-host }}/resource-manager/v1/folders/${FOLDER_ID}:updateAccessBindings"
```
