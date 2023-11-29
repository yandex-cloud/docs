# Upgrading to the paid version

You do not upgrade to the paid version automatically once the trial period ends. To upgrade to the paid version, on the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page in the management console, go to the billing account page and click **{{ ui-key.yacloud.billing.account.button_billing-payment-action }}**.

{% note info %}

You can upgrade to the paid version during the free trial or 30 days after it expires with no data loss.

{% endnote %}

## Using the remainder of the initial grant

{% include [billing-how-to-use-grant](../../../_includes/billing-how-to-use-grant.md) %}


The grant terms of use remain in effect when you upgrade:

{% list tabs group=accounts %}

 - Individual account {#individual}

   A remainder of [part](../../usage-grant.md) of the grant is only used to pay for the intended service or services.

 - Business account {#business}

   
   The grant terms of use depend on the payment method you select when creating your billing account:

   | Payment method | Using the grant |
   | ----- | ----- |
   | Bank transfer | The remainder of the grant can be used to pay for any {{ yandex-cloud }} services. |
   | Bank card | The remainder of [part](../../usage-grant.md) of the grant can only be used to pay for its intended service or services. |


{% endlist %}



## Paying for services

In {{ yandex-cloud }}, you pay for services based on the amount of resources consumed. For detailed guidelines on how to pay for resources after upgrading to the paid version, see the {{ billing-name }} [documentation](../../../billing/).


## Examples

{% list tabs group=examples %}

 - Example 1 {#example1}

   You are a resident of the Russian Federation and have registered a personal account.

   In 25 days, you spent ₽1,000 on {{ compute-full-name }} and ₽2,500 on other services. As you have fully spent one of the grant parts, the trial period terminates automatically and access to {{ yandex-cloud }} services is suspended unless you upgrade to the paid version.

   At the same time, you have 35 days until the grant expires (60 - 25).

   If you upgrade to the paid version within 30 days, you can use the remainder of the grant until it expires:
   - (3,000 - 2,500) = ₽500 for various services (other than {{ compute-name }}, {{ marketplace-full-name }} tools, and support services).

 - Example 2 {#example2}

   You are a resident of the Russian Federation and have registered a business account with the **{{ ui-key.yacloud.billing.account.overview.payment-type_label_card }}** payment method.

   In 20 days, you spent ₽500 on {{ compute-full-name }} and ₽3,000 on other services. As you have fully spent one of the grant parts, the trial period terminates automatically and access to {{ yandex-cloud }} services is suspended unless you upgrade to the paid version.

   If you upgrade to the paid version within 30 days, you can use the remainder of the grant until it expires:
   - (1,000 - 500) = ₽500 for {{ compute-name }} services, {{ marketplace-full-name }} tools, and support services.

 - Example 3 {#example3}

   You are a non-resident of the Russian Federation and have registered a business account with the **{{ ui-key.yacloud.billing.account.overview.payment-type_label_card }}** payment method.

   In 20 days, you spent $10 on {{ compute-full-name }} and $30 on other services.

   You upgraded to the paid version. The trial period terminates automatically.

   After upgrading to the paid version, you can continue to use the remainder of the grant until it expires:
   - (15 - 10) = $5 for {{ compute-name }} services, {{ marketplace-full-name }} tools, and support services.
   - (50 - 30) = $20 for various services (other than {{ compute-name }}, {{ marketplace-full-name }} tools, and support services).

 - Example 4 {#example4}

   You are a resident of the Russian Federation and have registered a business account with the **{{ ui-key.yacloud.billing.account.overview.payment-type_label_invoice }}** payment method.

   In 45 days, you spent ₽2,500 on various services.

   You upgraded to the paid version. The trial period terminates automatically.

   After upgrading to the paid version, you can continue to use the remainder of the grant until it expires:
   - (4,000 - 2,500) = ₽1,500 on various services.

{% endlist %}
