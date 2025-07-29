---
title: Adding the step of accessing the Telegram Bot API to a {{ sw-name }} workflow
description: Follow this guide to add the step of accessing the Telegram Bot API to a {{ sw-full-name }} workflow using the workflow step constructor.
---

# Accessing the Telegram Bot API

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![foundation-models-icon](../../../../_assets/console-icons/logo-telegram.svg) **Telegram bot** element to relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **Telegram bot** block to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. Under **Token**, specify the [bot token](https://core.telegram.org/bots/features#creating-a-new-bot) or {{ lockbox-name }} [secret](../../../../lockbox/concepts/secret.md) that token is stored in. Select:

          * `Lockbox` to store the bot token in a secret; in the **Secret** section, select the secret, its [version](../../../../lockbox/concepts/secret.md#version), and the key used to store the bot token.

              If you do not have a {{ lockbox-name }} secret, click **Create** to create one.

          * `Text` to store the bot token in the specification as text; enter the bot token in the **Value** field.

              {% note warning %}

              It is not safe to store the bot token in the specification in plain text.

              {% endnote %}

      1. Under **Action**:

          1. In the **Chat ID** field, provide chat ID or channel name in `@channelusername` format.
          1. In the **Text** field, enter the text of the message.
          1. Optionally, in the **Reply to** field, provide the ID of the message to reply to.
          1. Optionally, in the **Formatting mode** field, select message formatting mode. For more information, see the [Telegram Bot API](https://core.telegram.org/bots/api#formatting-options) documentation.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/telegrambot.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
