---
editable: false
---

# Pricing for {{ dataproc-name }}

{% if product == "cloud-il" %}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ dataproc-name }} can be used free of charge.

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ dataproc-name }} {#rules}

The total cost of using {{ dataproc-name }} includes:

* The cost of using the computing resources of {{ compute-full-name }} VMs to deploy hosts.
* Markup on using the computing resources of the {{ dataproc-name }} managed service.
* The cost of using the {{ compute-name }} network drives.
{% if product == "yandex-cloud" %}
* The cost of using {{ cloud-logging-full-name }} to receive and store logs.
{% endif %}
* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using computing resources {#rules-compute}

Charges are made as part of the {{ compute-name }} service per hour of host virtual machine time based on the [{{ compute-full-name }} computing resource pricing policy](../compute/pricing.md#prices) with a surcharge for using managed {{ dataproc-name }}.

### Disk space usage {#rules-storage}

The amount of storage requested for each cluster host is charged under {{ compute-name }} based on [disk space pricing](../compute/pricing.md#prices-storage).

{% if product == "yandex-cloud" %}

### Using {{ cloud-logging-full-name }} {#rules-logs}

Receiving and storing logs is paid based on the {{ cloud-logging-full-name }} [pricing rules](../logging/pricing.md).

{% endif %}

{% if region == "ru"%}

{% if product == "yandex-cloud" %}

### Example of price calculation {#price-calculation-example}

{% list tabs %}

- Standard hosts

   You create a cluster with a subcluster that has a `b2.medium` master host (2 vCPUs, 50%, 4 GB RAM) with 20 GB of `network-ssd` storage, and a data storage subcluster that consists of a single `s2.micro` host (2 vCPUs, 100%, 8 GB RAM) with 100 GB of `network-hdd` storage.

   In this case, the cost per hour of using the cluster includes the following components:

   | Resource {{ compute-name }} | Cost | Surcharge for {{ dataproc-name }} | Amount | Total |
   |--------------------------------------------|------------------------------------------------:|----------------------------------------------:|-----------:|---------:|
   | **Computing resources on Intel Cascade Lake** |
   | 1 vCPU core with a guaranteed share of 50% | {{ sku|RUB|compute.vm.cpu.50.v2|string }} | {{ sku|RUB|mdb.dataproc.v2.cpu.c50|string }} | 2 | ₽1.5600 |
   | 1 vCPU core with a guaranteed share of 100% | {{sku|RUB|compute.vm.cpu.c100.v2|string }} | {{ sku|RUB|mdb.dataproc.v2.cpu.c100|string }} | 2 | ₽2.6200 |
   | 1 GB RAM | {{ sku|RUB|compute.vm.ram.v2|string }} | {{ sku|RUB|mdb.dataproc.v2.ram|string }} | 4 + 8 = 12 | ₽4.0800 |
   | **Compute Cloud disks** |
   | 1 GB of SSD storage | {{ sku|RUB|nbs.network-nvme.allocated|string }} | — | 20 | ₽0.3300 |
   | 1 GB of HDD storage | {{ sku|RUB|nbs.network-hdd.allocated|string }} | — | 100 | ₽0.4100 |
   | **Total** |                                                 |                                               |            | ₽9.0000 |

   As a result, the total price per hour will be ₽9.0000.

{% endlist %}

{% endif %}

{% endif %}

## Pricing {#prices}

### Host computing resources {#prices-hosts}

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

### Egress traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

{% endif %}
