---
title: '{{ foundation-models-full-name }} release notes'
description: This page presents {{ foundation-models-full-name }} release notes.
---

# {{ foundation-models-full-name }} release notes

## Release as of 9/12/24 {#091224}

Upon request, {{ lora }}-based model and classifier [tuning](../concepts/tuning/index.md) has been added in Preview.

{{ yagpt-name }}-based classifiers are now [publicly available](../../overview/concepts/launch-stages.md). 

## Release as of 4/12/24 {#041224}

[{{ llama }} 3.1 models](../concepts/yandexgpt/models.md) are now available in {{ foundation-models-name }}. For model usage costs, see [{#T}](../pricing.md). {{ meta-disclaimer }}

## Release as of 2/12/24 {#021224}

The {{ yagpt-name }} 4th generation model became available in the main branch (`Latest`). Version 3 will remain available in the `Deprecated` branch, according to the models' [lifecycle](../concepts/yandexgpt/models.md#model-lifecycle).

## Release as of 21/11/24 {#211124}

The [{{ assistant-api }}](../concepts/assistant/index.md) functionality is now available to all {{ foundation-models-full-name }} users at the [Preview](../../overview/concepts/launch-stages.md) stage.

## Release as of 01/11/24 {#011124}

1. Image generation with {{ yandexart-name }} is now [publicly available](../../overview/concepts/launch-stages.md). Starting November 1, 2024, {{ yandexart-name }} is billed according to the rules described on the [{{ foundation-models-name }} pricing policy](../pricing.md#rules-image-generation) page.
1. Increased the {{ yandexart-name }} quotas for the number of generation requests per minute and full day (24 hours).
1. Increased the {{ yagpt-name }} quota for the number of concurrent generations. For information on the restrictions in place, refer to [{#T}](../concepts/limits.md).
1. Starting December 2, 2024, the test version (`RC` branch) of the {{ yagpt-name }} model will be the main version (`Latest` branch), while the current version will remain available in the `Deprecated` branch, according to the models' [lifecycle](../concepts/yandexgpt/models.md#model-lifecycle).

## Release as of 24/10/24 {#241024}

1. The {{ yagpt-name }} 4th generation model is available for testing (`RC` branch). Compared to the previous generation, the model's response speed has increased by an average of 2.5 times. The maximum context the model operates has also been increased. In asynchronous mode, 4th generation models can process up to 32,000 tokens. And now there is the {{ gpt-pro }} 32k model added to process large contexts in synchronous mode. For more information on model limitations, see [{#T}](../concepts/limits.md).
1. Increased the maximum number of tokens per response in the management console.

## Release as of 10/10/24 {#101024}

Updated the {{ yandexart-name }} model. The updated version has better understanding of requests, considers more details, and can generate text in Latin characters on the image.

## Release as of 21/06/24 {#210624}

Starting June 24, 2024, the {{ gpt-lite }} model based on {{ yagpt-name }} 3 is available by default (`latest` branch). The deprecated model based on {{ yagpt-name }} 2 is available in the `deprecated` branch until July 1, 2024.

## Release as of 07/06/24 {#070624}

Updated the {{ yandexart-name }} model:
* Compared to the previous version, the updated model understands text requests better and creates more realistic images.
* Added the optional `aspectRatio` parameter for image aspect ratio.

## Release as of 29/05/24 {#280524}

Added the [text classification](../concepts/classifier/index.md) feature.

## Release as of 28/05/24 {#280524}

The {{ yagpt-name }} 3-based {{ gpt-lite }} RC model is now available in Release Candidate status. The model may replace the current {{ gpt-lite }} in the future.

## Release as of 19/04/24 {#190424}

Added the ability to send asynchronous requests to {{ yagpt-name }} models fine-tuned in {{ ml-platform-name }}.

## Release as of 09/04/24 {#090424}

1. Added [generation of images](../concepts/yandexart/index.md) based on text description. The {{ yandexart-name }} model works in asynchronous mode and is available in the management console in [{{ foundation-models-name }} Playground]({{ link-console-main }}/link/foundation-models) and via the [API](../image-generation/api-ref/index.md).
1. Added examples of requests to {{ yandexart-name }} in the documentation.

## Release as of 25/03/24 {#250324}

Added a new {{ gpt-pro }} model of the YandexGPT 3 family.

## Release as of 26/01/24 {#260124}

Updated the {{ yagpt-name }} and {{ gpt-lite }} [models](../concepts/yandexgpt/models.md) and improved their response performance.

## Release as of 06/12/23 {#061223}

1. Added a new {{ yagpt-name }} [model](../concepts/yandexgpt/models.md) for asynchronous mode.
1. Significantly revised the service's API.
1. Unified model names and the way to access the models.

## Release as of 02/08/23 {#020823}

1. [Increased](../concepts/limits.md) the total number of prompt and response tokens.
1. Added a new mode called Chat.
1. Added a method for counting the number of tokens in a request.
