---
editable: false
---

# {{ dataproc-name }} pricing



{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What is included in the {{ dataproc-name }} cost {#rules}

The total cost of using {{ dataproc-name }} includes:

* The cost of using the computing resources of {{ compute-full-name }} VMs to deploy hosts.
* Markup on using the computing resources of the {{ dataproc-name }} managed service.
* The cost of using the {{ compute-name }} network drives.
* The cost of using {{ cloud-logging-full-name }} to receive and store logs.
* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using computing resources {#rules-compute}

Charges are made as part of the {{ compute-name }} service per hour of host virtual machine time based on the [{{ compute-full-name }} computing resource pricing policy](../compute/pricing.md#prices) with a surcharge for using managed {{ dataproc-name }}.

For information about external IP address usage pricing, see [{#T}](../vpc/pricing.md) in the {{ vpc-full-name }} documentation.

### Disk space usage {#rules-storage}

The amount of storage requested for each cluster host is charged under {{ compute-name }} based on [disk space pricing](../compute/pricing.md#prices-storage).


### Using {{ cloud-logging-full-name }} {#rules-logs}

Receiving and storing logs is paid based on the {{ cloud-logging-full-name }} [pricing rules](../logging/pricing.md).



### Example of cost calculation {#price-example}

{% list tabs %}

- Standard hosts

   The cost for 1 hour of using a cluster that has two subclusters with the following parameters:

   * First subcluster:
      * **Master host**: `b2.medium` class, Intel Cascade Lake, 2 × 50% vCPU, 4 GB RAM.
      * **Master host storage**: 20 GB of `network-ssd`.

   * Second subcluster:
      * **Data storage host**: `s2.micro` class, Intel Cascade Lake, 2 × 100% vCPU, 8 GB RAM.
      * **Host storage**: 100 GB of `network-hdd`.

   The cost is calculated as follows:

   > 
   > ({{ sku|USD|compute.vm.cpu.50.v2|string }} + {{ sku|USD|mdb.dataproc.v2.cpu.c50|string }}) × 2 + ({{ sku|USD|compute.vm.ram.v2|string }} + {{ sku|USD|mdb.dataproc.v2.ram|string }}) × 4 + {{ sku|USD|nbs.network-nvme.allocated|string }} × 20 = $0.026288
   > 
   >
   > Total: $0.026288 is the cost of using the first subcluster per hour.

   Where:

   * {{ sku|USD|compute.vm.cpu.50.v2|string }} is the cost of using 50% vCPU per hour.
   * {{ sku|USD|mdb.dataproc.v2.cpu.c50|string }} is the {{ dataproc-name }} markup for using 50% vCPU.
   * 2 is the number of vCPUs per master host.
   * {{ sku|USD|compute.vm.ram.v2|string }} is the cost of using 1 GB of RAM per hour.
   * {{ sku|USD|mdb.dataproc.v2.ram|string }} is the {{ dataproc-name }} markup for using 1 GB of RAM.
   * 4 is the amount of RAM per master host (in GB).
   * {{ sku|USD|nbs.network-nvme.allocated|string }} is the cost of using 1 GB of `network-ssd` per hour.
   * 20 is the master host storage capacity (in GB).

   > 
   > ({{ sku|USD|compute.vm.cpu.c100.v2|string }} + {{ sku|USD|mdb.dataproc.v2.cpu.c100|string }}) × 2 + ({{ sku|USD|compute.vm.ram.v2|string }} + {{ sku|USD|mdb.dataproc.v2.ram|string }}) × 8 + {{ sku|USD|nbs.network-hdd.allocated|string }} × 100 = $0.046694
   > 
   >
   > Total: $0.046694 is the cost of using the second subcluster per hour.

   Where:

   * {{ sku|USD|compute.vm.cpu.c100.v2|string }} is the cost of using 100% vCPU per hour.
   * {{ sku|USD|mdb.dataproc.v2.cpu.c100|string }} is the {{ dataproc-name }} markup for using 100% vCPU.
   * 2 is the number of vCPUs per data storage host.
   * {{ sku|USD|compute.vm.ram.v2|string }} is the cost of using 1 GB of RAM per hour.
   * {{ sku|USD|mdb.dataproc.v2.ram|string }} is the {{ dataproc-name }} markup for using 1 GB of RAM.
   * 8 is the amount of RAM per data storage host (in GB).
   * {{ sku|USD|nbs.network-hdd.allocated|string }} is the cost of using 1 GB of `network-hdd` per hour.
   * 100 is the storage capacity per data storage host (in GB).

   > 
   > $0.026288 + $0.046694 = $0.072982
   > 
   >
   > Total: $0.072982 is the cost of using a cluster with two subclusters per hour.

   Where:

   * ₽3.2500 is the cost of using the first subcluster per hour.
   * ₽5.7500 is the cost of using the second subcluster per hour.

{% endlist %}


## {{ metastore-full-name }} cluster pricing

This functionality is at the [Preview](../overview/concepts/launch-stages.md) stage and is free of charge.

## Pricing {#prices}

### Host computing resources {#prices-hosts}





{% include [usd.md](../_pricing/data-proc/usd.md) %}



{% note info %}

To access GPUs on {{ dataproc-name }} hosts, please submit a request to [technical support]({{ link-console-support }}).

{% endnote %}

### Egress traffic {#prices-traffic}





{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}


