---
editable: false
sourcePath: en/_api-ref-grpc/ai/foundation_models/v1/text_classification/text-classification/api-ref/grpc/TextClassification/classify.md
---

# Foundation Models Text Classification API, gRPC: TextClassificationService.Classify {#Classify}

RPC method to classify text with tuned model.

The names of the classes between which the model will be distributing requests
must be specified during model tuning and are not provided in the request.

## gRPC request

**rpc Classify ([TextClassificationRequest](#yandex.cloud.ai.foundation_models.v1.text_classification.TextClassificationRequest)) returns ([TextClassificationResponse](#yandex.cloud.ai.foundation_models.v1.text_classification.TextClassificationResponse))**

## TextClassificationRequest {#yandex.cloud.ai.foundation_models.v1.text_classification.TextClassificationRequest}

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
|| confidence | **double**

The probability of classifying text into a specific class. ||
|#