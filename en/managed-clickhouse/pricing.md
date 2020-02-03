---
editable: false
---
# Pricing for {{ mch-short-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mch-short-name }} {#rules}

The cost of {{ mch-name }} usage is based on:

* Storage type and size (disk space).

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts);

* Settings and number of backups.

* Volume of outgoing traffic from Yandex.Cloud to the internet.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

You can choose the host class for {{ CH }} and ZooKeeper hosts (as appropriate for the expected replication load).

{% note important %}

When you create a cluster with 2 or more {{ CH }}  hosts, 3  {{ ZK }} hosts with the minimal host class are created automatically to provide replication and fault tolerance for the cluster.

{% endnote %}

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You aren't charged for time when the DBMS or {{ ZK }} host isn't performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with more than 2 hosts in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * During an automatic backup, {{ mch-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

### Example of cluster cost calculation {#example}

For example, you created a cluster:

* with 3 {{ CH }} hosts with the host class `s1.micro` (2 vCPU, 8 GB RAM),
* with 3 automatically created {{ ZK }} hosts with the class `s1.nano` (1 vCPU, 4 GB RAM),
* with 100 GB of standard network storage.

Cost per hour for all hosts: `3 × (2 × ₽1.43 + 8 × ₽0.33) + 3 × (1 × ₽0.89 + 4 × ₽0,2) = ₽21.57`

The total cost of the cluster in the month (hosts and storage): `720 × ₽21.57 + 100 × 2,2881 ₽ = ₽15,759.21`

## Pricing {#prices}

### Host computing resources {{ CH }} {#prices-clickhouse}

{% list tabs %}

- Prices in USD, without VAT

    | Resource | Rate for 1 hour |
    | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | $0.000256 |
    | 20% vCPU | $0.003333 |
    | 50% vCPU | $0.005513 |
    | 100% vCPU | $0.018333 |
    | RAM (for 1 GB) | $0.004231 |
    | **Intel Cascade Lake** |
    | 5% vCPU | $0.000256 |
    | 20% vCPU | $0.003333 |
    | 50% vCPU | $0.005513 |
    | 100% vCPU | $0.015385 |
    | RAM (for 1 GB) | $0.004231 |

- Prices in roubles, with VAT

    | Resource | Rate for 1 hour |
    | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | ₽0.02|
    | 20% vCPU | ₽0.26 |
    | 50% vCPU | ₽0.43 |
    | 100% vCPU | ₽1.43 |
    | RAM (for 1 GB) | ₽0.33 |
    | **Intel Cascade Lake** |
    | 5% vCPU | ₽0.02 |
    | 20% vCPU | ₽0.26 |
    | 50% vCPU | ₽0.43 |
    | 100% vCPU | ₽1.20 |
    | RAM (for 1 GB) | ₽0.33 |

{% endlist %}

### Host computing resources {{ ZK }} {#prices-zookeeper}

{% list tabs %}

- Prices in USD, without VAT
  
    | Resource | Rate for 1 hour |
    | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | $0.001923 |
    | 20% vCPU | $0.004487 |
    | 50% vCPU | $0.006282 |
    | 100% vCPU | $0.011410 |
    | RAM (for 1 GB) | $0.002564 |
    | **Intel Cascade Lake** |
    | 5% vCPU | $0.001923 |
    | 20% vCPU | $0.004487 |
    | 50% vCPU | $0.006282 |
    | 100% vCPU | $0.009744 |
    | RAM (for 1 GB) | $0.002564 |

- Prices in roubles, with VAT

    | Resource | Rate for 1 hour |
    | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | ₽0.15 |
    | 20% vCPU | ₽0.35 |
    | 50% vCPU | ₽0.49 |
    | 100% vCPU | ₽0.89 |
    | RAM (for 1 GB) | ₽0.20 |
    | **Intel Cascade Lake** |
    | 5% vCPU | ₽0.15 |
    | 20% vCPU | ₽0.35 |
    | 50% vCPU | ₽0.49 |
    | 100% vCPU | ₽0.76 |
    | RAM (for 1 GB) | ₽0.20 |

{% endlist %}

### Storage and backups {#prices-storage}

{% list tabs %}

- Prices in USD, without VAT

  Service | Rate for 1 GB per month
  ----- | ----- | -----
  Fast network storage | $0.104302 |
  Backup over storage size | $0.032594


- Prices in roubles, with VAT

  Service | Rate for 1 GB per month
  ----- | -----
  Fast network storage | ₽8.1356 |
  Backup over storage size | ₽2.5424

{% endlist %}

### Outgoing traffic {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}


## Estimated prices for host classes {#calculated-prices}

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-clickhouse#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}


### {{ CH }} hosts {#calculated-clickhouse}

{% list tabs %}

- Prices in USD, without VAT

  Host class | Rate for 1 hour
  ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }} | $0.008974
  {{ b1-micro }} | $0.015128
  {{ b1-medium }}  | $0.027949
  {{ s1-nano }} | $0.035256
  {{ s1-micro }} | $0.070513
  {{ s1-small }} | $0.141026
  {{ s1-medium }}| $0.282051
  {{ s1-large }} | $0.564103
  {{ s1-xlarge }} | $1.128205
  **Intel Cascade Lake** |
  {{ b2-nano }}| $0.008974
  {{ b2-micro }} | $0.015128
  {{ b2-medium }} | $0.027949
  {{ m2-micro }} | $0.098462
  {{ m2-small }} | $0.196923
  {{ m2-medium }}| $0.295385
  {{ m2-large }} | $0.393846
  {{ m2-xlarge }} | $0.590769
  {{ m2-2xlarge }} | $0.787692
  {{ m2-3xlarge }} | $1.181538
  {{ m2-4xlarge }} | $1.575385
  {{ m2-5xlarge }} | $1.969231
  {{ m2-6xlarge }} | $2.363077
  {{ s2-micro }} | $0.064615
  {{ s2-small }} | $0.129231
  {{ s2-medium }} | $0.258462
  {{ s2-large }} | $0.387692
  {{ s2-xlarge }} | $0.516923
  {{ s2-2xlarge }} | $0.775385
  {{ s2-3xlarge }} | $1.033846
  {{ s2-4xlarge }} | $1.292308
  {{ s2-5xlarge }} | $1.550769
  {{ s2-6xlarge }} | $2.067692

