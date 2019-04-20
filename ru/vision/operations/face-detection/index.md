# Обнаружить лица на изображении

_Обнаружение лиц сейчас находится на [стадии Preview](/docs/overview/concepts/launch-stages)._

Чтобы обнаружить лица на фото, воспользуйтесь возможностью [Обнаружение лиц](../../concepts/face-detection/index.md).

Для этого в методе [batchAnalyze](../../api-ref/Vision/batchAnalyze.md) в свойстве `type` укажите `FACE_DETECTION`.

## Примеры {#examples}

[!INCLUDE [ai-before-beginning](../../../_includes/ai-before-beginning.md)]

### Обнаружить лица {#basic}

1. Подготовьте файл изображения, соответствующий требованиям:

    [!INCLUDE [file-restrictions](../../../_includes/vision/file-restrictions.md)]

    > [!NOTE]
    >
    > Нужно изображение? [Скачайте пример](https://storage.yandexcloud.net/vision/face-detection-sample.jpg).
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
                "type": "FACE_DETECTION"
            }]
        }]
    }
    ```

1. [!INCLUDE [send-request](../../../_includes/vision/send-request.md)]

### Готовая функция для отправки запросов в bash {#oneliner}

1. [!INCLUDE [cli-install](../../../_includes/cli-install.md)]
1. Скопируйте в терминал функцию:

    ```bash
    vision_face_detection() {
        curl -H "Authorization: Bearer `yc iam create-token`" \
        "https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze" \
        -d @<(cat << EOF
    {
        "folderId": "`yc config get folder-id`",
        "analyze_specs": [{
            "content": "`base64 -i $1`",
            "features": [{
                "type": "FACE_DETECTION"
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
    vision_face_detection path/to/image.jpg
    ```
