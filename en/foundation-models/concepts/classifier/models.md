---
title: Classifier models
description: In this tutorial, you will learn about the classifier models available in {{ foundation-models-name }}.
---

# Classifier models based on {{ yagpt-name }}

{{ foundation-models-full-name }} offers you {{ gpt-lite }} and {{ gpt-pro }}-based classifier models to [classify](./index.md) text requests provided in prompts. The classification is implemented based on the [{{ foundation-models-name }}Text Classification API](../../text-classification/api-ref/index.md).

If an out-of-the-box model is not enough, you can [fine-tune](../tuning/classifier.md) a {{ gpt-lite }}-based classifier for the model to classify your requests more accurately. To access a fine-tuned classifier model, use the [classify](../../text-classification/api-ref/TextClassification/classify.md) Text Classification API method.

| **Model** | **URI** | **[Operating modes](../index.md#working-mode)** |
|---|---|---|
| Prompt-based classifier built on {{ gpt-lite }} | `cls://<folder_ID>/yandexgpt-lite/latest` | Synchronous |
| Prompt-based classifier built on {{ gpt-pro }} | `cls://<folder_ID>/yandexgpt/latest` | Synchronous |
| Fine-tuned classifier | `cls://<basic_model_URI>/<version>@<tuning_suffix>` | Synchronous |
| Classifier model fine-tuned in {{ ml-platform-name }} | `cls://<folder_ID>/<fine-tuned_model_ID>` | Synchronous |

## Accessing models {#addressing-models}

You can access classifier models in a number of ways.

{% list tabs group=programming_language %}

- SDK {#sdk}

  When operating classifier models via [{{ ml-sdk-full-name }}](../../sdk/index.md), use one of the following formats:

  * **Model name**, provided as a string.

      ```python
      model = (
        sdk.models.text_classifiers("yandexgpt-lite")
      )
      ```

  * **Model name and version**, provided as strings in the `model_name` and `model_version` fields, respectively.

      ```python
      model = (
        sdk.models.text_classifiers(model_name="yandexgpt", model_version="latest")
      )
      ```

  * **Model URI**, provided as a string containing the full URI of the model. You can also use this method to access fine-tuned models.

      ```python
      model = (
        sdk.models.text_classifiers("cls://b1gt6g8ht345********/yandexgpt/latest")
      )
      ```

- API {#curl}

  To [access](../../operations/classifier/readymade.md) a model via the [REST API](../../text-classification/api-ref/TextClassification/fewShotClassify.md) or [gRPC API](../../text-classification/api-ref/grpc/TextClassification/fewShotClassify.md), specify the model's URI containing the [folder ID](../../../resource-manager/operations/folder/get-id.md) in the `modelUri` field of the request body. The `/latest` segment indicates the model version and is optional. To access a {{ yagpt-name }}-based classifier model, use the `fewShotClassify` Text Classification API method/call.

  **Example:**

  ```json
  {
    "modelUri": "cls://b1gt6g8ht345********/yandexgpt-lite/latest"
    ...
  }
  ```

  To access the `Latest` version, you do not need to specify the model version explicitly because `Latest` is used by default.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../operations/classifier/readymade.md)
* [{#T}](../../operations/classifier/additionally-trained.md)