# Questions about payment

#### Who can pay for resources? {#how-to-buy}

Resources are paid for by crediting funds to an individual [personal account](../concepts/personal-account.md) as per the [agreement](../concepts/contract.md). Funds can be credited to a personal account by individual entrepreneurs, businesses, and individuals.

For more information, see [How to pay for resources](../payment/index.md).

#### What payment methods can I use? {#payments}

{% include [payment-methods](../_includes/payment-methods.md) %}

{% include [change-payment-method](../_includes/change-payment-method.md) %}

#### What cards are accepted for payment? {#card-types}

{% include [payment-card-types](../_includes/payment-card-types.md) %}

#### Is there a minimum payment amount? {#minimum}

The minimum payment amount is {% if region == "ru" %}₽10{% endif %}{% if region == "kz" %}₸60{% endif %}{% if region == "int" %}$1{% endif %}.

#### How can I change my payment details? {#change-requisites}

{% include [change-address](../_includes/change-address.md) %}

#### In which currency can I pay for {{ yandex-cloud }}? {#currency}

{% list tabs %}

- For residents of Russia

  You must pay for {{ yandex-cloud }} resources in rubles (₽), regardless of your legal status ([billing account type](../concepts/billing-account.md#ba-types)).

- For residents of Kazakhstan

  You must pay for {{ yandex-cloud }} resources in tenge (₸), regardless of your legal status ([billing account type](../concepts/billing-account.md#ba-types)).

- For non-residents of Russia and Kazakhstan

  You must pay for {{ yandex-cloud }} resources in US dollars ($), regardless of the country you live in.

{% endlist %}

#### Can I pay for resources with a bank card in a different currency? {#currency-2}

{% if region == "ru" %}

Yes.

If you pay for resources with a bank card in a foreign currency, the equivalent amount in rubles, including VAT, is debited from the bank card. Additional bank fees for the currency conversion might be debited or credited a day or two later.

{% endif %}

{% if region == "kz" %}

Yes.

If you pay for resources with a bank card in a foreign currency, the equivalent amount in tenge, including VAT, is debited from the bank card. Additional bank fees for the currency conversion might be debited or credited a day or two later.

{% endif %}

#### I linked a bank card to my billing account. When will money be debited from it? {#unlink-card}

If this is your trial period, funds will not be debited from the bank card you linked.
Since you do not automatically upgrade to the paid version at the end of the trial period, funds are only debited after activating the paid version and using {{ yandex-cloud }} services.

If you upgraded to the paid version and used {{ yandex-cloud }} services, do the following to stop incurring charges:

1. Settle your arrears (if any).
1. Delete all billable service resources.
1. Contact [technical support]({{ link-console-support }}) to deactivate your account.

#### I linked a cloud to a new billing account. How do I pay for services now? {#unlink-cloud}

If the [cloud was previously linked](../operations/pin-cloud.md) to another billing account, check the period of the services: for services provided before the move, pay from the previous billing account. For services provided after, pay from the current billing account. The payment method must match [the billing account type](../concepts/billing-account.md#ba-types).

#### Will you provide an agreement for the provision and payment of services? {#oferta}

{% include [contract-qa](../_includes/contract-qa.md) %}

#### Where can I read the terms of the agreement? {#oferta-terms}

{% list tabs %}

- For residents of Russia

  You can learn more about the terms of the agreement in the section [Yandex Legal documents]{% if lang == "ru" %}(https://yandex.ru/legal/cloud_oferta/?lang=ru){% endif %}{% if lang == "en" %}(https://yandex.ru/legal/cloud_oferta/?lang=en){% endif %}.

- For residents of Kazakhstan

  You can learn more about the terms of the agreement in the section [Yandex Legal documents]{% if lang == "ru" %}(https://yandex.com/legal/cloud_oferta_kz/?lang=ru){% endif %}{% if lang =="en" %}(https://yandex.com/legal/cloud_oferta_kz/?lang=en){% endif %}.

- For non-residents of Russia and Kazakhstan

  You can learn more about the terms of the agreement in the section [Yandex Legal documents]{% if lang == "ru" %}(https://yandex.com/legal/cloud_customer_agreement/?lang=ru){% endif %}{% if lang == "en" %}(https://yandex.com/legal/cloud_customer_agreement/?lang=en){% endif %}.

{% endlist %}

#### Can a signed agreement be finalized? {#contract}

Businesses may conclude an agreement that is signed by both parties. To do this, you must submit a request using the **Ask a question** form on the [Contact us]({{ link-console-support }}) page. A {{ yandex-cloud }} manager will contact you to discuss the terms and conditions of signing the agreement.

#### How is resource consumption charged? {#tariffs}

{{ yandex-cloud }} resources are consumed on an as-needed basis. The amount for resources consumed is calculated individually for each service.

For more information, see [Pricing](../pricing.md).

#### Can I enable  an alert to be notified when my account balance is approaching zero? {#notification}

Since {{ yandex-cloud }} uses a postpaid billing system, we don't plan to introduce a service for notifying users about their account balance  approach to zero. We recommend that you track your spending and account balance on your own.