- Prices in roubles, with VAT

  Host class | Rate for 1 hour
  ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }}| ₽0.70
  {{ b1-micro }} | ₽1.18
  {{ b1-medium }} | ₽2.18
  {{ s1-nano }} | ₽2.75
  {{ s1-micro }} | ₽5.50
  {{ s1-small }} | ₽11.00
  {{ s1-medium }} | ₽22.00 |
  {{ s1-large }} | ₽44.00 |
  {{ s1-xlarge }} | ₽88.00 |
  **Intel Cascade Lake** | |
  {{ b2-nano }}| ₽0.70
  {{ b2-micro }} | ₽1.18
  {{ b2-medium }} | ₽2.18
  {{ m2-micro }} | ₽7.68
  {{ m2-small }} | ₽15.36
  {{ m2-medium }}| ₽23.04
  {{ m2-large }} | ₽30.72
  {{ m2-xlarge }} | ₽46.08
  {{ m2-2xlarge }} | ₽61.44
  {{ m2-3xlarge }} | ₽92.16
  {{ m2-4xlarge }} | ₽122.88
  {{ m2-5xlarge }} | ₽153.60
  {{ m2-6xlarge }} | ₽184.32
  {{ s2-micro }} | ₽5.04
  {{ s2-small }} | ₽10.08
  {{ s2-medium }} | ₽20.16
  {{ s2-large }} | ₽30.24
  {{ s2-xlarge }} | ₽40.32
  {{ s2-2xlarge }} | ₽60.48
  {{ s2-3xlarge }} | ₽80.64
  {{ s2-4xlarge }} | ₽100.80
  {{ s2-5xlarge }} | ₽120.96
  {{ s2-6xlarge }} | ₽161.28

