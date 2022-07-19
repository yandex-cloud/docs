# Обнаружение лиц на изображении

_Обнаружение лиц сейчас находится на [стадии Preview](/docs/overview/concepts/launch-stages)._

Чтобы обнаружить лица на фото, воспользуйтесь возможностью [Обнаружение лиц](../../concepts/face-detection/index.md).

Для этого в методе [batchAnalyze](../../api-ref/Vision/batchAnalyze.md) в свойстве `type` укажите `FACE_DETECTION`.

## Примеры {#examples}

### Перед началом {#before-you-begin}

{% include [ai-before-beginning](../../../_includes/ai-before-beginning.md) %}

### Найдите лица на изображении {#basic}

1. Подготовьте файл изображения, соответствующий требованиям:

    {% include [file-restrictions](../../../_includes/vision/file-restrictions.md) %}

    {% note info %}

    Нужно изображение? [Скачайте пример](https://storage.yandexcloud.net/vision/face-detection-sample.jpg).

    {% endnote %}
1. Кодируйте файл в формат Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}
1. Создайте файл с телом запроса, например `body.json`:

    **body.json:**
    ```json
    {
        "folderId": "b1gvmob95yysaplct532",
        "analyze_specs": [{
            "content": "iVBORw0KGgo...",
            "features": [{
                "type": "FACE_DETECTION"
            }]
        }]
    }
    ```

    Где `analyze_specs: content` – изображение, [кодированное в Base64](../base64-encode.md).

1. {% include [send-request](../../../_includes/vision/send-request.md) %}

### Готовая функция для отправки запросов в bash {#oneliner}

1. {% include [cli-install](../../../_includes/cli-install.md) %}
1. Скопируйте в терминал функцию:

    ```bash
    vision_face_detection() {
        curl -H "Authorization: Bearer `yc iam create-token`" \
        "https://vision.{{ api-host }}/vision/v1/batchAnalyze" \
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

    {% include [oneline-function-hints](../../../_includes/vision/oneline-function-hints.md) %}

1. Теперь вы можете вызывать эту функцию, передав путь к изображению в аргументах:

    ```bash
    vision_face_detection path/to/image.jpg
    ```
