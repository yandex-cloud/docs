Optionally, to set a custom retry policy for a step, expand the **Retry policy** section and click ![plus](../../../_assets/console-icons/plus.svg) **Retry policy**. In the form that appears:

1. Optionally, in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_initial-delay-field }}** field, set the initial value for delay between retries.
1. Optionally, in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_backoff-rate-field }}** field, set the multiplication factor for delay before each retry.
1. Optionally, in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_max-delay-field }}** field, set maximum delay between retries.
1. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}** field, select the errors for which the step will (will not) be retried.

    {% include [error-details](./error-details.md) %}
1. Optionally, in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_retry-count-field }}** field, set the maximum number of step retry attempts.
1. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-mode-field }}** field, select:

    * `INCLUDE`: To retry executing the step on errors specified in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}** field.
    * `EXCLUDE`: To retry executing the step on any errors other than those specified in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}** field.

If you want to delete a retry policy created for the step earlier, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}** in the **Retry policy** row.

If no custom retry policy is configured for a step, the retry policy [set for the whole workflow](../../../serverless-integrations/operations/workflows/constructor/setup-restart-policy.md) will apply.