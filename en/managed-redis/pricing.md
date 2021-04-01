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
    | 100% vCPU | $0.013462 | $0.009487 (-30%) | $0.007308 (-46%)
    | RAM (за 1 ГБ) | $0.003590 | $0.002308 (-36%) | $0.001795 (-50%)
    
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
    | 100% vCPU | ₽1.05 | ₽0.74 (-30%) | ₽0.57 (-46%)
    | RAM (for 1 GB) | ₽0.28 | ₽0.18 (-36%) | ₽0.14 (-50%)


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




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

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
  {{ hm2-nano }} | $0.055641 | $0.037436 (-33%) | $0.028974 (-48%)
  {{ hm2-micro }} | $0.070000 | $0.046667 (-33%) | $0.036154 (-48%)
  {{ hm2-small }} | $0.111282 | $0.074872 (-33%) | $0.057949 (-48%)
  {{ hm2-medium }} | $0.140000 | $0.093333 (-33%) | $0.072308 (-48%)
  {{ hm2-large }} | $0.168718 | $0.111795 (-34%) | $0.086667 (-49%)
  {{ hm2-xlarge }} | $0.226154 | $0.148718 (-34%) | $0.115385 (-49%)
  {{ hm2-60xlarge }} | $0.296154 | $0.195385 (-34%) | $0.151538 (-49%)
  {{ hm2-78xlarge }} | $0.360769 | $0.236923 (-34%) | $0.183846 (-49%)
  {{ hm2-96xlarge }} | $0.425385 | $0.278462 (-35%) | $0.216154 (-49%)
  {{ hm2-128xlarge }} | $0.567179 | $0.371282 (-35%) | $0.288205 (-49%)
  {{ hm2-160xlarge }} | $0.708974 | $0.464103 (-35%) | $0.360256 (-49%)
  {{ hm2-192xlarge }} | $0.850769 | $0.556923 (-35%) | $0.432308 (-49%)
  {{ hm2-224xlarge }} | $0.992564 | $0.649744 (-35%) | $0.504359 (-49%)
  {{ hm2-256xlarge }} | $1.134359 | $0.742564 (-35%) | $0.576410 (-49%)
  {{ hm2-320xlarge }} | $1.417949 | $0.928205 (-35%) | $0.720513 (-49%)
  {{ hm2-384xlarge }} | $1.701538 | $1.113846 (-35%) | $0.864615 (-49%)
  {{ hm2-448xlarge }} | $1.985128 | $1.299487 (-35%) | $1.008718 (-49%)
  {{ hm2-512xlarge }} | $2.268718 | $1.485128 (-35%) | $1.152821 (-49%)

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
  {{ hm2-nano }} | ₽4.34 | ₽2.92 (-33%) | ₽2.26 (-48%)
  {{ hm2-micro }} | ₽5.46 | ₽3.64 (-33%) | ₽2.82 (-48%)
  {{ hm2-small }} | ₽8.68 | ₽5.84 (-33%) | ₽4.52 (-48%)
  {{ hm2-medium }} | ₽10.92 | ₽7.28 (-33%) | ₽5.64 (-48%)
  {{ hm2-large }} | ₽13.16 | ₽8.72 (-34%) | ₽6.76 (-49%)
  {{ hm2-xlarge }} | ₽17.64 | ₽11.60 (-34%) | ₽9.00 (-49%) 
  {{ hm2-60xlarge }} | ₽23.10 | ₽15.24 (-34%) | ₽11.82 (-49%)
  {{ hm2-78xlarge }} | ₽28.14 | ₽18.48 (-34%) | ₽14.34 (-49%)
  {{ hm2-96xlarge }} | ₽33.18 | ₽21.72 (-35%) | ₽16.86 (-49%)
  {{ hm2-128xlarge }} | ₽44.24 | ₽28.96 (-35%) | ₽22.48 (-49%)
  {{ hm2-160xlarge }} | ₽55.30 | ₽36.20 (-35%) | ₽28.10 (-49%)
  {{ hm2-192xlarge }} | ₽66.36 | ₽43.44 (-35%) | ₽33.72 (-49%)
  {{ hm2-224xlarge }} | ₽77.42 | ₽50.68 (-35%) | ₽39.34 (-49%)
  {{ hm2-256xlarge }} | ₽88.48 | ₽57.92 (-35%) | ₽44.96 (-49%)
  {{ hm2-320xlarge }} | ₽110.60 | ₽72.40 (-35%) | ₽56.20 (-49%)
  {{ hm2-384xlarge }} | ₽132.72 | ₽86.88 (-35%) | ₽67.44 (-49%)
  {{ hm2-448xlarge }} | ₽154.84 | ₽101.36 (-35%) | ₽78.68 (-49%)
  {{ hm2-512xlarge }} | ₽176.96 | ₽115.84 (-35%) | ₽89.92 (-49%)

{% endlist %}
