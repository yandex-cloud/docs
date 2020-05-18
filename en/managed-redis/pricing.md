---
editable: false
---
# Pricing for {{ mrd-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

## What goes into the cost of using {{ mrd-short-name }} {#rules}

The cost of {{ mrd-name }} usage is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the {{ RD }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Disk space allocated for database clusters.

* Space used by DB backups in excess of the disk space requested for the cluster.
    * Backups are stored free of charge as long as the combined size of the DB and all backups is less than the selected storage volume.
    * The requested disk size is allocated for each host, so the number of hosts in the cluster does not affect the storage size and, consequently, the free backup size.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mrd-name }} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also pre-estimate your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}

### Host computing resources {#prices-hosts}

{% list tabs %}

- Prices in USD, without VAT

    | Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
    | ----- | ----- | ----- | ----- |
    **Intel Broadwell** |
    | 5% vCPU (**burstable**, 2 GB RAM) | $0.000128 | — | — 
    | 20% vCPU (**burstable**, 4 GB RAM) | $0.002949 | — | —
    | 100% vCPU (**high-memory**) | $0.016026 | — | —
    | RAM (for 1 GB) | $0.004359 | — | —
    **Intel Cascade Lake** |
    | 5% vCPU | $0.000897 | — | —
    | 50% vCPU | $0.008077 | — | —
    | 100% vCPU | $0.013462 | $0.009487 | $0.007308
    | RAM (за 1 ГБ) | $0.003590 | $0.002308 | $0.001795
    
- Prices in roubles, with VAT

    | Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
    | ----- | ----- | ----- | ----- |
    **Intel Broadwell** |
    | 5% vCPU (**burstable**, 2 GB RAM) | ₽0.01 | — | —
    | 20% vCPU (**burstable**, 4 GB RAM) | ₽0.23 | — | —
    | 100% vCPU (**high-memory**) | ₽1.25 | — | —
    | RAM (for 1 GB) | ₽0.34 | — | —
    **Intel Cascade Lake** |
    | 5% vCPU | ₽0.07 | — | —
    | 50% vCPU | ₽0.63 | — | —
    | 100% vCPU | ₽1.05 | ₽0.74 | ₽0.57
    | RAM (for 1 GB) | ₽0.28 | ₽0.18 | ₽0.14


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

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-redis#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

{% list tabs %}

- Prices in USD, without VAT
  
  Host class | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  ----- | ----- | ----- | -----
  **Intel Broadwell** | 
  {{ b1-nano }} | $0.008974 | — | — 
  {{ b1-small }} | $0.023333 | — | — 
  {{ hm1-nano }} | $0.066923 | — | — 
  {{ hm1-micro }} | $0.084359 | — | — 
  {{ hm1-small }} | $0.101795 | — | — 
  {{ hm1-medium }} | $0.168718 | — | — 
  {{ hm1-large }} | $0.203590 | — | — 
  {{ hm1-xlarge }} | $0.273333  | — | — 
  {{ hm1-2xlarge }} | $0.343077 | — | — 
  {{ hm1-3xlarge }} | $0.412821 | — | — 
  {{ hm1-4xlarge }} | $0.546667 | — | — 
  {{ hm1-5xlarge }} | $0.686154 | — | — 
  {{ hm1-6xlarge }} | $0.825641 | — | — 
  {{ hm1-7xlarge }} | $0.965128 | — | — 
  {{ hm1-8xlarge }} | $1.104615 | — | — 
  {{ hm1-9xlarge }} | $1.244103 | — | — 
  **Intel Cascade Lake** | 
  {{ b2-nano }} | $0.008974 | — | —
  {{ b2-medium }} | $0.030513 | — | —
  {{ hm2-nano }} | $0.055641 | $0.037436 | $0.028974
  {{ hm2-micro }} | $0.070000 | $0.046667 | $0.036154
  {{ hm2-small }} | $0.111282 | $0.074872 | $0.057949
  {{ hm2-medium }} | $0.140000 | $0.093333 | $0.072308
  {{ hm2-large }} | $0.168718 | $0.111795 | $0.086667
  {{ hm2-xlarge }} | $0.226154 | $0.148718 | $0.115385
  {{ hm2-64xlarge }} | $0.310513 | $0.204615 | $0.158718
  {{ hm2-80xlarge }} | $0.367949 | $0.241538 | $0.187436
  {{ hm2-96xlarge }} | $0.425385 | $0.278462 | $0.216154
  {{ hm2-128xlarge }} | $0.567179 | $0.371282 | $0.288205
  {{ hm2-160xlarge }} | $0.682051 | $0.445128 | $0.345641
  {{ hm2-192xlarge }} | $0.796923 | $0.518974 | $0.403077
  {{ hm2-224xlarge }} | $0.911795  | $0.592821 | $0.460513
  {{ hm2-256xlarge }} | $1.080513 | $0.704615 | $0.547179
  {{ hm2-320xlarge }} | $1.310256 | $0.852308 | $0.662051
  {{ hm2-384xlarge }} | $1.540000 | $1.000000 | $0.776923
  {{ hm2-448xlarge }} | $1.769744 | $1.147692 | $0.891795
  {{ hm2-512xlarge }} | $2.053333 | $1.333333 | $1.035897

