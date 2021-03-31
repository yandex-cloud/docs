---
editable: false
---

# Pricing for {{ mms-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## Cluster status {#running-stopped}

Pricing is applied differently depending on the cluster status:

* `Running` cluster: You pay for software licenses, computing resources, storage, and backups.
* `Stopped` cluster: You're charged for storage and backups in full, but pricing for software licenses is described in [{#T}](#license). Computing resources are free of charge.

  {% note alert %}

  If a cluster uses local storage (`local-ssd`), its computing resources are not released when it's stopped and are charged in full.

  {% endnote %}

## What goes into the cost of using {{ mms-short-name }} {#rules}

The cost of {{ mms-name }} usage is based on:

* The cost of licenses for Microsoft Windows Server Standard and Microsoft SQL Server.

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Software license usage {#license}

You're charged for using licenses monthly on an pre-payment basis. This means that a fee is charged at the beginning of a billing period before you actually start using the service resources. In this case:

* If you stop or delete your cluster during the billing period, license costs for this period are not refunded.
* If you change the cluster configuration and reduce resource consumption, the cost of released licenses for this period is not refunded. A new cost is valid from the first day of the following month.
* If you create a new cluster or restart a previously stopped cluster during the billing period, the license cost is calculated based on the number of days remaining in the billing period. For example, if there are 30 days in the month and 7 days left until the end of the month, you'll pay 7/30 of the monthly license cost.
* If you change the cluster configuration and increase resource consumption, you'll need additional licenses. Their cost is calculated based on the number of days remaining in the billing period. For example, if there are 30 days in the month and 7 days left until the end of the month, you'll additionally pay 7/30 of the monthly cost of new licenses.

### DB host usage {#rules-hosts-uptime}

The cost of using DB hosts is calculated according to the host class. Exact class characteristics are given in [{#T}](concepts/instance-types.md). The host usage fee is charged in accordance with the agreement.

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for the time when the DB host is not performing its main functions.

### Disk space usage {#rules-storage}

The disk space usage fee is charged in accordance with the agreement. The following is charged:

* Storage allocated for DB clusters.
  * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with 3 or more hosts in 100 GB increments.
* Space used by DB backups in excess of the storage specified for the cluster.
  * Backups are stored free of charge as long as the combined size of the database and all backups is less than the storage volume selected.
  * During an automatic backup, {{ mms-short-name }} doesn't create a new copy, but saves changes to the database compared to the previous copy. This means that storage used by automatic backups increases only in proportion to the volume of changes that are made.
  * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}

### Licenses {#licence}

For the following products, funds are debited once for the calendar month in advance when a VM is started, regardless of the actual amount of time the VM runs for:

{% list tabs %}

- Prices in USD, without VAT

  | Resource | Cost per month |
  | ----- | ----- |
  | Windows Server Standard* | $77.179488 per host |
  | Microsoft SQL Server Standard | $302.384620 for every 4 vCPUs |
  | Microsoft SQL Server Enterprise | $1 034.000014 for every 4 vCPUs |

- Prices in roubles, with VAT

  | Resource | Cost per month |
  | ----- | ----- |
  | Windows Server Standard* | ₽6 020 per host |
  | Microsoft SQL Server Standard | ₽23 586 for every 4 vCPUs |
  | Microsoft SQL Server Enterprise | ₽80 652 for every 4 vCPUs |

{% endlist %}

\* Windows Server Standard is provided at a fixed price that doesn't depend on VM configurations.

### Host computing resources {#prices-hosts}

{% list tabs %}

- Prices in USD, without VAT

  | Resource | Cost for 1 hour |
  | ----- | ----- |
  | **Intel Cascade Lake** |
  | 100% vCPU | $0.015385 |
  | RAM (for 1 GB) | $0.004103 |
 
- Prices in roubles, with VAT

  | Resource | Cost for 1 hour |
  | ----- | ----- |
  | **Intel Cascade Lake** |
  | 100% vCPU | ₽1.20 |
  | RAM (for 1 GB) | ₽0.32 |

{% endlist %}

### Storage and backups {#prices-storage}

{% list tabs %}

- Prices in USD, without VAT

  | Service | Cost of 1 GB per month |
  | ----- | ----- |
  | Standard network storage |  $0.029335 |
  | Fast network storage |  $0.104302 |
  | Fast local storage |  $0.104302 |
  | Backups beyond the storage size |  $0.032594 |
  
- Prices in roubles, with VAT

  | Service | Cost of 1 GB per month |
  | ----- | ----- |
  | Standard network storage |  ₽2.2881 |
  | Fast network storage |  ₽8.1356 |
  | Fast local storage |  ₽8.1356 |
  | Backups beyond the storage size |  ₽2.5424 |

{% endlist %}

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "pre-kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

## Estimated prices for host classes {#calculated-prices}

Prices for the time of host uptime are calculated based on [host classes](concepts/instance-types.md) and the aforementioned prices for using software licenses, vCPU, and RAM for the corresponding platform. To accurately calculate the cost of the desired cluster, use the [calculator](https://cloud.yandex.ru/services/managed-sqlserver#calculator).

{% include [host-class-price-alert](../_includes/mdb/pricing-host-class-alert.md) %}

{% list tabs %}

- Prices in USD, without VAT

  For a month of host operation at the rate of 720 hours per month, rounded to an integer, USD.

  | Host class | Cost of a standard license | Cost of an enterprise license |
  | ----- | ----- | ----- |
  | **Intel Cascade Lake** |
  | {{ m2-small }} | $518 | $1 250 |
  | {{ m2-medium }} | $739 | $1 836 |
  | {{ m2-large }} | $960 | $2 423 |
  | {{ m2-xlarge }} | $1 401 | $3 596 |
  | {{ m2-2xlarge }} | $1 842 | $4 769 |
  | {{ m2-3xlarge }} | The host class is not available | $7 114 |
  | {{ m2-4xlarge }} | The host class is not available | $9 460 |
  | {{ m2-5xlarge }} | The host class is not available | $11 805 |
  | {{ m2-6xlarge }} | The host class is not available | $14 151 |
  | {{ m2-7xlarge }} | The host class is not available | $16 497 |
  | {{ m2-8xlarge }} | The host class is not available | $18 842 |
  | {{ s2-small }} | $471 | $1 203 |
  | {{ s2-medium }} | $865 | $2 328 |
  | {{ s2-large }} | $1 259 | $3 454 |
  | {{ s2-xlarge }} | $1 653 | $4 579 |
  | {{ s2-2xlarge }} | $2 441 | $6 831 |
  | {{ s2-3xlarge }} | The host class is not available |  $9 082 |
  | {{ s2-4xlarge }} | The host class is not available |  $11 333 |
  | {{ s2-5xlarge }} | The host class is not available |  $13 584 |
  | {{ s2-6xlarge }} | The host class is not available |  $18 086 |
  
- Prices in roubles, with VAT

  For a month of host operation at the rate of 720 hours per month, rounded to an integer, RUB.

  | Host class | Cost of a standard license | Cost of an enterprise license |
  | ----- | ----- | ----- |
  | **Intel Cascade Lake** |
  | {{ m2-small }} | ₽40 435 | ₽97 501 |
  | {{ m2-medium }} | ₽57 642 | ₽143 241 |
  | {{ m2-large }} | ₽74 850 | ₽188 982 |
  | {{ m2-xlarge }} | ₽109 264 | ₽280 462 |
  | {{ m2-2xlarge }} | ₽143 679 | ₽371 943 |
  | {{ m2-3xlarge }} | The host class is not available | ₽554 905 |
  | {{ m2-4xlarge }} | The host class is not available | ₽737 866 |
  | {{ m2-5xlarge }} | The host class is not available | ₽920 828 |
  | {{ m2-6xlarge }} | The host class is not available | ₽1 103 790 |
  | {{ m2-7xlarge }} | The host class is not available | ₽1 286 751 |
  | {{ m2-8xlarge }} | The host class is not available | ₽1 469 713 |
  | {{ s2-small }} | ₽36 748 | ₽93 814 |
  | {{ s2-medium }} | ₽67 477 | ₽181 609 |
  | {{ s2-large }} | ₽98 205 | ₽269 403 |
  | {{ s2-xlarge }} | ₽128 934 | ₽357 198 |
  | {{ s2-2xlarge }} | ₽190 390 | ₽532 786 |
  | {{ s2-3xlarge }} | The host class is not available |  ₽708 375 |
  | {{ s2-4xlarge }} | The host class is not available |  ₽883 964 |
  | {{ s2-5xlarge }} | The host class is not available |  ₽1 059 553 |
  | {{ s2-6xlarge }} | The host class is not available |  ₽1 410 730 |

{% endlist %}