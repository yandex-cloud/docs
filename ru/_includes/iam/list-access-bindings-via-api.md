Посмотрите, кому и какие роли назначены на ресурс с помощью метода REST API `listAccessBindings`. Например, чтобы посмотреть роли на каталог `b1gvmob95yys********`:

```bash
export FOLDER_ID=b1gvmob95yys********
export IAM_TOKEN=CggaATEVAgA...
curl -H "Authorization: Bearer ${IAM_TOKEN}" "https://resource-manager.{{ api-host }}/resource-manager/v1/folders/${FOLDER_ID}:listAccessBindings"
```

Результат:

```
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
