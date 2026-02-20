---
title: '{{ sd-full-name }} pricing policy'
description: This article covers the {{ sd-name }} pricing policy.
editable: false
---

# {{ sd-full-name }} pricing policy



{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

The applicable {{ sd-name }} pricing depends on the module you are using:

* [Cloud Infrastructure Entitlement Management ({{ ciem-name }})](concepts/ciem.md) is free of charge.
* [For {{ dspm-name }})](concepts/dspm.md), see [below](#dspm-rules).
* For [{{ atr-name }}](concepts/access-transparency.md), see [{{ atr-name }}](#atr-rules) below.
* For [KSPM](concepts/kspm.md), see [Kubernetes® Security Posture Management (KSPM)](#kspm-rules) below.
* [{{ cspm-name }}](concepts/cspm.md), see [Cloud Security Posture Management ({{ cspm-name }})](#cspm-rules) below.
* [AI assistant](concepts/ai-assistant.md) is at the [Preview](../overview/concepts/launch-stages.md) stage and is free of charge.

## What goes into the cost of using {{ sd-name }} {#rules}

### {{ atr-name }} {#atr-rules}

The cost for using {{ atr-name }} is monthly-based and depends on the overall resource consumption over the previous month in the organization for which {{ atr-name }} is enabled. You can estimate the resource consumption for your organization based on the [usage details by service](../billing/operations/check-charges.md#services_1) for each [billing account](../billing/concepts/billing-account.md) associated with your organization.

The price is calculated in the beginning of the calendar month and does not change over this month. The price does not depend on the number of days in the calendar month when {{ atr-name }} is used from the first day of the month.

When {{ atr-name }} is used from the second day of the calendar month or later, only the remaining time until the end of the month is charged, on an hourly basis.

If you cancel your {{ atr-name }} subscription in the [management console]({{ link-console-main }}), charges will stop from the first day of the next calendar month.

### Data Security Posture Management ({{ dspm-name }}) {#dspm-rules}

When performing [data scan](operations/dspm/create-scan.md), {{ dspm-name }} sends requests to files in {{ objstorage-full-name }} buckets. Such requests are charged as per the [{{ objstorage-name }} pricing policy](../storage/pricing.md). Using {{ dspm-name }} is charged separately.

### {{ k8s }}® Security Posture Management (KSPM) {#kspm-rules}

The cost for using {{ k8s }}® Security Posture Management (KSPM) is monthly-based and depends on the number of worker nodes in [{{ managed-k8s-full-name }}](../managed-kubernetes/) clusters for scanning.

### Cloud Security Posture Management ({{ cspm-name }}) {#cspm-rules}

{% note info %}

Module billing starts on March 2, 2026.

{% endnote %}

The cost of using the {{ cspm-name }} module is calculated monthly and depends on the standard selected in the environment for infrastructure checking and the number of resources included in the check. All standards are charged except for the [{{ yandex-cloud }} Security Baseline](concepts/standard-compliance/yc-security-baseline.md).

Each environment is charged separately, even if resources overlap between them.

Inactive resources are also charged.

The price does not depend on the duration of the calendar month.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### {{ atr-name }} {#atr-pricing}



{% include notitle [usd.md](../_pricing/security-deck/access-transparency/usd.md) %}


The monthly price is based on 720 hours per month.

### Data Security Posture Management ({{ dspm-name }}) {#dspm-pricing}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|security_deck }}']}
    excludeSkuIds={['{{ pc|security_deck.access_transparency.subscription.v1 }}', '{{ pc|security_deck.kspm.nodes }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


The monthly price is based on 720 hours per month.


#### Cost calculation example {#amount-example}

Let’s assume you set up scanning a bucket with 50 text files, their overall size being 5 GB. All files were successfully scanned. The total cost per scan is:



{% include [usd-scan-by-amount](../_pricing_examples/security-deck/usd-scan-by-amount.md) %}


### {{ k8s }}® Security Posture Management (KSPM) {#kspm-pricing}

{% note warning %}

These prices apply starting February 2, 2026.

{% endnote %}



{% include notitle [usd.md](../_pricing/security-deck/kspm/usd.md) %}


The monthly price is based on 720 hours per month.

### Cloud Security Posture Management ({{ cspm-name }}) {#cspm-pricing}



{% include notitle [usd.md](../_pricing/security-deck/cspm/usd.md) %}

