---
title: Text generation models
description: In this tutorial, you will learn about the text generation models available in {{ foundation-models-name }}.
---

# Text generation models

{{ foundation-models-full-name }} provides access to large text models from different vendors. If an out-of-the-box model is not enough, you can [fine-tune](../tuning/index.md) some models to respond to your requests more accurately.

{% include [release-cycle](../../../_includes/foundation-models/release-cycle.md) %}

## Models available in synchronous and asynchronous mode {#generation}

All basic models are subject to the update rules described in [Model lifecycle](#model-lifecycle). When updating models, generations available in different branches (`/latest`, `/rc`, and `/deprecated` segments) may change. Modified models share usage [quotas](../limits.md#quotas) with their basic models.

#|
|| **Model and URI** | **Generation** | **Context** | **[Operating modes](../index.md#working-mode)** ||
|| **{{ gpt-lite }}** </br>`gpt://<folder_ID>/yandexgpt-lite`	| Deprecated 4</br>Latest 5</br>RC 5 | {{ yagpt-max-tokens }}</br>{{ yagpt-max-tokens }}</br>32 000 | Asynchronous, synchronous ||
|| **{{ gpt-pro }}** </br>`gpt://<folder_ID>/yandexgpt` | Deprecated 4</br>Latest 5</br>RC 5 | {{ yagpt-max-tokens }}</br>32 000^1^</br>32 000 | Asynchronous, synchronous ||
|| **{{ gpt-pro }} 32k**^2^ </br>`gpt://<folder_ID>/yandexgpt-32k`| Deprecated 4 | 32 000 | Synchronous ||
|| **{{ llama }} 8B**^3^ </br>`gpt://<folder_ID>/llama-lite` | Deprecated 3.1</br>Latest 3.1</br>RC 3.1 | 8 192 | Asynchronous, synchronous ||
|| **{{ llama }} 70B**^3^ </br>`gpt://<folder_ID>/llama` | Deprecated 3.3</br>Latest 3.3</br>RC 3.3 | 8 192 | Asynchronous, synchronous ||
|| [**Fine-tuned models**](../tuning/index.md) </br>`gpt://<basic_model_URI>/<version>@<tuning_suffix>` | Depends on the basic model | Depends on the basic model | Asynchronous, synchronous ||
|#

^1^ The context size depends on the mode. In synchronous mode, a 4th generation {{ gpt-pro }} model can process up to {{ yagpt-max-tokens }} tokens; in asynchronous, 32,000 tokens. 

^2^ {{ gpt-pro }} 32k features a larger context window compared to the 4th generation {{ gpt-pro }}. This model was designed specifically to process large texts in synchronous mode. The 5th generation {{ gpt-pro }} models have the same context windows size in synchronous and asynchronous mode. We recommend using them instead of {{ gpt-pro }} 32k, which is getting obsolete. 

^3^ {{ meta-disclaimer }}

## Models available in batch mode {#batch}

#|
|| **Model** | **URI** | **Context** ||
|| **Qwen2.5 7B Instruct** 
[Model card](https://huggingface.co/Qwen/Qwen2.5-7B-Instruct)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen2.5-7b-instruct` | 32 768 ||
|| **Qwen2.5 72B Instruct** 
[Model card](https://huggingface.co/Qwen/Qwen2.5-72B-Instruct)
[Qwen license](https://huggingface.co/Qwen/Qwen2.5-72B-Instruct/blob/main/LICENSE) | `gpt://<folder_ID>/qwen2.5-72b-instruct` | 16 384 ||
|| **QwQ 32B Instruct** 
[Model card](https://huggingface.co/Qwen/QwQ-32B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwq-32b` | 32 768 ||
|| **Llama-3.3-70B-Instruct**^3^ 
[Model card](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct)
[Llama 3.3 license](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct/blob/main/LICENSE) | `gpt://<folder_ID>/llama3.3-70b-instruct` | 8 192 ||
|| **Llama-3.1-70B-Instruct**^3^
[Model card](https://huggingface.co/meta-llama/Llama-3.1-70B-Instruct)
[Llama 3.1 license](https://huggingface.co/meta-llama/Llama-3.1-70B-Instruct/blob/main/LICENSE) | `gpt://<folder_ID>/llama3.1-70b-instruct` | 8 192 ||
|| **DeepSeek-R1-Distill-Llama-70B** 
[Model card](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-70B)
[MIT]({{ license-mit }}) license
Based on Llama-3.3-70B-Instruct. [Llama-3.3-70B-Instruct Terms of Use](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct/blob/main/LICENSE) | `gpt://<folder_ID>/deepseek-r1-distill-llama-70b` | 8 192 ||
|| **Qwen2.5 32B Instruct** 
[Model card](https://huggingface.co/Qwen/Qwen2.5-32B-Instruct)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen2.5-32b-instruct` | 32 768 ||
|| **DeepSeek-R1-Distill-Qwen-32B** 
[Model card](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-32B)
[MIT]({{ license-mit }}) license | `gpt://<folder_ID>/deepseek-r1-distill-qwen-32b` | 32 768 ||
|| **phi-4** 
[Model card](https://huggingface.co/microsoft/phi-4)
[MIT]({{ license-mit }}) license | `gpt://<folder_ID>/phi-4` | 16 384 ||
|| **Gemma3 1B it**
[Model card](https://huggingface.co/google/gemma-3-1b-it)
[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-1b-it` | 32 768 ||
|| **Gemma3 4B it**
[Model card](https://huggingface.co/google/gemma-3-4b-it)
[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-4b-it` | 131 072 ||
|| **Gemma3 12B it**
[Model card](https://huggingface.co/google/gemma-3-4b-it)
[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-12b-it` | 65 536 ||
|| **Gemma3 27B it**
[Model card](https://huggingface.co/google/gemma-3-4b-it)
[Gemma Terms of Use]({{ license-gemma }}) | `gpt://<folder_ID>/gemma-3-27b-it` | 32 768 ||
|| **Qwen3-0.6B** 
[Model card](https://huggingface.co/Qwen/Qwen3-0.6B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-0.6b` | 32 768 ||
|| **Qwen3-1.7B** 
[Model card](https://huggingface.co/Qwen/Qwen3-1.7B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-1.7b` | 32 768 ||
|| **Qwen3-4B** 
[Model card](https://huggingface.co/Qwen/Qwen3-4B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-4b` | 32 768 ||
|| **Qwen3-8B** 
[Model card](https://huggingface.co/Qwen/Qwen3-8B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-8b` | 32 768 ||
|| **Qwen3-14B** 
[Model card](https://huggingface.co/Qwen/Qwen3-14B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-14b` | 32 768 ||
|| **Qwen3-32B** 
[Model card](https://huggingface.co/Qwen/Qwen3-32B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-32b` | 32 768 ||
|| **Qwen3-30B-A3B** 
[Model card](https://huggingface.co/Qwen/Qwen3-30B-A3B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-30b-a3b` | 32 768 ||
|| **Qwen3-235B-A22B** 
[Model card](https://huggingface.co/Qwen/Qwen3-235B-A22B)
[Apache 2.0]({{ license-apache }}) license | `gpt://<folder_ID>/qwen3-235b-a22b` | 32 768 ||
|# 

^3^ {{ meta-disclaimer }}

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
        sdk.models.completions(model_name="yandexgpt-lite", model_version="rc")
      )
      ```

      The above example explicitly specifies the `Release Candidate` version of the `{{ gpt-lite }}` model.

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
