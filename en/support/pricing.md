---
editable: false
---

# Technical support pricing



{% note warning %}

Starting October 1, 2023, support service plans are going to change. For details, see [Current service plans](#effective-plans) and [Service plans starting October 1, 2023](#new-plans).

{% endnote %}

## Current service plans {#effective-plans}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

The cost depends on the selected service plan. For a table of all service plans and their features, see [{#T}](overview.md).

The selected service plan applies to a billing account and [can only be changed](overview#change-service-plan) by the billing account owner.

The basic service plan is provided to all {{ yandex-cloud }} users free of charge. For other service plans, the price is calculated based on the resources consumed for the current reporting period (calendar month). To calculate the cost of using the service, use our [calculator](/prices#calculator) or see the calculation methods in the sections below.

{% note info %}

* All prices are shown without VAT. The cost of technical support is calculated after deducting the amount of previously issued grants from the cost of the consumed resources.

{% endnote %}

### Basic {#base}

The basic service plan is provided to all {{ yandex-cloud }} users free of charge. It's suitable for personal and research projects.

### Standard {#standard}

{% note warning %}

This service plan is valid until October 1, 2023.

{% endnote %}

Compared to the basic plan, the <q>Standard</q> plan lets you request general recommendations about the architecture of your solution from {{ yandex-cloud }} technical support. It's suitable for development and pilot projects.

#### Service plan cost {#standard-price}




{% include [usd.md](../_pricing/support/usd-standard.md) %}


#### Example of cost calculation {#standard-example}

You started paid consumption on March 1 and enabled support under the Standard plan. Every day a percentage of the fixed cost is debited from your account:

>$11.538462 / 31 = $0.372208

Where:

* $11.538462 is the fixed cost of technical support per month.
* 31 is the number of days in March.

If, by the end of the reporting period, you spent $769.230000 or less on {{ yandex-cloud }} resources, then no additional charges apply. The cost of support is $11.538462.

If, by the end of the reporting period, you spent more than $769.230000 on {{ yandex-cloud }} resources, then as soon as you exceed the $769.230000 threshold, a percentage of both fixed and additional costs is debited from your account daily.

For example, you spent $769.230000 from March 1 to March 21, and then, from March 22 to the end of the month, you spent $8.000694 a day.

The total cost is:

>$11.538462 + (($769.230000 + 10 × $8.000694) − $769.230000) × 12% = $11.538462 + $80.000694 × 0.12 = $21.138545

Where:

* $11.538462 is the fixed cost of technical support per month.
* $769.230000 is the resource usage cost for the period from March 1 to March 21.
* 10 is the number of days from March 22 to the end of the month.
* $8.000694 is the resource usage cost per day from March 22 to the end of the month.


### Business {#business}

The <q>Business</q> plan is suitable for professional projects. Compared to the basic plan, it lets you:

* Request general recommendations about the architecture of your solution from {{ yandex-cloud }} technical support.
* Get advice and recommendations on configuring third-party software and fixing {{ yandex-cloud }} compatibility issues.
* Get recommendations for fixing problems with operating systems and their components.

#### Service plan cost {#business-price}




{% include [usd.md](../_pricing/support/usd-business.md) %}


#### Example of cost calculation {#business-example}

You started paid consumption on March 1 and enabled support under the Business plan. Every day a percentage of the fixed cost is debited from your account:

>$76.923078 / 31 = $2.481390

Where:

* $76.923078 is the fixed cost of technical support per month.
* 31 is the number of days in March.

If, by the end of the reporting period, you spent $769.230000 or less on {{ yandex-cloud }} resources, then no additional charges apply. The cost of support is $76.923078.

If, by the end of the reporting period, you spent on {{ yandex-cloud }} resources more than $769.230000, but less than $2,564.100000, then as soon as you exceed the $769.230000 threshold, a percentage of both fixed and additional costs is debited from your account daily.

For example, you spent $769.230000 from March 1 to March 21, and then, from March 22 to the end of the month, you spent $20 a day.

The total cost is:

>$76.923078 + (($769.230000 + 10 × $20) − $769.230000) × 7% = $76.923078 + $100 × 0.07 = $83.923078

Where:

* $76.923078 is the fixed cost of technical support per month.
* $769.230000 is the resource usage cost for the period from March 1 to March 21.
* 10 is the number of days from March 22 to the end of the month.
* $20 is the resource usage cost per day from March 22 to the end of the month.

If, by the end of the reporting period, you spent more than $2,564.100000 on {{ yandex-cloud }} resources, then as soon as you exceed the $769.230000 threshold, a percentage of both fixed and additional costs is debited from your account daily. Up to $2,564.100000, a percentage of additional cost is 7% of the amount you spent per day, and above that, it's 5%.

For example, you spent $769.230000 from March 1 to March 21. Then, from March 22 to March 26 , you spent $358.974000 a day and, from March 27 to the end of the month, $100 a day.

In this case, the additional cost of technical support before you exceed the $2,564.100000 threshold is calculated as follows:

>($2,564.100000 − $769.230000) × 7% = $1,794.870000 × 0.07 = $125.640000

Where $769.230000 is the resource usage cost for the period from March 1 to March 21.

The additional cost of technical support as soon as you exceed the $2,564.100000 threshold is calculated as follows:

>(($2,564.100000 + 5 × $100) — $2,564.100000) × 5% = $500 × 0.05 = $25

Where:

* $2,564.100000 is the resource usage cost for the period from March 1 to March 26.
* 5 is the number of days from March 27 to the end of the month.
* $100 is the resource usage cost per day from March 27 to the end of the month.

The total cost is:

>$76.923078 + $125.640000 + $25 = $227.563078

Where:

* $76.923078 is the fixed cost of technical support per month.
* $125.640000 is the additional cost of technical support before you exceed the $2,564.100000 threshold.
* $25 is the additional cost of technical support as soon as you exceed the $2,564.100000 threshold.

### Premium {#premium}

The <q>Premium</q> plan includes all the services offered under the other service plans and can be supplemented based on your requirements.

To get an estimate of the Premium service plan cost, please contact your {{ yandex-cloud }} manager or [support]({{link-console-support}}).

## Service plans starting October 1, 2023 {#new-plans}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

The cost depends on the selected service plan. The selected service plan applies to an organization and can only be changed by the organization owner or administrator. You can use one billing account to pay for technical support for multiple organizations that may have different support service plans activated. Service packages under various service plans are described in [Requesting technical support](overview.md).

| Service plan | Basic | Business | Premium |
--- | --- |---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------| ---
| **Cost** | Free | $24 per month plus 5% of the cost of the billing</br> account resources consumed by the organization | Contact us |

{% note info %}

* All prices are shown without VAT. The cost of support is calculated based on the cost of paid resources consumed.

{% endnote %}

### Basic {#base}

The basic service plan is provided to all {{ yandex-cloud }} users at no separate charge. It is suitable for personal and research projects.

### Business {#business}

This plan is good for business projects requiring 24/7 support.
The price is calculated based on the amount of resources consumed over the current reporting period (calendar month). To calculate the cost of using the service, use our [calculator](/prices#calculator) or see the calculation methods in the sections below.

#### Service plan cost {#business-price}




{% include [usd.md](../_pricing/support/usd-business-2023.md) %}


#### Example of calculating the cost for an organization whose resources are paid from a single billing account {#business-example-one-ba}

If a customer consumes resources for $800 a month, technical support will cost them $24 + $800 * 0.05 = $64 with the respective amount debited from a single billing account.

#### Example of calculating the cost for an organization whose resources are paid from two billing accounts {#business-example-two-ba}

If an organization with an activated support service plan has resources that are paid from different billing accounts, the percentage portion of the plan cost will be paid by each billing account depending on the cost of resources consumed. The fixed portion is paid by one account only: the one specified when selecting the Business plan. 

An organization with the activated Business plan pays for resources from different billing accounts:

* Account 1: Consumes resources for $400 a month.
* Account 2: Consumes resources for $80 a month.

The fixed amount will only be paid by one of the accounts, for example, Account 1.

The cost of support will be:

* $24 + $400 * 0.05 = $44 for Account 1.
* $80 * 0.05 = $4 for Account 2.

### Premium {#premium}

The <q>Premium</q> plan includes all the services offered under the other service plans and can be supplemented based on your requirements.

To get an estimate of the Premium service plan cost, please contact your {{ yandex-cloud }} manager or [support]({{link-console-support}}).

