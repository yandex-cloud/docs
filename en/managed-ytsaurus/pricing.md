---
title: '{{ myt-full-name }} pricing policy'
description: This article covers the {{ myt-name }} pricing policy.
editable: false
---

# {{ myt-full-name }} pricing policy



{% note info %}

{{ myt-full-name }} is at the [Preview](../overview/concepts/launch-stages.md) stage.

{% endnote %}

In this section, you can find the {{ myt-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources. Other {{ yandex-cloud }} resources you may employ while using the service are charged based on their pricing plans.


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## Cluster status {#running-stopped}

The prices apply differently depending on the cluster status:

* For a `Running` cluster, you pay for both the computing resources and storage size.
* For a `Stopped` cluster, you only pay for your storage size.

## What goes into the cost of using {{ myt-name }} {#rules}

When using {{ myt-name }}, you pay for:

* Disk type and storage size.
* Computing resources allocated to the cluster components.
   * Number of vCPUs.
   * Amount of RAM.
* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Using cluster components {#rules-components-uptime}

The component operation cost is charged per hour based on what computing resources you allocate for it. You can check the supported component configuration options in the [relevant section](concepts/component-types.md) and see prices for using vCPUs and RAM in the [Prices](#prices) section.

You can choose the configuration option for exec and tablet nodes based on the expected load. The number of service components, such as master, storage, system, and proxy nodes, depends on the cluster configuration and is applied automatically. See below for the minimum setup of service components required for a {{ ytsaurus-name }} cluster to run:
* **Master node**: Three configuration instances, 4 vCPUs and 12 GB RAM.
* **System node**: Two configuration instances, 24 vCPUs and 64 GB RAM.
* **Proxy node**: Two instances: One HTTP proxy and one RPC proxy.
* Service **tablet node**: Two `c8-m16` configuration instances, 8 vCPUs and 16 GB RAM. Service tablet nodes are used for system dynamic tables.
* **Storage node**: The number of storage nodes depends on the storage configuration and is applied as per below.

   **Defining the number of storage nodes in a cluster**

   1. For each `HDD`, there is one storage node with 4 vCPUs and 8 GB RAM.
   1. For each `SSD` or `non-replicated SSD`, there is one storage node with 8 vCPUs and 8 GB RAM. 

   Additionally, there are three service storage nodes with 8 vCPUs and 8 GB RAM. They are used to store chunks and logs of system dynamic tables.

The minimum billing unit is one minute (for example, 90 seconds of the component operation cost is same as two minutes).

### Disk space usage {#rules-storage}

You are charged for the following:
* The size of the storage for the exec node, where various jobs are run. 
* The size of the storage for the service storage nodes that stores chunks and logs of system dynamic tables. This size is applied automatically, with three non-replicated SSDs, 93 GB each.
* The size of storage for the storage node that houses the data of all {{ ytsaurus-name }} objects that are created during its operation. This storage may consist of one or two disks. The number and size of such disks are defined as per below.

   **Defining the number of disks in storage nodes**

   1. For each storage node, there is a main disk with the type and size you specify; this disk is used to store chunks.
   1. For each storage node for an `SSD` or `non-replicated SSD`, there is a service disk of the same type; this disk is used to store the logs and snapshots of dynamic tables.
   1. The service disk size depends on the storage configuration and is calculated as follows:
      * Assuming the storage node is for an `SSD` with `N` size, the service disk size is `0,1 × N` GB, rounded up to the nearest integer.
      * Assuming the storage node is for a `non-replicated SSD` with `N` size, the service disk size is `0,1 × N`, rounded up in increments of 93 GB.


The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 90 seconds costs the same as storing 1 GB for two minutes).

### Example of cluster cost calculation {#example}

This is an example of calculating the cost of using a cluster with the following properties for 30 days:

**Configurable components:**
* **Exec node**: One `c8-m32` configuration instance: 8 vCPUs and 32 GB RAM.
* **Tablet node**: Three `c8-m16` configuration instances, 8 vCPUs and 16 GB RAM.
* **Storage** with the following configuration:
   * `HDD` storage: Three disks, 2048 GB each.
   * `Non-replicated SSD` storage: Three disks, 465 GB each.

**Service components:**
* **Master node**: Three configuration instances, 4 vCPUs and 12 GB RAM.
* **System node**: Two configuration instances, 24 vCPUs and 64 GB RAM.
* **Proxy node**: Two instances: One HTTP proxy and one RPC proxy, both with 4 vCPUs and 8 GB RAM.
* Service **tablet node**: Two `c8-m16` configuration instances, 8 vCPUs and 16 GB RAM.
* **Storage** with the following configuration:
   * Exec node storage: One non-replicated SSD, 93 GB.
   * Storage for service storage nodes: Three non-replicated SSDs, 93 GB each.
   * Storage for storage nodes: Six non-replicated SSDs, 93 GB each.

      {% cut "More info on service disks for storage nodes" %}

      1. For three storage nodes for three non-replicated SSDs, 93 GB each, there will be three service disks, also non-replicated SSDs, 93 GB each.
      1. For three storage nodes for three non-replicated SSDs, 465 GB each, there will be three service disks, also non-replicated SSDs, 93 GB each.
   
      {% endcut %}

* **Storage node**: Six storage nodes, each with 8 vCPUs and 8 GB RAM; or three storage nodes, each with 4 vCPUs and 8 GB RAM.

   {% cut "More info on storage nodes" %}
   
   1. For a storage with three non-replicated SSDs, 93 GB each, there are three service storage nodes, each with 8 vCPUs and 8 GB RAM.
   1. For a storage with three HDDs, 2048 GB each, there are three storage nodes, each with 4 vCPUs and 8 GB RAM. 
   1. For a storage with three non-replicated SSDs, 465 GB each, there are three storage nodes, each with 8 vCPUs and 8 GB RAM.
   
   {% endcut %}



{% include [usd-ytsaurus](../_pricing_examples/managed-ytsaurus/usd-example.md) %}


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Component computing resources {#prices-components}



{% include [usd-prices](../_pricing/managed-ytsaurus/usd-components.md) %}


### Storage {#prices-storage}



{% include [usd-prices-storage](../_pricing/managed-ytsaurus/usd-storage.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
