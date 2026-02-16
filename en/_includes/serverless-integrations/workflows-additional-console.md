Expand **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}**:

1. Enter a name and description for the workflow. The naming requirements are as follows:

    {% include [name-format-2](../name-format.md) %}

1. Optionally, [add](../../serverless-integrations/operations/workflows/workflow/label-add.md) labels.
1. Optionally, [specify](../../serverless-integrations/operations/workflows/workflow/network-add.md) a cloud network.
1. Select a [service account](../../iam/concepts/users/service-accounts.md) or [create](../../iam/operations/sa/create.md) a new one.

    Make sure to assign the service account roles to access private resources used in the workflow steps.

1. Optionally, [set up](../../serverless-integrations/operations/workflows/workflow/logs-write.md) logging.