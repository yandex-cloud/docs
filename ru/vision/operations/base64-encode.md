# Кодирование файла в Base64

{{ vision-short-name }} API работает с изображениями в формате [Base64](https://ru.wikipedia.org/wiki/Base64). Переведите ваше изображение в формат `Base64`:

{% include [base64-encode-command](../../_includes/vision/base64-encode-command.md) %}

Передайте в теле запроса содержимое файла, полученное при переводе изображения в формат Base64:

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
* `content` – содержимое файла изображения в кодировке `Base64`.
