---
title: '{{ cloud-desktop-full-name }} pricing policy'
description: This article covers the {{ cloud-desktop-name }} pricing policy.
editable: false
---

# {{ cloud-desktop-full-name }} pricing policy


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


## What goes into the cost of using {{ cloud-desktop-name }} {#rules}

The {{ cloud-desktop-name }} usage cost includes:

* Computing resources:
  * Number of vCPUs
  * Amount of RAM
* Disk type and size
* Amount of outgoing traffic

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

The monthly prices are based on 720 hours per month.

### Using computing resources {#use-resources}

The cost of allocated computing resources is calculated based on how long the desktops were used: from when they get the `CREATING` (if being created) or `STARTING` (if starting) status until they are completely stopped. You are not charged for the time during which the desktops were stopped.

A desktop starts automatically once it is created.

### Using disks {#use-storage}

You are charged for disks whether the desktops are running or not.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Computing resources {#prices-desktop-resources}



{% include [usd-desktop-resources.md](../_pricing/cloud-desktop/usd-desktop-resources.md) %}


### Disks {#prices-storage}



{% include [usd-storage.md](../_pricing/cloud-desktop/usd-storage.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

## Cost calculation example {#price-example}

Here is an example of calculating the cost of using {{ cloud-desktop-name }} for one month, for a group of 10 desktops with the following configuration:

* Computing resources: 2 x 50% vCPUs and 2 GB of RAM.
* Boot disk: 50 GB SSD.
* Data disk: 30 GB HDD.
* Total operating time of all desktops over the month: 1,000 hours.



{% include [usd-cloud-desktop](../_pricing_examples/cloud-desktop/usd.md) %}


