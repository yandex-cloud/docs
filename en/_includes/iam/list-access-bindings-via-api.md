View who has which roles assigned for working with a resource using the `listAccessBindings` REST API method. For example, to view the roles for the `b1gvmob95yysaplct532` folder:

```bash
export FOLDER_ID=b1gvmob95yysaplct532
export IAM_TOKEN=CggaATEVAgA...
curl -H "Authorization: Bearer ${IAM_TOKEN}" "https://resource-manager.{{ api-host }}/resource-manager/v1/folders/${FOLDER_ID}:listAccessBindings"
```

Output:

```
{
  "accessBindings": [
  {
    "subject": {
      "id": "ajei8n54hmfhuk5nog0g",
      "type": "userAccount"
    },
    "roleId": "editor"
  }
  ]
}
```
