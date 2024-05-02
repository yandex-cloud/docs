# Upgrading to the paid version


You do not upgrade to the paid version automatically after the trial period ends. To upgrade to the paid version, go to [{{ billing-name }}]({{ link-console-billing }}), open the billing account page and click **{{ ui-key.yacloud_billing.billing.account.dashboard.button_go-pay}}**. You can upgrade to the paid version during the trial period or 60 days after it expires with no data loss.

{% note info %}

Upgrading to the paid version with the **{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_card }}** payment method involves the risk of your billing account balance becoming negative.

We recommend you to keep track of the money you spend from your personal account and top up your balance so it is always positive. If your personal account balance exceeds the [billing threshold](../../../billing/concepts/billing-threshold.md) and you fail to pay the resulting arrears before the deadline set out in the agreement, {{ yandex-cloud }} reserves the right to change the status of your billing account to `SUSPENDED`.

To control spending on {{ yandex-cloud }} resources more effectively, we recommend using a [budget](../../../billing/concepts/budget.md).

{% endnote %}

## Using the remainder of the initial grant

{% include [billing-how-to-use-grant](../../../_includes/billing-how-to-use-grant.md) %}


The grant terms of use remain in effect after the upgrade.


The grant terms of use depend on the payment method you select when creating your billing account:

| Payment method | Using the grant |
----- | -----
| Bank transfer | The remainder of the grant can be used to pay for any {{ yandex-cloud }} services. |
| Bank card | The remainder of one of the grant [parts](../../usage-grant.md) can only be used to pay for the services that part was originally intended for. |




## Paying for services

In {{ yandex-cloud }}, you pay for services based on the amount of resources consumed. For detailed guidelines on how to pay for resources after upgrading to the paid version, see the {{ billing-name }} [documentation](../../../billing/).


## Examples

{% list tabs group=examples %}

- Example 1 {#example1}

   You are a resident of the Russian Federation and have registered a business account with the **{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_card }}** payment method.

   In 20 days, you spent ₽500 on {{ compute-full-name }} and ₽3,000 on other services. As you have fully spent one of the grant parts, the trial period terminates automatically and access to {{ yandex-cloud }} services is suspended unless you upgrade to the paid version.

   If you upgrade to the paid version within 60 days, you can use the remainder of the grant until it expires:
   - (1,000 - 500) = ₽500 for {{ compute-name }} services, {{ marketplace-full-name }} tools, and support services.

- Example 2 {#example2}

   You are a non-resident of the Russian Federation and have registered a business account with the **{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_card }}** payment method.

   In 20 days, you spent $10 on {{ compute-full-name }} and $30 on other services.

   You upgraded to the paid version. The trial period terminates automatically.

   After upgrading to the paid version, you can continue to use the remainder of the grant until it expires:
   - (15 - 10) = $5 for {{ compute-name }} services, {{ marketplace-full-name }} tools, and support services.
   - (50 - 30) = $20 for various services (other than {{ compute-name }}, {{ marketplace-full-name }} tools, and support services).

- Example 3 {#example3}

   You are a resident of the Russian Federation and have registered a business account with the **{{ ui-key.yacloud_billing.billing.account.overview.payment-type_label_invoice }}** payment method.

   In 45 days, you spent ₽2,500 on various services.

   You upgraded to the paid version. The trial period terminates automatically.

   After upgrading to the paid version, you can continue to use the remainder of the grant until it expires:
   - (4,000 - 2,500) = ₽1,500 on various services.

{% endlist %}
