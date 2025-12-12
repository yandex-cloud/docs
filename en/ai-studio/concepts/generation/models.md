---
title: Available generative models
description: In this article, you will learn about the generative models available in {{ foundation-models-name }}.
---

# Common instance models

{{ foundation-models-full-name }} provides access to large generative models from different vendors. If out-of-the-box models are not enough, you can [fine-tune](../tuning/index.md) some of them for more accurate responses. All roles required for working with the models are listed in [{#T}](../../security/index.md).

In a common instance, model resources are available to all {{ yandex-cloud }} users and shared between them, so model response time may increase under heavy workloads. You can be assured that other users have no access to the context of your exchanges with the model: even with logging on, requests are stored anonymized and potentially sensitive information is masked. However, we recommend [disabling](../../operations/disable-logging.md) data logging whenever you use our models to process sensitive information.

Common instance models are subject to the update rules described in [Model lifecycle](#model-lifecycle). When updating models, generations available in different branches (`/latest`, `/rc`, and `/deprecated` segments) may change. Modified models share usage [quotas](../limits.md#quotas) with their basic models.

#|
|| **Model and URI** | **Context** | **Available APIs** ||
|| **{{ alice-ai }}** </br>`gpt://<folder_ID>/aliceai-llm`       | 32,768 | Text generation APIs, {{ openai }}-compatible APIs ||
|| **{{ gpt-pro }} 5.1** </br>`gpt://<folder_ID>/yandexgpt/rc`   | 32,768 | Text generation APIs, {{ openai }}-compatible APIs ||
|| **{{ gpt-pro }} 5** </br>`gpt://<folder_ID>/yandexgpt/latest` | 32,768 | Text generation APIs, {{ openai }}-compatible APIs ||
|| **{{ gpt-lite }} 5** </br>`gpt://<folder_ID>/yandexgpt-lite`	| 32,768 | Text generation APIs, {{ openai }}-compatible APIs ||
|| **Qwen3 235B** </br>`gpt://<folder_ID>/qwen3-235b-a22b-fp8/latest` | 262 144 | {{ openai }}-compatible APIs ||
|| **gpt-oss-120b** </br>`gpt://<folder_ID>/gpt-oss-120b/latest` | 131,072 | {{ openai }}-compatible APIs ||
|| **gpt-oss-20b** </br>`gpt://<folder_ID>/gpt-oss-20b/latest` | 131,072 | {{ openai }}-compatible APIs ||  
|| [**Fine-tuned {{ gpt-lite }}**](../tuning/index.md) </br>`gpt://<folder_ID>/yandexgpt-lite/latest@<suffix>` | 32,768 | Text generation APIs, {{ openai }}-compatible APIs ||
|| **Gemma 3 27B**
`gpt://<folder_ID>/gemma-3-27b-it/latest`
[Gemma Terms of Use]({{ license-gemma }}) | 131,072 | {{ openai }}-compatible APIs ||
|| **{{ yandexart-name }}** </br>`art://<folder_ID>/yandex-art/latest` | 500 characters | Image generation APIs ||
|#  

Gemma 3 27B works with Base64-encoded images. The model can handle images of any aspect ratio thanks to an adaptive algorithm that scales the longer side of the image to 896 pixels while preserving important visual details. Each image uses 256 context [tokens](./tokens.md).

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
      sdk.models.completions("gpt://b1gt6g8ht345********/yandexgpt/deprecated")
    )

    # Image generation 
    model = (
      sdk.models.image_generation("art://b1gt6g8ht345********/yandex-art/latest")
    )
    ```

      This example explicitly specifies the `{{ gpt-pro }}` model of the `Deprecated` version and the `{{ yandexart-name }}` model of the `Latest` version. 

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