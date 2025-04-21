---
title: Text generation models
description: In this tutorial, you will learn about the text generation models available in {{ foundation-models-name }}.
---

# Text generation models

{{ foundation-models-full-name }} provides access to large text models from different vendors. If an out-of-the-box model is not enough, you can [fine-tune](../tuning/index.md) some models to respond to your requests more accurately.

## Generation models {#generation}

All basic models are subject to the update rules described in [Model lifecycle](#model-lifecycle). When updating models, generations available in different branches (`/latest`, `/rc`, and `/deprecated` segments) may change. 

#|
|| **URI** | **Generation** | **[Operating modes](../index.md#working-mode)** ||
|| **{{ gpt-lite }}** ||
|| `gpt://<folder_ID>/yandexgpt-lite/deprecated`</br>`gpt://<folder_ID>/yandexgpt-lite/latest`</br>`gpt://<folder_ID>/yandexgpt-lite/rc`	| 4</br>4</br>5 |  Asynchronous, synchronous ||
|| **{{ gpt-pro }}** ||
|| `gpt://<folder_ID>/yandexgpt/deprecated`</br>`gpt://<folder_ID>/yandexgpt/latest`</br>`gpt://<folder_ID>/yandexgpt/rc` | 4</br>4</br>5  | Asynchronous, synchronous ||
|| **{{ gpt-pro }} 32k** ||
|| `gpt://<folder_ID>/yandexgpt-32k/deprecated`</br>`gpt://<folder_ID>/yandexgpt-32k/latest`</br>`gpt://<folder_ID>/yandexgpt/rc` | 4</br>4</br>5  | Synchronous^1^ ||
|| **{{ llama }} 8B**^2^ ||
|| `gpt://<folder_ID>/llama-lite/deprecated`</br>`gpt://<folder_ID>/llama-lite/latest`</br>`gpt://<folder_ID>/llama-lite/rc` | 3.1</br>3.1</br>3.1 | Asynchronous, synchronous ||
|| **{{ llama }} 70B**^2^ ||
|| `gpt://<folder_ID>/llama/deprecated`</br>`gpt://<folder_ID>/llama/latest`</br>`gpt://<folder_ID>/llama/rc` | 3.3</br>3.3</br>3.3 | Asynchronous, synchronous ||
|| [**Fine-tuned models**](../tuning/index.md) ||
|| `gpt://<basic_model_URI>/<version>@<tuning_suffix>` | Depends on the basic model | Asynchronous, synchronous ||
|| **Model fine-tuned in {{ ml-platform-full-name }}** ||
|| `ds://<folder_ID>/<fine-tuning_ID>` | 3 | Asynchronous, synchronous ||
|#

Modified models share usage [quotas](../limits.md#quotas) with their basic models.

^1^ {{ gpt-pro }} 32k features an expanded context and is designed specifically to handle large texts in synchronous mode. In asynchronous mode, the {{ gpt-pro }} model supports the same amount of context. 

^2^ {{ meta-disclaimer }}

{% include [release-cycle](../../../_includes/foundation-models/release-cycle.md) %}

## Accessing models {#addressing-models}

You can access text generation models of different versions in a number of ways.

{% list tabs group=programming_language %}

- SDK {#sdk}

  When operating text generation models via [{{ ml-sdk-full-name }}](../../sdk/index.md), use one of the following formats:

  * **Model name**, provided as a string. Only the `Latest` versions are available.

      ```python
      model = (
        sdk.models.completions("yandexgpt")
      )
      ```

  * **Model name and version**, provided as strings in the `model_name` and `model_version` fields, respectively.

      ```python
      model = (
        sdk.models.completions(model_name="yandexgpt-32k", model_version="rc")
      )
      ```

      The above example explicitly specifies the `Release Candidate` version of the `{{ gpt-pro }} 32k` model.

  * **Model URI**, provided as a string containing the full [URI](#generation) of the required model version. You can also use this method to access fine-tuned models.

      ```python
      model = (
        sdk.models.completions("gpt://b1gt6g8ht345********/llama/deprecated")
      )
      ```

      The above example explicitly specifies the `Deprecated` version of the `{{ llama }} 70B` model. 

- API {#curl}

  To [access](../../operations/yandexgpt/create-prompt.md) a model via the [REST API](../../text-generation/api-ref/index.md) or [gRPC API](../../text-generation/api-ref/grpc/index.md), specify the [model's URI](#generation) containing the [folder ID](../../../resource-manager/operations/folder/get-id.md) in the `modelUri` field of the request body. The `/latest`, `/rc`, and `/deprecated` segments indicate the model [version](#model-lifecycle). `/latest` is used by default.

  **Examples:**

  * Accessing the `Latest` version of the `{{ gpt-lite }}` model:

      ```json
      {
        "modelUri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest"
        ...
      }
      ```

      To access the `Latest` versions, you do not need to specify the model version explicitly because `Latest` is used by default.
      
      For example, this URI will allow you to access the `Latest` version of the `{{ gpt-lite }}` model: `gpt://<folder_ID>/yandexgpt-lite`.

  * Accessing the `RC` version of the `{{ llama }} 70B` model:

      ```json
      {
        "modelUri": "gpt://b1gt6g8ht345********/llama/rc"
        ...
      }
      ```

{% endlist %}


#### See also {#see-also}

* [{#T}](../../operations/yandexgpt/create-prompt.md)
* [{#T}](../../operations/yandexgpt/async-request.md)
