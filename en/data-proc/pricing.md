---
editable: false
---
# Pricing for {{ dataproc-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ dataproc-name }} {#rules}

The total cost of using {{ dataproc-name }} includes:

* The cost of using the computing resources of {{ compute-full-name }} VMs to deploy hosts.
* Markup on using the computing resources of the {{ dataproc-name }} managed service.
* The cost of using the {{ compute-name }} network drives.
* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of computing resources {#rules-compute}

Cost is charged under the {{ compute-name }} service for each hour of running the host virtual machine based on the [pricing for {{ compute-name }} computing resources](../compute/pricing.md#prices), including markup for using the {{ dataproc-name }} managed service.

### Disk space usage {#rules-storage}

The amount of storage requested for each cluster hosts is charged under the {{ compute-name }} service according to the [disk space pricing policy](../compute/pricing.md#prices-storage).

### Example of price calculation {#price-calculation-example}

You create a cluster with a single Data subcluster. Host master: `s2.micro` (2 vCPU, 8GB RAM) with 15GB SSD storage, one host per subcluster: `s2.small` (4 vCPU, 16 GB RAM), with 100 GB HDD storage.

Resource usage prices:

* usage a single core of a interruptible VM on the Intel Cascade Lake platform with 100% vCPU — ₽0.2040 per hour.
* usage of 1 GB of RAM of the interrupted VM on the Intel Cascade Lake platform — ₽0.0492 per hour.
* usage of 1 GB of SSD storage — ₽7.4441 per month.
* usage of 1 GB of HDD storage — ₽2.0847 per month.

The cost per hour of using the cluster includes the following components:

* (2 + 4) ×  ₽0.2040 + (8 + 16) ×  ₽0.0492 = ₽2.4048 (forthe  {{ compute-name }} computing resources).
*  ₽2.4048 × 0.1 = ₽0.2405 (the markup for using {{ dataproc-name }}).
* (15 × ₽7.4441 + 100 ×  ₽2.0847) / 30 / 24 = ₽0.4447 (for using {{ compute-name }} disks).

Total price per hour: ₽2.4048 + ₽0.2405 + ₽0.4447 = ₽3.09 ₽

## Pricing {#prices}

### Cost of computing resources with markup {{ dataproc-name }} {#prices-compute}




{% include [usd.md](../_pricing/data-proc/usd.md) %}

{% note info %}

You can use GPUs on {{ dataproc-name }} hosts by submitting a request to [tech support](https://console.cloud.yandex.com/support).

{% endnote %}

### Egress {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}
