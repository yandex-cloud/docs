---
description: "Чтобы оценить качество изображения, можно воспользоваться моделью quality сервиса {{ vision-full-name }}. Сервис сравнивает похожие изображения и выбирает лучшего качества или фильтрует изображения низкого качества, например, чтобы не показывать их в результатах поиска. Поддерживаемые форматы файлов для оценки качества JPEG, PNG, PDF."
keywords:
  - image quality
  - качество изображения
  - определение качества фотографии
---

# Определение качества изображения

{% include [deprecation-warning](../../../_includes/vision/deprecation-warning.md) %}

Чтобы оценить качество изображения, воспользуйтесь возможностью [Классификация изображений](../../concepts/classification/index.md).

Для этого в методе [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md) в свойстве `type` укажите `Classification`, а в конфигурации укажите модель [quality](../../concepts/classification/supported-models.md#quality).

## Примеры {#examples}

### Перед началом работы {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

### Примените модель для оценки качества {#basic}

1. Подготовьте файл изображения, соответствующий требованиям:

   {% include [file-restrictions](../../../_includes/vision/file-restrictions.md) %}

   {% note info %}

   Нужно изображение? [Скачайте пример](https://{{ s3-storage-host }}/vision/face-detection-sample.jpg).

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
           "model": "quality"
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

   {% include [classification-quality-response](../../../_includes/vision/classification-quality-response.md) %}

### Готовая функция для отправки запросов в bash {#oneliner}

{% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

1. Скопируйте в терминал функцию:

   ```bash
    vision_quality() {
      curl -H "Authorization: Bearer `yc iam create-token`" \
      "https://vision.{{ api-host }}/vision/v1/batchAnalyze" \
      -d @<(cat << EOF
        {
          "folderId": "`yc config get folder-id`",
          "analyze_specs": [{
            "content": "`base64 -i $1`",
            "features": [{
              "type": "CLASSIFICATION",
              "classificationConfig": {
                "model": "quality"
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
   vision_quality path/to/image.jpg
   ```