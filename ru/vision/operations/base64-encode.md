# Кодировать файл в Base64

Чтобы передать файл с изображением в [!KEYREF vision-short-name] API, переведите содержимое файла в текст в формате Base64:

[!INCLUDE [base64-encode-command](../../_includes/vision/base64-encode-command.md)]

Передайте содержимое созданного файла `output.txt` в теле запроса в свойстве `content`:

```json
{
    "folderId": "ajk55f3mblj12eghq2oe",
    "analyze_specs": [{
        "content": "iVBORw0KGgo...",
        "features": [{
            "type": "TEXT_DETECTION",
            "text_detection_config": {
                "language_codes": ["en", "ru"]
            }
        }]
    }]
}

```