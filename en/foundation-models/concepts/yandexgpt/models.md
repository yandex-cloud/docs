---
title: Text generation models
description: In this article, you will learn about text generation models and fine-tuning options.
---

# Text generation models

{{ yagpt-full-name }} provides access to large generative models:

* The standard {{ gpt-lite }} suitable for real-time tasks.
* The large {{ gpt-pro }} for more accurate responses to sophisticated prompts.

If out-of-the-box models are not enough, you can [fine-tune](../tuning/index.md) {{ gpt-lite }} and {{ llama }} 8b^1^ for them to provide more accurate responses to your requests.

To [access](../../operations/yandexgpt/create-prompt.md) your model via the API, under `modelUri`, specify its [URI](https://en.wikipedia.org/wiki/URI) which contains the [folder ID](../../../resource-manager/operations/folder/get-id.md). The `/latest`, `/rc`, and `/deprecated` segments indicate the model version. `/latest` is used by default.

## Generative models {#generation}

When updating models, generations available in [different branches](#model-lifecycle) (`/latest`, `/rc`, and `/deprecated` segments) may change. 


#|
|| **Model** | **URI** | **Generation** | **[Operating modes](../index.md#working-mode)** ||
|| **{{ gpt-lite }}** | `gpt://<folder_ID>/yandexgpt-lite/deprecated`
`gpt://<folder_ID>/yandexgpt-lite/latest` 
`gpt://<folder_ID>/yandexgpt-lite/rc`	| 3</br>4</br>4 |  Asynchronous, synchronous ||
|| **{{ gpt-pro }}** | `gpt://<folder_ID>/yandexgpt/deprcecated` 
`gpt://<folder_ID>/yandexgpt/latest` 
`gpt://<folder_ID>/yandexgpt/rc` | 3</br>4</br>4  | Asynchronous, synchronous ||
|| **{{ gpt-pro }} 32k** | `gpt://<folder_ID>/yandexgpt-32k/rc`
`gpt://<folder_ID>/yandexgpt-32k/latest` | 4</br>4  | Synchronous^2^ ||
|| **Model fine-tuned in {{ ml-platform-full-name }}** | `ds://<folder_ID>/<fine-tuned_model_ID>` | 3 | Asynchronous, synchronous ||
|| **{{ llama }} 8b**^1^ | `gpt://<folder_ID>/llama-lite/latest` | 3.1 | Asynchronous, synchronous ||
|| **{{ llama }} 70b**^1^ | `gpt://<folder_ID>/llama/latest` | 3.1 | Asynchronous, synchronous ||
|#

Modified models share usage [quotas](../limits.md#quotas) with their basic models.

^1^ {{ meta-disclaimer }}

^2^ {{ gpt-pro }} 32k features an expanded context and is designed specifically to handle large texts in synchronous mode. In asynchronous mode, the {{ gpt-pro }} model supports the same amount of context. 

{% include [release-cycle](../../../_includes/foundation-models/release-cycle.md) %}

## Tuning capabilities {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/foundation-models/yandexgpt/tuning-abilities.md) %}
