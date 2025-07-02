---
title: Adding sending messages to a {{ yds-name }} topic into a {{ sw-name }} workflow
description: Follow this guide to add sending messages to a {{ yds-full-name }} topic into a {{ sw-full-name }} workflow using the workflow step constructor.
---

# Sending messages to a {{ yds-full-name }} topic

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** section on the left side of the screen, drag the ![yds-icon](../../../../_assets/yds-icon.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.yds_integration_title }}** element to the relevant workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the new **{{ ui-key.yc-serverless-workflows.dynamic-forms.yds_integration_title }}** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.yds_properties_database_view_spec_layout_title }}** field, select a serverless [{{ ydb-short-name }} database](../../../../ydb/concepts/resources.md#serverless).
      1. In the **{{ ui-key.yc-serverless-workflows.dynamic-forms.yds_properties_topic_view_spec_layout_title }}** field, specify the topic ID.
      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/integration/yds.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
