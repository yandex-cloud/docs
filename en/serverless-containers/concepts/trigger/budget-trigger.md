# Trigger for budgets

A trigger for [budgets](../../../billing/concepts/budget.md) calls a {{ serverless-containers-name }} [container](../container.md) when threshold values are exceeded.

## Roles required for the proper operation of a trigger for budgets {#roles}

* To create a trigger, you need a permission for a service account that runs the trigger executing the operation. This permission is included in the [iam.serviceAccounts.user](../../../iam/concepts/access-control/roles#sa-user) and [editor](../../../iam/concepts/access-control/roles#editor) roles and higher.
* For a trigger to work, the service account needs:
   * `serverless.containers.invoker` for the container that the trigger invokes.
   * `viewer` for the cloud that the billing account is linked to.

## Format of the message from the trigger for budgets {#format}

After the trigger is activated, it sends the following message to the container:

```
{
   "messages":[
      {
         "billing_account_id":"a6q6***",
         "budget_id":"a626***",
         "budget_display_name":"name",
         "amount":90012.00,
         "currency":"RUB",
         "period":"2021",
         "budgeted_amount":100000.00,
         "threshold_amount":90000.00,
         "threshold_type":"amount"
      }
   ]
}
```

Where:

* `billing_account_id`: Billing account ID.
* `budget_id`: Budget ID.
* `budget_display_name`: Budget name.
* `amount`: The cost of resources or account balance when notifications were triggered.
* `currency`: Payment currency.
* `period`: Budget tracking period.
* `budgeted_amount`: Budget amount.
* `threshold_amount`: Consumption threshold that triggered notifications.
* `threshold_type`: Threshold type:
   * `amount`: Currency.
   * `percent`: Percentage.

## See also {#see-also_}

* [Trigger for budgets that calls a {{ sf-name }} function](../../../functions/concepts/trigger/budget-trigger.md).