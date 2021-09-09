# Enable usage notifications

To control expenses in {{ yandex-cloud }}, you can configure usage notifications with budgets. A budget is a way to control spending on {{ yandex-cloud }} resources over a specified period of time.

In a budget, you set a spending limit for certain resources covering a tracking period and configure the utilization thresholds that trigger notifications as well as the persons to notify. You can set multiple thresholds and define different notification recipients for each one. Reaching a pre-set threshold does not affect subsequent resource utilization.

You can set the tracking period to be a month, a quarter, or a year. As each subsequent tracking period begins, the budget will reset automatically. You can also set a custom tracking period by specifying the start and the end dates. This type of budget will not reset after it ends.

Budgets keep usage totals over the entire tracking period. A budget created in the middle of a month, for instance, will still keep track of all the monthly costs for the specified resources.

## Creating a budget {#create-budget}

To create a budget, you need the `editor` role. The `viewer` role is enough to receive notifications. For more information on access control, see [{#T}](../../iam/concepts/access-control/roles.md).

To create a budget:

1. In the [management console]({{ link-console-billing }}), click ![image](../../_assets/ugly-sandwich.svg) and go to **Billing**.

1. Select an account on the **List of accounts** page.

1. Go to the **Budgets** page and click **Create budget**.

    1. Enter the budget name.

    1. Set the budget tracking period. Indicate the following:

        * The budget start date, if you selected **Customizable** as the tracking period type. The start date is the first day of a month.
        * The budget end date. The end date defines when the budget stops calculating usage and sending notifications. The end date is the last day of a month. It must be no more than five years from the current date.

    1. Select the users to notify when the budget is exceeded.

    1. Define the budget scope. You can select individual clouds, folders, and services to include in a set budget. By default, data is collected from all the clouds, folders, and services that the selected billing account has access to.

    1. Set budget amount and type. A **Consumption cost** budget collects resource cost data without any discounts while a **Due and payable** budget applies discounts and active promo codes.

    1. Set at least one utilization threshold to trigger notifications. You can specify a threshold as a percentage or a cash value and select the users to receive notifications. A budget can have multiple thresholds.

   {% note info %}

   Users specified in the **General information** section will receive notifications when each specified threshold is exceeded. Users listed when setting a threshold will only receive a notification if the specific threshold is exceeded.

   If several thresholds are exceeded at the same time for a budget, users will only receive a single notification.

   {% endnote %}

1. After filling in all the fields, click **Create**. This will create a budget.

