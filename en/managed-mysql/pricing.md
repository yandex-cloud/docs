---
title: '{{ mmy-name }} pricing policy'
description: The cost of {{ mmy-name }} usage is calculated based on the disk type and storage size, computing resources allocated to cluster hosts, settings and number of backups, and amount of outgoing traffic from {{ yandex-cloud }} to the internet.
editable: false
---


# {{ mmy-name }} pricing policy

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      md: 6
    indent:
      top: '0'
      bottom: '0'
    children:
      - type: basic-card
        title: Price calculator
        text: Calculate the cost of the service based on your needs
        gravityIcon: Calculator
        iconPosition: left
        urlTitle: Price calculator
        url: https://yandex.cloud/en/prices?state=7f776c1fc309#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Price list
        text: Current prices of all our services
        gravityIcon: CircleRuble
        iconPosition: left
        urlTitle: Price list
        url: https://yandex.cloud/en/price-list?services=dn28hpu626uudbq0j8mk
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::


This section describes the {{ mmy-name }} pricing [policy](#rules) and [current prices](#prices) for its resources.

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}


## What goes into the cost of using {{ mmy-short-name }} {#rules}

The {{ mmy-name }} usage cost includes:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}


### Database host usage {#rules-hosts-uptime}

There are different ways to calculate the cost depending on the [host type](concepts/index.md):

* Standard hosts

  The host operation cost is charged per hour based on what computing resources you allocate for it.


* Dedicated hosts

  There are two cost components: the [{{ compute-full-name }} computing resources](../compute/pricing.md#prices) and the {{ mmy-name }} markup on these resources.


You can find the supported resource configurations in the [Host classes](concepts/instance-types.md) section. For the vCPU and RAM prices, see [Prices](#prices).

The minimum billing unit is one minute (for example, 1.5 minutes of host operation cost the same as two minutes). You will not be charged for the time when the {{ MY }} host is unavailable for basic operations.


### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for database clusters.

    * You can order local SSD storage (`local-ssd`) only for clusters with three or more hosts:

      
        * For **Intel Cascade Lake**: In increments of 100 GB.


        * For **Intel Ice Lake** and **AMD Zen 4**: In {{ local-ssd-v3-step }} increments.

    * You can only order non-replicated SSD storage (`network-ssd-nonreplicated`) in 93 GB increments for clusters with three or more hosts.

{% include [pricing-backup-general](../_includes/mdb/pricing-backup-general.md) %} 

For more information, see [Backups in {{ mmy-name }}](concepts/backup.md).
 
The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as 2 minutes).

### Cluster cost calculation example {#example}

Suppose we calculate the 30-day usage cost of a cluster with the following configuration:

* **{{ MY }} hosts**: Three `s3-c2-m8` hosts, Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM.
* **{{ ui-key.yacloud.mdb.forms.section_storage }}**: 100 GB of network HDD storage.

Cost calculation for {{ MY }} hosts:




{% include [usd-mysql-host](../_pricing_examples/managed-mysql/usd-host.md) %}


Calculation for the storage cost and total cost:




{% include [usd-mysql-storage](../_pricing_examples/managed-mysql/usd-storage.md) %}



## Discount for committed volume of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mmy-name }} provides two types of CVoS: for vCPUs and for RAM on the hosts you are going to use in your database clusters. In the management console, you can see how much you can potentially save with CVoS at your current consumption level. You can also estimate your monthly payments for the required number of vCPUs and RAM.

{% note info %}

A CVoS discount is only available for certain resource types. For unsupported resource types, the relevant CVoS columns under [Prices](#prices) are blank. Storage size and internet traffic cannot currently be reserved via CVoS.

{% endnote %}


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

Host prices are [calculated in different ways](#rules-hosts-uptime) depending on the selected host type.

The price of local SSD storage (`local-ssd`) also depends on the host type.

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}


{% include [Access to Compute Optimized on request](../_includes/mdb/note-compute-optimized-request.md) %}


There are two cost components: the [{{ compute-full-name }} computing resources](../compute/pricing.md#prices) and the {{ mmy-name }} markup on these resources.




<MDX>
  <PriceList
    serviceIds={['{{ pcs|mdb.mysql }}']}
    excludeSkuIds={['{{ pc|mdb.software_accelerated_network.mysql.highfreq-v4a.cores.dedicated }}', '{{ pc|mdb.software_accelerated_network.mysql.highfreq-v4a.cores-key-value }}', '{{ pc|mdb.software_accelerated_network.mysql.highfreq-v3.cores.dedicated }}', '{{ pc|mdb.software_accelerated_network.mysql.highfreq-v3.cores-key-value }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
