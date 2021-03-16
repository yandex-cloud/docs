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

{% list tabs %}

- USD, without VAT

    The cost of support under the service plan is fixed at $11.54 per month plus an additional amount, which is calculated as a percent of the cost of resources consumed for the current month, if such cost exceeds $769.23.
    
    The consumption cost percentage is calculated as follows:
    * If the consumption amount is more than $769.23, the additional cost is 12% the difference of the consumption amount minus $769.23.

- Roubles, with VAT
    
    The cost of support under the service plan is fixed at ₽900 per month plus an additional amount, which is calculated as a percent of the cost of resources consumed for the current month, if such cost exceeds ₽60,000.
    
    The consumption cost percentage is calculated as follows:
    * If the consumption amount is more than ₽60,000, the additional cost is 12% the difference of the consumption amount minus ₽60,000.

{% endlist%}

### Examples of cost calculation {#standard-examples}

{% list tabs %}

- USD, without VAT

    You started paid consumption on March 1 and enabled support under the Standard plan. Every day a percentage of the fixed cost is debited from your account: `$11.54 / 31 days = $0.37`.

    * If, by the end of the reporting period, you spent $769.23 or less on {{ yandex-cloud }} resources, then no additional charges apply.

	    Total cost of support for March: `$0.37 × 31 days = $11.54`.

    * If, by the end of the reporting period, you spent more than $769.23 on {{ yandex-cloud }} resources, then as soon as you exceed the $769.23 threshold, a percentage of both fixed and additional costs is debited from your account daily.

	    For example, you spent $769.23 before March 21 and then, from March 22 to the end of the month, you spent $12.82 every day.

	    12% of the difference of $897.44 and $769.23: `($897.44 − $769.23) × 12% = $128,21 × 0.12 = $15.39`.

	    Total cost of support for March: `(21 days × $0.37) + (10 days × ($0.37 + $12.82 × 0.12)) = $7.77 + $19.1 = $26.87`

- Roubles, with VAT

    You started paid consumption on March 1 and enabled support under the Standard plan. Every day a percentage of the fixed cost is debited from your account: `₽900 / 31 days = ₽29.03`.

    * If, by the end of the reporting period, you spent ₽60,000 or less on {{ yandex-cloud }} resources, then no additional charges apply.

        Total cost of support for March: `₽29.03 × 31 days = ₽900 `.

    * If, by the end of the reporting period, you spent more than ₽60,000 on {{ yandex-cloud }} resources, then as soon as you exceed the ₽60,000 threshold, a percentage of both fixed and additional costs is debited from your account daily.

        For example, you spent ₽60,000 before March 21 and then, from March 22 to the end of the month, you spent ₽1,000 every day.

        12% of the difference of ₽70,000 and ₽60,000: `(₽70,000 − ₽60,000) × 12% = ₽10,000 × 0.12 = ₽1,200`.

        Total cost of support for March: `(21 days × ₽29.03) + (10 days × (₽29.03 + ₽1000 × 0.12)) = ₽610 + ₽1490 = ₽2100`

{% endlist%}

## Business {#business}

The <q>Business</q> plan is suitable for professional projects. Compared to the basic plan, it lets you:

* Request general recommendations about the architecture of your solution from {{ yandex-cloud }} technical support.
* Get advice and recommendations on configuring third-party software and fixing {{ yandex-cloud }} compatibility issues.
* Get recommendations for fixing problems with operating systems and their components.

### Service plan cost {#business-price}

{% list tabs %}

- USD, without VAT

    The cost of support under the service plan is fixed at $76.92 per month plus an additional amount, which is calculated as a percent of the cost of resources consumed for the current month, if such cost exceeds $769.23.
    
    The consumption cost percentage is calculated as follows:
    
    * If the consumption amount is more than $769.23 but less than $2,564.1, the additional cost is 7% the difference of the consumption amount minus $769.23.
    * If the consumption amount is more than $2,564.1, the additional cost is $125.64 plus 5% the difference of the consumption amount minus $2,564.10.
    
- Roubles, with VAT

    The cost of support under the service plan is fixed at ₽6,000 per month plus an additional amount, which is calculated as a percent of the cost of resources consumed for the current month, if such cost exceeds ₽60,000.
    
    The consumption cost percentage is calculated as follows:
    
    * If the consumption amount is more than ₽60,000 but less than ₽200,000, the additional cost is 7% the difference of the consumption amount minus ₽60,000.
    * If the consumption amount is more than ₽200,000, the additional cost is ₽9,800 plus 5% the difference of the consumption amount minus ₽200,000.

{% endlist%}

### Examples of cost calculation {#business-examples}

{% list tabs %}

