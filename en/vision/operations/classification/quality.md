---
description: "To evaluate image quality, you can use the quality model offered by {{ vision-full-name }}. The service compares similar images and selects the best quality ones or filters out lower quality images, e.g., to exclude them from search results. Supported file formats for quality evaluation: JPEG, PNG, PDF."
noIndex: true
keywords:
  - image quality
  - photo quality detection
---

# Assessing image quality

{% include [deprecation-warning](../../../_includes/vision/deprecation-warning.md) %}

To evaluate the quality of an image, use [Image classification](../../concepts/classification/index.md).

In the [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md) method, set the `type` property to `Classification`, and specify the [quality](../../concepts/classification/supported-models.md#quality) model in the configuration.

## Examples {#examples}

### Getting started {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

### Apply the model to assess quality {#basic}

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
         "type": "CLASSIFICATION",
         "classificationConfig": {
           "model": "quality"
         }
       }]
     }]
   }
   ```

   Where:

   * `folderId`: [ID of any folder](../../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-vision-user }}` role or higher.
   * `analyze_specs: content`: [Base64 encoded](../base64-encode.md) image.

1. {% include [send-request](../../../_includes/vision/send-request.md) %}

   Where `IAM_TOKEN` is the IAM token you got [before you started](#before-you-begin).

   The response will contain the properties and the probability of matching them. You can use these properties to moderate the image:

   {% include [classification-quality-response](../../../_includes/vision/classification-quality-response.md) %}

### Ready-to-use function for sending requests in bash {#oneliner}

{% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

1. Copy the function to the terminal:

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

1. Now you can call this function by passing the image path in the arguments:

   ```bash
   vision_quality path/to/image.jpg
   ```