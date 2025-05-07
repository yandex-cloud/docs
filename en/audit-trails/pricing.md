---
title: '{{ at-full-name }} pricing policy'
description: This article provides the {{ at-name }} pricing policy.
editable: false
---

# {{ at-full-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

Delivered [data events](./concepts/events-data-plane.md) are billed.

[Management events](./concepts/events.md) are currently not billed.


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



{% include [usd](../_pricing/audit-trails/usd.md) %}




### Pricing formula {#price-formula}

The cost of delivered data events is calculated in proportion to their number.

For example, delivering 17,000 data events will cost:






{% include [usd-formula](../_pricing_examples/audit-trails/usd-formula.md) %}


### Examples of cost calculation {#price-example}

##### Example 1

  Calculation of the cost of delivering the events of receiving the contents of a {{ lockbox-full-name }} secret encrypted with the {{ kms-full-name }} encryption key:
  * Each time a secret is accessed, two events are delivered: the event of [accessing](./concepts/events-data-plane.md#lockbox) the {{ lockbox-short-name }} secret contents and the event of [decrypting](./concepts/events-data-plane.md#kms) the secret contents using the {{ kms-short-name }} key.
  * Number of times the secret is accessed: 7,000.





  
  {% include [usd-lockbox](../_pricing_examples/audit-trails/usd-lockbox.md) %}


##### Example 2

  Calculating the cost of delivering events when using {{ objstorage-full-name }} buckets.

  Total number of delivered events: 25,000. Out of which:
  * Number of [management](./concepts/events.md#objstorage) events transmitted when using buckets: 1,000.
      This includes the events of creating and deleting buckets, changing access policies, ACL and encryption settings.

  * Number of [data](./concepts/events-data-plane.md#objstorage) events transmitted when using buckets: 24,000.
      This includes the events of creating objects in buckets and changing object tags.





  
  {% include [usd-storage](../_pricing_examples/audit-trails/usd-storage.md) %}
