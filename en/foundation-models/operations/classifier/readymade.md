# Using prompt-based classifiers based on {{ yagpt-name }}

{{ foundation-models-full-name }} provides {{ yagpt-name }} [prompt-based classifiers](../../concepts/classifier/index.md) of these two types: [zero-shot](../../concepts/classifier/index.md#zero-shot) and [few-shot](../../concepts/classifier/index.md#few-shot). To send a request to a prompt-based classifier, use the [fewShotClassify](../../text-classification/api-ref/TextClassification/fewShotClassify.md) text classification API method or [{{ ml-sdk-full-name }}](../../sdk/index.md).

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/foundation-models/sdk-before-begin-ai-langmodel-user.md) %}

- cURL {#curl}

  1. {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}
  1. {% include [curl](../../../_includes/curl.md) %}

{% endlist %}

## Send a request to the classifier {#request}

{% list tabs group=programming_language %}

- SDK {#sdk}

  This code includes two independent examples illustrating different uses of the SDK interface:
  * Example 1: Request to the [zero-shot](../../concepts/classifier/index.md#zero-shot) classifier.
  * Example 2: Request to the [few-shot](../../concepts/classifier/index.md#few-shot) classifier.

  1. Create a file named `classify.py` and paste the following code into it:

      {% include [classifier-yandexgpt-sdk](../../../_includes/foundation-models/examples/classifier-yandexgpt-sdk.md) %}

      Where:

      * `request_text`: Message text.

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Run the created file:

      ```bash
      python3 classify.py
      ```

      In response, the service will return the classification results for both examples with the `confidence` values for the probability of classifying the query text into each class:

      ```text
      Zero-shot classification:
      TextClassificationLabel(label='translation', confidence=1.1142491374016572e-08)
      TextClassificationLabel(label='alarm', confidence=3.088581834731485e-08)
      TextClassificationLabel(label='weather', confidence=1.0)
      Few-shot classification:
      TextClassificationLabel(label='translation', confidence=0.9954985976219177)
      TextClassificationLabel(label='alarm', confidence=3.306578582851216e-05)
      TextClassificationLabel(label='weather', confidence=0.004468236118555069)
      ```

- cURL {#curl}

  {% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

  1. Create a file with the request body, e.g., `body.json`:

      {% cut "Zero-shot classifier" %}

      ```json
      {
        "modelUri": "cls://<folder_ID>/yandexgpt/latest",
        "text": "5:0",
        "task_description": "Categorize an article by its title",
        "labels": [
          "culture",
          "technologies",
          "sports"
        ]
      }
      ```

      Where:
      * `modelUri`: [ID of the model](../../../foundation-models/concepts/classifier/models.md) that will be used to classify the message. This parameter contains the {{ yandex-cloud }} [folder ID](../../../resource-manager/operations/folder/get-id.md).
      * `text`: Message text.
      * `taskDescription`: Text description of the task for the classifier.
      * `labels`: Array of classes.

          {% include [labels-should-make-sense-notice](../../../_includes/foundation-models/classifier/labels-should-make-sense-notice.md) %}

      {% endcut %}

      {% cut "Few-shot classifier" %}

      ```json
      {
        "modelUri": "cls://<folder_ID>/yandexgpt/latest",
        "text": "translate into Russian \"what's the weather like in London?\"",
        "task_description": "determine the intent type",
        "labels": [
          "translation",
          "alarm",
          "weather"
        ],
        "samples": [
          {
            "text": "set an alarm",
            "label": "alarm"
          },
          {
            "text": "weather for tomorrow",
            "label": "weather"
          },
          {
            "text": "translate the phrase \"set an alarm\"",
            "label": "translation"
          }
        ]
      }
      ```

      Where:
      * `modelUri`: [ID of the model](../../../foundation-models/concepts/classifier/models.md) that will be used to classify the message. This parameter contains the {{ yandex-cloud }} [folder ID](../../../resource-manager/operations/folder/get-id.md).
      * `text`: Message text.
      * `taskDescription`: Text description of the task for the classifier.
      * `labels`: Array of classes.

          {% include [labels-should-make-sense-notice](../../../_includes/foundation-models/classifier/labels-should-make-sense-notice.md) %}

      * `samples`: Array with examples of prompts for the classes specified in the `labels` field. Examples of prompts are provided as objects, each containing an example of a text query and the class to which such query should belong.

      {% endcut %}

  1. Send a request to the classifier by running the following command:

      ```bash
      export IAM_TOKEN=<IAM_token>
      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data "@<path_to_file_with_request_body>" \
        "https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification"
      ```

      {% note info %}

      The `https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification` endpoint only works with prompt-based classifiers. For [fine-tuned](additionally-trained.md) classifiers, use `https://{{ api-host-llm }}:443/foundationModels/v1/textClassification`.
      
      {% endnote %}

      In response, the service will return the classification results with the `confidence` values for the probability of classifying the query text into each class:

      {% cut "Zero-shot classifier" %}

      ```json
      {
        "predictions": [
          {
            "label": "culture",
            "confidence": 2.2111835562554916e-7
          },
          {
            "label": "technologies",
            "confidence": 0.0003487042267806828
          },
          {
            "label": "sports",
            "confidence": 0.9996510744094849
          }
        ],
        "modelVersion": "07.03.2024"
      }
      ```

      {% endcut %}

      {% cut "Few-shot classifier" %}

      ```json
      {
        "predictions": [
          {
            "label": "translation",
            "confidence": 0.9357050657272339
          },
          {
            "label": "alarm",
            "confidence": 0.00061939493753016
          },
          {
            "label": "weather",
            "confidence": 0.06367553025484085
          }
        ],
        "modelVersion": "07.03.2024"
      }
      ```

      {% endcut %}

{% endlist %}

The sum of the `confidence` values for all classes is always `1`.

#### See also {#see-also}

* [{#T}](../../concepts/classifier/index.md)
* Examples of working with ML SDK on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/text_classifiers)