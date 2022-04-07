Посмотрите, кому и какие роли назначены на ресурс с помощью метода `listAccessBindings`. Например, чтобы посмотреть роли на каталог `b1gvmob95yysaplct532`:

```bash
export FOLDER_ID=b1gvmob95yysaplct532
export IAM_TOKEN=CggaATEVAgA...
curl -H "Authorization: Bearer ${IAM_TOKEN}" "https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/${FOLDER_ID}:listAccessBindings"
```

Результат:

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