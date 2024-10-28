# Using prompt-based classifiers based on {{ yagpt-name }}

{{ foundation-models-full-name }} provides {{ yagpt-name }} [prompt-based classifiers](../../concepts/classifier/index.md) of these two types: [Zero-shot](../../concepts/classifier/index.md#zero-shot) and [Few-shot](../../concepts/classifier/index.md#few-shot). To send a request to a prompt-based classifier, use the [fewShotClassify](../../text-classification/api-ref/TextClassification/fewShotClassify.md) Text Classification API method.

## Getting started {#before-begin}

{% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

## Send a request to the classifier {#request}

To send a request to the classifier:

1. Create a file with the request body, e.g., `body.json`:

    {% list tabs group=classifier-models %}

    - Zero-shot classifier {#zero-shot}

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
      * `modelUri`: [ID of the model](../../../foundation-models/concepts/classifier/models.md) that will be used to classify the message. The parameter contains the {{ yandex-cloud }} [folder ID](../../../resource-manager/operations/folder/get-id.md).
      * `text`: Text content of the message.
      * `taskDescription`: Text description of the task for the classifier.
      * `labels`: Array of classes.

          {% include [labels-should-make-sense-notice](../../../_includes/foundation-models/classifier/labels-should-make-sense-notice.md) %}

    - Few-shot classifier {#few-shot}

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
      * `modelUri`: [ID of the model](../../../foundation-models/concepts/classifier/models.md) that will be used to classify the message. The parameter contains the {{ yandex-cloud }} [folder ID](../../../resource-manager/operations/folder/get-id.md).
      * `text`: Text content of the message.
      * `taskDescription`: Text description of the task for the classifier.
      * `labels`: Array of classes.

          {% include [labels-should-make-sense-notice](../../../_includes/foundation-models/classifier/labels-should-make-sense-notice.md) %}

      * `samples`: Array with examples of requests for the classes specified in the `labels` field. Examples of requests are provided as objects, each containing one example of a text query and the class to which such query should belong.

    {% endlist %}

1. Send a request to the classifier by running the following command:

   {% list tabs group=programming_language %}

   - Bash {#bash}
   
     {% include [curl](../../../_includes/curl.md) %}
     
     {% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

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

   {% endlist %}

    In the response, the service will return classification results with certain `confidence` values for the probability of classifying the query text into each one of the classes:

    {% list tabs group=classifier-models %}

    - Zero-shot classifier {#zero-shot}

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

    - Few-shot classifier {#few-shot}

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

    {% endlist %}

    The sum of the `confidence` values for all classes is always `1`.