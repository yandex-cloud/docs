---
title: "Кодирование файла в Base64 в {{ vision-full-name }}"
description: "Следуя данной инструкции, вы сможете передать файл с изображением в {{ vision-short-name }} API." 
---

# Кодирование файла в Base64

{{ vision-short-name }} API и OCR API работают с изображениями в формате [Base64](https://ru.wikipedia.org/wiki/Base64). Переведите ваше изображение или PDF-файл в формат `Base64`:

{% include [base64-encode-command](../../_includes/vision/base64-encode-command.md) %}

Передайте в теле запроса содержимое файла, полученное при переводе изображения или PDF-файла в формат Base64:

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
* `content` – содержимое файла изображения или PDF-файла в кодировке `Base64`.
