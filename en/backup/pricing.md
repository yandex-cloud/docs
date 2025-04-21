---
title: '{{ backup-full-name }} pricing policy'
description: This article provides the {{ backup-name }} pricing policy.
editable: false
---

# {{ backup-full-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## What goes into the cost of using {{ backup-name }} {#rules}

The cost of {{ backup-name }} depends on the number of resources to back up, such as {{ compute-full-name }} VMs and {{ baremetal-full-name }} servers, and the total storage space used by backups.

### Backing up resources {#vms}

In {{ backup-name }}, you start paying for a {{ compute-name }} instance or {{ baremetal-name }} server as soon as you link it to a [backup policy](./concepts/policy.md). Regardless of the resource status, you will be charged until you unlink it from the policy.

If you delete a VM in [{{ compute-full-name }}](../compute/) using the [management console]({{ link-console-main }}), this will also unlink such a VM from all policies. If you delete a VM using the CLI, {{ TF }}, or API, it will not be unlinked from policies automatically. You need to unlink it yourself.

If you need to unlink a {{ baremetal-name }} from a policy, you will still have to do it on your own.

The minimum billing unit is one resource (VM or {{ baremetal-name }} server) to back up, per hour.

### Using the storage {#backups}

You are charged for the total size of storage used by backups.

The minimum billing unit is 1 hour of storing 1 MB of data.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

If a secured resource is stopped or deleted, its backups are still stored in {{ backup-name }} and you continue to pay for their total size. The backup size depends on the following:
* VM disk usage or {{ baremetal-name }} server disk usage
* Amount of data updated during regular backups
* Data compression option

{% note info %}

To optimize your costs, consider removing the backups of the deleted VMs or the {{ baremetal-name }} servers you stopped renting.

{% endnote %}

The size of resource backups can fall short of the resource disk size, e.g., if the disk usage is low and the level of data compression is high, or exceed it, e.g., when there are many backups and their data is continuously modified and poorly compressed.

## Prices for the Russia region {#prices}



{% note warning %}

Starting May 1, 2025, the prices for {{ backup-full-name }} resources in the Russia region will increase. For new USD prices, see our [price list](https://yandex.cloud/en/price-list?installationCode=ru&currency=USD&services=dn21j2nquomme940r5rt).

{% endnote %}


{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

The monthly prices are based on 720 hours per month.

### Resources backed up with {{ backup-name }} {#prices-vms}



{% include [usd-vm-backups](../_pricing/backup/usd-vm-backups.md) %}


### Backup storage {#prices-backups}



{% include [usd-backup-size](../_pricing/backup/usd-backup-size.md) %}


## Cost calculation example {#price-example}

Here is an example of calculating the cost of {{ backup-name }} for one month for the following configuration:
* One VM is linked to backup policies.
* Total size of backups is 50 GB.



{% include [usd-backup](../_pricing_examples/backup/usd.md) %}


