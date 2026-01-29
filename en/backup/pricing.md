---
title: '{{ backup-full-name }} pricing policy'
description: This article covers the {{ backup-name }} pricing policy.
editable: false
---

# {{ backup-full-name }} pricing policy


{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ backup-name }} {#rules}

The cost of {{ backup-name }} depends on the number of backed up resource units, i.e., {{ compute-full-name }} VMs and {{ baremetal-full-name }} servers, and the total storage space used for backups.

### Resource unit backup {#vms}

In {{ backup-name }}, you start paying for a {{ compute-name }} instance or {{ baremetal-name }} server as soon as you link it to a [backup policy](./concepts/policy.md). You continue to pay until you unlink the resource unit from the policy, whichever status it is in.

If you delete a VM in [{{ compute-full-name }}](../compute/) using the [management console]({{ link-console-main }}), this will also unlink such a VM from all policies. If you delete a VM using the CLI, {{ TF }}, or API, it will not be unlinked from the policies automatically, so you will have to do it yourself.

If you need to unlink a {{ baremetal-name }} server from a policy, you will still have to do it on your own.

The minimum billing unit is one backed up resource unit (VM or {{ baremetal-name }} server) per hour.

### Using the storage {#backups}

You are charged for the total size of storage used by backups.

The minimum billing unit is 1 hour of storing 1 MB of data.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

If a backed up resource unit is stopped or deleted, {{ backup-name }} continues to store its backups, and you continue to pay based on their size. Such backup size depends on the following:
* VM disk usage or {{ baremetal-name }} server disk usage.
* Amount of data changes during regular backups.
* Data compression option.

{% note info %}

To optimize your costs, consider removing the backups of the deleted VMs or the {{ baremetal-name }} servers you stopped renting.

{% endnote %}

It is equally likely that backups may be smaller in size than the resource unit's actual disk, e.g., if the disk has a lot of unused space and the data is well compressed, or exceed its size, e.g., when there are many backups and their data is constantly modified and poorly compressed.



## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}




<MDX>
  <PriceList
    serviceIds={['{{ pcs|cloud_backup }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



## Cost calculation example {#price-example}

Let’s calculate the cost of {{ backup-name }} for one month for the following configuration:
* One VM is linked to backup policies.
* Total size of backups is 50 GB.




{% include [usd-backup](../_pricing_examples/backup/usd.md) %}

