---
editable: false
---

# Pricing for {{ mms-name }}

## Cluster status {#running-stopped}

Prices are applied differently depending on the cluster status:

* `Running` cluster: You pay for software licenses, computing resources, storage, and backups.
* `Stopped` cluster: You're charged for storage and backups in full, but pricing for software licenses is described in [{#T}](#license). Computing resources are free of charge.

   {% note alert %}

   If a cluster uses local storage (`local-ssd`), its computing resources are not released when it's stopped and are charged in full.

   {% endnote %}

## What goes into the cost of using {{ mms-short-name }} {#rules}

The {{ mms-name }} usage cost is based on:

* The cost of licenses for Windows Server Datacenter and Microsoft SQL Server.

{% include [pricing-rules](../../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../../_includes/pricing-gb-size.md) %}

### Using software licenses {#license}

You're charged for using licenses on an pre-payment basis. This means that a fee is charged at the beginning of a billing period before you actually start using the service resources. In this case:

* The billing period is one calendar month.
* If you create a new cluster or restore a cluster from a backup during a billing period, or launch an existing cluster for the first time since the period start, you need to pay the full license cost for the entire billing period.

   > For example, if you launch a cluster on March 15 for the first time since the beginning of the month, the license cost for all of March is charged. The next payment is charged April 1 for all of April.

