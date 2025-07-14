---
noIndex: true
---

# Модерирование изображений

{% include [deprecation-warning](../../../_includes/vision/deprecation-warning.md) %}

Чтобы определить, соответствует ли изображение таким признакам, как <q>контент для взрослых</q>, <q>шок-контент</q>, <q>водяные знаки</q>, воспользуйтесь возможностью [Классификация изображений](../../concepts/classification/index.md).

Для этого в методе [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md) в свойстве `type` укажите `Classification`, а в конфигурации укажите модель [moderation](../../concepts/classification/supported-models.md#moderation).

## Примеры {#examples}

### Перед началом работы {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

### Примените модель для модерации {#basic}

1. Подготовьте файл изображения, соответствующий требованиям:

    {% include [file-restrictions](../../../_includes/vision/file-restrictions.md) %}

    {% note info %}

    Нужен пример? [Скачайте изображение](https://{{ s3-storage-host }}/doc-files/ml/vision/moderate-watermark.jpg).

    {% endnote %}
    
1. Кодируйте файл в формат Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}
1. Создайте файл с телом запроса, например `body.json`:

    **body.json:**
    ```json
    {
        "folderId": "b1gvmob95yys********",
        "analyze_specs": [{
            "content": "iVBORw0KGgo...",
            "features": [{
                "type": "CLASSIFICATION",
                "classificationConfig": {
                    "model": "moderation"
                }
            }]
        }]
    }
    ```

    Где:

    * `folderId` – [идентификатор любого каталога](../../../resource-manager/operations/folder/get-id.md), на который у вашего аккаунта есть роль `{{ roles-vision-user }}` или выше.
    * `analyze_specs: content` – изображение, [кодированное в Base64](../base64-encode.md).

1. {% include [send-request](../../../_includes/vision/send-request.md) %}

    Где `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-you-begin).

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

{% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

1. {% include [cli-install](../../../_includes/cli-install.md) %}
1. Скопируйте в терминал функцию:

    ```bash
    vision_moderation() {
        curl --header "Authorization: Bearer `yc iam create-token`" \
        "https://vision.{{ api-host }}/vision/v1/batchAnalyze" \
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

    {% include [oneline-function-hints](../../../_includes/vision/oneline-function-hints.md) %}

1. Теперь вы можете вызывать эту функцию, передав путь к изображению в аргументах:

    ```bash
    vision_moderation path/to/image.jpg
    ```

{% note tip %}

Если вызов функции завершился с ошибкой `408 Request Timeout`, попробуйте решить проблему одним из способов:
* отправьте запрос повторно;
* уменьшите размер изображения;
* загрузите меньшее количество изображений в [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md).

{% endnote %}
