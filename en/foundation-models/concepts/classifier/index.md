# Classifiers based on {{ yagpt-name }}

{{ foundation-models-full-name }} allows classifying the text requests provided in prompts. Classification in {{ yagpt-name }}-based [models](./models.md) is implemented in the [{{ foundation-models-name }} Text Classification API](../../text-classification/api-ref/index.md).

There are three types of classification available in {{ foundation-models-name }}:
* _Binary_ classification assigns a request to one of two classes, e.g., [spam](https://en.wikipedia.org/wiki/Spamming) or non-spam.
* _Multi-class_ classification puts a request into one (and only one) of more than two classes. For example, a computer CPU can belong to one generation only.
* _Multi-label_ classification allows you to assign a request to multiple different non-mutually exclusive classes at the same time. For example, a single social media post may have multiple [hashtags](https://en.wikipedia.org/wiki/Hashtag) at the same time.

Classification models are only available in [synchronous mode](../index.md#working-mode).

{{ foundation-models-name }} provides {{ yagpt-name }} classifiers of these two types: [prompt-based](#readymade) and [trainable](#trainable).

## Prompt-based classifiers {#readymade}

{{ foundation-models-name }} prompt-based classifiers support binary and multi-class classification, require no model tuning, and are prompt-controlled. The [fewShotClassify](../../text-classification/api-ref/TextClassification/fewShotClassify.md) Text Classification API method enables [using](../../operations/classifier/readymade.md) these two prompt-based classifiers: _Zero-shot_ and _few-shot_. You can provide between 2 and 20 classes to the `fewShotClassify` method.

{% note tip %}

{% include [labels-should-make-sense-notice](../../../_includes/foundation-models/classifier/labels-should-make-sense-notice.md) %}

{% endnote %}

### Zero-shot classifier {#zero-shot}

The zero-shot classifier allows you to perform binary and multi-class classification by providing only the [model ID](./models.md), task description, request text, and an array of class names in the request body.

Request body format for the zero-shot classifier:

```json
{
  "modelUri": "string",
  "taskDescription": "string",
  "labels": [
    "string",
    "string",
    ...
    "string"
  ],
  "text": "string"
}
```

Where:
* `modelUri`: [ID of the model](./models.md) that will be used to classify the message. The parameter contains {{ yandex-cloud }} [folder ID](../../../resource-manager/operations/folder/get-id.md).
* `taskDescription`: Text description of the task for the classifier.
* `labels`: Array of classes.

    {% include [labels-should-make-sense-notice](../../../_includes/foundation-models/classifier/labels-should-make-sense-notice.md) %}

* `text`: Message text.

Use the `https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification` endpoint for [requests](../../operations/classifier/readymade.md) to zero-shot classifiers.


### Few-shot classifier {#few-shot}

The few-shot classifier enables binary and multi-class classification by providing the model with an array of sample requests for the classes specified in the `labels` field. You need to list these sample requests in the `samples` field of the request body to get more accurate results from the classifier.

Request body format for the few-shot classifier:

```json
{
  "modelUri": "string",
  "taskDescription": "string",
  "labels": [
    "string",
    "string",
    ...
    "string"
  ],
  "text": "string",
  "samples": [
    {
      "text": "string",
      "label": "string"
    },
    {
      "text": "string",
      "label": "string"
    },
    ...
    {
      "text": "string",
      "label": "string"
    }
  ]
}
```

Where:
* `modelUri`: [ID of the model](./models.md) that will be used to classify the message. The parameter contains {{ yandex-cloud }} [folder ID](../../../resource-manager/operations/folder/get-id.md).
* `taskDescription`: Text description of the task for the classifier.
* `labels`: Array of classes.

    {% include [labels-should-make-sense-notice](../../../_includes/foundation-models/classifier/labels-should-make-sense-notice.md) %}

* `text`: Message text.
* `samples`: Array of sample requests for the classes specified in the `labels` field. Sample requests are provided as objects, each one containing one text request sample and the class to which such request should belong.

Use the `https://{{ api-host-llm }}/foundationModels/v1/fewShotTextClassification` endpoint for [requests](../../operations/classifier/readymade.md) to few-shot classifiers.

{% note warning %}

You can deliver multiple classification examples in a single request. All examples in the request must not exceed 6,000 tokens.

{% endnote %}

## Trainable classifiers {#trainable}

If you are not satisfied with the output quality of the [zero-shot](#zero-shot) and [few-shot](#few-shot) classifiers, [tune your own one](../../../datasphere/tutorials/yagpt-tuning-classifier.md) based on {{ yagpt-name }} in {{ ml-platform-full-name }}. [Trainable classifiers](../../../datasphere/concepts/models/foundation-models.md#classifier-training) can be trained to offer all supported classification types.

To [run](../../operations/classifier/additionally-trained.md) a request to the classifier of a model fine-tuned in {{ ml-platform-name }}, use the [classify](../../text-classification/api-ref/TextClassification/classify.md) Text Classification API method. If you do so, you only need to provide the [model ID](./models.md) and the request text to the model. The names of the classes between which the model will be distributing requests must be specified during model tuning and are not provided in the request.

Request body format for the classifier of a model fine-tuned in {{ ml-platform-name }}:

```json
{
  "modelUri": "string",
  "text": "string"
}
```

Where:
* `modelUri`: [ID of the model](./models.md) that will be used to classify the message. The parameter contains {{ yandex-cloud }} [folder ID](../../../resource-manager/operations/folder/get-id.md) and the ID of the model [tuned](../../../datasphere/concepts/models/foundation-models.md#classifier-training) in {{ ml-platform-name }}.
* `text`: Message text. The total number of tokens per request must not exceed 8,000.

Use the `https://{{ api-host-llm }}:443/foundationModels/v1/textClassification` endpoint for [requests](../../operations/classifier/additionally-trained.md) to trainable classifiers.

The names of the classes between which the model will be distributing requests must be specified during model tuning and are not provided in the request.


## Response format {#response}

All {{ foundation-models-name }} classifier types return the result in the following format:

```yaml
{
  "predictions": [
    {
      "label": "string",
      "confidence": "number",
    },
    {
      "label": "string",
      "confidence": "number",
    },
    ...
    {
      "label": "string",
      "confidence": "number",
    }
  ],
  "modelVersion": "string"
}
```

Where:
* `label`: Class name.
* `confidence`: Probability of assigning the request text to this class.

    In multi-class classification, the sum of the `confidence` values for all classes is always `1`.

    In multi-label classification, the `confidence` value for each class is calculated independently (the sum of the values is not equal to `1`).