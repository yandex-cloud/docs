Посмотрите, кому и какие роли назначены на ресурс с помощью метода REST API `listAccessBindings`. Например, чтобы посмотреть роли на каталог `b1gvmob95yysaplct532`:

```bash
export FOLDER_ID=b1gvmob95yysaplct532
export IAM_TOKEN=CggaATEVAgA...
curl -H "Authorization: Bearer ${IAM_TOKEN}" "https://resource-manager.{{ api-host }}/resource-manager/v1/folders/${FOLDER_ID}:listAccessBindings"
```

Результат:
{% if product == "yandex-cloud" %}

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
{% endif %}
{% if product == "cloud-il" %}

```
{
  "accessBindings": [
  {
    "subject": {
      "id": "ajei8n54hmfhuk5nog0g",
      "type": "federatedUser"
    },
    "roleId": "editor"
  }
  ]
}
```
{% endif %}