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

### Example of cost calculation {#standard-example}

You started paid consumption on March 1 and enabled support under the Standard plan. Every day a percentage of the fixed cost is debited from your account:

{% if region == "ru" %}>₽900 / 31 = ₽29.0300{% endif %}
{% if region == "kz" %}>₸5400 / 31 = ₸174.1935{% endif %}
{% if region == "int" %}>$11.538462 / 31 = $0.372208{% endif %}

Where:

* {% if region == "ru" %}₽900{% endif %}{% if region == "kz" %}₸5400{% endif %}{% if region == "int" %}$11.538462{% endif %} is the fixed cost of technical support per month.
* 31 is the number of days in March.

If, by the end of the reporting period, you spent {% if region == "ru" %}₽60000{% endif %}{% if region == "kz" %}₸360000{% endif %}{% if region == "int" %}$769.230000{% endif %} or less on {{ yandex-cloud }} resources, then no additional charges apply. The cost of support is {% if region == "ru" %}₽900{% endif %}{% if region == "kz" %}₸5400{% endif %}{% if region == "int" %}$11.538462{% endif %}.

If, by the end of the reporting period, you spent more than {% if region == "ru" %}₽60000{% endif %}{% if region == "kz" %}₸360000{% endif %}{% if region == "int" %}$769.230000{% endif %} on {{ yandex-cloud }} resources, then as soon as you exceed the {% if region == "ru" %}₽60000{% endif %}{% if region == "kz" %}₸360000{% endif %}{% if region == "int" %}$769.230000{% endif %} threshold, a percentage of both fixed and additional costs is debited from your account daily.

For example, you spent {% if region == "ru" %}₽60000{% endif %}{% if region == "kz" %}₸360000{% endif %}{% if region == "int" %}$769.230000{% endif %} from March 1 to March 21, and then, from March 22 to the end of the month, you spent {% if region == "ru" %}₽1000{% endif %}{% if region == "kz" %}₸5000{% endif %}{% if region == "int" %}$8.000694{% endif %} a day.

The total cost is:

{% if region == "ru" %}>₽900 + ((₽60000 + 10 × ₽1000) − ₽60000) × 12% = ₽900 + ₽10000 × 0.12 = ₽2100{% endif %}
{% if region == "kz" %}>₸5400 + ((₸360000 + 10 × ₸5000) − ₸360000) × 12% = ₸5400 + ₸50000 × 0.12 = ₸11400{% endif %}
{% if region == "int" %}>$11.538462 + (($769.230000 + 10 × $8.000694) − $769.230000) × 12% = $11.538462 + $80.000694 × 0.12 = $21.138545{% endif %}

Where:

* {% if region == "ru" %}₽900{% endif %}{% if region == "kz" %}₸5400{% endif %}{% if region == "int" %}$11.538462{% endif %} is the fixed cost of technical support per month.
* {% if region == "ru" %}₽60000{% endif %}{% if region == "kz" %}₸360000{% endif %}{% if region == "int" %}$769.230000{% endif %} is the resource usage cost for the period from March 1 to March 21.
* 10 is the number of days from March 22 to the end of the month.
* {% if region == "ru" %}₽1000{% endif %}{% if region == "kz" %}₸5000{% endif %}{% if region == "int" %}$8.000694{% endif %} is the resource usage cost per day from March 22 to the end of the month.


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

### Example of cost calculation {#business-example}

You started paid consumption on March 1 and enabled support under the Business plan. Every day a percentage of the fixed cost is debited from your account:

{% if region == "ru" %}>₽6000 / 31 = ₽193.5500{% endif %}
{% if region == "kz" %}>₸36000 / 31 = ₸1161.2903{% endif %}
{% if region == "int" %}>$76.923078 / 31 = $2.481390{% endif %}

Where:

* {% if region == "ru" %}₽6000{% endif %}{% if region == "kz" %}₸36000{% endif %}{% if region == "int" %}$76.923078{% endif %} is the fixed cost of technical support per month.
* 31 is the number of days in March.

