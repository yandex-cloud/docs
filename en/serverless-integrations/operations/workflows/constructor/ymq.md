---
title: Adding sending messages to a {{ message-queue-name }} queue to a {{ sw-name }} workflow
description: Follow this guide to add sending messages to a {{ message-queue-full-name }} queue to your {{ sw-full-name }} workflow using the workflow step constructor.
---

# Sending messages to a {{ message-queue-full-name }} queue

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![ymq-icon](../../../../_assets/ymq-icon.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.ymq_integration_title }}** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **{{ ui-key.yc-serverless-workflows.dynamic-forms.ymq_integration_title }}** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.ymq_properties_queue_arn_view_spec_layout_title }}** field, enter the {{ message-queue-name }} ARN.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/ymq.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
