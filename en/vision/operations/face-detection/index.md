# Detecting faces in images

{% include [deprecation-warning](../../../_includes/vision/deprecation-warning.md) %}

To detect faces in a photo, use the [Face Detection](../../concepts/face-detection/index.md).

To do this in the [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md) method, set the `type` property to `FACE_DETECTION`.

## Examples {#examples}

### Getting started {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

### Find faces in an image {#basic}

1. Prepare an image file that meets the requirements:

   {% include [file-restrictions](../../../_includes/vision/file-restrictions.md) %}

   {% note info %}

   Need an image? [Download a sample](https://{{ s3-storage-host }}/vision/face-detection-sample.jpg).

   {% endnote %}
1. Encode the file as Base64:

   {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}
1. Create a file with the request body, e.g., `body.json`:

    **body.json:**
    ```json
    {
        "folderId": "b1gvmob95yys********",
        "analyze_specs": [{
            "content": "iVBORw0KGgo...",
            "features": [{
                "type": "FACE_DETECTION"
            }]
       }]
    }
    ```

   Where:

   * `folderId`: [ID of any folder](../../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-vision-user }}` role or higher.
   * `analyze_specs: content`: Image [encoded in Base64](../base64-encode.md).

1. {% include [send-request](../../../_includes/vision/send-request.md) %}

   Where `IAM_TOKEN` is the IAM token received [before starting](#before-you-begin).

### Ready-to-use function for sending requests in bash {#oneliner}

{% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

1. {% include [cli-install](../../../_includes/cli-install.md) %}
1. Copy the function to the terminal:

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

1. Now you can call this function by passing the image path in the arguments:

    ```bash
    vision_face_detection path/to/image.jpg
    ```
