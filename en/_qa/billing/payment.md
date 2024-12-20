# Questions about payment

#### Where can I see the prices? {#pricing}

You can see {{ yandex-cloud }} prices on the [pricing policy](../../billing/pricing.md) pages of individual services.


To calculate the cost of your cloud resource configuration, use [our calculator]({{ link-cloud-calculator }}).

#### Who can pay for resources? {#how-to-buy}

You pay for resources by crediting money to your individual [personal account](../../billing/concepts/personal-account.md) as per the [agreement](../../billing/concepts/contract.md). Money can be credited to a personal account by individual entrepreneurs, businesses, and individuals.

For more information, see [How to pay for resources](../../billing/payment/index.md).

#### What payment methods can I use? {#payments}

{% include [payment-methods](../../billing/_includes/payment-methods.md) %}


{% include [change-payment-method](../../billing/_includes/change-payment-method.md) %}

#### What cards are accepted for payment? {#card-types}
{% include [payment-card-types](../../_includes/billing/payment-card-types-business.md) %}

#### Is there a minimum payment amount? {#minimum}
Depending on the currency, the minimum payment amount is:

* ₽10
* ₸60
* $1

#### How can I change my payment details? {#change-requisites}

{% include [change-address](../../billing/_includes/change-address.md) %}

#### In which currency can I pay for {{ yandex-cloud }}? {#currency}

{% list tabs group=residents %}

- Residents of Russia {#russia}

   You can only pay for {{ yandex-cloud }} resources in rubles (₽), regardless of your legal status ([billing account type](../../billing/concepts/billing-account.md#ba-types)).

   {% include [rb payment](../../_includes/billing/rb-payment.md) %}


- Residents of Kazakhstan {#kazakhstan}

   You can only pay for {{ yandex-cloud }} resources in tenge (₸), regardless of your legal status ([billing account type](../../billing/concepts/billing-account.md#ba-types)).


- Non-residents of Russia and Kazakhstan {#nonresidents}

   You can pay for {{ yandex-cloud }} resources only in US dollars ($), whatever your country of residence.

{% endlist %}



#### I linked a card to my business billing account. When will money be debited from it? {#unlink-card}

If this is your trial period, funds will not be debited from the bank card you linked.
Since you do not automatically upgrade to the paid version at the end of the trial period, funds are only debited after activating the paid version and using {{ yandex-cloud }} services.

If you upgraded to the paid version and used {{ yandex-cloud }} services, do the following to stop incurring charges:

1. Settle your arrears (if any).
1. Delete all billable service resources.
1. Contact [technical support]({{ link-console-support }}) to deactivate your account.

#### I linked a cloud to a new billing account. How do I pay for services now? {#unlink-cloud}

If the [cloud was previously linked](../../billing/operations/pin-cloud.md) to another billing account, check the service usage period. For services provided before the move, pay from the previous billing account. For services provided after, pay from the current billing account. The payment method must match the [billing account type](../../billing/concepts/billing-account.md#ba-types).

#### How is resource consumption charged? {#tariffs}

{{ yandex-cloud }} resources are consumed on an as-needed basis. The amount for resources consumed is calculated individually for each service.

For more information, see [Pricing](../../billing/pricing.md).

#### If I pay an invoice by bank transfer after the end of the reporting period, will my resources be blocked? {#payment-delay}


You can pay within 14 calendar days (not counting public holidays) after the reporting period ends. Depending on which company you contracted with, you can find detailed information in the _Legal Documents_ section for [Iron Hive doo Beograd (Serbia)](https://yandex.com/legal/cloud_customer_agreement/) or [Direct Cursus Technology L.L.C. (Dubai)](https://yandex.com/legal/cloud_customer_agreement_uae/).
 If you pay within this time period, your resources will not be blocked. Remember that it takes up to three business days for your payment to get through, so do not postpone it.

#### What goes into the cost of using {{ marketplace-full-name }}? {#marketplace}

The cost of using {{ marketplace-full-name }} is the total cost of using {{ marketplace-full-name }} products. For in-depth review of the items adding up the usage cost, see the [details](../../billing/operations/check-charges.md) in {{ billing-name }} with grouping by product selected.


#### Can I withdraw money from my account? {#refund}

{% include [payment-refund](../../_includes/billing/payment-refund.md) %}