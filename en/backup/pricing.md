---
editable: false
---

# {{ backup-full-name }} pricing

To calculate the cost of using {{ backup-name }}, see the prices on this page.

## What goes into the cost of using {{ backup-name }} {#rules}

The cost of {{ backup-name }} depends on the number of protected VMs and the total size of storage used by backups.

### VM protection {#vms}

You start paying for a VM in {{ backup-name }} as soon as you link it to a [backup policy](./concepts/policy.md). Regardless of the VM status, you will be charged for the VM until you unlink it from the policy.

If you delete a VM in [{{ compute-full-name }}](../compute/) using the [management console]({{ link-console-main }}), the VM will be unlinked from all policies. If you delete a VM using the CLI, {{ TF }}, or API, it will not be unlinked from policies automatically. You need to unlink it yourself.

The minimum billing unit is 1 VM per hour.

### Using storage {#backups}

You are charged for the total size of storage used by backups.

The minimum billing unit is 1 hour of storing 1 MB of data.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

If a VM is stopped or deleted, its backups are still stored in {{ backup-name }} and you continue to pay for their volume stored. The backup size depends on the following:
* VM disk usage
* Amount of data updated during regular backups
* Data compression option

{% note info %}

To pay less, delete the backups of the deleted VMs that you no longer need.

{% endnote %}

The size of VM backups can fall short of the VM disk size, e.g., if the VM disk usage is low and the level of data compression is high, or exceed it, e.g., when there are many backups and their data is continuously modified and poorly compressed.

## Pricing {#prices}

The monthly usage rate is based on 720 hours per month.

### Protected {{ backup-name }} VMs {#prices-vms}





{% include [usd-vm-backups](../_pricing/backup/usd-vm-backups.md) %}



### Backup storage {#prices-backups}





{% include [usd-backup-size](../_pricing/backup/usd-backup-size.md) %}



## Cost calculation example {#price-example}

Here is an example of calculating the cost of {{ backup-name }} for one month for the following configuration:
* One VM is linked to backup policies.
* Total size of backups is 50 GB.




> 1 VM × $1.910400 + 50 GB × $0.033600 = $3.590400

> $3.590400 is the cost of using {{ backup-name }} to protect one VM with the total size of backups amounting to 50 GB per month, without VAT.

Where:
* 1: Number of VMs linked to backup policies.
* $1.910400: Cost of connecting 1 VM to {{ backup-name }} per month, without VAT.
* 50 GB: Total size of backups.
* $0.033600: Cost of storing 1 GB of backups per month, without VAT.