If, by the end of the reporting period, you spent {% if region == "ru" %}₽60000{% endif %}{% if region == "kz" %}₸360000{% endif %}{% if region == "int" %}$769.230000{% endif %} or less on {{ yandex-cloud }} resources, then no additional charges apply. The cost of support is {% if region == "ru" %}₽6000{% endif %}{% if region == "kz" %}₸36000{% endif %}{% if region == "int" %}$76.923078{% endif %}.

If, by the end of the reporting period, you spent on {{ yandex-cloud }} resources more than {% if region == "ru" %}₽60000{% endif %}{% if region == "kz" %}₸360000{% endif %}{% if region == "int" %}$769.230000{% endif %}, but less than {% if region == "ru" %}₽200000{% endif %}{% if region == "kz" %}₸1200000{% endif %}{% if region == "int" %}$2564.100000{% endif %}, then as soon as you exceed the {% if region == "ru" %}₽60000{% endif %}{% if region == "kz" %}₸360000{% endif %}{% if region == "int" %}$769.230000{% endif %} threshold, a percentage of both fixed and additional costs is debited from your account daily.

For example, you spent {% if region == "ru" %}₽60000{% endif %}{% if region == "kz" %}₸360000{% endif %}{% if region == "int" %}$769.230000{% endif %} from March 1 to March 21, and then, from March 22 to the end of the month, you spent {% if region == "ru" %}₽1000{% endif %}{% if region == "kz" %}₸5000{% endif %}{% if region == "int" %}$20{% endif %} a day.

The total cost is:

{% if region == "ru" %}>₽6000 + ((₽60000 + 10 × ₽1000) − ₽60000) × 7% = ₽6000 + ₽10000 × 0.07 = ₽6700{% endif %}
{% if region == "kz" %}>₸36000 + ((₸360 000 + 10 × ₸5000) − ₸360000) × 7% = ₸36000 + ₸50000 × 0.07 = ₸39500{% endif %}
{% if region == "int" %}>$76.923078 + (($769.230000 + 10 × $20) − $769.230000) × 7% = $76.923078 + $100 × 0.07 = $83.923078{% endif %}

Where:

* {% if region == "ru" %}₽6000{% endif %}{% if region == "kz" %}₸36000{% endif %}{% if region == "int" %}$76.923078{% endif %} is the fixed cost of technical support per month.
* {% if region == "ru" %}₽60000{% endif %}{% if region == "kz" %}₸360000{% endif %}{% if region == "int" %}$769.230000{% endif %} is the resource usage cost for the period from March 1 to March 21.
* 10 is the number of days from March 22 to the end of the month.
* {% if region == "ru" %}₽1000{% endif %}{% if region == "kz" %}₸5000{% endif %}{% if region == "int" %}$20{% endif %} is the resource usage cost per day from March 22 to the end of the month.

If, by the end of the reporting period, you spent more than {% if region == "ru" %}₽200000{% endif %}{% if region == "kz" %}₸1200000{% endif %}{% if region == "int" %}$2564.100000{% endif %} on {{ yandex-cloud }} resources, then as soon as you exceed the {% if region == "ru" %}₽60000{% endif %}{% if region == "kz" %}₸360000{% endif %}{% if region == "int" %}$769.230000{% endif %} threshold, a percentage of both fixed and additional costs is debited from your account daily. Up to {% if region == "ru" %}₽200000{% endif %}{% if region == "kz" %}₸1200000{% endif %}{% if region == "int" %}$2564.100000{% endif %}, a percentage of additional cost is 7% of the amount you spent per day, and above that, it's 5%.

For example, you spent {% if region == "ru" %}₽60000{% endif %}{% if region == "kz" %}₸360000{% endif %}{% if region == "int" %}$769.230000{% endif %} from March 1 to March 21. Then, from March 22 to March 26 , you spent {% if region == "ru" %}₽28000{% endif %}{% if region == "kz" %}₸140000{% endif %}{% if region == "int" %}$358.974000{% endif %} a day and, from March 27 to the end of the month, {% if region == "ru" %}₽10000{% endif %}{% if region == "kz" %}₸62000{% endif %}{% if region == "int" %}$100{% endif %} a day.

