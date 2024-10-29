---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/text_classification/text-classification/api-ref/TextClassification/classify.md
---

# Foundation Models Text Classification API, REST: TextClassification.Classify {#Classify}

RPC method for text classification.

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

Request for the service to classify text.

#|
||Field | Description ||
|| modelUri | **string**

The identifier of the classification model. ||
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

Response containing classifier predictions.

#|
||Field | Description ||
|| predictions[] | **[ClassificationLabel](#yandex.cloud.ai.foundation_models.v1.text_classification.ClassificationLabel)**

Result of classification - a list of label-confidence pairs. ||
|| modelVersion | **string**

Model version (changes with model releases). ||
|#

## ClassificationLabel {#yandex.cloud.ai.foundation_models.v1.text_classification.ClassificationLabel}

A pair of text label and corresponding confidence used in classification problems.

#|
||Field | Description ||
|| label | **string**

A label with a class name. ||
|| confidence | **string**

Confidence of item's belonging to a class. ||
|#