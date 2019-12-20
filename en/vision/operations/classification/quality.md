# Assessing image quality

_Image classification is currently in the [Preview stage](/docs/overview/concepts/launch-stages)._

To evaluate the quality of an image, use the [Image Classification](../../concepts/classification/index.md) feature.

In the [batchAnalyze](../../api-ref/Vision/batchAnalyze.md) method, set the `type` property to `Classification`, and in the configuration, specify the [quality](../../concepts/classification/supported-models.md#quality) model.

## Examples {#examples}

### Before getting started {#before-you-begin}

{% include [ai-before-beginning](../../../_includes/ai-before-beginning.md) %}

### Apply the model to assess quality {#basic}

1. Prepare an image file that meets the requirements:

    {% include [file-restrictions](../../../_includes/vision/file-restrictions.md) %}

    {% note info %}

    Need an image? [Download a sample](https://storage.yandexcloud.net/vision/face-detection-sample.jpg).

    {% endnote %}

1. Encode the file as Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}

1. Create a file with the request body (for example, `body.json`). In the `content` property, specify a [Base64-encoded](../base64-encode.md) image:

    **body.json:**

    ```json
    {
        "folderId": "b1gvmob95yysaplct532",
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

1. {% include [send-request](../../../_includes/vision/send-request.md) %}

    The response will contain the properties and the probability of matching them. You can use these properties to moderate the image:

    {% include [classification-quality-response](../../../_includes/vision/classification-quality-response.md) %}

### Ready-to-use function for sending requests in bash {#oneliner}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

1. Copy the function to the terminal:

    ```bash
    vision_quality() {
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

1. Now you can call this function by passing the image path in the arguments:

    ```bash
    vision_quality path/to/image.jpg
    ```

