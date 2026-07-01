---
title: '{{ sd-full-name }} pricing policy'
description: This article covers the {{ sd-name }} pricing policy.
editable: false
---

# {{ sd-full-name }} pricing policy



{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

{{ sd-name }} modules are billed separately. You can also choose the Starter package, which includes multiple modules.

Pricing details are outlined below:

* [Starter package](#starter-rules).
* [Data Security Posture Management ({{ dspm-name }})](concepts/dspm.md).
* [{{ atr-name }}](concepts/access-transparency.md).
* [{{ k8s }}® Security Posture Management ({{ kspm-name }})](./concepts/kspm.md).
* [Cloud Security Posture Management ({{ cspm-name }})](./concepts/cspm.md).

{% note info %}

[Cloud Infrastructure Entitlement Management ({{ ciem-name }})](concepts/ciem.md) and the [AI assistant](concepts/ai-assistant.md) are provided free of charge.

{% endnote %}


## What goes into the cost of using {{ sd-name }} {#rules}

### Starter package {#starter-rules}

This package includes [Cloud Security Posture Management](./concepts/cspm.md) and [Threat Detector](./concepts/threat-detector.md).

Our subscription plans are priced per calendar month.
A calendar month is a period from 00:00 on the first day of the month to 23:59 on the last day of the same month, UTC+3.

Prices for the number of monthly resources are fixed and do not depend on the number of days in the month.

### {{ atr-name }} {#atr-rules}

The cost for using {{ atr-name }} is monthly-based and depends on the overall resource consumption over the previous month in the organization for which {{ atr-name }} is enabled. You can estimate the resource consumption for your organization based on the [usage details by service](../billing/operations/check-charges.md#services_1) for each [billing account](../billing/concepts/billing-account.md) associated with your organization.

The price is calculated in the beginning of the calendar month and does not change over this month. The price does not depend on the number of days in the calendar month when {{ atr-name }} is used from the first day of the month.

When {{ atr-name }} is used from the second day of the calendar month or later, only the remaining time until the end of the month is charged, on an hourly basis.

If you cancel your {{ atr-name }} subscription in the [management console]({{ link-console-main }}), charges will stop from the first day of the next calendar month.

### {{ dspm-full-name }} ({{ dspm-name }}) {#dspm-rules}

Using {{ dspm-name }} consists of two main phases, which are billed separately:

* [Data analysis](./concepts/dspm.md#discovery-mode): This is the initial operational phase of {{ dspm-name }}, during which resources containing potentially sensitive data are automatically discovered, identified, and cataloged within the selected environment. Within this phase, 100,000 objects per month are free of charge. Once this limit is exceeded, the use of {{ dspm-name }} is billed either according to your selected plan or per million objects.
* Continuous monitoring ([scanning](./concepts/dspm.md#scanning)): This phase involves regular requests to files in {{ objstorage-full-name }} buckets and Yandex 360 disks to check for compliance with security policies. The read operations are billed as per [{{ objstorage-name }} pricing](../storage/pricing.md).

### {{ kspm-full-name }} ({{ kspm-name }}) {#kspm-rules}

The cost for using {{ kspm-full-name }} ({{ kspm-name }}) is monthly-based and depends on the number of worker nodes in [{{ managed-k8s-full-name }}](../managed-kubernetes/) clusters for scanning.

### {{ cspm-full-name }} ({{ cspm-name }}) {#cspm-rules}

Your {{ cspm-name }} charge is calculated monthly and depends on the infrastructure inspection standard selected for the environment and the number of resources covered by the inspection. All standards are billable except for the [{{ yandex-cloud }} basic security rules](concepts/standard-compliance/yc-security-baseline.md).

Each environment is billed separately, even if their resources overlap.

Inactive resources are also billable.

The price does not depend on the number of days in the calendar month.


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Starter package {#starter-pricing}



{% include notitle [usd.md](../_pricing/security-deck/starter/usd.md) %}


### {{ atr-name }} {#atr-pricing}



{% include notitle [usd.md](../_pricing/security-deck/access-transparency/usd.md) %}


### {{ dspm-full-name }} ({{ dspm-name }}) {#dspm-pricing}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|security_deck }}']}
    excludeSkuIds={['{{ pc|security_deck.access_transparency.subscription.v1 }}', '{{ pc|security_deck.kspm.nodes }}', '{{ pc|security_deck.cspm.resources }}', '{{ pc|security_deck.dspm.t1_5.subscription.monthly_usage.v1 }}', '{{ pc|security_deck.dspm.t11.subscription.monthly_usage.v1 }}', '{{ pc|security_deck.dspm.t3.subscription.monthly_usage.v1 }}', '{{ pc|security_deck.dspm.t5_5.subscription.monthly_usage.v1 }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


#### Cost calculation example {#amount-example}

Let’s assume you set up scanning a bucket with 50 text files, their overall size being 5 GB. All files were successfully scanned. The total cost per scan is:



{% include [usd-scan-by-amount](../_pricing_examples/security-deck/usd-scan-by-amount.md) %}


### {{ kspm-full-name }} ({{ kspm-name }}) {#kspm-pricing}



{% include notitle [usd.md](../_pricing/security-deck/kspm/usd.md) %}


### {{ cspm-full-name }} ({{ cspm-name }}) {#cspm-pricing}



{% include notitle [usd.md](../_pricing/security-deck/cspm/usd.md) %}


