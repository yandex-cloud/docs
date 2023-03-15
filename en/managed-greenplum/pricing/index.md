---
editable: false
---

# Pricing for {{ mgp-name }}

{% include [currency-choice](../../_includes/pricing/currency-choice.md) %}

{% include [pricing-status](../../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning](../../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mgp-short-name }} {#rules}

The {{ mgp-name }} usage cost is based on:

* Disk type and storage size.
* Computing resources allocated to cluster hosts and host type.
* Settings and number of backups.
* Egress traffic from {{ yandex-cloud }}.

{% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

### Using cluster hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are shown in [{#T}](../concepts/instance-types.md) while prices for using vCPUs and RAM are quoted in the [Prices](#prices) section.

There are different ways to calculate the cost depending on the [host type](../concepts/):

* Standard hosts

   The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources.

{% if product == "yandex-cloud" %}

* Dedicated hosts

   The usage cost includes two components: [the cost of {{ compute-full-name }} computing resources](../../compute/pricing.md#prices) and {{ mgp-name }} markup for using these resources.

{% endif %}

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for time when the {{ GP }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for clusters.

   * You can only order local SSD storage (`local-ssd`) for clusters with two master hosts:
      {% if product == "yandex-cloud" %}* For Intel Cascade Lake: In 100 GB increments.{% endif %}
      * For Intel Ice Lake: In {{ local-ssd-v3-step }} increments.
   * You can only order storage on non-replicated SSDs (`network-ssd-nonreplicated`) in 93 GB increments for clusters with two master hosts.

* Space used by DB backups in excess of the storage amount specified for the cluster.

   * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

   * During an automatic backup, {{ mgp-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

   * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use and is based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

{% if audience == "cvos" %}

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../../_includes/mdb/cvos.md) %}

{{mgp-name}} provides two types of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}

{% endif %}

### Example of cluster cost calculation {#example}

The cost of using a cluster with the following parameters for 30 days:

* **Standard hosts**: 3 `s3-c8-m32` hosts: Intel Ice Lake, 8 × 100% vCPU, 32 GB RAM.
* **Storage for standard hosts**: 100 GB of HDD network storage.
* **Dedicated hosts**: 3 `s2.medium` hosts: Intel Cascade Lake, 8 × 100% vCPU, 32 GB RAM.
* **Storage for dedicated hosts**: 50 GB of local SSD storage.

Cost calculation for standard hosts:

> {% if region == "ru" %}3 × (8×₽2.1500 + 32×₽0.5700) = ₽106.3200{% endif %}
> {% if region == "int" %}3 × (8×$0.017231 + 32×$0.004564) = $0.851688{% endif %}
> {% if region == "kz" %}3 × (8×₸10.7500 + 32×₸2.8500) = ₸531.6000{% endif %}
>
> Total: {% if region == "ru" %}₽106.3200{% endif %}{% if region == "int" %}$0.851688{% endif %}{% if region == "kz" %}₸531.6000{% endif %} is the cost per hour of standard host operation.

Where:
* 3: Number of standard hosts.
* 8: Number of vCPUs.
* {% if region == "ru" %}₽2.1500{% endif %}{% if region == "int" %}$0.017231{% endif %}{% if region == "kz" %}₸10.7500{% endif %}: Cost of using 100% vCPU per hour.
* 32: Amount of RAM per standard host (in GB).
* {% if region == "ru" %}₽0.5700{% endif %}{% if region == "int" %}$0.004564{% endif %}{% if region == "kz" %}₸2.8500{% endif %}: Cost of using 1GB of RAM on 100% vCPU per hour.

Cost calculation for dedicated hosts:

> {% if region == "ru" %}3 × (8×₽1.2000 + 32×₽0.3100) = ₽58.5600{% endif %}
> {% if region == "int" %}3 × (8×$0.009595 + 32×$0.002538) = $0.473928{% endif %}
> {% if region == "kz" %}3 × (8×₸6.0000 + 32×₸1.5500) = ₸292.8000{% endif %}
>
> Total: {% if region == "ru" %}₽58.5600{% endif %}{% if region == "int" %}$0.473928{% endif %}{% if region == "kz" %}₸292.8000{% endif %} is the cost per hour of dedicated host operation.

Where:
* 3: Number of dedicated hosts.
* 8: Number of vCPUs.
* {% if region == "ru" %}₽1.2000{% endif %}{% if region == "int" %}$0.009595{% endif %}{% if region == "kz" %}₸6.0000{% endif %}: Cost of using 100% vCPU per hour.
* 32: Amount of RAM per dedicated host (in GB).
* {% if region == "ru" %}₽0.3100{% endif %}{% if region == "int" %}$0.002538{% endif %}{% if region == "kz" %}₸1.5500{% endif %}: Cost of using 1GB of RAM on 100% vCPU per hour.

Calculation for the storage cost and total cost:

> {% if region == "ru" %}(720 × ₽106.3200 + 100 × ₽3.2000) + (720 × ₽58.5600 + 50 × ₽13.0100) = ₽119684.1000{% endif %}
> {% if region == "kz" %}(720 × ₸531.6000 + 100 × ₸16.0000) + (720 × ₸292.8000 + 50 × ₸65.0500) = ₸598420.5000{% endif %}
> {% if region == "int" %}(720 × $0.851688 + 100 × $0.104080) + (720 × $0.473928 + 50 × $0.104080) = $970.0555{% endif %}
>
> Total: {% if region == "ru" %}₽119684.1000{% endif %}{% if region == "kz" %}₸598420.5000{% endif %}{% if region == "int" %}$970.0555{% endif %} is the cost of using the cluster for 30 days.

Where:
* 720: Number of hours in 30 days.
* {% if region == "ru" %}₽106.3200{% endif %}{% if region == "kz" %}₸531.6000{% endif %}{% if region == "int" %}$0.851688{% endif %}: Cost per hour of standard host operation.
* 100: Amount of HDD network storage (in GB) for standard hosts.
* {% if region == "ru" %}₽3.2000{% endif %}{% if region == "kz" %}₸16.0000{% endif %}{% if region == "int" %}$0.104080{% endif %}: Cost of using 1 GB of network HDD storage per month.
* {% if region == "ru" %}₽58.5600{% endif %}{% if region == "kz" %}₸292.8000{% endif %}{% if region == "int" %}$0.473928{% endif %}: Cost per hour of dedicated host operation.
* 50: Amount of local SSD storage (in GB) for dedicated hosts.
* {% if region == "ru" %}₽13.0100{% endif %}{% if region == "kz" %}₸65.0500{% endif %}{% if region == "int" %}$0.104080{% endif %}: Cost of using 1 GB of local SSD storage per month.

## Pricing {#prices}

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

{% endif %}

Prices for hosts are [calculated in different ways](#rules-hosts-uptime) depending on the selected host type.

The cost of storage on local SSDs (`local-ssd`) also depends on the host type.

{% include [pricing-month-term](../../_includes/mdb/pricing-month-term.md) %}

### Host computing resources {#prices-hosts}

{% list tabs %}

- Standard hosts

   The cost is calculated differently depending on the [host configuration](../concepts/instance-types.md):

   * For hosts i2 and i3 (`io-optimized`), the cost is made up of the price for {{ mgp-name }} host computing resources (see the table below) and [the price for software-accelerated network use](../../compute/pricing.md#software-accelerated-network).
   * For hosts with other configurations, you only pay for their computing resources:

   {% if region == "ru" %} {% include notitle [RUB: standard hosts](../../_pricing/managed-greenplum/rub-hosts-standard.md) %}{% endif %}
   {% if region == "kz" %} {% include notitle [KZT: standard hosts](../../_pricing/managed-greenplum/kzt-hosts-standard.md) %}{% endif %}
   {% if region == "int" %} {% include notitle [USD: standard hosts](../../_pricing/managed-greenplum/usd-hosts-standard.md) %}{% endif %}

{% if product == "yandex-cloud" %}

- Dedicated hosts

   The usage cost includes two components: [the cost of {{ compute-full-name }} computing resources](../../compute/pricing.md#prices) and {{ mgp-name }} markup for using these resources.

   {% if region == "ru" %} {% include notitle [RUB: dedicated hosts](../../_pricing/managed-greenplum/rub-hosts-dedicated.md) %}{% endif %}
   {% if region == "kz" %} {% include notitle [KZT: dedicated hosts](../../_pricing/managed-greenplum/kzt-hosts-dedicated.md) %}{% endif %}
   {% if region == "int" %} {% include notitle [USD: dedicated hosts](../../_pricing/managed-greenplum/usd-hosts-dedicated.md) %}{% endif %}

{% endif %}

{% endlist %}

### Storage and backups {#prices-storage}

{% list tabs %}

- Standard hosts

   {% include [local-ssd for Intel Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

   {% if region == "ru" %}{% include notitle [rub-storage-standard.md](../../_pricing/managed-greenplum/rub-storage-standard.md) %}{% endif %}
   {% if region == "kz" %}{% include notitle [kzt-storage-standard.md](../../_pricing/managed-greenplum/kzt-storage-standard.md) %}{% endif %}
   {% if region == "int" %}{% include notitle [usd-storage-standard.md](../../_pricing/managed-greenplum/usd-storage-standard.md) %}{% endif %}

{% if product == "yandex-cloud" %}

- Dedicated hosts

   The cost is made up of two components: the [{{ compute-full-name }} storage cost](../../compute/pricing.md#prices) and the {{ mgp-name }} price for it. All prices are shown per 1 GB per month.

   {% if region == "ru" %}{% include notitle [rub-storage-dedicated.md](../../_pricing/managed-greenplum/rub-storage-dedicated.md) %}{% endif %}
   {% if region == "kz" %}{% include notitle [kzt-storage-dedicated.md](../../_pricing/managed-greenplum/kzt-storage-dedicated.md) %}{% endif %}
   {% if region == "int" %}{% include notitle [usd-storage-dedicated.md](../../_pricing/managed-greenplum/usd-storage-dedicated.md) %}{% endif %}

{% endif %}

{% endlist %}

Pricing for backup storage has the following specifics:

* Backups are stored free of charge as long as the combined size of the database and all backups is less than the total storage size.

* [Adding a segment host](../operations/hosts/cluster-expand.md#add-hosts) increases the total cost per cluster. However, expenses for storing backups beyond the storage size will decrease because the total storage will expand.

* {% include [backup-wal](../../_includes/mdb/mgp/backup-wal.md) %}

### Egress traffic {#prices-traffic}

{% if region == "ru" %} {% include notitle [rub-egress-traffic.md](../../_pricing/rub-egress-traffic.md) %} {% endif %}
{% if region == "kz" %} {% include notitle [kzt-egress-traffic.md](../../_pricing/kzt-egress-traffic.md) %} {% endif %}
{% if region == "int" %} {% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %} {% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
