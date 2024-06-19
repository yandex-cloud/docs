---
title: "{{ at-full-name }} pricing policy"
description: "This article describes the {{ at-name }} pricing policy."
editable: false
---

# {{ at-full-name }} pricing

Delivered [data events](./concepts/events-data-plane.md) are billed.

[Management events](./concepts/events.md) are currently not billed.


## Prices for Russia {#prices}



{% include [usd](../_pricing/audit-trails/usd.md) %}





### Pricing formula {#price-formula}

The cost of delivered data events is calculated in proportion to their number.

For example, delivering 17,000 data events will cost:



> (17,000 / 100,000) × $0.288 = 0.17 × $0.288 = $0.05
> 
> Total: $0.05




### Examples of cost calculation {#price-example}

##### Example 1

  Calculation of the cost of delivering the events of receiving the contents of a {{ lockbox-full-name }} secret encrypted with the {{ kms-full-name }} encryption key:
  * Each time a secret is accessed, two events are delivered: the event of [accessing](./concepts/events-data-plane.md#lockbox) the {{ lockbox-short-name }} secret contents and the event of [decrypting](./concepts/events-data-plane.md#kms) the secret contents using the {{ kms-short-name }} key.
  * Number of times the secret is accessed: 7,000.


   
 
  The cost is calculated as follows:

  > (2 × 7,000 / 100,000) × $0.288 = 0.14 × $0.288 = $0.04
  >
  > Total: $0.04

  Where:
   
  * 2: Number of events delivered per a single access to a secret.
  * 7,000: Number of times the secret is accessed.
  * 0.288: Price for delivering 100,000 events.
  * 100,000: Divide to reduce the number of events to a billing unit.


##### Example 2

  Calculating the cost of delivering events when using {{ objstorage-full-name }} buckets.

  Total number of delivered events: 25,000. Out of which:
  * Number of [management](./concepts/events.md#objstorage) events transferred when using buckets: 1,000.
     This includes the events of creating and deleting buckets, changing access policies, ACL and encryption settings.

  * Number of [data](./concepts/events-data-plane.md#objstorage) events transferred when using buckets: 24,000.
     This includes the events of creating objects in buckets and changing object tags.


   
 
  The cost is calculated as follows:
  
  > ((25,000 - 1,000) / 100,000) × $0.288 = 0.24 × $0.288 = $0.07
  >
  > Total: $0.07

  Where:

  * 25,000: Total number of delivered {{ objstorage-name }} events.
  * 1,000: Number of delivered management events that are not billed.
  * 0.288: Price for delivering 100,000 events.
  * 100,000: Divide to reduce the number of events to a billing unit.


