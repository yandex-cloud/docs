# Activating the paid version

Legal entities can activate the paid version within sixty days after the trial period expires. Otherwise, all of their resources are deleted automatically.
If you have not spent the full amount of the [initial grant](../concepts/bonus-account.md) during the trial period, you can use its balance to pay for the resources you will consume in the future.

{% note info %}

The paid version can be activated by a user who has been assigned the [role](../security/index.md#billing-accounts-owner) `billing.accounts.owner`.

{% endnote %}

To upgrade to the paid version:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}
  
  1. {% include [move-to-billing-step](../_includes/move-to-billing-step.md) %}
  1. Select a billing account.
  1. On the ![image](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud_billing.billing.account.switch_overview }}** page, click **{{ ui-key.yacloud_billing.billing.account.button_billing-payment-action }}**.
  1. Confirm the action by clicking **{{ ui-key.yacloud_billing.billing.account.button_billing-payment-action }}** again.

{% endlist %}

Upon activation of the paid version, your [personal account balance](../concepts/personal-account.md#balance) will be zero by default. We recommend that you keep track and [maintain a positive balance](../operations/pay-the-bill.md) at all times.
<br/>If you fail to top up your account on time and run into arrears, your use of {{ yandex-cloud }} services may be suspended. For more information, see [Billing cycle for organizations and individual entrepreneurs](../payment/billing-cycle-business.md).