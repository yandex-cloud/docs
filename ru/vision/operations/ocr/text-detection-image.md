# Распознавание текста на изображении

Чтобы [распознать текст](../../concepts/ocr/index.md) на изображении, вы можете использовать [OCR API](../../ocr/api-ref/index.md). OCR API — это обновленный и переработанный интерфейс, который предоставляет больше [возможностей](../../concepts/limits.md#vision-limits), в т.ч. распознавание многоколоночного текста.

## Перед началом работы {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

## Распознать текст на изображении с помощью OCR API {#ocr-api-recognition}

Распознавание текста на изображении реализовано в методе [recognize](../../ocr/api-ref/TextRecognition/recognize.md) OCR API.

1. Подготовьте файл изображения, соответствующий требованиям:

    {% include [file-restrictions](../../../_includes/vision/ocr-file-restrictions.md) %}

    {% note info %}

    Нужен пример изображения? Скачайте изображение дорожного знака, [предупреждающего о пингвинах](https://{{ s3-storage-host }}/vision/penguins_sample.jpg).

    {% endnote %}

1. Кодируйте файл с изображением в формат Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}

1. Создайте файл с телом запроса, например `body.json`.

    **body.json:**
    ```json
    {
      "mimeType": "JPEG",
      "languageCodes": ["*"],
      "model": "page",
      "content": "<изображение_в_кодировке_base64>"
    }
    ```

    В свойстве `content` укажите содержимое файла, полученное при [переводе](../base64-encode.md) изображения в формат Base64.
    
    Чтобы сервис автоматически определил язык текста, укажите в конфигурации свойство `"languageCodes": ["*"]`.


1. {% include [send-request](../../../_includes/vision/send-request_ocr.md) %}

    Результат будет состоять из распознанных блоков текста, строк и слов с указанием их местоположения на изображении:

    {% include [text-detection](../../../_includes/vision/text-detection-example.md) %}

1. Чтобы получить все распознанные на изображении слова, найдите все значения со свойством `text`.

{% include [coordinate-definition-issue-note](../../../_includes/vision/coordinate-definition-issue-note.md) %}

