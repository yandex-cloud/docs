---
title: Adding the No op step to a {{ sw-name }} workflow
description: Follow this guide to add the No op (no operations) step to a {{ sw-full-name }} workflow using the workflow step constructor.
---

# Adding the No op step

The No op control step does not involve any actions. You may need to use this step, e.g., to successfully complete a pipeline if the default condition is met in the [Switch](./switch.md) step or if you need a placeholder step when prototyping your workflow.

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. From the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_management-group-label }}** section on the left side of the screen, drag the ![no-op-icon](../../../../_assets/serverless-integrations/no-op-icon.svg) **No op** element to the appropriate workflow location in the constructor window.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. In the workflow schema window, click the added **No op** section to select it.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}

{% endlist %}

## See also {#see-also}

* [YaWL specification](../../../concepts/workflows/yawl/management/noop.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)