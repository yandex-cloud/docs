---
editable: false
---
# Pricing for {{ mmy-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mmy-short-name }} {#rules}

The cost of {{ mmy-name }} usage is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the {{ MY }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with more than 3 hosts in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * The number of hosts in the cluster does not affect the size of the storage or free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mmy-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also pre-estimate your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}

### Host computing resources {#prices-hosts}

{% list tabs %}

- Prices in USD, without VAT

    | Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
    | ----- | ----- | ----- | -----
    | **Intel Broadwell** |
    | 5% vCPU | $0.000385 | - | - 
    | 20% vCPU | $0.003462 | - | - 
    | 50% vCPU | $0.005769 | - | - 
    | 100% vCPU | $0.015128 | - | - 
    | RAM (for 1 GB) | $0.004103 | - | - 
    | **Intel Cascade Lake** |
    | 5% vCPU | $0.000385 | - | - 
    | 20% vCPU | $0.003462 | - | - 
    | 50% vCPU | $0.005769 | - | - 
    | 100% vCPU | $0.015000 | $0.010385 (-31%) | $0.008077 (-46%)  
    | RAM (for 1 GB) | $0.004103 | $0.002692 (-34%)  | $0.002051 (-50%) 


- Prices in roubles, with VAT
  
    | Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
    | ----- | ----- | ----- | -----
    | **Intel Broadwell** |
    | 5% vCPU | ₽0.03 | - | - 
    | 20% vCPU | ₽0.27 | - | - 
    | 50% vCPU | ₽0.45 | - | - 
    | 100% vCPU | ₽1.18 | - | - 
    | RAM (for 1 GB) | ₽0.32 | - | - 
    | **Intel Cascade Lake** |
    | 5% vCPU | ₽0.03 | - | - 
    | 20% vCPU | ₽0.27 | - | - 
    | 50% vCPU | ₽0.45 | - | - 
    | 100% vCPU | ₽1.17 | ₽0.81 (-31%)  | ₽0.63 (-46%)  
    | RAM (for 1 GB) | ₽0.32 | ₽0.21 (-34%)  | ₽0.16 (-50%)  
    
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

## Estimated prices for host classes {#calculated-host-price}

Prices for host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-mysql#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

{% list tabs %}

- Prices in USD, without VAT

  Host class | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  ----- | ----- | ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }} | $0.008974 | - | - 
  {{ b1-micro }} | $0.015128 | - | - 
  {{ b1-medium }}  | $0.027949 | - | - 
  {{ s1-nano }} | $0.031538 | - | - 
  {{ s1-micro }} | $0.063077 | - | - 
  {{ s1-small }} | $0.126154 | - | - 
  {{ s1-medium }}| $0.252308 | - | - 
  {{ s1-large }} | $0.504615 | - | - 
  {{ s1-xlarge }} | $1.009231 | - | - 
  **Intel Cascade Lake** |
  {{ b2-nano }}| $0.008974 | - | - 
  {{ b2-micro }} | $0.015128 | - | - 
  {{ b2-medium }} | $0.027949 | - | - 
  {{ m2-micro }} | $0.095641 | $0.063846 (-33%) | $0.048974 (-49%)
  {{ m2-small }} | $0.191282 | $0.127692 (-33%) | $0.097949 (-49%)
  {{ m2-medium }}| $0.286923 | $0.191538 (-33%) | $0.146923 (-49%)
  {{ m2-large }} | $0.382564 | $0.255385 (-33%) | $0.195897 (-49%)
  {{ m2-xlarge }} | $0.573846 | $0.383077 (-33%) | $0.293846 (-49%)
  {{ m2-2xlarge }} | $0.765128 | $0.510769 (-33%) | $0.391795 (-49%)
  {{ m2-3xlarge }} | $1.147692 | $0.766154 (-33%) | $0.587692 (-49%)
  {{ m2-4xlarge }} | $1.530256 | $1.021538 (-33%) | $0.783590 (-49%)
  {{ m2-5xlarge }} | $1.912821 | $1.276923 (-33%) | $0.979487 (-49%)
  {{ m2-6xlarge }} | $2.295385 | $1.532308 (-33%) | $1.175385 (-49%)
  {{ m2-7xlarge }} | $2.677949 | $1.787692 (-33%) | $1.371282 (-49%)
  {{ m2-8xlarge }} | $3.060513 | $2.043077 (-33%) | $1.567180 (-49%)
  {{ s2-micro }} | $0.062821 | $0.042308 (-33%) | $0.032564 (-48%)
  {{ s2-small }} | $0.125641 | $0.084615 (-33%) | $0.065128 (-48%)
  {{ s2-medium }} | $0.251282 | $0.169231 (-33%) | $0.130256 (-48%)
  {{ s2-large }} | $0.376923 | $0.253846 (-33%) | $0.195385 (-48%)
  {{ s2-xlarge }} | $0.502564 | $0.338462 (-33%) | $0.260513 (-48%)
  {{ s2-2xlarge }} | $0.753846 | $0.507692 (-33%) | $0.390769 (-48%)
  {{ s2-3xlarge }} | $1.005128 | $0.676923 (-33%) | $0.521026 (-48%)
  {{ s2-4xlarge }} | $1.256410 | $0.846154 (-33%) | $0.651282 (-48%)
  {{ s2-5xlarge }} | $1.507692 | $1.015385 (-33%) | $0.781538 (-48%)
  {{ s2-6xlarge }} | $2.010256 | $1.353846 (-33%) | $1.042051 (-48%)

