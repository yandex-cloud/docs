# Распознать текст на картинке

Чтобы распознать текст на картинке, воспользуйтесь возможностью [Распознавание текста](../../concepts/ocr/index.md).

Для этого в методе [batchAnalyze](../../api-ref/Vision/batchAnalyze.md) в свойстве `type` укажите `TEXT_DETECTION`, а в свойстве `textDetectionConfig` задайте настройки распознавания.

{% note info %}

Распознается текст, расположенный горизонтально. Если изображение или текст перевернуты, текст может не распознаться. Если вы отсканировали документ и не знаете, как повернуто изображение, отправьте несколько вариантов изображения с разными углами поворота.

{% endnote %}

## Примеры {#examples}

{% include [ai-before-beginning](../../../_includes/ai-before-beginning.md) %}

### Распознать текст {#basic}

{% include [text-detection-steps](../../../_includes/vision/text-detection-steps.md) %}

### Распознать текст на нескольких языках {#multiple-languages}

1. Создайте файл с телом запроса, например `body.json`. В свойстве `content` укажите изображение, [кодированное в Base64](../base64-encode.md).

    **body.json:**
    ```json
    {
        "folderId": "ajk55f3mblj12eghq2oe",
        "analyze_specs": [{
            "content": "iVBORw0KGgo...",
            ...
    ```
1. [Выберите языки](../../concepts/ocr/supported-languages.md) для распознавания текста и соответствующие им модели распознавания:

   * Если все языки входят в одну модель, то укажите в теле запроса несколько языков, например французский и немецкий:

       **body.json:**
       ```json
       {
           "folderId": "ajk55f3mblj12eghq2oe",
           "analyze_specs": [{
               "content": "iVBORw0KGgo...",
               "features": [{
                   "type": "TEXT_DETECTION",
                   "text_detection_config": {
                       "language_codes": ["fr", "de"]
                   }
               }]
           }]
       }
       ```
   * Если языки из разных моделей, задайте несколько конфигураций в свойстве `features`.
       Например, распознайте изображение на иврите, арабском и английском языках:

       **body.json:**
       ```json
       {
           "folderId": "ajk55f3mblj12eghq2oe",
           "analyze_specs": [{
               "content": "iVBORw0KGgo...",
               "features": [{
                   "type": "TEXT_DETECTION",
                   "text_detection_config": {
                       "language_codes": ["he","en"]
                   }
               },{
                   "type": "TEXT_DETECTION",
                   "text_detection_config": {
                       "language_codes": ["ar","en"]
                   }
               }]
           }]
       }
       ```
1. Отправьте запрос на распознавание с помощью метода [batchAnalyze](../../api-ref/Vision/batchAnalyze.md) и сохраните ответ в файл, например `output.json`:

    ```bash
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d @body.json \
        https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze > output.json
    ```