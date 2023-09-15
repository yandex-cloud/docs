# Кодирование файла в Base64

Чтобы передать файл с изображением в {{ vision-short-name }} API, переведите содержимое файла в текст в формате Base64:

{% include [base64-encode-command](../../_includes/vision/base64-encode-command.md) %}

Передайте содержимое созданного файла `output.txt` в теле запроса:

```json
{
    "folderId": "b1gvmob95yys********",
    "analyze_specs": [{
        "content": "iVBORw0KGgo...",
        ...
    }]
}

```

Где:
* `folderId` – [идентификатор любого каталога](../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `{{ roles-vision-user }}` или выше.
* `analyze_specs: content` – содержимое созданного файла `output.txt`.
