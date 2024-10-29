---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/text_classification/text-classification/api-ref/TextClassification/fewShotClassify.md
---

# Foundation Models Text Classification API, REST: TextClassification.FewShotClassify {#FewShotClassify}

RPC method for few-shot text classification.

## HTTP request

```
POST https://llm.{{ api-host }}/foundationModels/v1/fewShotTextClassification
```

## Body parameters {#yandex.cloud.ai.foundation_models.v1.text_classification.FewShotTextClassificationRequest}

```json
{
  "modelUri": "string",
  "taskDescription": "string",
  "labels": [
    "string"
  ],
  "text": "string",
  "samples": [
    {
      "text": "string",
      "label": "string"
    }
  ]
}
```

Request for the service to classify text.

#|
||Field | Description ||
|| modelUri | **string**

The identifier of the classification model. ||
|| taskDescription | **string**

Text description of the classification task. ||
|| labels[] | **string**

List of available labels for the classification result. ||
|| text | **string**

Text for classification. ||
|| samples[] | **[ClassificationSample](#yandex.cloud.ai.foundation_models.v1.text_classification.ClassificationSample)**

Optional set of text samples with expected labels that may be used as an additional hint for the classifier. ||
|#

## ClassificationSample {#yandex.cloud.ai.foundation_models.v1.text_classification.ClassificationSample}

Description of a sample for the classification task.

#|
||Field | Description ||
|| text | **string**

Text sample. ||
|| label | **string**

Expected label for a given text. ||
|#

## Response {#yandex.cloud.ai.foundation_models.v1.text_classification.FewShotTextClassificationResponse}

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