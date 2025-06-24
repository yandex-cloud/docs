---
title: '{{ ca-full-name }} release notes'
description: This section contains {{ ca-name }} release notes.
---

# {{ ca-full-name }} release notes

## May 2025 {#may-2025}

* Implemented a [chat](concepts/index.md#chat) to interact with the AI assistant in the IDE interface, with support for generation of tests and documentation.
* Added new [quotas](concepts/limits.md) for generation of documentation and tests as well as the number of chats.
* Added support for [quick actions](concepts/index.md#quick-actions): {{ ca-name }} integrations into the IDE.
* For Visual Studio Code, added localization of the plugin UI based on the IDE language.

## February 2025 {#feb-2025}

* {% include [rebranding](../_includes/code-assistant/rebranding.md) %}
* The service is publicly available at the [Preview](../overview/concepts/launch-stages.md) stage; you no longer need to request access. For more information, see [{#T}](index.md).
* Introduced a [system of quotas](concepts/limits.md).
* Added plugin support to the [VSCodium](https://vscodium.com/) IDE, a specialized build of Visual Studio Code that features only open-source components.

## January 2025 {#jan-2025}

Added the _personal memory_ feature. When generating suggestions, the model now relies on the user's previously written code and tabs currently open in their IDE. The context is available to each user individually; data is not shared within the organization or between users. A/B testing revealed a statistically significant change in metrics: accepted suggestions increased by **11%**, while rejected suggestions decreased by **17%**.

## December 2024 {#dec-2024}

* Added support for automatic plugin updates for [JetBrains IDE](https://www.jetbrains.com/ides/) and [Visual Studio Code](https://code.visualstudio.com/).
* Changed the installation method for the JetBrains IDE plugin. The plugin installed using the new method will be updated automatically. For more information, see [Installing and configuring a plugin](./index.md#install-plugin).
* Added a tooltip generation indicator in the JetBrains IDE.

## November 2024 {#nov-2024}

* The {{ ca-name }} plugin is available for JetBrains IDE version 2024.3.
* Added a tooltip generation indicator in Visual Studio Code.

## October 2024 {#oct-2024}

* Added a plugin operation indicator in the JetBrains IDE.
* Added [plugin management](index.md#manage-plugin) commands.

## September 2024 {#sep-2024}

The service is available upon request at the [Preview](../overview/concepts/launch-stages.md) stage for Visual Studio Code and JetBrains IDE versions 2024.1 and 2024.2.

For more information about {{ ca-name }}, see these public materials:
* Slides for presentation at Yandex Scale 2024, [AI tools for developers](https://scale.yandex.cloud/?v=1&videoTab=1&video=1981).
* Habr article [How we taught {{ ca-full-name }} to help developers with code and to make them happy](https://habr.com/ru/companies/yandex/articles/841436/).