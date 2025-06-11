---
title: Adding sending emails with {{ postbox-short-name }} to a {{ sw-name }} workflow
description: Follow this guide to add sending emails with {{ postbox-full-name }} to a {{ sw-full-name }} workflow using the workflow step constructor.
---

# Sending emails with {{ postbox-full-name }}

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![postbox-icon](../../../../_assets/postbox-icon.svg) **{{ postbox-short-name }}** element to desired workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the added **{{ postbox-short-name }}** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **Sender address** field, enter the {{ postbox-full-name }} address that will send the emails.

          {% note info %}

          Make sure the [service account](../../../../iam/concepts/users/service-accounts.md) specified in the workflow settings and the address specified in this field reside in the same [folder](../../../../resource-manager/concepts/resources-hierarchy.md#folder).
 
          {% endnote %}

      1. Under **To addresses**, select:

          * `Address array` to specify recipient addresses one by one using ![plus](../../../../_assets/console-icons/plus.svg) **Add recipient**.
          * `Raw string` to specify recipient addresses as a comma-separated list.

      1. Optionally, under **BCC addresses**, select:

          * `Address array` to specify BCC recipient addresses one by one using ![plus](../../../../_assets/console-icons/plus.svg) **Add BCC**.
          * `Raw string` to specify BCC recipient addresses as a comma-separated list.

      1. Under **Message**, add the content of the message to send. Select:

          * `Text` to set the email content using the form:

              1. In the **Subject** field, specify the email header.
              1. In the **HTML content** field, specify the message text to display in email clients with HTML support.
              1. In the **Text** field, specify the message text to display in email clients without HTML support.
              1. In the **Encoding** field, select the message encoding.

          * `Template` to set the email content as a template. For more information, see the [{{ postbox-name }} documentation](../../../../postbox/aws-compatible-api/api-ref/send-email.md).

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/postbox.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
