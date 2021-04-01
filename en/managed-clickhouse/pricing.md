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

{% note warning %}

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

The total cost of the cluster in the month (hosts and storage): `720 × ₽21.57 + 100 × ₽2.2881 = ₽15,759.21`


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mch-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also pre-estimate your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}

### Host computing resources {{ CH }} {#prices-clickhouse}

{% list tabs %}

- Prices in USD, without VAT

    | Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
    | ----- | ----- | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | $0.000256 | - | - 
    | 20% vCPU | $0.003333 | - | - 
    | 50% vCPU | $0.005513 | - | - 
    | 100% vCPU | $0.018333 | - | - 
    | RAM (for 1 GB) | $0.004231 | - | - 
    | **Intel Cascade Lake** |
    | 5% vCPU | $0.000256 | - | - 
    | 20% vCPU | $0.003333 | - | - 
    | 50% vCPU | $0.005513 | - | - 
    | 100% vCPU | $0.015385 | $0.011282 (-27%) | $0.008718 (-43%) 
    | RAM (for 1 GB) | $0.004231 | $0.002692 (-36%) | $0.002051 (-52%)

- Prices in roubles, with VAT

    | Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
    | ----- | ----- | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | ₽0.02| - | - 
    | 20% vCPU | ₽0.26 | - | - 
    | 50% vCPU | ₽0.43 | - | - 
    | 100% vCPU | ₽1.43 | - | - 
    | RAM (for 1 GB) | ₽0.33 | - | - 
    | **Intel Cascade Lake** |
    | 5% vCPU | ₽0.02 | - | - 
    | 20% vCPU | ₽0.26 | - | - 
    | 50% vCPU | ₽0.43 | - | - 
    | 100% vCPU | ₽1.20 | ₽0.88 (-27%) | ₽0.68 (-43%)
    | RAM (for 1 GB) | ₽0.33 | ₽0.21 (-36%) | ₽0.16 (-52%) 

{% endlist %}

### Host computing resources {{ ZK }} {#prices-zookeeper}

{% note info %}

You can't order {{ ZK }} resources with CVoS discounts.

{% endnote %}

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
  ----- | ----- 
  Fast network storage | $0.104302 |
  Backup over storage size | $0.032594


- Prices in roubles, with VAT

  Service | Rate for 1 GB per month
  ----- | -----
  Fast network storage | ₽8.1356 |
  Backup over storage size | ₽2.5424

{% endlist %}

### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

## Estimated prices for host classes {#calculated-prices}

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-clickhouse#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}


### {{ CH }} hosts {#calculated-clickhouse}

{% list tabs %}

- Prices in USD, without VAT

  Host class | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  ----- | ----- | ----- | ----- |
  **Intel Broadwell** |
  {{ b1-nano }} | $0.008974 | - | - 
  {{ b1-micro }} | $0.015128 | - | - 
  {{ b1-medium }}  | $0.027949 | - | - 
  {{ s1-nano }} | $0.035256 | - | - 
  {{ s1-micro }} | $0.070513 | - | - 
  {{ s1-small }} | $0.141026 | - | - 
  {{ s1-medium }}| $0.282051 | - | - 
  {{ s1-large }} | $0.564103 | - | - 
  {{ s1-xlarge }} | $1.128205 | - | - 
  **Intel Cascade Lake** |
  {{ b2-nano }}| $0.008974 | - | - 
  {{ b2-micro }} | $0.015128 | - | - 
  {{ b2-medium }} | $0.027949 | - | - 
  {{ m2-micro }} | $0.098462 | $0.065641 (-33%) | $0.050256 (-49%)
  {{ m2-small }} | $0.196923 | $0.131282 (-33%) | $0.100513 (-49%)
  {{ m2-medium }}| $0.295385 | $0.196923 (-33%) | $0.150769 (-49%)
  {{ m2-large }} | $0.393846 | $0.262564 (-33%) | $0.201026 (-49%)
  {{ m2-xlarge }} | $0.590769 | $0.393846 (-33%) | $0.301538 (-49%)
  {{ m2-2xlarge }} | $0.787692 | $0.525128 (-33%) | $0.402051 (-49%)
  {{ m2-3xlarge }} | $1.181538 | $0.787692 (-33%) | $0.603077 (-49%)
  {{ m2-4xlarge }} | $1.575385 | $1.050256 (-33%) | $0.804103 (-49%)
  {{ m2-5xlarge }} | $1.969231 | $1.312821 (-33%) | $1.005128 (-49%)
  {{ m2-6xlarge }} | $2.363077 | $1.575385 (-33%) | $1.206154 (-49%)
  {{ m2-7xlarge }} | $2.756923 | $1.837949 (-33%) | $1.407180 (-49%)
  {{ m2-8xlarge }} | $3.150769 | $2.100513 (-33%) | $1.608205 (-49%)
  {{ s2-micro }} | $0.064615 | $0.044103 (-32%) | $0.033846 (-48%) 
  {{ s2-small }} | $0.129231 | $0.088205 (-32%) | $0.067692 (-48%) 
  {{ s2-medium }} | $0.258462 | $0.176410 (-32%) | $0.135385 (-48%)
  {{ s2-large }} | $0.387692 | $0.264615 (-32%) | $0.203077 (-48%)
  {{ s2-xlarge }} | $0.516923 | $0.352821 (-32%) | $0.270769  (-48%)
  {{ s2-2xlarge }} | $0.775385 | $0.529231 (-32%) | $0.406154 (-48%)
  {{ s2-3xlarge }} | $1.033846 | $0.705641 (-32%) | $0.541538  (-48%)
  {{ s2-4xlarge }} | $1.292308 | $0.882051 (-32%) | $0.676923 (-48%)
  {{ s2-5xlarge }} | $1.550769 | $1.058462 (-32%) | $0.812308 (-48%)
  {{ s2-6xlarge }} | $2.067692 | $1.411282 (-32%) | $1.083077 (-48%) 

