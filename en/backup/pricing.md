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

The cost of {{ backup-name }} depends on the number of target resource units, i.e., VMs and servers, and the total storage space used for their backups.

### Resource unit backup {#vms}

In {{ backup-name }}, you start paying for a [resource](./concepts/index.md#protected-resources) as soon as you link it to a [backup policy](./concepts/policy.md). Regardless of the resource status, you will be charged for the resource until you unlink it from the policy.

If you delete a VM in [{{ compute-full-name }}](../compute/index.yaml) using the [management console]({{ link-console-main }}), the system automatically unlinks such a VM from all policies. If you delete a VM using the CLI, {{ TF }}, or API, you will have to manually unlink it from policies.

If you need to [unlink](./operations/policy-vm/detach-vm.md) a {{ baremetal-name }} server or an [external resource](./concepts/vm-connection/external-resources.md) from a policy, you will still have to do it on your own.

The minimum billing unit is one [resource unit](./concepts/index.md#protected-resources) per hour.

### Using the storage {#backups}

You pay for the total storage space consumed by backups.

The minimum billing unit is 1 hour of storing 1 MB of data.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

If a backed up resource unit is stopped or deleted, {{ backup-name }} continues to store its backups, and you continue to pay based on their size. Such backup size depends on the following:
* Used disk space of the resource to back up.
* Amount of data changes during regular backups.
* Data compression option.

{% note info %}

To optimize your costs, consider removing the backups of the deleted [resources](./concepts/index.md#protected-resources) you stopped renting.

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

