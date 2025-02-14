---
title: '{{ cloud-desktop-full-name }} pricing policy'
description: This article provides the {{ cloud-desktop-name }} pricing policy.
editable: false
---

# {{ cloud-desktop-full-name }} pricing policy



{% note warning %}

These prices apply starting February 25, 2025.

{% endnote %}

## What goes into the cost of using {{ sws-name }} {#rules}

The {{ cloud-desktop-name }} usage cost is based on:
* Desktop computing resources:
  * Number of cores (vCPUs).
  * Amount of RAM.
* Type and size of storage.
* Amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

The monthly prices are based on 720 hours per month.

### Computing resources usage {#use-resources}

The cost of a desktop depends on the allocated computing resources and usage time. Attached disks and network usage are charged separately.

The cost is calculated for the time of using the desktop, when the status switches to `CREATING` (during creation) or `STARTING` (during startup) until it is completely stopped. The time when the desktop is stopped is not charged.

The desktop starts automatically once it is created.

### Storage usage {#use-storage}

Disks are charged for whether desktops are running or not.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Computing resources {#prices-desktop-resources}



{% include [usd-nfs.md](../_pricing/cloud-desktop/usd-desktop-resources.md) %}


### Disks and images {#prices-storage}



{% include [usd-nfs.md](../_pricing/cloud-desktop/usd-storage.md) %}


{% endlist %}

{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
