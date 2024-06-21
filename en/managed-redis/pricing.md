---
editable: false
---

# {{ mrd-name }} pricing

In this section, you can find {{ mrd-name }} pricing [rules](#rules) and [effective prices](#prices) for the service resources.

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

## What goes into the cost of using {{ mrd-short-name }} {#rules}

The {{ mrd-name }} usage cost is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. You can find the supported resource configurations in the [Host classes](concepts/instance-types.md) section, and vCPU and RAM prices, in the [Prices](#prices) section.

The minimum billing unit is one minute (for example, 1.5 minutes of host operation cost the same as 2 minutes). You are not paying for the time when the {{ RD }} host is unable to perform its main functions.

### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for DB clusters.

   * Non-replicated SSD (`network-ssd-nonreplicated`) storage can only be ordered for clusters with three or more hosts running Intel Cascade Lake and Intel Ice Lake, in increments of 93 GB.

   * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
            * For **Intel Broadwell** and **Intel Cascade Lake**: In increments of 100 GB.
      * For **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.

   * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts for **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.

   For more information about platform-specific storage limitations, see [Disk types](./concepts/storage.md).

* Space used by DB backups in excess of the storage requested for the cluster.

   * Backups are stored free of charge as long as the combined size of the DB and all backups is smaller than the selected storage size.
   * The requested storage size is allocated for each host, so the number of hosts in the cluster does not affect the free backup size.

The cost is specified for one month of use and based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).


## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mrd-name }} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns feature dashes under [Prices](#prices). Currently, you cannot order storage or web traffic this way.

{% endnote %}

## Prices for Russia {#prices}





All prices are shown without VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Host computing resources {#prices-hosts}



{% include [usd-host.md](../_pricing/managed-redis/usd-host.md) %}


### Storage and backups {#prices-storage}


{% note info %}

Access to network SSD storage with 3 replicas is provided on request. Contact [technical support]({{ link-console-support }}) or your account manager.

{% endnote %}





{% include [usd-storage.md](../_pricing/managed-redis/usd-storage.md) %}


{% include [storage-limitations-mrd](../_includes/mdb/mrd/storage-limitations-note.md) %}

{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}