* If you stop or delete your cluster during the billing period, license costs for this period are not refunded.
* If you change a cluster configuration and reduce resource usage during a billing period, the cost of the licenses released in this period is not subject to refund. The new pricing will take effect on the first day of the following billing period.
* If you change your cluster configuration and increase resource usage during a billing period, you will need additional licenses. If this is the case, you will be charged the full cost of these licenses for the entire billing period regardless of the date you made the changes.
* Multi-host {{ MS }} clusters with [non-readable secondary replicas](../concepts/replication.md#readable-and-non-readable-replicas) only require a Microsoft SQL Server Enterprise license for the primary replica.
* Multi-host {{ MS }} clusters with [readable secondary replicas](../concepts/replication.md#readable-and-non-readable-replicas) require a Microsoft SQL Server Enterprise license for each replica.

### DB host usage {#rules-hosts-uptime}

The cost of using DB hosts is calculated according to their class. Exact class characteristics are given in [{#T}](../concepts/instance-types.md). The host usage fee is charged in accordance with the agreement.

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for the time when the DB host is not performing its main functions.

### Disk space usage {#rules-storage}

The disk space usage fee is charged in accordance with the agreement. The following is charged:

* Storage allocated for DB clusters.

   * You can only order fast local storage (`local-ssd`) for clusters with three or more hosts:
      {% if product == "yandex-cloud" %}* For Intel Broadwell and Intel Cascade Lake in 100 GB increments.{% endif %}
      * For Intel Ice Lake: In {{ local-ssd-v3-step }} increments.

   * Storage on non-replicated network drives (`network-ssd-nonreplicated`) can only be ordered for clusters with three or more hosts in 93 GB increments.

* Space used by DB backups in excess of the storage amount specified for the cluster.

   * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

   * During an automatic backup, {{ mms-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

   * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

## Pricing {#prices}

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

{% endif %}

{% if region == "ru"%}

{% include [rub-pricing.md](../../_pricing/managed-sqlserver/rub-pricing.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-pricing.md](../../_pricing/managed-sqlserver/kzt-pricing.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-pricing.md](../../_pricing/managed-sqlserver/usd-pricing.md) %}

{% endif %}

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}

{% endif %}

{% if region == "ru"%}

## Example cluster cost calculations {#examples}

### Cluster cost calculation without configuration changes {#example-simple}

For example, you created a cluster:

* With 3 standard `s3-c4-m16` class {{ MS }} hosts (Intel Ice Lake, 4 vCPUs, 16 GB RAM).
* With any {{ MS }} version, Enterprise Edition.
* With 100 GB of storage on network HDDs (`network-hdd`).

Cost of using resources:

* 1 billing period of using a Windows Server Datacenter license on 1 vCPU: ₽1202.40.
* 1 billing period of using a Microsoft SQL Server Enterprise license on 1 vCPU: ₽23227.35.
* 1 hour of using a core on an Ice Lake class {{ MS }} host with 100% vCPU: ₽1.0800.
* 1 hour of using 1 GB of RAM on an Ice Lake class {{ MS }} host: ₽0.2880.
* 1 month of using 1 GB of HDD network storage (`network-hdd`): ₽2.2881.

Depending on the [secondary replica type](../concepts/replication.md#readable-and-non-readable-replicas) used, the total cost of a cluster in a billing period may vary. A billing period is assumed to include 720 hours (30 days).

{% list tabs %}

- With non-readable secondary replicas

   * Software licenses:

      * The cost of Windows Server Datacenter licenses is debited for each cluster host. Total:

         `3 hosts × (4 vCPUs × ₽1202.40) = ₽14428.80` per billing period.

      * The cost of Microsoft SQL Server licenses is debited for a single cluster host (primary replica). Total:

         `1 host × (4 vCPUs × ₽23227.35) = ₽92909.4` per billing period.

      Total license cost: `₽14428.80 + ₽92909.40 = ₽107338.20`

   * Host computing resources:

      Hourly cost for three hosts:

      `3 hosts × (4 vCPUs × ₽1.0800 + 16 GB RAM × ₽0.2880) = ₽26.7840`

      Total cost of computing resources: `720 hours × ₽26.7840 = ₽19284.48` per billing period.

   * Storage (not including backups):

      Total cost of storage for thee hosts: `3 hosts × 100 GB × ₽2.2881 = ₽686.43` per billing period.

   Total cluster cost: `₽107338.20 + ₽19284.48 + ₽686.43 = ₽127309.11`

- With readable secondary replicas

   * Software licenses:

      * The cost of Windows Server Datacenter licenses is debited for each cluster host. Total:

         `3 hosts × (4 vCPUs × ₽1202.40) = ₽14428.80` per billing period.

      * The cost of Microsoft SQL Server licenses is debited for each cluster host. Total:

         `3 hosts × (4 vCPUs × ₽23227.35) = ₽278728.20` per billing period.

      Total license cost: `₽14428.80 + ₽278728.20 = ₽293157.00`

   * Host computing resources:

      Hourly cost for three hosts:

      `3 hosts × (4 vCPUs × ₽1.0800 + 16 GB RAM × ₽0.2880) = ₽26.7840`

      Total cost of computing resources: `720 hours × ₽26.7840 = ₽19284.48` per billing period.

   * Storage (not including backups):

      Total cost of storage for thee hosts: `3 hosts × 100 GB × ₽2.2881 = ₽686.43` per billing period.

   Total cluster cost: `₽293157.00 + ₽19284.48 + ₽686.43 = ₽313127.91`

{% endlist %}

### Cluster cost calculation with configuration changes {#example-difficult}

For instance, on March 10 (in this example and hereafter, we assume for simplicity's sake that updates occur at 00:00 UTC+3), you create a cluster:

* With 3 standard `s3-c4-m16` class {{ MS }} hosts (Intel Ice Lake, 4 vCPUs, 16 GB RAM).
* With any {{ MS }} version, Enterprise Edition.
* With 100 GB of storage on network HDDs (`network-hdd`).

On March 15 you decided to upgrade your cluster host class to `s3-c12-m48` (Intel Ice Lake, 12 vCPUs, 48 GB RAM). On March 25 you shut the cluster down, and on March 30 you deleted it entirely.

Cost of using resources:

* 1 billing period for a Windows Server Datacenter license on 1 vCPU: ₽1202.40.
* 1 billing period for a Microsoft SQL Server Enterprise license on 1 vCPU: ₽23227.35.
* 1 hour core use on an Ice Lake class {{ MS }} host with 100% vCPU: ₽1.0800.
* 1 hour of 1 GB of RAM use on an Ice Lake class {{ MS }} host: ₽0.2880.
* 1 month of using 1 GB of HDD network storage (`network-hdd`): ₽2.2881.

Depending on the [secondary replica type](../concepts/replication.md#readable-and-non-readable-replicas) used, the total cost of a cluster in a billing period may vary:

{% list tabs %}

- With non-readable secondary replicas

   * Software licenses:

      The license cost is debited when you create a cluster or scale one up.

      * The cost of Windows Server Datacenter licenses is debited for each cluster host. Total when creating a cluster:

         `3 hosts × (4 vCPUs × ₽1202.40) = ₽14428.80`

      * The cost of Microsoft SQL Server licenses is debited for a single cluster host (primary replica). Total when creating a cluster:

         `1 host × (4 vCPUs × ₽23227.35) = ₽92909.4`

      On March 10 you will be charged `₽14428.80 + ₽92909.40 = ₽107338.20`

      On March 15, when you add 8 cores to each of the three cluster hosts, you will be charged:

      `3 hosts × (8 vCPUs × ₽1202.40 ₽) + 1 host × (8 vCPUs × ₽23227.35) = ₽214676.40`

      You will require additional licenses only for those cores that are not covered by licenses previously activated in the same month.

      Total license cost: `₽107338.20 + ₽214676.40 = ₽322014.60`

   * Host computing resources:

      * Cost of one hour of operation for three `s3-c4-m16` class hosts (Intel Ice Lake, 4 vCPUs, 16 GB RAM):

         `3 hosts × (4 vCPUs × ₽1.0800 + 16 GB RAM × ₽0.2880) = ₽26.7840`

      For the period between March 10 and 14 you will be charged: `5 days × 24 hours × ₽26.7840 = ₽3214.08`

      * Cost of one hour of operation for three `s3-c12-m48` class hosts (Intel Ice Lake, 12 vCPUs, 48 GB RAM):

         `3 hosts × (12 vCPUs × ₽1.0800 + 48 GB RAM × ₽0.2880) = ₽80.3520`

      For the period between March 15 and 24 you will be charged: `10 days x 24 hours x ₽80.3520 = ₽19284.48`

      Once you stop the cluster on March 25, you will not be charged for any computing resources.

      Total cost of computing resources: `₽3214.08 + ₽19284.48 = ₽22498.56`

   * Storage (not including backups):

      The cost of storage is calculated over the entire life of a cluster, from March 10 to 30:

      `3 hosts × 100 GB × (20 days / 30 days) × ₽2.2881 = ₽457.62`

   Total cluster cost: `₽322014.60 + ₽22498.56 + ₽457.62 = ₽344970.78`

- With readable secondary replicas

   * Software licenses:

      The cost of licenses is debited when you create or scale up a cluster.

      * The cost of Windows Server Datacenter licenses is debited for each cluster host. Total when creating a cluster:

         `3 hosts × (4 vCPUs × ₽1202.40) = ₽14428.80`

      * The cost of Microsoft SQL Server licenses is debited for each cluster host. Total when creating a cluster:

         `3 hosts × (4 vCPUs × ₽23227.35 ) = ₽278728.20`

      On March 10 you will be charged: `₽14428.80 + ₽278728.20 = ₽293157.00`

      On March 15, when you add 8 cores to each of the three cluster hosts, you will be charged:

      `3 hosts × (8 vCPUs × ₽1202.40) + 3 hosts × (8 vCPUs × ₽23227.35) = ₽586314.00`

      You will require additional licenses only for those cores that are not covered by licenses previously activated in the same month.

      Total cost of licenses: `₽293157.00 + ₽586314.00 = ₽879471.00`

   * Host computing resources:

      * Cost of one hour of operation for three `s3-c4-m16` class hosts (Intel Ice Lake, 4 vCPUs, 16 GB RAM):

         `3 hosts × (4 vCPUs × ₽1.0800 + 16 GB RAM × ₽0.2880) = ₽26.7840`

      For the period between March 10 and 14 you will be charged: `5 days × 24 hours × ₽26.7840 = ₽3214.08`

      * Cost of one hour of operation for three `s3-c12-m48` class hosts (Intel Ice Lake, 12 vCPUs, 48 GB RAM):

         `3 hosts × (12 vCPUs × ₽1.0800 + 48 GB RAM × ₽0.2880) = ₽80.3520`

      For the period between March 15 and 24 you will be charged: `10 days x 24 hours x ₽80.3520 = ₽19284.48`

      Once you stop the cluster on March 25, you will not be charged for any computing resources.

      Total cost of computing resources: `₽3214.08 + ₽19284.48 = ₽22498.56`

   * Storage (not including backups):

      The cost of storage is calculated over the entire life of a cluster, from March 10 to 30:

      `3 hosts × 100 GB × (20 days / 30 days) × ₽2.2881 = ₽457.62`

   Total cluster cost: `₽879471.00 + ₽22498.56 + ₽457.62 = ₽902427.18`

{% endlist %}

{% endif %}
