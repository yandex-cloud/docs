---
editable: false
---
# Pricing rules for {{ ydb-name }} dedicated mode

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/pricing/pricing-status.md) %}

## What goes into the cost of using YDB {#rules}

When using {{ ydb-name }} in dedicated mode, you pay for the following:

* The type and size of [storage groups](../concepts/databases.md#storage-groups) allocated for the DB.
* Allocated computing resources.

Other consumed resources to be additionally paid for:

* The space used in {{ objstorage-name }} to store on-demand backups.
* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Use of computing resources {#rules-hosts-uptime}

The cost is calculated for each hour of VM operation in accordance with its class. Exact class characteristics are given in [Basic concepts](../concepts/databases.md#compute-units).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation).

### Disk space usage {#rules-storage}

The following is charged:

* Storage allocated for DB storage groups.

* Space used by on-demand DB backups saved in {{ objstorage-name }}. The cost of creating and storing backups is calculated according to the {{ objstorage-name }} rates.

   {% note info %}

   For each DB, Yandex Database automatically creates and stores two full backups for the last two days for free. No fee is charged for storing automatic backups.

   {% endnote %}

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Discount for committed volumes of services (CVoS) {#cvos}

You can get a guaranteed discount on service resource usage when you plan for a month, a year, or three years ahead.

Yandex Database provides two types of [CVoS](../../billing/concepts/cvos.md): for vCPUs and RAM for the DB hosts. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also pre-estimate your monthly payments for DBs that use a specific class of VMs.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}

## Pricing {#prices}

All prices are shown with VAT. Prices are given for a 30-day month. For shorter months, the price is higher. For longer months, it's lower.

### Host computing resources {#prices-compute-units}

{% list tabs %}

- Prices in USD

  | Resource | Cost for 1 hour, without VAT | Cost with CVoS for 1 year, without VAT |
  | ----- | ----- | ----- |
  | **Intel Cascade Lake** |
  | 100% vCPU | $0.0150 | $0.010897 (-28%) |
  | RAM (for 1 GB) | $0.004102 | $0.002692 (-35%) |

- Prices in roubles

  | Resource | Cost for 1 hour, with VAT | Cost with CVoS for 1 year, with VAT |
  | ----- | ----- | ----- |
  | **Intel Cascade Lake** |
  | 100% vCPU | ₽1.17 | ₽0.85 (-28%) |
  | RAM (for 1 GB) | ₽0.32 | ₽0.21 (-35%) |

{% endlist %}

### Storage and backups {#prices-storage}

{% list tabs %}

- Prices in USD

  | Service | Cost of 1 GB per month, without VAT |
  | ----- | ----- |
  | Data storage in storage groups of SSD drives | $0.171923 |
  | Storage of on-demand backups in {{ objstorage-full-name }} | $0.016166 |

- Prices in roubles

  | Service | Cost of 1 GB per month, with VAT |
  | ----- | ----- |
  | Data storage in storage groups of SSD drives | ₽13.410 |
  | Storage of on-demand backups in {{ objstorage-full-name }} | ₽1.261 |

{% endlist %}

{% note info "Минимальный размер группы" %}

A single [storage group](../concepts/databases.md##storage-groups) can store up to 100 GB of user data.  The minimum granularity of space allocation for a DB is one storage group.

{% endnote %}

To create on-demand backups in {{ ydb-name }}, specify a bucket in {{ objstorage-name }}.

### Outgoing traffic {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}

## Estimated cost of computing resources {#calculated-prices}

The cost of operation time is given for [computing resource classes](../concepts/databases.md#compute-units).

**Per month per DB with 1 VM**

At the rate of 720 hours per month.

{% list tabs %}

- Prices in USD

  | Host class | Cost per month, without VAT | Cost with CVoS for 1 year, without VAT |
  | ----- | ----- | ----- |
  | **Intel Cascade Lake** |
  | s2-medium | $180,923079 |  $124.800001 (-31%) |

- Prices in roubles

  | Host class | Cost per month, with VAT | Cost with CVoS for 1 year, with VAT |
  | ----- | ----- | ----- |
  | **Intel Cascade Lake** |
  | s2-medium | ₽14,112 |  ₽9,734.40 (-31%) |

{% endlist %}

**Per hour per DB with 1 VM**

{% list tabs %}

- Prices in USD

  | Host class | Cost of 1 hour, without VAT | Cost with CVoS for 1 year, without VAT |
  | ----- | ----- | ----- |
  | **Intel Cascade Lake** |
  | s2-medium | $0.251282 |  $0.173333 (-31%) |

- Prices in roubles

  | Host class | Cost of 1 hour, with VAT | Cost with CVoS for 1 year, with VAT |
  | ----- | ----- | ----- |
  | **Intel Cascade Lake** |
  | s2-medium | ₽19.60 |  ₽13.52 (-31%) |

{% endlist %}

