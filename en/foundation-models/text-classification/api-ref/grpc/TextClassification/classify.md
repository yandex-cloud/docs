---
editable: false
sourcePath: en/_api-ref-grpc/ai/foundation_models/v1/text_classification/text-classification/api-ref/grpc/TextClassification/classify.md
---

# Foundation Models Text Classification API, gRPC: TextClassificationService.Classify {#Classify}

RPC method for text classification.

## gRPC request

**rpc Classify ([TextClassificationRequest](#yandex.cloud.ai.foundation_models.v1.text_classification.TextClassificationRequest)) returns ([TextClassificationResponse](#yandex.cloud.ai.foundation_models.v1.text_classification.TextClassificationResponse))**

## TextClassificationRequest {#yandex.cloud.ai.foundation_models.v1.text_classification.TextClassificationRequest}

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

## TextClassificationResponse {#yandex.cloud.ai.foundation_models.v1.text_classification.TextClassificationResponse}

```json
{
  "predictions": [
    {
      "label": "string",
      "confidence": "double"
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
|| confidence | **double**

Confidence of item's belonging to a class. ||
|#