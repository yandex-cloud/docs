---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Enable usage notifications

To control expenses in {{ yandex-cloud }}, you can configure usage notifications with budgets. A budget is a way to control spending on resources used in {{yandex-cloud }}. In a budget, you set a monthly spending limit for certain resources and configure the utilization thresholds for which notifications are sent and to whom. You can set multiple thresholds and define different notification recipients for each. Reaching a pre-set threshold does not affect subsequent resource utilization.

Budgets keep a running utilization total for a month. A budget created in the middle of the month will still keep track of all the monthly costs for specified resources.

## Create a budget {#create-budget}

1. To create a budget, you need the `editor` role. The `viewer` role is enough to receive notifications. For more information on access control, see [{#T}](../../iam/concepts/access-control/roles.md).

1. In the [management console]({{ link-console-billing }}), click ![image](../../_assets/ugly-sandwich.svg) and go to **Billing**.

1. Select an account on the **List of accounts** page.

1. Go to the **Budgets** page and click **Create budget**.
    1. Enter a name and select a budget end date as well as the users to notify when each threshold is reached. The end date defines when the budget stops calculating usage and sending notifications.
    1. Define the budget scope. You can select individual clouds, folders, and services to include in a set budget. By default, data is collected from all the clouds, folders, and services that the selected billing account has access to.
    1. Set budget amount and type. A **Consumption cost** budget collects resource cost data without any discounts while a **Due and payable** budget applies discounts and active promo codes.
    1. Set at least one utilization threshold to trigger notifications. You can specify a threshold as a percentage or a cash value and select the users to receive notifications. A budget can have multiple thresholds.

   {% note info %}

   Users specified in the **General information** section will receive notifications when each specified threshold is exceeded. Users listed when setting a threshold will only receive a notification if the specific threshold is exceeded.

   If several thresholds are exceeded at the same time for a budget, users will only receive a single notification.

   {% endnote %}

1. After filling in all the fields, click **Create**. This will create a budget.

