---
title: Text generation models
description: In this tutorial, you will learn about the text generation models available in {{ foundation-models-name }}.
---

# Text generation models

{{ foundation-models-full-name }} provides access to large text models from different vendors. If an out-of-the-box model is not enough, you can [fine-tune](../tuning/index.md) some models to respond to your requests more accurately.

## Models available in common instance {#generation}

All basic models are subject to the update rules described in [Model lifecycle](#model-lifecycle). When updating models, generations available in different branches (`/latest`, `/rc`, and `/deprecated` segments) may change. Modified models share usage [quotas](../limits.md#quotas) with their basic models.

#|
|| **Model and URI** | **Generation** | **Context** | **[Operating modes](../index.md#working-mode)** ||
|| **{{ gpt-lite }}** </br>`gpt://<folder_ID>/yandexgpt-lite`	| Deprecated 5</br>Latest 5</br>RC 5 | 32,000 | Asynchronous, synchronous ||
|| **{{ gpt-pro }}** </br>`gpt://<folder_ID>/yandexgpt` | Deprecated 5</br>Latest 5</br>RC 5.1 | 32,000 | Asynchronous, synchronous ||
|| **{{ llama }} 8B**^1^ </br>`gpt://<folder_ID>/llama-lite` | Deprecated 3.1</br>Latest 3.1</br>RC 3.1 | 8,192 | Asynchronous, synchronous ||
|| **{{ llama }} 70B**^1^ </br>`gpt://<folder_ID>/llama` | Deprecated 3.3</br>Latest 3.3</br>RC 3.3 | 8,192 | Asynchronous, synchronous ||
|| **Qwen3 235B** </br>`gpt://<folder_ID>/qwen3-235b-a22b-fp8/latest` | — | 256,000 | [{{ openai }} API](../openai-compatibility.md) ||
|| **gpt-oss-120b** </br>`gpt://<folder_ID>/gpt-oss-120b/latest` | — | 128,000 | [{{ openai }} API](../openai-compatibility.md) ||
|| **gpt-oss-20b** </br>`gpt://<folder_ID>/gpt-oss-20b/latest` | — | 128,000 | [{{ openai }} API](../openai-compatibility.md) ||  
|| [**Fine-tuned models**](../tuning/index.md) </br>`gpt://<folder_ID>/<basic_model>/<version>@<suffix>` | Depends on the basic model | Depends on the basic model | Asynchronous, synchronous ||
|| **Gemma3 27B**
`gpt://<folder ID>/gemma-3-27b-it/latest`
[Gemma Terms of Use]({{ license-gemma }}) | — | 128 000 | [{{ openai }} API](../openai-compatibility.md) ||
|| **{{ yandexart-name }}** </br>`art://<folder_ID>/yandex-art/latest` | — | — | Asynchronous ||
|#

^1^ {{ meta-disclaimer }}

The Gemma 3 27B model is designed to process Base64-encoded images of any aspect ratio. An adaptive algorithm scales images up to 896 pixels on the largest side, ensuring that important visual details are preserved. Each image requires 256 [tokens](./tokens.md) for processing.

{% include [release-cycle](../../../_includes/foundation-models/release-cycle.md) %}

## Models available in batch mode {#batch}

### Text generation models {#text-batch}

#|
|| **Model** | **URI** | **Context** ||
|| **Qwen2.5 7B Instruct** 
[Model card](https://huggingface.co/Qwen/Qwen2.5-7B-Instruct)
[Apache 2.0]({{ license-apache }}) license  | `gpt://<folder_ID>/qwen2.5-7b-instruct` | 32,768 ||
|| **Qwen2.5 72B Instruct** 
[Model card](https://huggingface.co/Qwen/Qwen2.5-72B-Instruct)
[Qwen license](https://huggingface.co/Qwen/Qwen2.5-72B-Instruct/blob/main/LICENSE)  | `gpt://<folder_ID>/qwen2.5-72b-instruct` | 16,384 ||
|| **QwQ 32B Instruct** 
[Model card](https://huggingface.co/Qwen/QwQ-32B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwq-32b` | 32,768 ||
|| **Llama-3.3-70B-Instruct**^2^ 
[Model card](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct)
[Llama 3.3 license](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct/blob/main/LICENSE) | `gpt://<folder_ID>/llama3.3-70b-instruct` | 8,192 ||
|| **Llama-3.1-70B-Instruct**^2^
[Model card](https://huggingface.co/meta-llama/Llama-3.1-70B-Instruct)
[Llama 3.1 license](https://huggingface.co/meta-llama/Llama-3.1-70B-Instruct/blob/main/LICENSE)  | `gpt://<folder_ID>/llama3.1-70b-instruct` | 8,192 ||
|| **DeepSeek-R1-Distill-Llama-70B** 
[Model card](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-70B)
[MIT]({{ license-mit }}) license
Based on Llama-3.3-70B-Instruct. [Llama-3.3-70B-Instruct Terms of Use](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct/blob/main/LICENSE) | `gpt://<folder_ID>/deepseek-r1-distill-llama-70b` | 8,192 ||
|| **Qwen2.5 32B Instruct** 
[Model card](https://huggingface.co/Qwen/Qwen2.5-32B-Instruct)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen2.5-32b-instruct` | 32,768 ||
|| **DeepSeek-R1-Distill-Qwen-32B** 
[Model card](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-32B)
[MIT]({{ license-mit }}) license | `gpt://<folder_ID>/deepseek-r1-distill-qwen-32b` | 32,768 ||
|| **phi-4** 
[Model card](https://huggingface.co/microsoft/phi-4)
[MIT]({{ license-mit }}) license  | `gpt://<folder_ID>/phi-4` | 16,384 ||
|| **Gemma3 1B it**
[Model card](https://huggingface.co/google/gemma-3-1b-it)
[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-1b-it` | 32,768 ||
|| **Gemma3 4B it**
[Model card](https://huggingface.co/google/gemma-3-4b-it)
[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-4b-it` | 131,072 ||
|| **Gemma3 12B it**
[Model card](https://huggingface.co/google/gemma-3-4b-it)
[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-12b-it` | 65,536 ||
|| **Gemma3 27B it**
[Model card](https://huggingface.co/google/gemma-3-4b-it)
[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-27b-it` | 32,768 ||
|| **Qwen3-0.6B** 
[Model card](https://huggingface.co/Qwen/Qwen3-0.6B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-0.6b` | 32,768 ||
|| **Qwen3-1.7B** 
[Model card](https://huggingface.co/Qwen/Qwen3-1.7B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-1.7b` | 32,768 ||
|| **Qwen3-4B** 
[Model card](https://huggingface.co/Qwen/Qwen3-4B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-4b` | 32,768 ||
|| **Qwen3-8B** 
[Model card](https://huggingface.co/Qwen/Qwen3-8B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-8b` | 32,768 ||
|| **Qwen3-14B** 
[Model card](https://huggingface.co/Qwen/Qwen3-14B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-14b` | 32,768 ||
|| **Qwen3-32B** 
[Model card](https://huggingface.co/Qwen/Qwen3-32B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-32b` | 32,768 ||
|| **Qwen3-30B-A3B** 
[Model card](https://huggingface.co/Qwen/Qwen3-30B-A3B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-30b-a3b` | 32,768 ||
|| **Qwen3-235B-A22B** 
[Model card](https://huggingface.co/Qwen/Qwen3-235B-A22B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-235b-a22b` | 32,768 ||
|# 

^2^ {{ meta-disclaimer }}

### Multimodal models {#multimodels-batch}

| **Model** | **URI** | **Context** |
|---|---|---|
| **Qwen2 VL 7B**</br>[Model card](https://huggingface.co/Qwen/Qwen2-VL-7B-Instruct)</br>[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen2-vl-7b-instruct/` | 4096 |
| **Qwen2.5 VL 7B**</br>[Model card](https://huggingface.co/Qwen/Qwen2.5-VL-7B-Instruct)</br>[Apache 2.0]({{ license-apache }}) license  | `gpt://<folder_ID>/qwen2.5-vl-7b-instruct/` | 4096 |
| **Qwen 2.5 VL 32B Instruct**</br>[Model card](https://huggingface.co/Qwen/Qwen2.5-VL-32B-Instruct)</br>[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen2.5-vl-32b-instruct/` | 4096 |
| **DeepSeek 2 VL**</br>[Model card](https://huggingface.co/deepseek-ai/deepseek-vl2)</br>[DeepSeek license](https://github.com/deepseek-ai/DeepSeek-LLM/blob/HEAD/LICENSE-MODEL) | `gpt://<folder_ID>/deepseek-vl2/` | 4096 |
| **DeepSeek 2 VL Tiny**</br>[Model card](https://huggingface.co/deepseek-ai/deepseek-vl2-tiny)</br>[DeepSeek license](https://github.com/deepseek-ai/DeepSeek-LLM/blob/HEAD/LICENSE-MODEL) | `gpt://<folder_ID>/deepseek-vl2-tiny/` | 4096 |
| **Gemma3 4B it**</br>[Model card](https://huggingface.co/google/gemma-3-4b-it)</br>[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-4b-it/` | 4096 |
| **Gemma3 12B it**</br>[Model card](https://huggingface.co/google/gemma-3-12b-it)</br>[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-12b-it/` | 4096 |
| **Gemma3 27B it**</br>[Model card](https://huggingface.co/google/gemma-3-27b-it)</br>[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-27b-it/` | 4096 |

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

    The above example explicitly specifies the `Release Candidate` of the `{{ gpt-lite }}` model and the `Latest` of the `{{ yandexart-name }}` model.

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

    The above example explicitly specifies the `Deprecated` version of the `{{ llama }} 70B` model and the `Latest` of the `{{ yandexart-name }}` model. 

- API {#curl}

  To [access](../../operations/generation/create-prompt.md) a model via the [REST API](../../text-generation/api-ref/index.md) or [gRPC API](../../text-generation/api-ref/grpc/index.md), specify the [model's URI](#generation) containing the [folder ID](../../../resource-manager/operations/folder/get-id.md) in the `modelUri` field of the request body. The `/latest`, `/rc`, and `/deprecated` segments indicate the model [version](#model-lifecycle). `/latest` is used by default.

  **Examples:**

  * Accessing the `Latest` versions of the `{{ gpt-lite }}` and `{{ yandexart-name }}` models:

    ```json
    {
      "modelUri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest"
      ...

      "modelUri": "art://b1gt6g8ht345********/yandex-art/latest"
    }
    ```

    To access the `Latest` versions, you do not need to specify the model version explicitly because `Latest` is used by default.

  * Accessing the `RC` version of the `{{ llama }} 70B` model:

    ```json
    {
      "modelUri": "gpt://b1gt6g8ht345********/llama/rc"
      ...
    }
    ```

{% endlist %}


#### See also {#see-also}

* [{#T}](../../operations/generation/create-prompt.md)
* [{#T}](../../operations/generation/async-request.md)
* [{#T}](../../operations/generation/yandexart-request.md)
* [{#T}](../../operations/batch/create.md)
