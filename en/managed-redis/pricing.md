---
editable: false
---

# Pricing policy for [!KEYREF mrd-name]

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

Data in the **For 1 GB of RAM** tab is quoted for reference: the table shows how the price of 1 GB of RAM of a Redis host change with the host class.

---

**[!TAB Per month]**

Host class | Price per month, without VAT | Price per month, with VAT 
----- | ----- | ----- | -----
[!KEYREF b1.nano] | ₽423 | ₽508
[!KEYREF b1.small] | ₽1 094 | ₽1 313
[!KEYREF hm1.nano] | ₽3 140 | ₽3 768
[!KEYREF hm1.micro] | ₽4 347 | ₽5 216
[!KEYREF hm1.small] | ₽5 313 | ₽6 375
[!KEYREF hm1.medium] | ₽7 550 | ₽9 060
[!KEYREF hm1.large] | ₽9 506 | ₽11 407
[!KEYREF hm1.xlarge] | ₽13 465 | ₽16 158
[!KEYREF hm1.2xlarge] | ₽16 902 | ₽20 282
[!KEYREF hm1.3xlarge] | ₽20 316 | ₽24 379
[!KEYREF hm1.4xlarge] | ₽23 791 | ₽28 549
[!KEYREF hm1.5xlarge] | ₽30 984 | ₽37 181
[!KEYREF hm1.6xlarge] | ₽37 809 | ₽45 370
[!KEYREF hm1.7xlarge] | ₽44 251 | ₽53 101
[!KEYREF hm1.8xlarge] | ₽50 335 | ₽60 402
[!KEYREF hm1.9xlarge] | ₽56 052 | ₽67 262

**[!TAB Per hour]**

Host class | Price per hour, without VAT | Price per hour, with VAT
----- | ----- | ----- | -----
[!KEYREF b1.nano] | ₽0.5880 | ₽0.7056
[!KEYREF b1.small] | ₽1.5200 | ₽1.8240
[!KEYREF hm1.nano] | ₽4.3608 | ₽5.2332
[!KEYREF hm1.micro] | ₽6.0372 | ₽7.2444
[!KEYREF hm1.small] | ₽7.3792 | ₽8.8548
[!KEYREF hm1.medium] | ₽10.4856 | ₽12.5832
[!KEYREF hm1.large] | ₽13.2032 | ₽15.8436
[!KEYREF hm1.xlarge] | ₽18.7008 | ₽22.4412
[!KEYREF hm1.2xlarge] | ₽23.4752 | ₽28.1700
[!KEYREF hm1.3xlarge] | ₽28.2160 | ₽33.8592
[!KEYREF hm1.4xlarge] | ₽33.0432 | ₽39.6516
[!KEYREF hm1.5xlarge] | ₽43.0336 | ₽51.6408
[!KEYREF hm1.6xlarge] | ₽52.5120 | ₽63.0144
[!KEYREF hm1.7xlarge] | ₽61.4592 | ₽73.7508
[!KEYREF hm1.8xlarge] | ₽69.9104 | ₽83.8920
[!KEYREF hm1.9xlarge] | ₽77.8496 | ₽93.4200

**[!TAB For 1 GB of RAM]**

Host class | Price of 1 GB per hour, without VAT | Price of 1 GB per hour, with VAT 
----- | ----- | ----- | -----
[!KEYREF b1.nano] | ₽0.2940 | ₽0.3528
[!KEYREF b1.small] | ₽0.3800 | ₽0.4560
[!KEYREF hm1.nano] | ₽0.5451 | ₽0.6541
[!KEYREF hm1.micro] | ₽0.5031 | ₽0.6037
[!KEYREF hm1.small] | ₽0.4612 | ₽0.5534
[!KEYREF hm1.medium] | ₽0.4369 | ₽0.5243
[!KEYREF hm1.large] | ₽0.4126 | ₽0.4951
[!KEYREF hm1.xlarge] | ₽0.3896 | ₽0.4675
[!KEYREF hm1.2xlarge] | ₽0.3668 | ₽0.4402
[!KEYREF hm1.3xlarge] | ₽0.3527 | ₽0.4232
[!KEYREF hm1.4xlarge] | ₽0.3442 | ₽0.4130
[!KEYREF hm1.5xlarge] | ₽0.3362 | ₽0.4034
[!KEYREF hm1.6xlarge] | ₽0.3282 | ₽0.3938
[!KEYREF hm1.7xlarge] | ₽0.3201 | ₽0.3841
[!KEYREF hm1.8xlarge] | ₽0.3121 | ₽0.3745
[!KEYREF hm1.9xlarge] | ₽0.3041 | ₽0.3649

---


### Storage and backups {#prices-storage}

Service | Cost of 1 GB per month, without VAT | Cost of 1 GB per month, with VAT
----- | ----- | ----- 
Fast network storage | ₽6.7797 | ₽8.1356 |
Backup over storage size | ₽2.1186 | ₽2.5424 ₽

### Outgoing traffic {#prices-traffic}

[!INCLUDE-NOTITLE [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md)]

