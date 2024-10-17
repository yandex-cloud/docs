The user needs the `editor` [role](../../iam/concepts/access-control/roles.md) to create a budget. To get notifications, the `viewer` role is sufficient.

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

   1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
   1. Select a [billing account](../../billing/concepts/billing-account.md).
   1. In the **{{ ui-key.yacloud_billing.billing.account.overview.section_account-data }}** section, in the **{{ ui-key.yacloud.common.id }}** field, copy the billing account ID. You will need it when creating a [trigger](../../functions/concepts/trigger/index.md) for budgets.
   1. Go to the **{{ ui-key.yacloud_billing.billing.account.switch_budgets }}** tab and click **{{ ui-key.yacloud_billing.billing.account.budgets.button_create }}**.
   1. Under **{{ ui-key.yacloud.common.section-base }}**, specify:
      * **{{ ui-key.yacloud.common.name }}**: `vm-budget`.
      * **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud_billing.billing.account.budgets.label_type-expense }}`.
      * **{{ ui-key.yacloud_billing.billing.account.budgets.label_amount }}**: Amount of consumption expenses, e.g. `₽10`.
      * **{{ ui-key.yacloud_billing.billing.account.budgets.label_reset-period }}**: `{{ ui-key.yacloud_billing.billing.account.budgets.reset-period_value_monthly }}`.
      * **{{ ui-key.yacloud_billing.billing.account.budgets.label_expire }}**: Budget expiration date.

         The end date is when the budget stops calculating usage and sending notifications. The end date is the last day of the month. It must be within five years of the current date.
      * **{{ ui-key.yacloud_billing.billing.account.budgets.label_notify }}**: Select yourself.
   1. Under **{{ ui-key.yacloud_billing.billing.account.budgets.section_scope }}**, select your current [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) and the **{{ compute-name }}** service.
   1. Under **{{ ui-key.yacloud_billing.billing.account.budgets.label_limits }}**, set the threshold values as a percentage upon reaching which:
      * Specified users will get notifications.
      * Trigger for budgets will fire.

      For example, you can set two thresholds: `50%` and `100%`.
   1. Click **{{ ui-key.yacloud.common.create }}**.
   1. A window will open with the new `vm-budget`. In the **{{ ui-key.yacloud.common.id }}** field, copy the ID of the new budget. You will need it later when creating a trigger.

- API {#api}

   To create a budget, use the [create](../../billing/api-ref/Budget/create.md) method for the [Budget](../../billing/api-ref/Budget/index.md) resource or the [BudgetService/Create](../../billing/api-ref/grpc/Budget/create.md) gRPC API call.

{% endlist %}