{% endlist %}


### Хосты ZooKeeper {#prices-zookeeper}

{% list tabs %}

- Prices in USD, without VAT

  Host class | Rate for 1 hour
  ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }} | $0.008974
  {{ b1-micro }}  | $0.014103
  {{ b1-medium }}  | $0.022821
  {{ s1-nano }} | $0.021667
  {{ s1-micro }}  | $0.043333
  {{ s1-small }}  | $0.086667
  {{ s1-medium }}  | $0.173333
  {{ s1-large }}  | $0.346667
  {{ s1-xlarge }}  | $0.693333
  **Intel Cascade Lake** |
  {{ b2-nano }} | $0.008974
  {{ b2-micro }}  | $0.014103
  {{ b2-medium }}  | $0.022821
  {{ m2-micro }} | $0.060513
  {{ m2-small }} | $0.121026
  {{ m2-medium }}| $0.181538
  {{ m2-large }} | $0.242051
  {{ m2-xlarge }} | $0.363077
  {{ m2-2xlarge }} | $0.484103
  {{ m2-3xlarge }} | $0.726154
  {{ m2-4xlarge }} | $0.968205
  {{ m2-5xlarge }} | $1.210256
  {{ m2-6xlarge }} | $1.452308
  {{ s2-micro }}  | $0.040000
  {{ s2-small }}  | $0.080000
  {{ s2-medium }}  | $0.160000
  {{ s2-large }}  | $0.240000
  {{ s2-xlarge }}  | $0.320000
  {{ s2-2xlarge }}  | $0.480000
  {{ s2-3xlarge }}  | $0.640000
  {{ s2-4xlarge }} | $0.800000
  {{ s2-5xlarge }} | $0.960000
  {{ s2-6xlarge }} | $1.280000

- Prices in roubles, with VAT

  Host class | Rate for 1 hour
  ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }} | ₽0.70
  {{ b1-micro }}  | ₽1.10
  {{ b1-medium }}  | ₽1.78
  {{ s1-nano }}  | ₽1.69 |
  {{ s1-micro }}  | ₽3.38 |
  {{ s1-small }}  | ₽6.76 |
  {{ s1-medium }}  | ₽13.52 |
  {{ s1-large }}  | ₽27.04 |
  {{ s1-xlarge }}  | ₽54.08 |
  **Intel Cascade Lake** |
  {{ b2-nano }} | ₽0.70
  {{ b2-micro }}  | ₽1.10
  {{ b2-medium }}  | ₽1.78
  {{ m2-micro }} | ₽4.72
  {{ m2-small }} | ₽9.44
  {{ m2-medium }}| ₽14.16
  {{ m2-large }} | ₽18.88
  {{ m2-xlarge }} | ₽28.32
  {{ m2-2xlarge }} | ₽37.76
  {{ m2-3xlarge }} | ₽56.64
  {{ m2-4xlarge }} | ₽75.52
  {{ m2-5xlarge }} | ₽94.40
  {{ m2-6xlarge }} | ₽113.28
  {{ s2-micro }}  | ₽3.12
  {{ s2-small }}  | ₽6.24
  {{ s2-medium }}  | ₽12.48
  {{ s2-large }}  | ₽18.72
  {{ s2-xlarge }}  | ₽24.96
  {{ s2-2xlarge }}  | ₽37.44
  {{ s2-3xlarge }}  | ₽49.92
  {{ s2-4xlarge }} | ₽62.40
  {{ s2-5xlarge }} | ₽74.88
  {{ s2-6xlarge }} | ₽99.84

{% endlist %}
