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
* The cost of using {{ cloud-logging-full-name }} to receive and store logs.
* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using computing resources {#rules-compute}

Charges are made as part of the {{ compute-name }} service per hour of host virtual machine time based on the [{{ compute-full-name }} computing resource pricing policy](../compute/pricing.md#prices) with a surcharge for using managed {{ dataproc-name }}.

### Disk space usage {#rules-storage}

The amount of storage requested for each cluster host is charged under {{ compute-name }} based on [disk space pricing](../compute/pricing.md#prices-storage).


### Using {{ cloud-logging-full-name }} {#rules-logs}

Receiving and storing logs is paid based on the {{ cloud-logging-full-name }} [pricing rules](../logging/pricing.md).



## Pricing {#prices}

### Host computing resources {#prices-hosts}




{% include [usd.md](../_pricing/data-proc/usd.md) %}


{% note info %}

To access GPUs on {{ dataproc-name }} hosts, please submit a request to [technical support]({{ link-console-support }}).

{% endnote %}

### Egress traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}