- Prices in roubles, with VAT

  Host class | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  ----- | ----- | ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }}| ₽0.70 | − | −
  {{ b1-micro }} | ₽1.18 | − | −
  {{ b1-medium }} | ₽2.18 | − | −
  {{ s1-nano }} | ₽2.75 | − | −
  {{ s1-micro }} | ₽5.50 | − | −
  {{ s1-small }} | ₽11.00 | − | −
  {{ s1-medium }} | ₽22.00 | − | −
  {{ s1-large }} | ₽44.00 | − | −
  {{ s1-xlarge }} | ₽88.00 | − | −
  **Intel Cascade Lake** | |
  {{ b2-nano }}| ₽0.70 | − | −
  {{ b2-micro }} | ₽1.18 | − | −
  {{ b2-medium }} | ₽2.18 | − | −
  {{ m2-micro }} | ₽7.68 | ₽5.12 (-33%) | ₽3.92 (-49%)
  {{ m2-small }} | ₽15.36 | ₽10.24 (-33%) | ₽7.84 (-49%)
  {{ m2-medium }}| ₽23.04 | ₽15.36 (-33%) | ₽11.76 (-49%)
  {{ m2-large }} | ₽30.72 | ₽20.48 (-33%) | ₽15.68 (-49%)
  {{ m2-xlarge }} | ₽46.08 | ₽30.72 (-33%) | ₽23.52 (-49%)
  {{ m2-2xlarge }} | ₽61.44 | ₽40.96 (-33%) | ₽31.36 (-49%)
  {{ m2-3xlarge }} | ₽92.16 | ₽61.44 (-33%) | ₽47.04 (-49%)
  {{ m2-4xlarge }} | ₽122.88 | ₽81.92 (-33%) | ₽62.72 (-49%)
  {{ m2-5xlarge }} | ₽153.60 | ₽102.40 (-33%) | ₽78.40 (-49%)
  {{ m2-6xlarge }} | ₽184.32 | ₽122.88 (-33%) | ₽94.08 (-49%)
  {{ m2-7xlarge }} | ₽215.04 | ₽143.36 (-33%) | ₽109.76 (-49%)
  {{ m2-8xlarge }} | ₽245.76 | ₽163.84 (-33%)| ₽125.44 (-49%)
  {{ s2-micro }} | ₽5.04 | ₽3.44 (-32%) | ₽2.64 (-48%)
  {{ s2-small }} | ₽10.08 | ₽6.88 (-32%) | ₽5.28 (-48%)
  {{ s2-medium }} | ₽20.16 | ₽13.76 (-32%) | ₽10.56 (-48%)
  {{ s2-large }} | ₽30.24 | ₽20.64 (-32%) | ₽15.84 (-48%)
  {{ s2-xlarge }} | ₽40.32 | ₽27.52 (-32%) | ₽21.12 (-48%)
  {{ s2-2xlarge }} | ₽60.48 | ₽41.28 (-32%) | ₽31.68 (-48%)
  {{ s2-3xlarge }} | ₽80.64 | ₽55.04 (-32%) | ₽42.24 (-48%)
  {{ s2-4xlarge }} | ₽100.80 | ₽68.80 (-32%) | ₽52.80 (-48%)
  {{ s2-5xlarge }} | ₽120.96 | ₽82.56 (-32%) | ₽63.36 (-48%)
  {{ s2-6xlarge }} | ₽161.28 | ₽110.08 (-32%) | ₽84.48 (-48%)

{% endlist %}


### ZooKeeper hosts {#prices-zookeeper}

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
  {{ m2-7xlarge }} | $1.694359
  {{ m2-8xlarge }} | $1.936410
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
  {{ m2-7xlarge }} | ₽132.16 
  {{ m2-8xlarge }} | ₽151.04
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