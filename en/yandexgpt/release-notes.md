---
title: "{{ yagpt-full-name }} release notes"
description: "This page contains {{ yagpt-full-name }} release notes."
---

# {{ yagpt-full-name }} release notes

## Current version {#current}

### Release on 27/03/2024 {#270324}

1. Added a new {{ gpt-pro }} model of the YandexGPT 3 family.
1. Model tuning in {{ ml-platform-name }} now works based on the new {{ gpt-pro }} model.
1. In the [management console]({{ link-console-main }}/link/yandexgpt), new {{ yandex-cloud }} users without a [billing account](../billing/concepts/billing-account.md) now have a quota of {{ gpt-freetier }} free prompts per hour.

## Previous versions {#previous}

### Release on 26/01/2024 {#260124}

Updated the {{ yagpt-name }} and {{ gpt-lite }} [models](concepts/models.md) and improved their response performance.

### Release on 06/12/2023 {#061223}

1. Added a new {{ yagpt-name }} [model](concepts/models.md) for asynchronous mode.
1. Significantly revised the service's API.
1. Unified model names and the way to access the models.

### Release on 02/08/2023 {#020823}

1. [Increased](concepts/limits.md) the total number of tokens in the prompt and response.
1. Added a new mode called Chat.
1. Added a method for counting the number of tokens in a request.
