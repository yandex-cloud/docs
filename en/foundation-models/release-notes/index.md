---
title: '{{ foundation-models-full-name }} release notes'
description: This page presents the {{ foundation-models-full-name }} release notes.
---

# {{ foundation-models-full-name }} release notes

## Release as of 28/08/2025 {#280825}

* The {{ gpt-pro }} 5.1 model is available for testing (`RC` branch). The new model does not support the reasoning mode.
* Discontinued support for version 4 of the {{ gpt-pro }}, {{ gpt-pro }} 32k, {{ gpt-lite }} models, and models fine-tuned on {{ gpt-lite }} version 4.

## Release as of 06/08/2025 {#060825}

The {{ openai }} gpt-oss-120b and gpt-oss-20b models are now available in synchronous mode via the {{ openai }} API. These models are good at reasoning, but do not yet support function calling.

## Release as of 24/07/2025 {#240725}

Updated the Qwen3 235B model by increasing its context length to 256,000 tokens.

## Release as of 03/07/2025 {#030725}

Qwen3 235B is now available in synchronous mode. The model works only through the {{ openai }} API.

## Release as of 15/05/2025 {#150525}

In line with the lifecycle, updated the [text generation model](../concepts/generation/models.md#generation) versions available in synchronous and asynchronous mode. Discontinued support of {{ yagpt-name }} version 3 models and models fine-tuned in {{ ml-platform-full-name }}.

## Release as of 30/04/2025 {#290425}

New text models of the Qwen3 family are now available in batch mode.

## Release as of 24/04/2025 {#240425}

Vision language models are now available in {{ foundation-models-name }}.

Added [batch mode](../concepts/index.md#working-mode) for working with models: now you can process large amounts of data with a single request. The batch mode is supported for [text generation models](../concepts/generation/models.md#batch) and vision language models. Added new types of [datasets](../concepts/resources/dataset.md) to use in batch mode.

## Release as of 31/03/2025 {#310325}

1. The `RC` branch now features the {{ gpt-lite }} 5th generation model, which supports contexts of up to 32,000 tokens in both synchronous and asynchronous modes.
1. Added [support](../concepts/openai-compatibility.md) for {{ openai }} tools to work with text generation models. 

## Release as of 19/03/2025 {#190325}

Increased some limits for {{ assistant-api }}: now you can add up to 10,000 documents with the total size of 5 million tokens to a search index. You can upload up to 100 documents at a time. Also, increased the maximum number of threads to 10,000 and maximum number of messages per thread to 100,000. For a complete list of limits, see [{#T}](../concepts/limits.md).

## Release as of 25/02/2025 {#250225}

The {{ yagpt-name }} 5th generation model is available for testing (`RC` branch). The 5th generation key upgrades include:
* [Function calling](../concepts/generation/function-call.md) was significantly improved.
* Added support for structured output. This feature enables you to set up the model to generate responses in random JSON format or according to the provided schema. For more information on structuring model output, see [Text generation overview](../concepts/generation/index.md#answers-formatting).
* Increased the supported context to 32,000 tokens for all modes.

## Release as of 11/02/25 {#110225}

1. Updated the [{{ llama }} 70B](../concepts/generation/models.md) model version. Now {{ llama }} 3.3. {{ meta-disclaimer }} is available in all branches.
1. A new version is out: {{ ml-sdk-name }} 0.3.1. It features the following updates:
	* Python 3.8 is no longer supported.
	* Added the multipart mode for uploading large datasets.
	* Added the `allow_data_logging` option that allows you to use dataset data to improve the tuning service when loading datasets.
	* Added the `validation_errors` field that stores dataset validation errors.
	* Replaced the `grpc_credentials` field with `verify` in the SDK builder.

## Release as of 07/02/25 {#070225}

Added support for the [reasoning mode](../concepts/generation/chain-of-thought.md) in the {{ gpt-pro }} model.

## Release as of 09/12/24 {#091224}

Upon request, {{ lora }}-based model and classifier [tuning](../concepts/tuning/index.md) has been added in Preview.

{{ yagpt-name }}-based classifiers are now [publicly available](../../overview/concepts/launch-stages.md). 

## Release as of 04/12/24 {#041224}

[{{ llama }} 3.1 models](../concepts/generation/models.md) are now available in {{ foundation-models-name }}. For model usage costs, see [{#T}](../pricing.md). 

## Release as of 02/12/24 {#021224}

The {{ yagpt-name }} 4th generation model is now available in the main branch (`Latest`). Version 3 will remain available in the `Deprecated` branch as per the models' [lifecycle](../concepts/generation/models.md#model-lifecycle).

## Release as of 21/11/24 {#211124}

The [{{ assistant-api }}](../concepts/assistant/index.md) functionality is now available to all {{ foundation-models-full-name }} users at the [Preview](../../overview/concepts/launch-stages.md) stage.

## Release as of 01/11/24 {#011124}

1. Image generation with {{ yandexart-name }} is now [publicly available](../../overview/concepts/launch-stages.md). Starting November 1, 2024, {{ yandexart-name }} is billed as per the rules described on the [{{ foundation-models-name }} pricing policy](../pricing.md#rules-image-generation) page.
1. Increased the {{ yandexart-name }} quotas for the number of generation requests per minute and full day (24 hours).
1. Increased the {{ yagpt-name }} quota for the number of concurrent generations. For information on the restrictions in place, refer to [{#T}](../concepts/limits.md).
1. Starting December 2, 2024, the {{ yagpt-name }} model's test version (`RC` branch) will become the main version (`Latest` branch). The current version will remain available in the `Deprecated` branch as per the models' [lifecycle](../concepts/generation/models.md#model-lifecycle).

## Release as of 24/10/2024 {#241024}

1. The {{ yagpt-name }} 4th generation model is available for testing (`RC` branch). Compared to the previous generation, the model's response speed has increased by an average of 2.5 times. The maximum context the model operates has also been increased. In asynchronous mode, 4th generation models can process up to 32,000 tokens. And now there is the {{ gpt-pro }} 32k model added to process large contexts in synchronous mode. For more information on model limitations, see [{#T}](../concepts/limits.md).
1. Increased the maximum number of tokens per response in the management console.

## Release as of 10/10/24 {#101024}

Updated the {{ yandexart-name }} model. The updated version has better understanding of prompts, considers more details, and can generate text in Latin characters on the image.

## Release as of 21/06/24 {#210624}

Starting June 24, 2024, the {{ gpt-lite }} model based on {{ yagpt-name }} 3 is available by default (`latest` branch). The deprecated model based on {{ yagpt-name }} 2 is available in the `deprecated` branch until July 1, 2024.

## Release as of 07/06/24 {#070624}

Updated the {{ yandexart-name }} model:
* Compared to the previous version, the updated model understands text prompts better and creates more realistic images.
* Added the optional `aspectRatio` parameter for the image aspect ratio.

## Release as of 29/05/24 {#280524}

Added the [text classification](../concepts/classifier/index.md) feature.

## Release as of 28/05/24 {#280524}

The {{ yagpt-name }} 3-based {{ gpt-lite }} RC model is now available in Release Candidate status. The model may replace the current {{ gpt-lite }} in the future.

## Release as of 19/04/24 {#190424}

Now you can send asynchronous requests to {{ yagpt-name }} models fine-tuned in {{ ml-platform-name }}.

## Release as of 09/04/24 {#090424}

1. Added the [generation of images](../concepts/generation/index.md) based on a text description. The {{ yandexart-name }} model works in asynchronous mode and is available in the management console in [{{ foundation-models-name }} Playground]({{ link-console-main }}/link/foundation-models) and via the [API](../image-generation/api-ref/index.md). 
1. Added examples of requests to {{ yandexart-name }} in the documentation.

## Release as of 25/03/24 {#250324}

Added a new {{ gpt-pro }} model of the YandexGPT 3 family.

## Release as of 26/01/24 {#260124}

Updated the {{ yagpt-name }} and {{ gpt-lite }} [models](../concepts/generation/models.md) and improved their response performance.

## Release as of 06/12/23 {#061223}

1. Added a new {{ yagpt-name }} [model](../concepts/generation/models.md) for asynchronous mode.
1. Significantly revised the service's API.
1. Unified model names and the way to access the models.

## Release as of 02/08/23 {#020823}

1. [Increased](../concepts/limits.md) the total number of prompt and response tokens.
1. Added a new mode called Chat.
1. Added a method for counting the number of tokens in a request.
