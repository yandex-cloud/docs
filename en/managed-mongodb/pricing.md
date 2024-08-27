---
editable: false
---

# {{ mmg-name }} pricing



In this section, you can find {{ mmg-name }} pricing [rules](#rules) and [effective prices](#prices) for the service resources.

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

{% include [pricing-status-warning.md](../_includes/mdb/pricing-status-warning.md) %}

## What goes into the cost of using {{ mmg-short-name }} {#rules}

The {{ mmg-name }} usage cost is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. You can find supported resource configurations in the [Host classes](concepts/instance-types.md) section, and vCPU and RAM prices, in the [Prices](#prices) section.

The minimum billing unit is one minute (for example, 1.5 minutes of host operation cost the same as 2 minutes). You are not paying for the time when the {{ MG }} host is unable to perform its main functions.

### Disk space usage {#rules-storage}

You pay for the following:

* Storage allocated for DB clusters.


* Non-replicated SSD (`network-ssd-nonreplicated`) storage can only be ordered for clusters with three or more hosts, in increments of 93 GB.

   * You can only order local SSD storage (`local-ssd`) for clusters with three or more hosts:
      * For **Intel Broadwell** and **Intel Cascade Lake**: In increments of 100 GB.
      * For **Intel Ice Lake**: In increments of {{ local-ssd-v3-step }}.

   For more information about platform-specific storage limitations, see [{#T}](./concepts/storage.md).


* Space used by DB backups in excess of the storage amount specified for the cluster.

   * Backups are stored free of charge as long as the combined size of the DB and all its backups is smaller than the selected storage size.

   * When performing automatic backups, {{ mmg-short-name }} does not create a new copy but saves the data changed from the previous backup. It means the storage space used by automatic backups only increases in proportion to the volume of changes.

   * The number of hosts in a cluster does not affect the storage size and, therefore, the free volume of backups.

The price covers one month of use based on 720 hours per month. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

### Example of cluster cost calculation {#example}

The cost of using a cluster with the following parameters for 30 days:

* **{{ MG }} hosts**: 3 `s3-c2-m8` hosts: Intel Ice Lake, 2 × 100% vCPU, 8 GB RAM .
* **{{ ui-key.yacloud.mdb.forms.section_storage }}**: 100 GB of HDD network storage.

Cost calculation for {{ MG }} hosts:



> 3 × (2&nbsp;×&nbsp;$0.012800 + 8&nbsp;×&nbsp;$0.007200) = $0.249600
>
> Total: $0.249600, cost per hour of {{ MG }} host operation.

Where:
* 3 is the number of {{ MG }} hosts.
* 2 is the number of vCPUs.
* $0.012800: Cost of using 100% vCPU per hour.
* 8 is the amount of RAM per {{ MG }} host (in GB).
* $0.007200: Cost of using 1 GB of RAM at 100% vCPU per hour.


Calculation for the storage cost and total cost:



> 720 × $0.249600 + 100&nbsp;×&nbsp;$0.025600 = $182.272000
>
> Total: $182.272000, cost of using the cluster for 30 days.

Where:
* 720: Number of hours in 30 days.
* $0.249600: Cost per hour of {{ MG }} host operation.
* 100: Amount of HDD network storage (in GB).
* $0.025600: Cost of using 1 GB of HDD network storage per month.



## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


All prices below do not include VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Host computing resources {#prices-host}

The prices for computing resources are the same for all types of hosts: mongod, mongos, and mongocfg.



{% include [usd-host](../_pricing/managed-mongodb/usd-host.md) %}



### Storage and backups {#prices-storage}


{% note info %}

Access to network SSD storage with three replicas is provided upon request. Contact [support]({{ link-console-support }}) or your account manager.

{% endnote %}




{% include [usd-storage](../_pricing/managed-mongodb/usd-storage.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

