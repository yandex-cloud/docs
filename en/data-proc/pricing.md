---
editable: false
---

# {{ dataproc-name }} pricing


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


## What goes into the cost of using {{ dataproc-name }} {#rules}

The total cost of using {{ dataproc-name }} includes:

* The cost of using the computing resources of {{ compute-full-name }} VMs to deploy hosts.
* Markup on computing resources for using the {{ dataproc-name }} managed service.
* Using the {{ compute-name }} network drives.
* Using {{ cloud-logging-full-name }} to collect and store logs.
* Amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using computing resources {#rules-compute}

Charges are made as part of the {{ compute-name }} service per hour of host virtual machine time based on the [{{ compute-full-name }} computing resource pricing policy](../compute/pricing.md#prices) with a surcharge for using managed {{ dataproc-name }}.

For information about external IP address usage pricing, see [{#T}](../vpc/pricing.md) in the {{ vpc-full-name }} documentation.

### Disk space usage {#rules-storage}

The amount of storage requested for each cluster host is charged under {{ compute-name }} based on [disk space pricing](../compute/pricing.md#prices-storage).

### Using {{ cloud-logging-full-name }} {#rules-logs}

You pay for receiving and storing your logs based on the {{ cloud-logging-full-name }} [pricing policy](../logging/pricing.md).

### Example of calculating the cost of standard hosts {#price-example}

Per-hour cost of using a cluster of two subclusters with the following parameters:

* First subcluster:
  * **Master host**: `b2.medium` class, Intel Cascade Lake, 2 × 50% vCPU, 4 GB RAM.
  * **Master host storage**: 20 GB of `network-ssd`.

* Second subcluster:
  * **Data storage host**: `s2.micro` class, Intel Cascade Lake, 2 × 100% vCPU, 8 GB RAM.
  * **Host storage**: 100 GB of `network-hdd`.

The cost is calculated as follows:



{% list tabs %}

- Standard hosts

  Per-hour cost of using a cluster of two subclusters with the following parameters:

  * First subcluster:
    * **Master host**: `b2.medium` class, Intel Cascade Lake, 2 × 50% vCPU, 4 GB RAM.
    * **Master host storage**: 20 GB of `network-ssd`.

  * Second subcluster:
    * **Data storage host**: `s2.micro` class, Intel Cascade Lake, 2 × 100% vCPU, 8 GB RAM.
    * **Host storage**: 100 GB of `network-hdd`.

  The cost is calculated as follows:

  > ({{ sku|USD|compute.vm.cpu.50.v2|string }} + {{ sku|USD|mdb.dataproc.v2.cpu.c50|string }}) × 2 + ({{ sku|USD|compute.vm.ram.v2|string }} + {{ sku|USD|mdb.dataproc.v2.ram|string }}) × 4 + {{ sku|USD|nbs.network-nvme.allocated|string }} × 20 = $0.026288
  >
  > Total: $0.026288, cost of using the first subcluster per hour.

  Where:

  * {{ sku|USD|compute.vm.cpu.50.v2|string }}: Cost of using 50% vCPU per hour.
  * {{ sku|USD|mdb.dataproc.v2.cpu.c50|string }}: {{ dataproc-name }} markup for using 50% vCPU.
  * 2 is the number of vCPUs per master host.
  * {{ sku|USD|compute.vm.ram.v2|string }}: Сost of using 1 GB of RAM per hour.
  * {{ sku|USD|mdb.dataproc.v2.ram|string }}: {{ dataproc-name }} markup for using 1 GB of RAM.
  * 4 is the amount of RAM per master host (in GB).
  * {{ sku|USD|nbs.network-nvme.allocated|string }}: Сost of using 1 GB of `network-ssd` per hour.
  * 20 is the master host storage capacity (in GB).

  > ({{ sku|USD|compute.vm.cpu.c100.v2|string }} + {{ sku|USD|mdb.dataproc.v2.cpu.c100|string }}) × 2 + ({{ sku|USD|compute.vm.ram.v2|string }} + {{ sku|USD|mdb.dataproc.v2.ram|string }}) × 8 + {{ sku|USD|nbs.network-hdd.allocated|string }} × 100 = $0.046694
  >
  > Total: $0.046694, cost of using the second subcluster per hour.

  Where:

  * {{ sku|USD|compute.vm.cpu.c100.v2|string }}: Cost of using 100% vCPU per hour.
  * {{ sku|USD|mdb.dataproc.v2.cpu.c100|string }}: {{ dataproc-name }} markup for using 100% vCPU.
  * 2 is the number of vCPUs per data storage host.
  * {{ sku|USD|compute.vm.ram.v2|string }}: Сost of using 1 GB of RAM per hour.
  * {{ sku|USD|mdb.dataproc.v2.ram|string }}: {{ dataproc-name }} markup for using 1 GB of RAM.
  * 8 is the amount of RAM per data storage host (in GB).
  * {{ sku|USD|nbs.network-hdd.allocated|string }}: Сost of using 1 GB of `network-hdd` per hour.
  * 100 is the storage capacity per data storage host (in GB).

  > $0.026288 + $0.046694 = $0.072982
  >
  > Total: $0.072982, cost of using a cluster with two subclusters per hour.

  Where:

  * $0.026288: Cost of using the first subcluster per hour.
  * $0.046694: Cost of using the second subcluster per hour.

{% endlist %}


## {{ metastore-full-name }} cluster pricing

This functionality is at the [Preview](../overview/concepts/launch-stages.md) stage and is free of charge.

## Prices for the Russia region {#prices}




All prices below do not include VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Host computing resources {#prices-hosts}

#### Standard hosts {#standard-hosts}



{% include [usd-standard-hosts](../_pricing/data-proc/usd-standard-hosts.md) %}


#### Dedicated hosts {#dedicated-hosts}

The usage cost includes two components: [the cost of {{ compute-full-name }} computing resources](../compute/pricing.md#prices-dedicated-host) and {{ dataproc-name }} markup for using these resources.



{% include [usd-dedicated-hosts(../_pricing/data-proc/usd-dedicated-hosts.md) %}


{% note info %}

To access GPUs on {{ dataproc-name }} hosts, please submit a request to [technical support]({{ link-console-support }}).

{% endnote %}

{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
