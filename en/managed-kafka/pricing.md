---
editable: false
---

# Pricing for {{ mkf-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Cluster status {#running-stopped}

Pricing is applied differently depending on the cluster status:

* For a `Running` cluster, you are charged both for the computing resources and the size of storage.
* For a `Stopped` cluster, you are only charged for the storage size.

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mkf-short-name }} {#rules}

The cost of {{ mkf-name }} usage is based on:

* Storage type and size (disk space).

* Computing resources allocated to cluster hosts (including {{ ZK }} hosts);

* Volume of outgoing traffic from Yandex.Cloud to the internet.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of cluster hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

You can choose the host class for {{ KF }} broker hosts and {{ ZK }} hosts (as appropriate for the expected replication load).

{% note warning %}

When you create a cluster with 2 or more {{ KF }} broker hosts, 3 {{ ZK }} hosts with the minimal host class are created automatically  in three availability zones to provide replication and fault tolerance for the cluster. If you create a cluster with a single broker host, then no {{ ZK }} hosts are created.

{% endnote %}

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You aren't charged for time when the broker host or {{ ZK }} host isn't performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for clusters.
    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with more than 3 broker hosts in 100 GB increments.

The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

### Example of cluster cost calculation {#example}

For example, you created a cluster:

* with 3 {{ KF }} broker hosts with the host class `s2.micro` (2 vCPU, 8 GB RAM),
* with 3 automatically created {{ ZK }} hosts with the class `b2.medium` (2 vCPU, 50% vCPU, 4 GB RAM),
* with 100 GB of standard network storage.

Cost per hour for all hosts: `3 × (2 × ₽1.05 + 8 × ₽0.28) + 3 × (2 × ₽0.49 + 4 × ₽0.20) = ₽18.36`

The total cost of the cluster in the month (hosts and storage): `720 × ₽18.36 + 100 × ₽2.2881 = ₽13,448.01`


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mkf-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also pre-estimate your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}

### Host computing resources {{ KF }} {#prices-kafka-brokers}

{% list tabs %}

- Prices in USD, without VAT

  | Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  | ----- | ----- | ----- | ----- | 
  | **Intel Cascade Lake** |
  | 50% vCPU | $0.006026 | - | - 
  | 100% vCPU | $0.013462 | $0.009487 (-30%) | $0.007308 (-46%) 
  | RAM (for 1 GB) | $0.003590 | $0.002308 (-36%) | $0.001795 (-50%)

- Prices in roubles, with VAT

  | Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  | ----- | ----- | ----- | ----- |
  | **Intel Cascade Lake** |
  | 50% vCPU | ₽0.47 | − | −
  | 100% vCPU | ₽1.05 | ₽0.74 (-30%) | ₽0.57 (-46%) 
  | RAM (for 1 GB) | ₽0.28 | ₽0.18 (-36%) | ₽0.14 (-50%)

{% endlist %}

### Host computing resources {{ ZK }} {#prices-zookeeper}

{% note info %}

You can't order {{ ZK }} resources with CVoS discounts.

{% endnote %}

{% list tabs %}

- Prices in USD, without VAT
  
  | Resource | Rate for 1 hour |
  | ----- | ----- |
  | **Intel Cascade Lake** |
  | 50% vCPU | $0.006282 |
  | 100% vCPU | $0.009744 |
  | RAM (for 1 GB) | $0.002564 |

- Prices in roubles, with VAT

  | Resource | Rate for 1 hour |
  | ----- | ----- |
  | **Intel Cascade Lake** |
  | 50% vCPU | ₽0.49 |
  | 100% vCPU | ₽0.76 |
  | RAM (for 1 GB) | ₽0.20 |

{% endlist %}

### Storage {#prices-storage}

{% list tabs %}

- Prices in USD, without VAT

  | Service | Rate for 1 GB per month |
  | ----- | ----- |
  | Standard network storage | $0.029335 |
  | Fast network storage | $0.104303 |
  | Fast local storage | $0.104303 |


- Prices in roubles, with VAT

  | Service | Rate for 1 GB per month |
  | ----- | ----- |
  | Standard network storage | ₽2.2881 |
  | Fast network storage | ₽8.1356 |
  | Fast local storage | ₽8.1356 |

{% endlist %}

### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

## Estimated prices for host classes {#calculated-prices}

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-kafka#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}


### {{ KF }} broker hosts {#calculated-kafka-brokers}

{% list tabs %}

