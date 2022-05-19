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
* Using {{ cloud-logging-full-name }} to receive and store logs.
* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using computing resources {#rules-compute}

Charges are made as part of the {{ compute-name }} service per hour of host virtual machine time based on the [{{ compute-full-name }} computing resource pricing policy](../compute/pricing.md#prices) with a surcharge for using managed {{ dataproc-name }}.

### Disk space usage {#rules-storage}

The amount of storage requested for each cluster host is charged under {{ compute-name }} based on [disk space pricing](../compute/pricing.md#prices-storage).

### Using {{ cloud-logging-full-name }} {#rules-logs}

Receiving and storing logs is paid based on the {{ cloud-logging-full-name }} [pricing rules](../logging/pricing.md).

{% if region == "ru" %}

### Example of price calculation {#price-calculation-example}

{% list tabs %}

- Standard hosts

    You create a cluster with a single Data subcluster. Host master: `s2.micro` (2 vCPU, 8 GB RAM) with 15 GB SSD storage, one host per subcluster: `s2.small` (4 vCPU, 16 GB RAM), with 100 GB HDD storage.

    Prices for use of resources:

    * Using one core of a preemptible VM run on Intel Cascade Lake with 100% vCPU costs ₽0.2040 per hour.
    * Using of 1 GB RAM of a preemptible VM on Intel Cascade Lake costs ₽0.0492 per hour.
    * Using 1 GB of SSD memory costs ₽7.4441 per month.
    * Using 1 GB of HDD memory costs ₽2.0847 per month.

    In this case, the cost per hour of using the cluster includes the following components:

    * (2 + 4) × ₽0.2040 + (8 + 16) × ₽0.0492 = ₽2.4048 (for the {{ compute-name }} computing resources).
    * ₽2.4048 × 0.1 = ₽0.2405 (the markup for using {{ dataproc-name }}).
    * (15 × ₽7.4441 + 100 × ₽2.0847) / 30 / 24 = ₽0.4447 (for using {{ compute-name }} disks).

    Total price per hour: ₽2.4048 + ₽0.2405 + ₽0.4447 = ₽3.09

{% endlist %}

{% endif %}

## Pricing {#prices}

### Cost of computing resources with markup {{ dataproc-name }} {#prices-compute}

{% if region == "ru" %}

{% include [rub.md](../_pricing/data-proc/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/data-proc/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/data-proc/usd.md) %}

{% endif %}

{% note info %}

To access GPUs on {{ dataproc-name }} hosts, please submit a request to [technical support]({{ link-console-support }}).

{% endnote %}

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}
