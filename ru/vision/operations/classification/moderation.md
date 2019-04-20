# Модерировать изображения

_Классификация изображений сейчас находится на [стадии Preview](/docs/overview/concepts/launch-stages)._

Чтобы определить, соответствует ли изображение таким признакам, как <q>контент для взрослых</q>, <q>шок-контент</q>, <q>водяные знаки</q>, воспользуйтесь возможностью [Классификация изображений](../../concepts/classification/index.md).

Для этого в методе [batchAnalyze](../../api-ref/Vision/batchAnalyze.md) в свойстве `type` укажите `Classification`, а в конфигурации укажите модель [moderation](../../concepts/classification/supported-models.md#moderation).

## Примеры {#examples}

[!INCLUDE [ai-before-beginning](../../../_includes/ai-before-beginning.md)]

### Применить модель для модерации {#basic}

1. Подготовьте файл изображения, соответствующий требованиям:

    [!INCLUDE [file-restrictions](../../../_includes/vision/file-restrictions.md)]

    > [!NOTE]
    >
    > Нужно изображение? [Скачайте пример](https://storage.yandexcloud.net/vision/moderate-watermark.jpg).
1. Кодируйте файл в формат Base64:

    [!INCLUDE [base64-encode-command](../../../_includes/vision/base64-encode-command.md)]
1. Создайте файл с телом запроса, например `body.json`. В свойстве `content` укажите изображение, [кодированное в Base64](../base64-encode.md):

    **body.json:**
    ```json
    {
        "folderId": "ajk55f3mblj12eghq2oe",
        "analyze_specs": [{
            "content": "iVBORw0KGgo...",
            "features": [{
                "type": "classification",
                "classificationConfig": {
                    "model": "moderation"
                }
            }]
        }]
    }
    ```

1. [!INCLUDE [send-request](../../../_includes/vision/send-request.md)]

    В ответе будут содержаться признаки и вероятность соответствия этим признакам. По этим признакам вы можете модерировать изображение:

    ```json
    {
     "results": [
      {
       "results": [
        {
         "classification": {
          "properties": [
           {
            "name": "adult",
            "probability": 0.0017486262368038297
           },
           {
            "name": "gruesome",
            "probability": 0.0002884353743866086
           },
           {
            "name": "text",
            "probability": 0.13789896667003632
           },
           {
            "name": "watermarks",
            "probability": 0.99908816814422607
           }
          ]
         }
        }
       ]
      }
     ]
    }
    ```

### Готовая функция для отправки запросов в bash {#oneliner}

1. [!INCLUDE [cli-install](../../../_includes/cli-install.md)]
1. Скопируйте в терминал функцию:

    ```bash
    vision_moderation() {
        curl -H "Authorization: Bearer `yc iam create-token`" \
        "https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze" \
        -d @<(cat << EOF
    {
        "folderId": "`yc config get folder-id`",
        "analyze_specs": [{
            "content": "`base64 -i $1`",
            "features": [{
                "type": "CLASSIFICATION",
                "classificationConfig": {
                    "model": "moderation"
                }
            }]
        }]
    }
    EOF
    )
    }
    ```

    [!INCLUDE [oneline-function-hints](../../../_includes/vision/oneline-function-hints.md)]

1. Теперь вы можете вызывать эту функцию, передав путь к изображению в аргументах:

    ```bash
    vision_moderation path/to/image.jpg
    ```
