# Upgrading to the paid version

You don't upgrade to the paid version automatically once the trial period ends. To upgrade to the paid version, on the [Billing]({{ link-console-billing }}) page in the management console, go to the billing account page and click **Upgrade to paid version**.

{% note info %}

You can upgrade to the paid version during the free trial or 30 days after it expires with no data loss.

{% endnote %}

## Using the remainder of the initial grant

{% include [billing-how-to-use-grant](../../../_includes/billing-how-to-use-grant.md) %}

The grant terms of use remain in effect when you upgrade:

{% list tabs %}

- Individual account

   A remainder of [part](../../usage-grant.md) of the grant is only used to pay for the intended service or services.

- Business account

   {% if region != "kz" %}

   The grant terms of use depend on the payment method you select when creating your billing account:

   | Payment method | Using the grant |
   ----- | ----- 
   | Bank transfer | The remainder of the grant can be used to pay for any {{ yandex-cloud }} services. |
   | Bank card | The remainder of [part](../../usage-grant.md) of the grant can only be used to pay for its intended service or services. |

   {% else %}

   The remainder of the grant can be used to pay for any {{ yandex-cloud }} services.

   {% endif %}



{% endlist %}


## Paying for services

In {{ yandex-cloud }}, you pay for services based on the amount of resources consumed. For detailed instructions on how to pay for resources after upgrading to the paid version, see the Billing [documentation](../../../billing/).

## Examples

{% list tabs %}

- Example 1

   You are a resident of the Russian Federation and registered a personal account.

   In 25 days, you spent ₽1000 on Yandex Compute Cloud and ₽2500 on other services. Since you fully spent a part of the grant, the trial period terminates automatically and access to {{ yandex-cloud }} services is suspended unless you upgrade to the paid version.

   At the same time, you have 35 days until the grant expires (60 - 25).

   If you upgrade to the paid version within 30 days, you can use the remainder of the grant until it expires:
   - (3000-2500) = ₽500 for services other than Compute Cloud.

- Example 2

   You are a resident of the Russian Federation and registered a business account with the **Bank card** payment method.

   In 20 days, you spent ₽500 on Yandex Compute Cloud and ₽3000 on other services. Since you fully spent a part of the grant, the trial period terminates automatically and access to {{ yandex-cloud }} services is suspended unless you upgrade to the paid version.

   If you upgrade to the paid version within 30 days, you can use the remainder of the grant until it expires:
   - (1000- 500) = ₽500 for Compute Cloud.

- Example 3

   You are a non-resident of the Russian Federation and registered a business account with the **Bank card** payment method.

   In 20 days, you spent $10 on Yandex Compute Cloud services and $30 on other services.

   You upgraded to the paid version. The trial period terminates automatically.

   After upgrading to the paid version, you can continue to use the remainder of the grant until it expires:
   - (15 - 10) = $5 for Compute Cloud.
   - (50 - 30) = $20 for services other than Compute Cloud.

- Example 4

   You are a resident of the Russian Federation and registered a business account with the **Bank transfer** payment method.

   In 45 days, you spent ₽2500 on various services.

   You upgraded to the paid version. The trial period terminates automatically.

   After upgrading to the paid version, you can continue to use the remainder of the grant until it expires:
   - (4000-2500) = ₽1500 for services other than Compute Cloud.


{% endlist %}