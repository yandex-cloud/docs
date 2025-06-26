---
title: '{{ sd-full-name }} pricing policy'
description: This article covers the {{ sd-name }} pricing policy.
editable: false
---

# {{ sd-full-name }} pricing policy



The applicable {{ sd-name }} pricing depends on the module you are using:

* [Cloud Infrastructure Entitlement Management ({{ ciem-name }}) module](concepts/ciem.md) is free of charge.
* For [Data Security Posture Management ({{ dspm-name }}) module](concepts/dspm.md), see [{{ dspm-name }}](#dspm-rules) below.
* For [{{ atr-name }}](concepts/access-transparency.md), see [{{ atr-name }}](#atr-rules) below.

## What goes into the cost of using {{ sd-name }} {#rules}

### {{ atr-name }} {#atr-rules}

The cost for using {{ atr-name }} is monthly-based and depends on the overall resource consumption over the previous month in the organization for which {{ atr-name }} is enabled. You can estimate the resource consumption for your organization based on the [usage details by service](../billing/operations/check-charges.md#services_1) for each [billing account](../billing/concepts/billing-account.md) associated with your organization.

The price is calculated in the beginning of the calendar month and does not change over this month. The price does not depend on the number of days in the calendar month when {{ atr-name }} is used from the first day of the month.

When {{ atr-name }} is used from the second day of the calendar month or later, only the remaining time until the end of the month is charged, on an hourly basis.

If you cancel your {{ atr-name }} subscription in the [management console]({{ link-console-main }}), charges will stop from the first day of the next calendar month.

### Data Security Posture Management ({{ dspm-name }}) {#dspm-rules}

When performing [data scan](operations/dspm/create-scan.md), {{ dspm-name }} sends requests to files in {{ objstorage-full-name }} buckets. Such requests are charged as per the [{{ objstorage-name }} pricing policy](../storage/pricing.md). Using {{ dspm-name }} is charged separately.

## Prices for the Russia region {#prices}

### {{ atr-name }} {#atr-pricing}



{% include notitle [usd.md](../_pricing/security-deck/access-transparency/usd.md) %}


### Data Security Posture Management ({{ dspm-name }}) {#dspm-pricing}

#### Data scan (by size) {#scan-by-volume}



{% include notitle [usd.md](../_pricing/security-deck/dspm/usd.md) %}

