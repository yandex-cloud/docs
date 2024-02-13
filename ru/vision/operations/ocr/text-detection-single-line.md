# Распознавание строки текста

Если вы не хотите передавать в {{ vision-name }} изображение целиком, вы можете вырезать строку и отправить на распознавание только ее.

## Перед началом работы {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

## Распознать строку текста с помощью OCR API {#ocr-line-recognition}

OCR API позволяет распознать отдельную строку с помощью метода [recognize](../../ocr/api-ref/TextRecognition/recognize.md).

Чтобы распознать единственную строку текста на изображении, воспользуйтесь инструкцией [Распознавание текста на изображении](./text-detection-image.md).

## Распознать строку текста с помощью Vision API {#vision-line-recognition}

{% include [deprecation-warning](../../../_includes/vision/deprecation-warning.md) %}

Vision API позволяет распознать отдельную строку с помощью метода [recognize](../../ocr/api-ref/TextRecognition/recognize.md).

В конфигурации укажите модель `line`, которая лучше подходит для распознавания отдельных строк.

{% note alert %}

{% include [include](../../../_includes/vision/text-detection-line-note.md) %}

{% endnote %}

Чтобы распознать строку текста:

1. Кодируйте файл изображения в формат Base64.

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}

1. Создайте файл с телом запроса, например `body.json`:

    **body.json:**
    ```json
    {
        "folderId": "b1gvmob95yys********",
        "analyze_specs": [{
            "content": "iVBORw0KGgo...",
            "features": [{
                "type": "TEXT_DETECTION",
                "text_detection_config": {
                    "language_codes": ["*"],
                    "model": "line"
                }
            }]
        }]
    }
    ```

    Где:
    * `folderId` – [идентификатор любого каталога](../../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `{{ roles-vision-user }}` или выше.
    * `content` – содержимое файла, полученное при [переводе](../base64-encode.md) изображения в формат Base64.
    * `model` – модель `line`.

1. {% include [send-request](../../../_includes/vision/send-request.md) %}