- Prices in roubles, with VAT

  Host class | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  ----- | ----- | ----- | -----
  **Intel Broadwell** | 
  {{ b1-nano }} | ₽0.70 | — | — 
  {{ b1-small }} | ₽1.82 | — | — 
  {{ hm1-nano }} | ₽5.22 | — | — 
  {{ hm1-micro }} | ₽6.58 | — | — 
  {{ hm1-small }} | ₽7.94 | — | — 
  {{ hm1-medium }} | ₽13.16 | — | — 
  {{ hm1-large }} | ₽15.88 | — | — 
  {{ hm1-xlarge }} | ₽21.32 | — | — 
  {{ hm1-2xlarge }} | ₽26.76 | — | — 
  {{ hm1-3xlarge }} | ₽32.20 | — | — 
  {{ hm1-4xlarge }} | ₽42.64 | — | — 
  {{ hm1-5xlarge }} | ₽53.52 | — | — 
  {{ hm1-6xlarge }} | ₽64.40 | — | — 
  {{ hm1-7xlarge }} | ₽75.28 | — | — 
  {{ hm1-8xlarge }} | ₽86.16 | — | — 
  {{ hm1-9xlarge }} | ₽97.04 | — | — 
  **Intel Cascade Lake** | 
  {{ b2-nano }} | ₽0.70 | — | —
  {{ b2-medium }} | ₽2.38 | — | —
  {{ hm2-nano }} | ₽4.34 | ₽2.92 | ₽2.26
  {{ hm2-micro }} | ₽5.46 | ₽3.64 | ₽2.82 
  {{ hm2-small }} | ₽8.68 | ₽5.84 | ₽4.52 
  {{ hm2-medium }} | ₽10.92 | ₽7.28 | ₽5.64 
  {{ hm2-large }} | ₽13.16 | ₽8.72 | ₽6.76 
  {{ hm2-xlarge }} | ₽17.64 | ₽11.60 | ₽9.00 
  {{ hm2-64xlarge }} | ₽24.22 | ₽15.96 | ₽12.38 
  {{ hm2-80xlarge }} | ₽28.70 | ₽18.84 | ₽14.62 
  {{ hm2-96xlarge }} | ₽33.18 | ₽21.72 | ₽16.86 
  {{ hm2-128xlarge }} | ₽44.24 | ₽28.96 | ₽22.48 
  {{ hm2-160xlarge }} | ₽53.20 | ₽34.72 | ₽26.96 
  {{ hm2-192xlarge }} | ₽62.16 | ₽40.48 | ₽31.44 
  {{ hm2-224xlarge }} | ₽71.12 | ₽46.24 | ₽35.92 
  {{ hm2-256xlarge }} | ₽84.28 | ₽54.96 | ₽42.68 
  {{ hm2-320xlarge }} | ₽102.20 | ₽66.48 | ₽51.64 
  {{ hm2-384xlarge }} | ₽120.12 | ₽78.00 | ₽60.60 
  {{ hm2-448xlarge }} | ₽138.04 | ₽89.52 | ₽69.56
  {{ hm2-512xlarge }} | ₽160.16 | ₽104.00 | ₽80.80

{% endlist %}