- Prices in roubles, with VAT

  Host class | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  ----- | ----- | ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }}| ₽0.70 | − | −
  {{ b1-micro }} | ₽1.18 | − | −
  {{ b1-medium }} | ₽2.18 | − | −
  {{ s1-nano }} | ₽2.46 | − | −
  {{ s1-micro }} | ₽4.92 | − | −
  {{ s1-small }} | ₽9.84 | − | −
  {{ s1-medium }} | ₽19.68 | − | −
  {{ s1-large }} | ₽39.36 | − | −
  {{ s1-xlarge }} | ₽78.72 | − | −
  **Intel Cascade Lake** |
  {{ b2-nano }}| ₽0.70 | − | −
  {{ b2-micro }} | ₽1.18 | − | −
  {{ b2-medium }} | ₽2.18 | − | −
  {{ m2-micro }} | ₽7.46 | ₽4.98 (-33%) | ₽3.82 (-49%)
  {{ m2-small }} | ₽14.92 | ₽9.96 (-33%) | ₽7.64 (-49%)
  {{ m2-medium }}| ₽22.38 | ₽14.94 (-33%) | ₽11.46 (-49%)
  {{ m2-large }} | ₽29.84 | ₽19.92 (-33%) | ₽15.28 (-49%)
  {{ m2-xlarge }} | ₽44.76 | ₽29.88 (-33%) | ₽22.92 (-49%)
  {{ m2-2xlarge }} | ₽59.68 | ₽39.84 (-33%) | ₽30.56 (-49%)
  {{ m2-3xlarge }} | ₽89.52 | ₽59.76 (-33%) | ₽45.84 (-49%)
  {{ m2-4xlarge }} | ₽119.36 | ₽79.68 (-33%) | ₽61.12 (-49%)
  {{ m2-5xlarge }} | ₽149.20 | ₽99.60 (-33%) | ₽76.40 (-49%)
  {{ m2-6xlarge }} | ₽179.04 | ₽119.52 (-33%) | ₽91.68 (-49%)
  {{ m2-7xlarge }} | ₽208.88 | ₽139.44 (-33%) | ₽106.96 (-49%)
  {{ m2-8xlarge }} | ₽238.72 | ₽159.36 (-33%) | ₽122.24 (-49%)
  {{ s2-micro }} | ₽4.90 | ₽3.30 (-33%) | ₽2.54 (-48%)
  {{ s2-small }} | ₽9.80 | ₽6.60 (-33%) | ₽5.08 (-48%)
  {{ s2-medium }} | ₽19.60 | ₽13.20 (-33%) | ₽10.16 (-48%)
  {{ s2-large }} | ₽29.40 | ₽19.80 (-33%) | ₽15.24 (-48%)
  {{ s2-xlarge }} | ₽39.20 | ₽26.40 (-33%) | ₽20.32 (-48%)
  {{ s2-2xlarge }} | ₽58.80 | ₽39.60 (-33%) | ₽30.48 (-48%)
  {{ s2-3xlarge }} | ₽78.40 | ₽52.80 (-33%) | ₽40.64 (-48%)
  {{ s2-4xlarge }}| ₽98.00 | ₽66.00 (-33%) | ₽50.80 (-48%)
  {{ s2-5xlarge }}| ₽117.60 | ₽79.20 (-33%) | ₽60.96 (-48%)
  {{ s2-6xlarge }}| ₽156.80 | ₽105.60 (-33%) | ₽81.28 (-48%)

{% endlist %}
