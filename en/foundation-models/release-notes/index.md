---
title: '{{ foundation-models-full-name }} release notes'
description: This page presents {{ foundation-models-full-name }} release notes.
---

# {{ foundation-models-full-name }} release notes

## Release as of 10/10/24 {#101024}

Updated the {{ yandexart-name }} model: The updated version has better understanding of requests, considers more details, and can generate text in Latin characters on the image.

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
