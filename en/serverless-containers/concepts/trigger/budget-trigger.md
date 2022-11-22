# Trigger for budgets

A trigger for [budgets](../../../billing/concepts/budget.md) calls a {{ serverless-containers-name }} [container](../container.md) when threshold values are exceeded.

A trigger for budgets needs a [service account](../../../iam/concepts/users/service-accounts.md) to invoke a container.

## Roles required for the proper operation of a trigger for budgets {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user) and [editor](../../../iam/concepts/access-control/roles#editor) roles and higher.
* For a trigger to work, the service account needs the `serverless.containers.invoker` role for the container to be invoked by the trigger.

## Format of the message from the trigger for budgets {#format}

After the trigger is activated, it sends the following message to the container:

{% include [budget-format](../../../_includes/functions/budget-format.md) %}

## See also {#see-also_}

* [Trigger for budgets that calls a {{ sf-name }} function](../../../functions/concepts/trigger/budget-trigger.md).