# Using fine-tuned classifiers based on {{ yagpt-name }}

To run a request to the classifier of a model [fine-tuned](../../../datasphere/concepts/models/foundation-models.md#classifier-training) in {{ ml-platform-name }}, use the [classify](../../text-classification/api-ref/TextClassification/classify.md) Text Classification API method.

## Getting started {#before-begin}

{% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

## Send a request to the classifier {#request}

To send a request to the classifier:

1. Create a file with the request body, e.g., `body.json`:

   ```json
   {
     "modelUri": "cls://<folder_ID>/<classifier_ID>",
     "text": "<request_text>"
   }
   ```

   Where:
   * `modelUri`: [ID of the model](../../../foundation-models/concepts/classifier/models.md) that will be used to classify the message. The parameter contains {{ yandex-cloud }} [folder ID](../../../resource-manager/operations/folder/get-id.md) and the ID of the model [tuned](../../../datasphere/concepts/models/foundation-models.md#classifier-training) in {{ ml-platform-name }}.
   * `text`: Message text. The total number of tokens per request must not exceed 8,000.

   The names of the classes between which the model will be distributing requests must be specified during model tuning; therefore, they are not provided in the request.

1. Send a request to the classifier by running the following command:

   ```bash
   export IAM_TOKEN=<IAM_token>
   curl -X POST \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     -d "@<path_to_file_with_request_body>" \
     "https://{{ api-host-llm }}:443/foundationModels/v1/textClassification"
   ```

   In the response, the service will return the classification results with the `confidence` values for the probability of classifying the request text into each one of the classes:

   ```json
   {
     "predictions": [
       {
         "label": "<class_name_1>",
         "confidence": 0.00010150671005249023
       },
       {
         "label": "<class_name_2>",
         "confidence": 0.000008225440979003906
       },
       ...
       {
         "label": "<class_name_n>",
         "confidence": 0.93212890625
       }
     ],
     "modelVersion": "<model_version>"
   }
   ```

   In multi-class classification, the sum of the `confidence` values for all classes is always `1`.

   In multi-label classification, the `confidence` value for each class is calculated independently (the sum of the values is not equal to `1`).