In this case, the additional cost of technical support before you exceed the {% if region == "ru" %}₽200000{% endif %}{% if region == "kz" %}₸1200000{% endif %}{% if region == "int" %}$2564.100000{% endif %} threshold is calculated as follows:

{% if region == "ru" %}>(₽200000 − ₽60000) × 7% = ₽140000 × 0.07 = ₽9800{% endif %}
{% if region == "kz" %}>(₸1200000 − ₸360000) × 7% = ₸840000 × 0.07 = ₸58800{% endif %}
{% if region == "int" %}>($2564.100000 − $769.230000) × 7% = $1794.870000 × 0.07 = $125.640000{% endif %}

Where {% if region == "ru" %}₽60000{% endif %}{% if region == "kz" %}₸360000{% endif %}{% if region == "int" %}$769.230000{% endif %} is the resource usage cost for the period from March 1 to March 21.

The additional cost of technical support as soon as you exceed the {% if region == "ru" %}₽200000{% endif %}{% if region == "kz" %}₸1200000{% endif %}{% if region == "int" %}$2564.100000{% endif %} threshold is calculated as follows:

{% if region == "ru" %}>((₽200000 + 5 × ₽10000) — ₽200000) × 5% = ₽50000 × 0.05 = ₽2500{% endif %}
{% if region == "kz" %}>((₸1200000 + 5 × ₸62000) — ₸1200000) × 5% = ₸310000 × 0.05 = ₸15500{% endif %}
{% if region == "int" %}>(($2564.100000 + 5 × $100) — $2564.100000) × 5% = $500 × 0.05 = $25{% endif %}

Where:

* {% if region == "ru" %}₽200000{% endif %}{% if region == "kz" %}₸1200000{% endif %}{% if region == "int" %}$2564.100000{% endif %} is the resource usage cost for the period from March 1 to March 26.
* 5 is the number of days from March 27 to the end of the month.
* {% if region == "ru" %}₽10000{% endif %}{% if region == "kz" %}₸62000{% endif %}{% if region == "int" %}$100{% endif %} is the resource usage cost per day from March 27 to the end of the month.

The total cost is:

{% if region == "ru" %}>₽6000 + ₽9800 + ₽2500 = ₽18300{% endif %}
{% if region == "kz" %}>₸36000 + ₸58800 + ₸15500 = ₸110300{% endif %}
{% if region == "int" %}>$76.923078 + $125.640000 + $25 = $227.563078{% endif %}

Where:

* {% if region == "ru" %}₽6000{% endif %}{% if region == "kz" %}₸36000{% endif %}{% if region == "int" %}$76.923078{% endif %} is the fixed cost of technical support per month.
* {% if region == "ru" %}₽9800{% endif %}{% if region == "kz" %}₸58800{% endif %}{% if region == "int" %}$125.640000{% endif %} is the additional cost of technical support before you exceed the {% if region == "ru" %}₽200000{% endif %}{% if region == "kz" %}₸1200000{% endif %}{% if region == "int" %}$2564.100000{% endif %} threshold.
* {% if region == "ru" %}₽2500{% endif %}{% if region == "kz" %}₸15500{% endif %}{% if region == "int" %}$25{% endif %} is the additional cost of technical support as soon as you exceed the {% if region == "ru" %}₽200000{% endif %}{% if region == "kz" %}₸1200000{% endif %}{% if region == "int" %}$2564.100000{% endif %} threshold.

## Premium {#premium}

The <q>Premium</q> plan includes all the services offered under the other service plans and can be supplemented based on your requirements.

To get an estimate of the Premium service plan cost, please contact your {{ yandex-cloud }} manager or [support]({{link-console-support}}).

{% endif %}
