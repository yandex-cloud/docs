---
editable: false
---

# Pricing policy for Managed Service for Redis

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using Managed Service for Redis {#rules}

The cost of Managed Service for Redis usage is based on:

* Storage (disk space) type and size.

* [The host class](concepts/instance-types.md) selected for the cluster.

* How many DB hosts are in the clusters.

* Number of backups.

* The amount of outgoing traffic.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. The exact class characteristics are given in the section [#T](concepts/instance-types.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the Redis host is not performing its main functions.


### Disk space use {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the DB and all backups is less than the selected storage volume.
    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).


## Prices {#prices}


### Hosts {#prices-hosts}

The first two tabs contain prices for a single Managed Service for Redis host working for a month or an hour.

**Price per 1 GB of RAM per hour** is quoted for reference: the table shows how the price of 1 GB of RAM of a Redis host change with the host class.

{% list tabs %}

- Prices in USD
  
  Prices are indicated without VAT.
  
  Host class | Rate for 1 host per hour | Price per 1 GB RAM per hour
  ----- | ----- | -----
  b1.nano (2 GB) | $0.009046 | $0.004523
  b1.small (4 GB) | $0.023384 | $0.005846
  hm1.nano (8 GB) | $0.067092 | $0.008387
  hm1.micro (12 GB) | $0.092876 | $0.007740
  hm1.small (16 GB) | $0.113523 | $0.007095
  hm1.medium (24 GB) | $0.161323 | $0.006722
  hm1.large (32 GB) | $0.203123 | $0.006348
  hm1.xlarge (48 GB) | $0.287707 | $0.005994
  hm1.2xlarge (64 GB) | $0.361153 | $0.005643
  hm1.3xlarge (80 GB) | $0.434092 | $0.005426
  hm1.4xlarge (96 GB) | $0.508353 | $0.005295
  hm1.5xlarge (128 GB) | $0.662061 | $0.005172
  hm1.6xlarge (160 GB) | $0.807876 | $0.005049
  hm1.7xlarge (192 GB) | $0.945523 | $0.004925
  hm1.8xlarge (224 GB) | $1.075538 | $0.004802
  hm1.9xlarge (256 GB) | $1.197692 | $0.004678
  
- Prices in roubles
  
  Prices are indicated including VAT.
  
  Host class | Rate for 1 host per hour | Price per 1 GB RAM per hour
  ----- | ----- | ----- | -----
  b1.nano (2 GB) | ₽0.7056 | ₽0.3528
  b1.small (4 GB) | ₽1.8240 | ₽0.4560
  hm1.nano (8 GB) | ₽5.2332 | ₽0.6541
  hm1.micro (12 GB) | ₽7.2444 | ₽0.6037
  hm1.small (16 GB) | ₽8.8548 | ₽0.5534
  hm1.medium (24 GB) | ₽12.5832 | ₽0.5243
  hm1.large (32 GB) | ₽15.8436 | ₽0.4951
  hm1.xlarge (48 GB) | ₽22.4412 | ₽0.4675
  hm1.2xlarge (64 GB) | ₽28.1700 | ₽0.4402
  hm1.3xlarge (80 GB) | ₽33.8592 | ₽0.4232
  hm1.4xlarge (96 GB) | ₽39.6516 | ₽0.4130
  hm1.5xlarge (128 GB) | ₽51.6408 | ₽0.4034
  hm1.6xlarge (160 GB) | ₽63.0144 | ₽0.3938
  hm1.7xlarge (192 GB) | ₽73.7508 | ₽0.3841
  hm1.8xlarge (224 GB) | ₽83.8920 | ₽0.3745
  hm1.9xlarge (256 GB) | ₽93.4200 | ₽0.3649
  
{% endlist %}


### Storage and backups {#prices-storage}

{% list tabs %}

- Prices in USD
  
  Service | Rate for 1 GB per month, without VAT
  ----- | ----- | ----- 
  Fast network storage | $0.104302 |
  Backup over storage size | $0.032594 ₽
  
  
- Prices in roubles
  
  Service | Rate for 1 GB per month, with VAT
  ----- | -----
  Fast network storage | ₽8.1356 |
  Backup over storage size | ₽2.5424 ₽
  
{% endlist %}

### Outgoing traffic {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}

