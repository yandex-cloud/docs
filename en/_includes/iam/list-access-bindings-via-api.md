View the roles and assignees for the resource using the `listAccessBindings` REST API method. For example, to view the roles for the `b1gvmob95yys********` folder:

```bash
export FOLDER_ID=b1gvmob95yys********
export IAM_TOKEN=CggaATEVAgA...
curl \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  "https://resource-manager.{{ api-host }}/resource-manager/v1/folders/${FOLDER_ID}:listAccessBindings"
```

Result:

```json
{
  "accessBindings": [
  {
    "subject": {
      "id": "ajei8n54hmfh********",
      "type": "userAccount"
    },
    "roleId": "editor"
  }
  ]
}
```
