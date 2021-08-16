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


## Pricing {#prices}

### Cost of computing resources with markup {{ dataproc-name }} {#prices-compute}




{% include [usd.md](../_pricing/data-proc/usd.md) %}

{% note info %}

You can use GPUs on {{ dataproc-name }} hosts by submitting a request to [tech support](https://console.cloud.yandex.com/support).

{% endnote %}

### Egress {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}
