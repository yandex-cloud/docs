---
title: Available generative models
description: In this article, you will learn about the generative models available in {{ foundation-models-name }}.
---

# Common instance models

{{ foundation-models-full-name }} provides access to large generative models from different vendors. If out-of-the-box models are not enough, you can [fine-tune](../tuning/index.md) some of them for more accurate responses. All roles required for working with the models are listed in [{#T}](../../security/index.md).

In a common instance, model resources are available to all {{ yandex-cloud }} users and shared between them, so model response time may increase under heavy workloads. We guarantee that no other user can access the context of your chats with our models: even with logging enabled, we store your queries in an anonymized form, where potentially sensitive information is reliably masked. However, we recommend [disabling](../../operations/disable-logging.md) data logging whenever you use our models to process sensitive information.

Common instance models are subject to the update rules described in [Model lifecycle](#model-lifecycle). When updating models, generations available in different branches (`/latest`, `/rc`, and `/deprecated` segments) may change. Modified models share usage [quotas](../limits.md#quotas) with their basic models.

#|
|| **Model and URI** | **Generation** | **Context** | **[Operating modes](../index.md#working-mode)** ||
|| **{{ gpt-lite }}** </br>`gpt://<folder_ID>/yandexgpt-lite`	| Deprecated 5</br>Latest 5</br>RC 5 | 32,000 | Asynchronous, synchronous ||
|| **{{ gpt-pro }}** </br>`gpt://<folder_ID>/yandexgpt` | Deprecated 5</br>Latest 5</br>RC 5.1 | 32,000 | Asynchronous, synchronous ||
|| **{{ llama }} 8B**^1^ </br>`gpt://<folder_ID>/llama-lite` | Deprecated 3.1</br>Latest 3.1</br>RC 3.1 | 8,192 | Asynchronous, synchronous ||
|| **{{ llama }} 70B**^1^ </br>`gpt://<folder_ID>/llama` | Deprecated 3.3</br>Latest 3.3</br>RC 3.3 | 8,192 | Asynchronous, synchronous ||
|| **Qwen3 235B** </br>`gpt://<folder_ID>/qwen3-235b-a22b-fp8/latest` | — | 256,000 | [{{ openai }} API](../openai-compatibility.md) ||
|| **gpt-oss-120b** </br>`gpt://<folder_ID>/gpt-oss-120b/latest` | — | 128,000 | [{{ openai }} API](../openai-compatibility.md) ||
|| **gpt-oss-20b** </br>`gpt://<folder_ID>/gpt-oss-20b/latest` | — | 128,000 | [{{ openai }} API](../openai-compatibility.md) ||  
|| [**Fine-tuned text models**](../tuning/index.md) </br>`gpt://<folder_ID>/<basic_model>/<version>@<suffix>` | Depends on the basic model | Depends on the basic model | Asynchronous, synchronous ||
|| **Gemma 3 27B**
`gpt://<folder_ID>/gemma-3-27b-it/latest`
[Gemma Terms of Use]({{ license-gemma }}) | — | 128 000 | [{{ openai }} API](../openai-compatibility.md) ||
|| **{{ yandexart-name }}** </br>`art://<folder_ID>/yandex-art/latest` | — | — | Asynchronous ||
|#

^1^ {{ meta-disclaimer }}

Gemma 3 27B processes Base64-encoded images. The model can handle images of any aspect ratio thanks to an adaptive algorithm that scales the longer side of the image to 896 pixels while preserving important visual details. Each image uses 256 context [tokens](./tokens.md).

{% include [release-cycle](../../../_includes/ai-studio/release-cycle.md) %}

## Accessing models {#addressing-models}

You can access text generation models of different versions in a number of ways.

{% list tabs group=programming_language %}

- SDK {#sdk}

  When operating text generation models via [{{ ml-sdk-full-name }}](../../sdk/index.md), use one of the following formats:

  * **Model name**, provided as a string. Only the `Latest` versions are available.

    ```python
    # Text generation
    model = (
      sdk.models.completions("yandexgpt")
    )

    # Image generation
    model = (
      sdk.models.image_generation("yandex-art")
    )
    ```

  * **Model name and version**, provided as strings in the `model_name` and `model_version` fields, respectively.

    ```python
    # Text generation
    model = (
      sdk.models.completions(model_name="yandexgpt-lite", model_version="rc")
    )

    # Image generation
    model = (
      sdk.models.image_generation(model_name="yandex-art", model_version="latest")
    )
    ```

    This example explicitly specifies the `{{ gpt-lite }}` model of the `Release Candidate` version and the `{{ yandexart-name }}` model of the `Latest` version.

  * **Model URI**, provided as a string containing the full [URI](#generation) of the required model version. You can also use this method to access fine-tuned models.

    ```python
    # Text generation
    model = (
      sdk.models.completions("gpt://b1gt6g8ht345********/llama/deprecated")
    )

    # Image generation
    model = (
      sdk.models.image_generation("art://b1gt6g8ht345********/yandex-art/latest")
    )
    ```

      This example explicitly specifies the `{{ llama }} 70B` model of the `Deprecated` version and the `{{ yandexart-name }}` model of the `Latest` version. 

- API {#curl}

  To [access](../../operations/generation/create-prompt.md) {{ yagpt-name }} models via the [REST API](../../text-generation/api-ref/index.md) or [gRPC API](../../text-generation/api-ref/grpc/index.md), specify the [model URI](#generation) containing the [folder ID](../../../resource-manager/operations/folder/get-id.md) in the `modelUri` field of the request body. The `/latest`, `/rc`, and `/deprecated` segments indicate the model [version](#model-lifecycle). `/latest` is used by default.

  To [access](../../operations/generation/yandexart-request.md) a {{ yandexart-name }} model via the [REST API](../../image-generation/api-ref/index.md) or [gRPC API](../../image-generation/api-ref/grpc/index.md), specify the model URI containing the [folder ID](../../../resource-manager/operations/folder/get-id.md) in the `modelUri` field of the request body. The `/latest` segment indicates the model version and is optional.

  * Accessing the `Latest` versions:

    ```json
    {

      "modelUri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest"
      ...

      "modelUri": "art://b1gt6g8ht345********/yandex-art/latest"
    }
    ```

  * Accessing the `RC` version (if available):
  
    ```json
    {

      "modelUri": "gpt://b1gt6g8ht345********/yandexgpt-lite/rc"
      ...
    }
    ```
    
{% endlist %}

#### See also {#see-also}

* [{#T}](../../operations/generation/create-prompt.md)
* [{#T}](../../operations/generation/async-request.md)
* [{#T}](../../operations/generation/yandexart-request.md)
* [{#T}](../../operations/batch/create.md)