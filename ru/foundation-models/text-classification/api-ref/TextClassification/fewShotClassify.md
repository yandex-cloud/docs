---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/text_classification/text-classification/api-ref/TextClassification/fewShotClassify.md
---

# Foundation Models Text Classification API, REST: TextClassification.FewShotClassify {#FewShotClassify}

RPC method for binary and multi-class classification.

You can provide up to 20 classes for few-shot text classification
with optional examples.

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
For examples of usage, see [step-by-step guides](/docs/operations/classifier/readymade).

#|
||Field | Description ||
|| modelUri | **string**

The [URI](/docs/foundation-models/concepts/classifier/models) of the classifier model. ||
|| taskDescription | **string**

Text description of the classification task. ||
|| labels[] | **string**

List of available labels for the classification result.
Give meaningful names to label classes: this is essential for correct classification results.
For example, use ``chemistry`` and ``physics`` rather than ``chm`` and ``phs`` for class names. ||
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