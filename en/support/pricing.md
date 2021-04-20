---
editable: false
---
# Technical support pricing

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

The cost depends on the selected service plan. For a table of all service plans and their features, see [{#T}](overview.md).

The basic service plan is provided to all {{ yandex-cloud }} users free of charge. For other service plans, the price is calculated based on resources consumed for the current reporting period (calendar month). Calculation methods are given below.

{% note info %}

All prices are shown with VAT. The cost of technical support is calculated after deducting the amount of previously issued grants from the cost of resources consumed.

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

### Examples of cost calculation {#standard-examples}

{% list tabs %}

- USD, without VAT

    You started paid consumption on March 1 and enabled support under the Standard plan. Every day a percentage of the fixed cost is debited from your account: `$11.54 / 31 days = $0.37`.

    * If, by the end of the reporting period, you spent $769.23 or less on {{ yandex-cloud }} resources, then no additional charges apply.

	    Total cost of support for March: `$0.37 × 31 days = $11.54`.

    * If, by the end of the reporting period, you spent more than $769.23 on {{ yandex-cloud }} resources, then as soon as you exceed the $769.23 threshold, a percentage of both fixed and additional costs is debited from your account daily.

	    For example, you spent $769.23 before March 21 and then, from March 22 to the end of the month, you spent $12.82 every day.

	    12% of the difference of $897.44 and $769.23: `($897.44 − $769.23) × 12% = $128.21 × 0.12 = $15.39`.

	    Total cost of support for March: `(21 days × $0.37) + (10 days × ($0.37 + $12.82 × 0.12)) = $7.77 + $19.1 = $26.87`

- Roubles, with VAT

    You started paid consumption on March 1 and enabled support under the Standard plan. Every day a percentage of the fixed cost is debited from your account: `₽900 / 31 days = ₽29.03`.

    * If, by the end of the reporting period, you spent ₽60000 or less on {{ yandex-cloud }} resources, then no additional charges apply.

        Total cost of support for March: `₽29.03 × 31 days = ₽900 `.

    * If, by the end of the reporting period, you spent more than ₽60000 on {{ yandex-cloud }} resources, then as soon as you exceed the ₽60000 threshold, a percentage of both fixed and additional costs is debited from your account daily.

        For example, you spent ₽60000 before March 21 and then, from March 22 to the end of the month, you spent ₽1000 every day.

        12% of the difference of ₽70000 and ₽60000: `(₽70000 − ₽60000) × 12% = ₽10000 × 0.12 = ₽1200`.

        Total cost of support for March: `(21 days × ₽29.03) + (10 days × (₽29.03 + ₽1000 × 0.12)) = ₽610 + ₽1490 = ₽2100`

{% endlist%}

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

### Examples of cost calculation {#business-examples}

{% list tabs %}

- USD, without VAT

    You started paid consumption on March 1 and enabled support under the Business plan. Every day a percentage of the fixed cost is debited from your account: `$76.92 / 31 days = $2.48`.

    * If, by the end of the reporting period, you spent $769.23 or less on {{ yandex-cloud }} resources, then no additional charges apply.

        Total cost of support for March: `$2.48 × 31 days = $76.92`.

    * If, by the end of the reporting period, you spent more than $769.23, but less than $2564.1, on {{ yandex-cloud }} resources, then as soon as you exceed the $769.23 threshold, a percentage of both fixed and additional costs is debited from your account daily.

        For example, you spent $769.23 before March 21 and then, from March 22 to the end of the month, you spent $12.82 every day.

        7% of the difference of $897.44 and $769.23: `($897.44 − $769.23) × 7% = $128.21 × 0.07 = $8.97`.

        Total cost of support for March: `(21 days × $2.48) + (10 days × ($2.48 + ($12.82 × 0.07))) = $52.08 + $33.8 = $85.88`.

    * If, by the end of the reporting period, you spent more than $2564.1 on {{ yandex-cloud }} resources, then as soon as you exceed the $769.23 threshold, a percentage of both fixed and additional costs is debited from your account daily. Up to $2564.1, the percentage of additional cost is 7% of the amount you spent per day, and after $2564.1, it's 5%.

        For example, you spent $769.23 before March 21. Then, from March 22 to March 26, you spent $358.97 daily, and from March 27 to the end of the month, you spent $128.21 per day.

        7% of the difference of $2564.1 and $769.23: `($2564.1 − $769.23) × 7% = $1794.87 × 0.07 = $125.64`.

        5% of the difference between the consumption amount and $2564.1: `($3205.13 − $2564.1) × 5% = $641.03 × 0.05 = $32.05`.

        Total cost of support for March: `(21 days × $2.48) + (5 days × ($2.48 + ($358.97× 0.07))) + (5 days × ($2.48 + ($128.21 × 0.05))) = $52.08 + $138.04 + $44.45 = $234.57`.

- Roubles, with VAT

    You started paid consumption on March 1 and enabled support under the Business plan. Every day a percentage of the fixed cost is debited from your account: `₽6,000 / 31 days = ₽193.55`.

    * If, by the end of the reporting period, you spent ₽60000 or less on {{ yandex-cloud }} resources, then no additional charges apply.

        Total cost of support for March: `₽193.55 × 31 days = ₽6000`.

    * If, by the end of the reporting period, you spent more than ₽60000, but less than ₽200000, on {{ yandex-cloud }} resources, then as soon as you exceed the ₽60000 threshold, a percentage of both fixed and additional costs is debited from your account daily.

        For example, you spent ₽60000 before March 21 and then, from March 22 to the end of the month, you spent ₽1000 every day.

        7% of the difference of ₽70000 and ₽60000: `(₽70000 − ₽60000) × 7% = ₽10000 × 0.07 = ₽700`.

        Total cost of support for March: `(21 days × ₽193.55) + (10 days × (₽193.55 + (₽1000 × 0.07))) = ₽4065 + ₽2635 = ₽6700`.

    * If, by the end of the reporting period, you spent more than ₽200000 on {{ yandex-cloud }} resources, then as soon as you exceed the ₽60000 threshold, a percentage of both fixed and additional costs is debited from your account daily. Up to ₽200000, the percentage of additional cost is 7% of the amount you spent per day, and after ₽200000, it's 5%.

        For example, you spent ₽60000 before March 21. Then, from March 22 to March 26, you spent ₽28000 daily, and from March 27 to the end of the month, you spent ₽10000 per day.

        7% of the difference of ₽200000 and ₽60000: `(₽200000 − ₽60000) × 7% = ₽140000 × 0.07 = ₽9800`.

        5% of the difference between the consumption amount and ₽200000: `(₽250000 − ₽200000) × 5% = ₽50000 × 0.05 = ₽2500`.

        Total cost of support for March: `(21 days × ₽193.55) + (5 days × (₽193.55 + (₽28000 × 0.07))) + (5 days × (₽193.55 + (₽10000 × 0.05))) = ₽4065 + ₽10768 + ₽3467 = ₽18300`.

{% endlist%}

## Premium {#premium}

The <q>Premium</q> plan includes all the services offered under the other service plans and can be supplemented based on your requirements.

To get an estimate of the Premium service plan cost, please contact your {{ yandex-cloud }} manager or [support]({{link-console-support}}).
