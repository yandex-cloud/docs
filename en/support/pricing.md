---
editable: false
---

# Technical support pricing

{% if product == "cloud-il" %}

{{ yandex-cloud }} technical support is free of charge.

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

The cost depends on the selected service plan. For a table of all service plans and their features, see [{#T}](overview.md).

The basic service plan is provided to all {{ yandex-cloud }} users free of charge. For other service plans, the price is calculated based on resources consumed for the current reporting period (calendar month). To calculate the cost of using the service, use our [calculator](https://cloud.yandex.com/prices#calculator) or see the calculation methods in the sections below.


{% note info %}

All prices are shown {% if region == "ru" %}with{% endif %}{% if region == "kz" %}with{% endif %}{% if region == "int" %}without{% endif %} VAT. The cost of technical support is calculated after deducting the amount of previously issued grants from the cost of resources consumed.

{% endnote %}

## Basic {#base}

The basic service plan is provided to all {{ yandex-cloud }} users free of charge. It's suitable for personal and research projects.

## Standard {#standard}

Compared to the basic plan, the <q>Standard</q> plan lets you request general recommendations about the architecture of your solution from {{ yandex-cloud }} technical support. It's suitable for development and pilot projects.

### Service plan cost {#standard-price}

{% if region == "ru" %}

{% include [rub.md](../_pricing/support/rub-standard.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/support/kzt-standard.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/support/usd-standard.md) %}

{% endif %}

{% if region == "ru" %}

### Examples of cost calculation {#standard-examples}
You started paid consumption on March 1 and enabled support under the Standard plan. Every day a percentage of the fixed cost is debited from your account: `₽900 / 31 days = ₽29.03`.

* If, by the end of the reporting period, you spent ₽60,000 or less on {{ yandex-cloud }} resources, then no additional charges apply.

   Total cost of support for March: `₽29.03 × 31 days = ₽900`.

* If, by the end of the reporting period, you spent more than ₽60,000 on {{ yandex-cloud }} resources, then as soon as you exceed the ₽60,000 threshold, a percentage of both fixed and additional costs is debited from your account daily.

   For example, you spent ₽60,000 before March 21 and then, from March 22 to the end of the month, you spent ₽1000 every day.

   12% of the difference of ₽70000 and ₽60000: `(₽70000 − ₽60000) × 12% = ₽10000 × 0.12 = ₽1200`.

   Total cost of support for March: `21 days × ₽29.03 + 10 days × (₽29.03 + ₽1000 × 0.12) = ₽610 + ₽1490 = ₽2100`

{% endif %}

## Business {#business}

The <q>Business</q> plan is suitable for professional projects. Compared to the basic plan, it lets you:

* Request general recommendations about the architecture of your solution from {{ yandex-cloud }} technical support.
* Get advice and recommendations on configuring third-party software and fixing {{ yandex-cloud }} compatibility issues.
* Get recommendations for fixing problems with operating systems and their components.

### Service plan cost {#business-price}

{% if region == "ru" %}

{% include [rub.md](../_pricing/support/rub-business.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/support/kzt-business.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/support/usd-business.md) %}

{% endif %}

{% if region == "ru" %}

### Examples of cost calculation {#business-examples}
You started paid consumption on March 1 and enabled support under the Business plan. Every day a percentage of the fixed cost is debited from your account: `₽6000 / 31 days = ₽193.55`.

* If, by the end of the reporting period, you spent ₽60,000 or less on {{ yandex-cloud }} resources, then no additional charges apply.

   Total cost of support for March: `₽193.55 × 31 days = ₽6000`.

* If, by the end of the reporting period, you spent more than ₽60,000, but less than ₽200,000, on {{ yandex-cloud }} resources, then as soon as you exceed the ₽60,000 threshold, a percentage of both fixed and additional costs is debited from your account daily.

   For example, you spent ₽60000 before March 21 and then, from March 22 to the end of the month, you spent ₽1000 every day.

   7% of the difference of ₽70,000 and ₽60,000: `(₽70000 − ₽60000) × 7% = ₽10,000 × 0.07 = ₽700`.

   Total cost of support for March: `21 days × ₽193.55 + 10 days × (₽193.55 + ₽1000 × 0.07) = ₽4065 + ₽2635 = ₽6700`.

* If, by the end of the reporting period, you spent more than ₽200,000 on {{ yandex-cloud }} resources, then as soon as you exceed the ₽60,000 threshold, a percentage, fixed, and additional costs is debited from your account daily. Up to ₽200,000, a percentage of additional cost is 7% of the amount you spent per day, and after ₽200,000, it's 5%.

   For example, you spent ₽60,000 before March 21. Then, from March 22 to March 26, you spent ₽28,000 daily, and from March 27 to the end of the month, you spent ₽10,000 a day.

   7% of the difference of ₽200000 and ₽60000: `(₽200000 − ₽60000) × 7% = ₽140000 × 0.07 = ₽9800`.

   5% of the difference between the consumption amount and ₽200000: `(₽250000 − ₽200000) × 5% = ₽50000 × 0.05 = ₽2500`.

   Total cost of support for March: `(21 days × ₽193.55) + (5 days × (₽193.55 + (₽28000 × 0.07))) + (5 days × (₽193.55 + (₽10000 × 0.05))) = ₽4065 + ₽10768 + ₽3467 = ₽18300`.

{% endif %}

## Premium {#premium}

The <q>Premium</q> plan includes all the services offered under the other service plans and can be supplemented based on your requirements.

To get an estimate of the Premium service plan cost, please contact your {{ yandex-cloud }} manager or [support]({{link-console-support}}).

{% endif %}
