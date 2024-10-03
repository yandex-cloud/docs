# Trigger for budgets that invokes a {{ sf-name }} function

[Trigger](../trigger/) for [budgets](../../../billing/concepts/budget.md) calls a {{ sf-name }} [function](../function.md) when threshold values are exceeded.

A trigger for budgets needs a [service account](../../../iam/concepts/users/service-accounts.md) to call the function.

For more information about creating a trigger for budgets, see [{#T}](../../operations/trigger/budget-trigger-create.md).

## Roles required for the proper operation of a trigger for budgets {#roles}

* To create a trigger, you need a permission for the service account under which the trigger executes the operation. This permission comes with the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles.md#sa-user) and [{{ roles-editor }}](../../../iam/concepts/access-control/roles.md#editor) roles or higher.
* For the trigger to fire, the service account requires the `{{ roles-functions-invoker }}` role for the function invoked by the trigger.

## Format of the message from the trigger for budgets {#format}

After the trigger is activated, it sends the following message to the function:

{% include [budget-format](../../../_includes/functions/budget-format.md) %}

## See also {#see-also}

* [{#T}](../../../serverless-containers/concepts/trigger/budget-trigger.md)
* [{#T}](../../../api-gateway/concepts/trigger/budget-trigger.md)
* [{#T}](../../tutorials/serverless-trigger-budget-vm.md)
