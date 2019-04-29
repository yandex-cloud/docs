---
editable: false
---

# Pricing policy for [!KEYREF mrd-name]

[!INCLUDE [currency-choice](../_includes/pricing/currency-choice.md)]

## What goes into the cost of using [!KEYREF mrd-short-name] {#rules}

The cost of [!KEYREF mrd-name] usage is based on:

* Storage (disk space) type and size.

* [The host class](concepts/instance-types.md) selected for the cluster.

* How many DB hosts are in the clusters.

* Number of backups.

* The amount of outgoing traffic.

[!INCLUDE [pricing-gb-size](../_includes/pricing-gb-size.md)]


### Use of DB hosts {#rules-hosts-uptime}

The cost is calculated for each hour of the host's operation in accordance with its class. The exact class characteristics are given in the section [[!TITLE]](concepts/instance-types.md).

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation). You are not charged for time when the [!KEYREF RD] host is not performing its main functions.


### Disk space use {#rules-storage}

The following is charged:

* Storage allocated for DB clusters.

* Space used by DB backups in excess of the storage specified for the cluster.

    * Backups are stored free of charge as long as the combined size of the DB and all backups is less than the selected storage volume.
    * The number of hosts in the cluster does not affect the size of the storage and, consequently, that of free backups.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).


## Prices {#prices}


### Hosts {#prices-hosts}

The first two tabs contain prices for a single [!KEYREF mrd-name] host working for a month or an hour.

**Price per 1 GB of RAM per hour** is quoted for reference: the table shows how the price of 1 GB of RAM of a Redis host change with the host class.

---

**[!TAB Prices in USD]**

Prices are indicated without VAT.

Host class | Rate for 1 host per hour | Price per 1 GB RAM per hour
----- | ----- | -----
[!KEYREF b1.nano] | $0.009046 | $0.004523
[!KEYREF b1.small] | $0.023384 | $0.005846
[!KEYREF hm1.nano] | $0.067092 | $0.008387
[!KEYREF hm1.micro] | $0.092876 | $0.007740
[!KEYREF hm1.small] | $0.113523 | $0.007095
[!KEYREF hm1.medium] | $0.161323 | $0.006722
[!KEYREF hm1.large] | $0.203123 | $0.006348
[!KEYREF hm1.xlarge] | $0.287707 | $0.005994
[!KEYREF hm1.2xlarge] | $0.361153 | $0.005643
[!KEYREF hm1.3xlarge] | $0.434092 | $0.005426
[!KEYREF hm1.4xlarge] | $0.508353 | $0.005295
[!KEYREF hm1.5xlarge] | $0.662061 | $0.005172
[!KEYREF hm1.6xlarge] | $0.807876 | $0.005049
[!KEYREF hm1.7xlarge] | $0.945523 | $0.004925
[!KEYREF hm1.8xlarge] | $1.075538 | $0.004802
[!KEYREF hm1.9xlarge] | $1.197692 | $0.004678

**[!TAB Prices in roubles]**

Prices are indicated including VAT.

Host class | Rate for 1 host per hour | Price per 1 GB RAM per hour
----- | ----- | ----- | -----
[!KEYREF b1.nano] | ₽0.7056 | ₽0.3528
[!KEYREF b1.small] | ₽1.8240 | ₽0.4560
[!KEYREF hm1.nano] | ₽5.2332 | ₽0.6541
[!KEYREF hm1.micro] | ₽7.2444 | ₽0.6037
[!KEYREF hm1.small] | ₽8.8548 | ₽0.5534
[!KEYREF hm1.medium] | ₽12.5832 | ₽0.5243
[!KEYREF hm1.large] | ₽15.8436 | ₽0.4951
[!KEYREF hm1.xlarge] | ₽22.4412 | ₽0.4675
[!KEYREF hm1.2xlarge] | ₽28.1700 | ₽0.4402
[!KEYREF hm1.3xlarge] | ₽33.8592 | ₽0.4232
[!KEYREF hm1.4xlarge] | ₽39.6516 | ₽0.4130
[!KEYREF hm1.5xlarge] | ₽51.6408 | ₽0.4034
[!KEYREF hm1.6xlarge] | ₽63.0144 | ₽0.3938
[!KEYREF hm1.7xlarge] | ₽73.7508 | ₽0.3841
[!KEYREF hm1.8xlarge] | ₽83.8920 | ₽0.3745
[!KEYREF hm1.9xlarge] | ₽93.4200 | ₽0.3649

---


### Storage and backups {#prices-storage}

---

**[!TAB Prices in USD]**

Service | Rate for 1 GB per month, without VAT
----- | ----- | ----- 
Fast network storage | $0.104302 |
Backup over storage size | $0.032594 ₽


**[!TAB Prices in roubles]**

Service | Rate for 1 GB per month, with VAT
----- | -----
Fast network storage | ₽8.1356 |
Backup over storage size | ₽2.5424 ₽

---

### Outgoing traffic {#prices-traffic}

[!INCLUDE-NOTITLE [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md)]

