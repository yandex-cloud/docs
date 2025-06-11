---
title: Configuring a retry policy in a {{ sw-name }} workflow
description: Follow this guide to configure a retry policy for an entire {{ sw-full-name }} workflow using the workflow step constructor.
---

# Configuring a retry policy for a workflow

{% list tabs %}

- Management console {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %}
  1. In the workflow schema window, click any point free of schema elements to deselect all elements. Make sure you can see the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_main-settings-label }}** section on the right side of the screen.
  1. Under **{{ ui-key.yacloud.serverless-workflows.workflow-editor_main-settings-label }}**:

      1. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}** field, select the errors for which the workflow steps will (will not) be retried.

          {% include [error-details](../../../../_includes/serverless-integrations/workflows-constructor/error-details.md) %}
      1. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-mode-field }}** field, select:

          * `INCLUDE`: To retry executing workflow steps on errors specified in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}** field.
          * `EXCLUDE`: To retry executing workflow steps on errors other than those specified in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}** field.
      1. Optionally, in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_retry-count-field }}** field, set the maximum number of step retry attempts.
      1. Optionally, in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_initial-delay-field }}** field, set the initial value for delay between retries.
      1. Optionally, in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_backoff-rate-field }}** field, set the multiplication factor for delay before each retry.
      1. Optionally, in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_max-delay-field }}** field, set maximum delay between retries.

      The general retry policy settings apply to all workflow steps that do not have their own retry policy settings.

{% endlist %}

## See also {#see-also}

* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)