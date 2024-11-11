---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/text_classification/text-classification/api-ref/TextClassification/classify.md
---

# Foundation Models Text Classification API, REST: TextClassification.Classify {#Classify}

RPC method to classify text with tuned model.

The names of the classes between which the model will be distributing requests
must be specified during model tuning and are not provided in the request.

## HTTP request

```
POST https://llm.{{ api-host }}/foundationModels/v1/textClassification
```

## Body parameters {#yandex.cloud.ai.foundation_models.v1.text_classification.TextClassificationRequest}

```json
{
  "modelUri": "string",
  "text": "string"
}
```

Request for the service to classify text with tuned model.

The names of the classes between which the model will be distributing requests must be specified during model tuning;
therefore, they are not provided in the request.

For examples of usage, see [step-by-step guides](/docs/operations/classifier/additionally-trained).

#|
||Field | Description ||
|| modelUri | **string**

The [URI](/docs/foundation-models/concepts/classifier/models) of your tuned classifier model. ||
|| text | **string**

Text for classification. ||
|#

## Response {#yandex.cloud.ai.foundation_models.v1.text_classification.TextClassificationResponse}

**HTTP Code: 200 - OK**

```json
{
  "predictions": [
    {
      "label": "string",
      "confidence": "string"
    }
  ],
  "modelVersion": "string"
}
```

Response with classifier predictions.

#|
||Field | Description ||
|| predictions[] | **[ClassificationLabel](#yandex.cloud.ai.foundation_models.v1.text_classification.ClassificationLabel)**

The classification results with the `confidence`` values
for the probability of classifying the request text into each class. ||
|| modelVersion | **string**

The model version changes with each new releases. ||
|#

## ClassificationLabel {#yandex.cloud.ai.foundation_models.v1.text_classification.ClassificationLabel}

A pair of text labels and their corresponding confidence values.

#|
||Field | Description ||
|| label | **string**

A class name label. ||
|| confidence | **string**

The probability of classifying text into a specific class. ||
|#