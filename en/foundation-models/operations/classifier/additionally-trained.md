# Using fine-tuned classifiers based on {{ yagpt-name }}

To run a request to a [fine-tuned](../../concepts/tuning/index.md) classifier, use the [classify](../../text-classification/api-ref/TextClassification/classify.md) text classification API method or [{{ ml-sdk-full-name }}](../../sdk/index.md).

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

To send a request to the classifier:

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Create a file named `classify.py` and paste the following code into it:

      {% include [classifier-ds-trained-sdk](../../../_includes/foundation-models/examples/classifier-ds-trained-sdk.md) %}

      Where:

      * `request_text`: Message text. The total number of [tokens](../../concepts/yandexgpt/tokens.md) per request must not exceed 8,000.

          {% include [sdk-input-format](../../../_includes/foundation-models/sdk-input-format.md) %}

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

      * `model`: [ID of the model](../../../foundation-models/concepts/classifier/models.md) that will be used to classify the message. This parameter contains the {{ yandex-cloud }} [folder ID](../../../resource-manager/operations/folder/get-id.md) and fine-tuning suffix.

      The names of the classes between which the model will be distributing queries must be specified during model tuning; therefore, they are not provided in the request.

  1. Run the created file:

      ```bash
      python3 classify.py
      ```

      In response, the service will return the classification results with the `confidence` values for the probability of classifying the query text into each class.

- cURL {#curl}
  
  {% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}
  
  1. Create a file with the request body, e.g., `body.json`:
  
      ```json
      {
        "modelUri": "cls://<basic_model_URI>/<version>@<tuning_suffix>",
        "text": "<request_text>"
      }
      ```
  
      Where:
      * `modelUri`: [ID of the model](../../../foundation-models/concepts/classifier/models.md) that will be used to classify the message.
      * `text`: Message text. The total number of [tokens](../../concepts/yandexgpt/tokens.md) per request must not exceed 8,000.
  
      The names of the classes between which the model will be distributing queries must be specified during model tuning; therefore, they are not provided in the request.
      
  1. Send a request to the classifier by running the following command:
  
      ```bash
      export IAM_TOKEN=<IAM_token>
      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data "@<path_to_request_body_file>" \
        "https://{{ api-host-llm }}:443/foundationModels/v1/textClassification"
      ```

      {% note info %}
      
      The `https://{{ api-host-llm }}:443/foundationModels/v1/textClassification` endpoint only works with fine-tuned classifiers. For [prompt-based classifiers](readymade.md), use `https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification`.
      
      {% endnote %}      
  
      In response, the service will return the classification results with the `confidence` values for the probability of classifying the query text into each class:
  
      ```json
      {
        "predictions": [
          {
            "label": "<class_1_name>",
            "confidence": 0.00010150671005249023
          },
          {
            "label": "<class_2_name>",
            "confidence": 0.000008225440979003906
          },
          ...
          {
            "label": "<class_n_name>",
            "confidence": 0.93212890625
          }
        ],
        "modelVersion": "<model_version>"
      }
      ```

{% endlist %}

In multi-class classification, the sum of the `confidence` values for all classes is always `1`.
  
In multi-label classification, the `confidence` value for each class is calculated independently (the sum of the values is not equal to `1`).

#### See also {#see-also}

* [{#T}](../../concepts/classifier/index.md)
* Examples of working with {{ ml-sdk-name }} on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/text_classifiers)