Optionally, to set a custom retry policy for a step, expand the **{{ ui-key.yc-serverless-workflows.dynamic-forms.common_retry_policy_view_spec_layout_title }}** section and click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-serverless-workflows.dynamic-forms.common_retry_policy_view_spec_layout_title }}**. In the form that appears:

1. Optionally, in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_initial-delay-field }}** field, set the initial value for a delay between step retries.
1. Optionally, in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_backoff-rate-field }}** field, set the multiplication factor for delay before each step retry.
1. Optionally, in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_max-delay-field }}** field, set the value for a maximum delay between step retries.
1. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}** field, select the errors for which the step will or will not be retried.

    {% include [error-details](./error-details.md) %}
1. Optionally, in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_retry-count-field }}** field, set the maximum number of step retry attempts.
1. In the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-mode-field }}** field, select:

    * `INCLUDE`: Retry executing a step when errors specified in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}** field occur.
    * `EXCLUDE`: To retry executing the step on any errors other than those specified in the **{{ ui-key.yacloud.serverless-workflows.workflow-editor_error-list-field }}** field.

If you want to delete a retry policy you created for the step earlier, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}** in the **{{ ui-key.yc-serverless-workflows.dynamic-forms.common_retry_policy_view_spec_layout_title }}** row.

If no custom retry policy is configured for a step, the retry policy [set for the whole workflow](../../../serverless-integrations/operations/workflows/constructor/setup-restart-policy.md) will apply.