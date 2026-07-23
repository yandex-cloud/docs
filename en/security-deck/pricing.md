---
title: '{{ sd-full-name }} pricing policy'
description: This article covers the {{ sd-name }} pricing policy.
editable: false
---

# {{ sd-full-name }} pricing policy



{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

In {{ sd-name }}, each module is billed separately. You can also use package plans and subscriptions.

You pay for the following modules:

* [Data Security Posture Management ({{ dspm-name }})](concepts/dspm.md)
* [{{ atr-name }}](concepts/access-transparency.md)
* [{{ k8s }}® Security Posture Management ({{ kspm-name }})](concepts/kspm.md)
* [Cloud Security Posture Management ({{ cspm-name }})](concepts/cspm.md)
* [Vulnerability Management ({{ vuln-man-short-name }})](concepts/vulnerability-management.md)

You do not pay for:

* [Cloud Infrastructure Entitlement Management ({{ ciem-name }})](concepts/ciem.md)
* [Threat detection ({{ td-name }})](concepts/threat-detector.md)
* [AI assistant](concepts/ai-assistant.md)

## What goes into the cost of using {{ sd-name }} {#rules}

### Package plans and subscriptions {#starter-rules}

#|
|| **Name** | **Description** | **Terms** ||
|| {{ sd-name }}. Starter package | Configuration checks for compliance with standards in the [configuration control module](./concepts/cspm.md) and suspicious activity and threat alerts in the [threat detection module](./concepts/threat-detector.md).</br>There are several plans for different numbers of resources per environment. | The prices based on resources per month are fixed and do not depend on the number of days in the month. ||
|#

The package prices and subscriptions below are per calendar month.
A calendar month is a period from 00:00 on the first day of the month to 23:59 on the last day of the same month, UTC+3.

### Module pricing {#modules-rules}

{% note tip %}

You can estimate the resource consumption for your organization based on the [usage details by service](../billing/operations/check-charges.md#services_1) for each [billing account](../billing/concepts/billing-account.md) associated with your organization.

{% endnote %}

#|
|| **Module** | **Billing unit** | **Terms** ||
|| {{ atr-name }} | Overall consumption of resources over the previous month in the organization the module is enabled for. | Calculated monthly.</br>The price is calculated at the beginning of the calendar month and remains unchanged until its end.</br>If the module is used from the first day of the month, the price does not depend on the duration of the calendar month. If used from the second day of the calendar month or later, you pay only for the remaining time until the end of the month on an hourly basis.</br>If you cancel your subscription in the [management console]({{ link-console-main }}), payments will stop to be charged from the first day of the next calendar month. ||
|| Data Security Posture Management ({{ dspm-name }}) | <ul><li>[Data analysis](./concepts/dspm.md#discovery-mode): Once the limit is exceeded, you pay per 1,000,000 objects.</li><li>[Scanning](./concepts/dspm.md#scanning): Data read operations and the amount of data scanned.</li></ul> | <ul><li>[Data analysis](./concepts/dspm.md#discovery-mode): Once the free limit of 100,000 objects is exceeded, you pay per 1,000,000 objects based on the pricing ladder.</li><li>Continuous monitoring ([scanning](./concepts/dspm.md#scanning)): You pay for requests as per the {{ objstorage-name }} [pricing policy](../storage/pricing.md).</li></ul> ||
|| {{ k8s }} Security Posture Management ({{ kspm-name }}) | Worker nodes in [{{ managed-k8s-full-name }}](../managed-kubernetes/) clusters covered by scanning | Calculated monthly. ||
|| Cloud Security Posture Management ({{ cspm-name }}) | Number of the environment's resources checked for compliance with enabled standards:<ul><li>{{ compute-full-name }} virtual machine</li><li>{{ objstorage-full-name }} bucket</li><li>Database clusters ^1^</li><li>{{ k8s }} cluster</li><li>{{ vpc-full-name }} cloud network.</li></ul> | Calculated monthly.</br>All standards are billable except for the [{{ yandex-cloud }} basic security rules](concepts/standard-compliance/yc-security-baseline.md).</br>Each environment is billed separately, even if their resources overlap.</br>Inactive resources are also billable.</br>The price does not depend on the number of days in the calendar month. ||
|#

^1^ The check includes database clusters of the following services:

* {{ mch-full-name }}
* {{ mgp-full-name }}
* {{ mkf-full-name }}
* {{ mmy-full-name }}
* {{ mmg-full-name }}
* {{ mos-full-name }}
* {{ mpg-full-name }}
* {{ mrd-full-name }}

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Starter package {#starter-pricing}



{% include notitle [usd.md](../_pricing/security-deck/starter/usd.md) %}


### {{ atr-name }} {#atr-pricing}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|security_deck }}']}
    skuIds={['{{ pc|security_deck.access_transparency.subscription.v1 }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



### {{ dspm-full-name }} ({{ dspm-name }}) {#dspm-pricing}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|security_deck }}']}
    excludeSkuIds={['{{ pc|security_deck.access_transparency.subscription.v1 }}', '{{ pc|security_deck.kspm.nodes }}', '{{ pc|security_deck.cspm.resources }}', '{{ pc|security_deck.dspm.t1_5.subscription.monthly_usage.v1 }}', '{{ pc|security_deck.dspm.t11.subscription.monthly_usage.v1 }}', '{{ pc|security_deck.dspm.t3.subscription.monthly_usage.v1 }}', '{{ pc|security_deck.dspm.t5_5.subscription.monthly_usage.v1 }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


##### Cost calculation example {#amount-example}

Let’s assume you set up scanning a bucket with 50 text files, their overall size being 5 GB. All files were successfully scanned. The total cost per scan is:



{% include [usd-scan-by-amount](../_pricing_examples/security-deck/usd-scan-by-amount.md) %}


### {{ k8s }} Security Posture Management ({{ kspm-name }}) {#kspm-pricing}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|security_deck }}']}
    skuIds={['{{ pc|security_deck.kspm.nodes }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



### {{ cspm-name }} {#cspm-pricing}



<MDX>
  <PriceList
    serviceIds={['{{ pcs|security_deck }}']}
    skuIds={['{{ pc|security_deck.cspm.resources }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>