- Prices in USD, without VAT

  Host class | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years |
  ----- | ----- | ----- | ----- |
  **Intel Cascade Lake** |
  {{ b2-medium }} | $0.026410 | - | - | 
  {{ m2-micro }} | $0.084359 | $0.055897 (-34%) | $0.043333 (-49%)
  {{ m2-small }} | $0.168718 | $0.111795 (-34%) | $0.086667 (-49%)
  {{ m2-medium }} | $0.253077 | $0.167692 (-34%) | $0.130000 (-49%)
  {{ m2-large }} | $0.337436 | $0.223590 (-34%) | $0.173333 (-49%)
  {{ m2-xlarge }} | $0.506154 | $0.335385 (-34%) | $0.260000 (-49%)
  {{ m2-2xlarge }} | $0.674872 | $0.447179 (-34%) | $0.346667 (-49%)
  {{ m2-3xlarge }} | $1.012308 | $0.670769 (-34%) | $0.520000 (-49%)
  {{ m2-4xlarge }} | $1.349744 | $0.894359 (-34%) | $0.693333 (-49%)
  {{ m2-5xlarge }} | $1.687180 | $1.117949 (-34%) | $0.866667 (-49%)
  {{ m2-6xlarge }} | $2.024615 | $1.341538 (-34%) | $1.040000 (-49%)
  {{ m2-7xlarge }} | $2.362051 | $1.565128 (-34%) | $1.213333 (-49%)
  {{ m2-8xlarge }} | $2.699487 | $1.788718 (-34%) | $1.386667 (-49%)
  {{ s2-micro }} | $0.055641 | $0.037436 (-33%) | $0.028974 (-48%)
  {{ s2-small }} | $0.111282 | $0.074872 (-33%) | $0.057949 (-48%)
  {{ s2-medium }} | $0.222564 | $0.149744 (-33%) | $0.115897 (-48%)
  {{ s2-large }} | $0.333846 | $0.224615 (-33%) | $0.173846 (-48%)
  {{ s2-xlarge }} | $0.445128 | $0.299487 (-33%) | $0.231795 (-48%)
  {{ s2-2xlarge }} | $0.667692 | $0.449231 (-33%) | $0.347692 (-48%)
  {{ s2-3xlarge }} | $0.890256 | $0.598974 (-33%) | $0.463590 (-48%)
  {{ s2-4xlarge }} | $1.112821 | $0.748718 (-33%) | $0.579487 (-48%)
  {{ s2-5xlarge }} | $1.414615 | $0.898462 (-33%) | $0.695385 (-48%)
  {{ s2-6xlarge }} | $1.780513 | $1.197949 (-33%) | $0.927180 (-48%)

- Prices in roubles, with VAT

  Host class | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  ----- | ----- | ----- | -----
  **Intel Cascade Lake** | |
  {{ b2-medium }} | ₽2.06 | − | −
  {{ m2-micro }} | ₽6.58 | ₽4.36 (-34%) | ₽3.38 (-49%)
  {{ m2-small }} | ₽13.16 | ₽8.72 (-34%) | ₽6.76 (-49%)
  {{ m2-medium }} | ₽19.74 | ₽13.08 (-34%) | ₽10.14 (-49%)
  {{ m2-large }} | ₽26.32 | ₽17.44 (-34%) | ₽13.52 (-49%)
  {{ m2-xlarge }} | ₽39.48 | ₽26.16 (-34%) | ₽20.28 (-49%)
  {{ m2-2xlarge }} | ₽52.64 | ₽34.88 (-34%) | ₽27.04 (-49%)
  {{ m2-3xlarge }} | ₽78.96 | ₽52.32 (-34%) | ₽40.56 (-49%)
  {{ m2-4xlarge }} | ₽105.28 | ₽69.76 (-34%) | ₽54.08 (-49%)
  {{ m2-5xlarge }} | ₽131.60 | ₽87.20 (-34%) | ₽67.60 (-49%)
  {{ m2-6xlarge }} | ₽157.92 | ₽104.64 (-34%) | ₽81.12 (-49%)
  {{ m2-7xlarge }} | ₽184.24 | ₽122.08 (-34%) | ₽94.64 (-49%)
  {{ m2-8xlarge }} | ₽210.56 | ₽139.52 (-34%) | ₽108.16 (-49%)
  {{ s2-micro }} | ₽4.34 | ₽2.92 (-33%) | ₽2.26 (-48%)
  {{ s2-small }} | ₽8.68 | ₽5.84 (-33%) | ₽4.52 (-48%)
  {{ s2-medium }} | ₽17.36 | ₽11.68 (-33%) | ₽9.04 (-48%)
  {{ s2-large }} | ₽26.04 | ₽17.52 (-33%) | ₽13.56 (-48%)
  {{ s2-xlarge }} | ₽34.72 | ₽23.36 (-33%) | ₽18.08 (-48%)
  {{ s2-2xlarge }} | ₽52.08 | ₽35.04 (-33%) | ₽27.12 (-48%)
  {{ s2-3xlarge }} | ₽69.44 | ₽46.72 (-33%) | ₽36.16 (-48%)
  {{ s2-4xlarge }} | ₽86.80 | ₽58.40 (-33%) | ₽45.20 (-48%)
  {{ s2-5xlarge }} | ₽110.34 | ₽70.08 (-33%) | ₽54.24 (-48%)
  {{ s2-6xlarge }} | ₽138.88 | ₽93.44 (-33%) | ₽72.32 (-48%)

{% endlist %}


### {{ ZK }} hosts {#calculated-zookeeper}

{% list tabs %}

- Prices in USD, without VAT

  Host class | Rate for 1 hour
  ----- | -----
  **Intel Cascade Lake** |
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
  **Intel Cascade Lake** |
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
