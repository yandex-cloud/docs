---
title: "{{ foundation-models-full-name }} release notes"
description: "This page presents {{ foundation-models-full-name }} release notes."
---

# {{ foundation-models-full-name }} release notes

## Release on 07/06/2024 {#070624}

Updated the {{ yandexart-name }} model:
* Compared to the previous version, the updated model understands text requests better and creates more realistic images.
* Added the optional `aspectRatio` parameter to specify the image aspect ratio.

## Release on 29/05/2024 {#280524}

Added the [text classification](../concepts/classifier/index.md) feature.

## Release on 28/05/2024 {#280524}

The {{ yagpt-name }} 3-based {{ gpt-lite }} RC model is now available in Release Candidate status. The model may replace the current {{ gpt-lite }} in the future.

## Release on 19/04/2024 {#190424}

Added the ability to send asynchronous requests to {{ yagpt-name }} models fine-tuned in {{ ml-platform-name }}.

## Release on 09/04/2024 {#090424}

1. Added [generation of images](../concepts/yandexart/index.md) based on text description. The {{ yandexart-name }} model works in asynchronous mode and is available in the management console in [{{ foundation-models-name }} Playground]({{ link-console-main }}/link/foundation-models) and via the [API](../image-generation/api-ref/index.md).
1. Added examples of requests to {{ yandexart-name }} in the documentation.

## Release on 25/03/2024 {#250324}

Added a new {{ gpt-pro }} model of the YandexGPT 3 family.

## Release on 26/01/2024 {#260124}

Updated the {{ yagpt-name }} and {{ gpt-lite }} [models](../concepts/yandexgpt/models.md) and improved their response performance.

## Release on 06/12/2023 {#061223}

1. Added a new {{ yagpt-name }} [model](../concepts/yandexgpt/models.md) for asynchronous mode.
1. Significantly revised the service's API.
1. Unified model names and the way to access the models.

## Release on 02/08/2023 {#020823}

1. [Increased](../concepts/limits.md) the total number of prompt and response tokens.
1. Added a new mode called Chat.
1. Added a method for counting the number of tokens in a request.
