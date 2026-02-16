---
title: '{{ yagpt-name }} training for projects in {{ speechsense-full-name }}'
description: Follow this guide to enable or disable {{ yagpt-name }} training for one or multiple projects in {{ speechsense-name }}.
---

# {{ yagpt-name }} training

[{{ yagpt-name }}](../../../ai-studio/concepts/generation/models.md) is used in {{ speechsense-name }} [dialogs](../../concepts/dialogs.md) for data analysis. To increase the analysis quality, e.g., assign semantics tags or perform audio recognition, {{ yagpt-name }} models can be trained on your project data.

Starting September 1, 2025, {{ yagpt-name }} training is enabled by default in new projects. You can [disable](#disable-yandexgpt-training) it if you prefer to opt out. For projects created before September 1, 2025, you need to [enable](#enable-yandexgpt-training) {{ yagpt-name }} training manually.

Data collection starts once you enable training, and the {{ yagpt-name }} model gets updated every three months based on the collected data. The result of model training will only be integrated into your project.

To enable or disable {{ yagpt-name }} training, you need the `{{ roles-speechsense-admin }}` role in the space.

## Enabling {{ yagpt-name }} training {#enable-yandexgpt-training}

{% note warning %}

By enabling [{{ yagpt-name }}](../../../ai-studio/concepts/generation/models.md) training for a project, you allow using your project’s data for model training. [Learn more about how we process data](https://yandex.com/legal/cloud_terms_speechsense/).

{% endnote %}

To enable {{ yagpt-name }} training for one or multiple projects:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space of your choice.
1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.common.settings }}** tab.
1. Under **{{ ui-key.yc-ui-talkanalytics.spaces.gpt-learning.title }}**, click ![image](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-talkanalytics.common.customize }}**.
1. Select one or more projects you want to enable {{ yagpt-name }} training for, then click **Save**.

From now on, all new data you add to the project will be collected for {{ yagpt-name }} training. Older data is not used for training.

## Disabling {{ yagpt-name }} training {#disable-yandexgpt-training}

To disable {{ yagpt-name }} training for one or multiple projects:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space of your choice.
1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.common.settings }}** tab.
1. Under **{{ ui-key.yc-ui-talkanalytics.spaces.gpt-learning.title }}**, click ![image](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-talkanalytics.common.customize }}**.
1. Deselect those projects you want to disable {{ yagpt-name }} training for, then click **Save**.