- USD, without VAT

    You started paid consumption on March 1 and enabled support under the Business plan. Every day a percentage of the fixed cost is debited from your account: `$76.92 / 31 days = $2.48`.

    * If, by the end of the reporting period, you spent $769.23 or less on {{ yandex-cloud }} resources, then no additional charges apply.

        Total cost of support for March: `$2.48 × 31 days = $76.92`.

    * If, by the end of the reporting period, you spent more than $769.23, but less than $2,564.1, on {{ yandex-cloud }} resources, then as soon as you exceed the $769.23 threshold, a percentage of both fixed and additional costs is debited from your account daily.

        For example, you spent $769.23 before March 21 and then, from March 22 to the end of the month, you spent $12.82 every day.

        7% of the difference of $897.44 and $769.23: `($897.44 − $769.23) × 7% = $128.21 × 0.07 = $8.97`.

        Total cost of support for March: `(21 days × $2.48) + (10 days × ($2.48 + ($12.82 × 0.07))) = $52.08 + $33.8 = $85.88`.

    * If, by the end of the reporting period, you spent more than $2,564.1 on {{ yandex-cloud }} resources, then as soon as you exceed the $769.23 threshold, a percentage of both fixed and additional costs is debited from your account daily. Up to $2,564.1, the percentage of additional cost is 7% of the amount you spent per day, and after $2,564.1, it's 5%.

        For example, you spent $769.23 before March 21. Then, from March 22 to March 26, you spent $358.97 daily, and from March 27 to the end of the month, you spent $128.21 per day.

        7% of the difference of $2,564.1 and $769.23: `($2,564.1 − $769.23) × 7% = $1,794.87 × 0.07 = $125.64`.

        5% of the difference between the consumption amount and $2,564.1: `($3,205.13 − $2,564.1) × 5% = $641,03 × 0.05 = $32,05`.

        Total cost of support for March: `(21 days × $2.48) + (5 days × ($2.48 + ($358.97× 0.07))) + (5 days × ($2.48 + ($128.21 × 0.05))) = $52.08 + $138.04 + $44.45 = $234.57`.

- Roubles, with VAT

    You started paid consumption on March 1 and enabled support under the Business plan. Every day a percentage of the fixed cost is debited from your account: `₽6,000 / 31 days = ₽193.55`.

    * If, by the end of the reporting period, you spent ₽60,000 or less on {{ yandex-cloud }} resources, then no additional charges apply.

        Total cost of support for March: `₽193.55 × 31 days = ₽6,000`.

    * If, by the end of the reporting period, you spent more than ₽60,000, but less than ₽200,000, on {{ yandex-cloud }} resources, then as soon as you exceed the ₽60,000 threshold, a percentage of both fixed and additional costs is debited from your account daily.

        For example, you spent ₽60,000 before March 21 and then, from March 22 to the end of the month, you spent ₽1,000 every day.

        7% of the difference of ₽70,000 and ₽60,000: `(₽70,000 − ₽60,000) × 7% = ₽10,000 × 0.07 = ₽700`.

        Total cost of support for March: `(21 days × ₽193.55) + (10 days × (₽193.55 + (₽1,000 × 0.07))) = ₽4,065 + ₽2,635 = ₽6,700`.

    * If, by the end of the reporting period, you spent more than ₽200,000 on {{ yandex-cloud }} resources, then as soon as you exceed the ₽60,000 threshold, a percentage of both fixed and additional costs is debited from your account daily. Up to ₽200,000, the percentage of additional cost is 7% of the amount you spent per day, and after ₽200,000, it's 5%.

        For example, you spent ₽60,000 before March 21. Then, from March 22 to March 26, you spent ₽28,000 daily, and from March 27 to the end of the month, you spent ₽10,000 per day.

        7% of the difference of ₽200,000 and ₽60,000: `(₽200,000 − ₽60,000) × 7% = ₽140,000 × 0.07 = ₽9,800`.

        5% of the difference between the consumption amount and ₽200,000: `(₽250,000 − ₽200,000) × 5% = ₽50,000 × 0.05 = ₽2,500`.

        Total cost of support for March: `(21 days × ₽193.55) + (5 days × (₽193.55 + (₽28,000 × 0.07))) + (5 days × (₽193.55 + (₽10,000 × 0.05))) = ₽4,065 + ₽10,768 + ₽3,467 = ₽18,300`.

{% endlist%}

## Premium {#premium}

The <q>Premium</q> plan includes all the services offered under the other service plans and can be supplemented based on your requirements.

To get an estimate of the Premium service plan cost, please contact your {{ yandex-cloud }} manager or [support]({{link-console-support}}).

{% note info %}

Prices are rounded to two decimal places.

{% endnote %}