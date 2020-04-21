---
editable: false
---
# Pricing for {{ mpg-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mpg-short-name }} {#rules}

The cost of {{ mpg-name }} usage is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. Exact class characteristics are given in [{#T}](concepts/instance-types.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the {{ PG }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with 3 or more hosts in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * During an automatic backup, {{ mpg-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).


## Discount for committed volumes of services (CVoS)

You can get a guaranteed discount on Yandex.Cloud resource usage when you plan for one or three years ahead. To see the resources you can get a discount on:

1. Go to [Billing](https://console.cloud.yandex.com/billing).
1. Click on the desired billing account
1. Choose **Special offers** in the left-hand menu.

A CVoS guarantees a discount on usage, but doesn't guarantee the availability of the resources ordered. Read more about CVoS in the [Billing documentation](../billing/concepts/cvos.md).

{{mpg-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also pre-estimate your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}

### Host computing resources {#prices-hosts}

{% list tabs %}

- Prices in USD, without VAT
  
    | Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
    | ----- | ----- | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | $0.000513 | - | - 
    | 20% vCPU | $0.003590 | - | - 
    | 50% vCPU | $0.006026 | - | - 
    | 100% vCPU | $0.017179 | - | - 
    | RAM (for 1 GB) | $0.003974 | - | - 
    | **Intel Cascade Lake** |
    | 5% vCPU | $0.000513 | - | - 
    | 20% vCPU | $0.003590 | - | - 
    | 50% vCPU | $0.006026 | - | - 
    | 100% vCPU | $0.014487 | $0.010385 | $0.008205
    | RAM (for 1 GB) | $0.003974 | $0.002564 | $0.001923
  
- Prices in roubles, with VAT

    | Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
    | ----- | ----- | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | ₽0.04 | - | - 
    | 20% vCPU | ₽0.28 | - | - 
    | 50% vCPU | ₽0.47 | - | - 
    | 100% vCPU | ₽1.34 | - | - 
    | RAM (for 1 GB) | ₽0.31 | - | - 
    | **Intel Cascade Lake** |
    | 5% vCPU | ₽0.04 | - | - 
    | 20% vCPU | ₽0.28 | - | - 
    | 50% vCPU | ₽0.47 | - | - 
    | 100% vCPU | ₽1.13 | ₽0.81 | ₽0.64 
    | RAM (for 1 GB) | ₽0.31 | ₽0.20 | ₽0.15 

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

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-postgresql#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

{% list tabs %}

- Prices in USD, without VAT

  Host class | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  ----- | ----- | ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }} | $0.008974 | - | - 
  {{ b1-micro }} | $0.015128 | - | - 
  {{ b1-medium }}  | $0.027949 | - | - 
  {{ s1-nano }} | $0.033077 | - | - 
  {{ s1-micro }} | $0.066154 | - | - 
  {{ s1-small }} | $0.132308 | - | - 
  {{ s1-medium }}| $0.264615 | - | - 
  {{ s1-large }} | $0.529231 | - | - 
  {{ s1-xlarge }} | $1.058462 | - | - 
  **Intel Cascade Lake** |
  {{ b2-nano }}| $0.008974 | - | - 
  {{ b2-micro }} | $0.015128 | - | - 
  {{ b2-medium }} | $0.027949 | - | - 
  {{ m2-micro }} | $0.092564 | $0.061795 | $0.047179
  {{ m2-small }} | $0.185128 | $0.123590 | $0.094359
  {{ m2-medium }}| $0.277692 | $0.185385 | $0.141538
  {{ m2-large }} | $0.370256 | $0.247179 | $0.188718
  {{ m2-xlarge }} | $0.555385 | $0.370769 | $0.283077
  {{ m2-2xlarge }} | $0.740513 | $0.494359 | $0.377436
  {{ m2-3xlarge }} | $1.110769 | $0.741538 | $0.566154
  {{ m2-4xlarge }} | $1.481026 | $0.988718 | $0.754872
  {{ m2-5xlarge }} | $1.851282 | $1.235897 | $0.943590
  {{ m2-6xlarge }} | $2.221538 | $1.483077 | $1.132308
  {{ m2-7xlarge }} | $2.591795 | $1.730256 | $1.321026
  {{ m2-8xlarge }} | $2.962051 | $1.977436 | $1.509744
  {{ s2-micro }} | $0.060769 | $0.041282 | $0.031795 
  {{ s2-small }} | $0.121538 | $0.082564 | $0.063590 
  {{ s2-medium }} | $0.243077 | $0.165128 | $0.127179 
  {{ s2-large }} | $0.364615 | $0.247692 | $0.190769 
  {{ s2-xlarge }} | $0.486154 | $0.330256 | $0.254359 
  {{ s2-2xlarge }} | $0.729231 | $0.495385 | $0.381538 
  {{ s2-3xlarge }} | $0.972308 | $0.660513 | $0.508718 
  {{ s2-4xlarge }} | $1.215385 | $0.825641 | $0.635897 
  {{ s2-5xlarge }} | $1.458462 | $0.990769 | $0.763077 
  {{ s2-6xlarge }} | $1.944615 | $1.321026 | $1.017436

- Prices in roubles, with VAT

  Host class | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  ----- | ----- | ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }}| ₽0.70 | − | −
  {{ b1-micro }} | ₽1.18 | − | −
  {{ b1-medium }} | ₽2.18 | − | −
  {{ s1-nano }} | ₽2.58 | − | −
  {{ s1-micro }} | ₽5.16 | − | −
  {{ s1-small }} | ₽10.32 | − | −
  {{ s1-medium }} | ₽20.64 | − | −
  {{ s1-large }} | ₽41.28 | − | −
  {{ s1-xlarge }} | ₽82.56 | − | −
  **Intel Cascade Lake** |
  {{ b2-nano }}| ₽0.70 | − | −
  {{ b2-micro }} | ₽1.18 | − | −
  {{ b2-medium }} | ₽2.18 | − | −
  {{ m2-micro }} | ₽7.22 | ₽4.82 | ₽3.68
  {{ m2-small }} | ₽14.44 | ₽9.64 | ₽7.36
  {{ m2-medium }}| ₽21.66 | ₽14.46 | ₽11.04
  {{ m2-large }} | ₽28.88 | ₽19.28 | ₽14.72
  {{ m2-xlarge }} | ₽43.32 | ₽28.92 | ₽22.08
  {{ m2-2xlarge }} | ₽57.76 | ₽38.56 | ₽29.44
  {{ m2-3xlarge }} | ₽86.64 | ₽57.84 | ₽44.16
  {{ m2-4xlarge }} | ₽115.52 | ₽77.12 | ₽58.88
  {{ m2-5xlarge }} | ₽144.40 | ₽96.40 | ₽73.60
  {{ m2-6xlarge }} | ₽173.28 | ₽115.68 | ₽88.32
  {{ m2-7xlarge }} | ₽202.16 | ₽134.96 | ₽103.04 
  {{ m2-8xlarge }} | ₽231.04 | ₽154.24 | ₽117.76 
  {{ s2-micro }} | ₽4.74 | ₽3.22 | ₽2.48
  {{ s2-small }} | ₽9.48 | ₽6.44 | ₽4.96
  {{ s2-medium }} | ₽18.96 | ₽12.88 | ₽9.92
  {{ s2-large }} | ₽28.44 | ₽19.32 | ₽14.88
  {{ s2-xlarge }} | ₽37.92 | ₽25.76 | ₽19.84
  {{ s2-2xlarge }} | ₽56.88 | ₽38.64 | ₽29.76
  {{ s2-3xlarge }} | ₽75.84 | ₽51.52 | ₽39.68
  {{ s2-4xlarge }}| ₽94.80 | ₽64.40 | ₽49.60
  {{ s2-5xlarge }}| ₽113.76 | ₽77.28 | ₽59.52
  {{ s2-6xlarge }}| ₽151.68 | ₽103.04 | ₽79.36

{% endlist %}
