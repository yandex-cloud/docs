---
editable: false
---
# Pricing for {{ mmg-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mmg-short-name }} {#rules}

The cost of {{ mmg-name }} usage is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the {{ MG }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.
    * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with more than 3 hosts in 100 GB increments.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.

    * During an automatic backup, {{ mmg-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.

    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use.  The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{mmg-name}} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also pre-estimate your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}


## Pricing {#prices}

### Host computing resources {#prices-host}

The prices for computing resources are the same for all types of hosts: mongod, mongos, and mongocfg.

{% list tabs %}

- Prices in USD, without VAT

    | Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
    | ----- | ----- | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | $0.000385 | - | - 
    | 20% vCPU | $0.003718 | - | - 
    | 50% vCPU | $0.006026 | - | - 
    | 100% vCPU | $0.012821 | - | - 
    | RAM (for 1 GB) | $0.006410 | - | - 
    | **Intel Cascade Lake** |
    | 5% vCPU | $0.000385 | - | - 
    | 20% vCPU | $0.003718 | - | - 
    | 50% vCPU | $0.006026 | - | - 
    | 100% vCPU | $0.012821 | $0.010128 (-21%) | $0.007564 (-41%) 
    | RAM (for 1 GB) | $0.006410 | $0.005641 (-12%) | $0.004872 (-24%) 

- Prices in roubles, with VAT

    | Resource | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
    | ----- | ----- | ----- | ----- |
    | **Intel Broadwell** |
    | 5% vCPU | ₽0.03 | - | - 
    | 20% vCPU | ₽0.29 | - | - 
    | 50% vCPU | ₽0.47 | - | - 
    | 100% vCPU | ₽1.00 | - | - 
    | RAM (for 1 GB) | ₽0.50 | - | - 
    | **Intel Cascade Lake** |
    | 5% vCPU | ₽0.03 | - | - 
    | 20% vCPU | ₽0.29 | - | - 
    | 50% vCPU | ₽0.47 | - | - 
    | 100% vCPU | ₽1.00 | ₽0.79 (-21%)  | ₽0.59 (-41%)  
    | RAM (for 1 GB) | ₽0.50 | ₽0.44 (-12%) | ₽0.38 (-24%) 

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

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the above prices for using vCPU and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.com/services/managed-mongodb#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

{% list tabs %}

- Prices in USD, without VAT

  Host class | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  ----- | ----- | ----- | -----
  **Intel Broadwell** |
  {{ b1-nano }} | $0.013590 | - | - 
  {{ b1-micro }} | $0.020256 | - | - 
  {{ b1-medium }}  | $0.037692 | - | - 
  {{ s1-nano }} | $0.038462 | - | - 
  {{ s1-micro }} | $0.076923 | - | - 
  {{ s1-small }} | $0.153846 | - | - 
  {{ s1-medium }}| $0.307692 | - | - 
  {{ s1-large }} | $0.615385 | - | - 
  {{ s1-xlarge }} | $1.230769 | - | - 
  **Intel Cascade Lake** |
  {{ b2-nano }}| $0.013590 | - | - 
  {{ b2-micro }} | $0.020256 | - | - 
  {{ b2-medium }} | $0.037692 | - | - 
  {{ m2-micro }} | $0.128205 | $0.110513 (-14%) | $0.093077 (-27%)
  {{ m2-small }} | $0.256410 | $0.221026 (-14%) | $0.186154 (-27%)
  {{ m2-medium }}| $0.384615 | $0.331538 (-14%) | $0.279231 (-27%)
  {{ m2-large }} | $0.512821 | $0.442051 (-14%) | $0.372308 (-27%)
  {{ m2-xlarge }} | $0.769231 | $0.663077 (-14%) | $0.558462 (-27%)
  {{ m2-2xlarge }} | $1.025641 | $0.884103 (-14%) | $0.744615 (-27%)
  {{ m2-3xlarge }} | $1.538462 | $1.326154 (-14%) | $1.116923 (-27%)
  {{ m2-4xlarge }} | $2.051282 | $1.768205 (-14%) | $1.489231 (-27%)
  {{ m2-5xlarge }} | $2.564103 | $2.210256 (-14%) | $1.861538 (-27%)
  {{ m2-6xlarge }} | $3.076923 | $2.652308 (-14%) | $2.233846 (-27%)
  {{ m2-7xlarge }} | $3.589744 | $3.094359 (-14%) | $2.606154 (-27%)
  {{ m2-8xlarge }} | $4.102564 | $3.536410 (-14%) | $2.978462 (-27%)
  {{ s2-micro }} | $0.076923 | $0.065385 (-15%) | $0.054103 (-30%)
  {{ s2-small }} | $0.153846 | $0.130769 (-15%) | $0.108205 (-30%)
  {{ s2-medium }} | $0.307692 | $0.261538 (-15%) | $0.216410 (-30%)
  {{ s2-large }} | $0.461538 | $0.392308 (-15%) | $0.324615 (-30%)
  {{ s2-xlarge }} | $0.615385 | $0.523077 (-15%) | $0.432821 (-30%)
  {{ s2-2xlarge }} | $0.923077 | $0.784615 (-15%) | $0.649231 (-30%)
  {{ s2-3xlarge }} | $1.230769 | $1.046154 (-15%) | $0.865641 (-30%)
  {{ s2-4xlarge }} | $1.538462 | $1.307692 (-15%) | $1.082051 (-30%)
  {{ s2-5xlarge }} | $1.846154 | $1.569231 (-15%) | $1.298462 (-30%)
  {{ s2-6xlarge }} | $2.461538 | $2.092308 (-15%) | $1.731282 (-30%)

- Prices in roubles, with VAT

  Host class | Rate for 1 hour | With CVoS for 1 year | With CVoS for 3 years
  ----- | ----- | ----- | -----
  | **Intel Broadwell** |
  {{ b1-nano }}| ₽1.06 | − | −
  {{ b1-micro }} | ₽1.58 | − | −
  {{ b1-medium }} | ₽2.94 | − | −
  {{ s1-nano }} | ₽3.00 | − | −
  {{ s1-micro }} | ₽6.00 | − | −
  {{ s1-small }} | ₽12.00 | − | −
  {{ s1-medium }} | ₽24.00 | − | −
  {{ s1-large }} | ₽48.00 | − | −
  {{ s1-xlarge }} | ₽96.00 | − | −
  **Intel Cascade Lake** |
  {{ b2-nano }}| ₽1.06 | − | −
  {{ b2-small }} | ₽1.58 | − | −
  {{ b2-medium }} | ₽2.94 | − | −
  {{ m2-micro }} | ₽10.00 | ₽8.62 (-14%) | ₽7.26 (-27%)
  {{ m2-small }} | ₽20.00 | ₽17.24 (-14%) | ₽14.52 (-27%)
  {{ m2-medium }}| ₽30.00 | ₽25.86 (-14%) | ₽21.78 (-27%)
  {{ m2-large }} | ₽40.00 | ₽34.48 (-14%) | ₽29.04 (-27%)
  {{ m2-xlarge }} | ₽60.00 | ₽51.72 (-14%) | ₽43.56 (-27%)
  {{ m2-2xlarge }} | ₽80.00 | ₽68.96 (-14%) | ₽58.08 (-27%)
  {{ m2-3xlarge }} | ₽120.00 | ₽103.44 (-14%) | ₽87.12 (-27%)
  {{ m2-4xlarge }} | ₽160.00 | ₽137.92 (-14%) | ₽116.16 (-27%)
  {{ m2-5xlarge }} | ₽200.00 | ₽172.40 (-14%) | ₽145.20 (-27%)
  {{ m2-6xlarge }} | ₽240.00 | ₽206.88 (-14%) | ₽174.24 (-27%)
  {{ m2-7xlarge }} | ₽280.00 | ₽241.36 (-14%) | ₽203.28 (-27%)
  {{ m2-8xlarge }} | ₽320.00 | ₽275.84 (-14%) | ₽232.32 (-27%)
  {{ s2-micro }} | ₽6.00 | ₽5.10 (-15%) | ₽4.22 (-30%)
  {{ s2-small }} | ₽12.00 | ₽10.20 (-15%) | ₽8.44 (-30%)
  {{ s2-medium }} | ₽24.00 | ₽20.40 (-15%) | ₽16.88 (-30%)
  {{ s2-large }} | ₽36.00 | ₽30.60 (-15%) | ₽25.32 (-30%)
  {{ s2-xlarge }} | ₽48.00 | ₽40.80 (-15%) | ₽33.76 (-30%)
  {{ s2-2xlarge }} | ₽72.00 | ₽61.20 (-15%) | ₽50.64 (-30%)
  {{ s2-3xlarge }} | ₽96.00 | ₽81.60 (-15%) | ₽67.52 (-30%)
  {{ s2-4xlarge }}| ₽120.00 | ₽102.00 (-15%) | ₽84.40 (-30%)
  {{ s2-5xlarge }}| ₽144.00 | ₽122.40 (-15%) | ₽101.28 (-30%)
  {{ s2-6xlarge }} | ₽192.00 | ₽163.20 (-15%) | ₽135.04 (-30%)

{% endlist %}
