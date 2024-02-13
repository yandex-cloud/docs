# Image moderation

{% include [deprecation-warning](../../../_includes/vision/deprecation-warning.md) %}

To determine whether an image matches properties such as <q>adult content</q>, <q>shocking content</q>, or <q>watermarks</q>, use the [Image Classification](../../concepts/classification/index.md).

In the [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md) method, set the `type` property to `Classification`, and in the configuration, specify the [moderation](../../concepts/classification/supported-models.md#moderation).

## Examples {#examples}

### Getting started {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

### Apply the moderation model {#basic}

1. Prepare an image file that meets the requirements:

   {% include [file-restrictions](../../../_includes/vision/file-restrictions.md) %}

   {% note info %}

   Need an image? [Download a sample](https://{{ s3-storage-host }}/vision/moderate-watermark.jpg).

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
                   "model": "moderation"
               }
           }]
       }]
   }
   ```

   Where:

   * `folderId`: [ID of any folder](../../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-vision-user }}` role or higher.
   * `analyze_specs: content`: Image [encoded in Base64](../base64-encode.md).

1. {% include [send-request](../../../_includes/vision/send-request.md) %}

   Where `IAM_TOKEN` is the IAM token received [before starting](#before-you-begin).

   The response will contain the properties and the probability of matching them. You can use these properties to moderate the image:

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

### Ready-to-use function for sending requests in bash {#oneliner}

{% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

1. {% include [cli-install](../../../_includes/cli-install.md) %}
1. Copy the function to the terminal:

   ```bash
   vision_moderation() {
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

1. Now you can call this function by passing the image path in the arguments:

   ```bash
   vision_moderation path/to/image.jpg
   ```

{% note tip %}

If an attempt to invoke a function ends with the `408 Request Timeout` error, try to fix the issue in one of the following ways:
* Send the request again.
* Reduce the image size.
* Upload fewer images to [batchAnalyze](../../vision/api-ref/Vision/batchAnalyze.md).

{% endnote %}
