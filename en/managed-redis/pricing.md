---
editable: false
---
# Pricing for {{ mrd-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [pricing-status.md](../_includes/mdb/pricing-status.md) %}

## What goes into the cost of using {{ mrd-short-name }} {#rules}

The cost of {{ mrd-name }} usage is based on:

{% include [pricing-rules](../_includes/mdb/pricing-rules.md) %}

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### DB host usage {#rules-hosts-uptime}

The cost is calculated for each hour of operation of the host in accordance with the allocated computing resources. Supported resource configurations are listed in the [{#T}](concepts/instance-types.md) section, prices for using vCPU and RAM — in the [Prices](#prices) section.

The minimum billing unit is a minute (for example, 1.5 minutes of host usage cost the same as 2 minutes). You are not charged for time when the {{ RD }} host is not performing its main functions.

### Disk space usage {#rules-storage}

The following is charged:

* Disk space allocated for database clusters.
   * Storage on fast local disks (`local-ssd`) can only be ordered for clusters with three or more hosts:
      * For Intel Broadwell and Intel Cascade Lake: In increments of 100 GB.
      * For Intel Ice Lake: In increments of {{ local-ssd-v3-step }}.

* Space used by DB backups in excess of the disk space requested for the cluster.
    * Backups are stored free of charge as long as the combined size of the DB and all backups is less than the selected storage volume.
    * The requested disk size is allocated for each host, so the number of hosts in the cluster does not affect the storage size and, consequently, the free backup size.

The cost is specified for one month of use. The minimum billing unit is 1 GB per minute (for example, storing 1 GB for 1.5 minutes costs the same as storing 1 GB for 2 minutes).

## Discount for committed volumes of services (CVoS) {#cvos}

{% include [cvos](../_includes/mdb/cvos.md) %}

{{ mrd-name }} provides two kinds of CVoS: on vCPUs and RAM on the hosts you plan to use in DB clusters. In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

{% note info %}

You can use a CVoS to order certain types of resources. For non-supported resources, CVoS columns contain dashes under [Prices](#prices). You currently can't order storage or web traffic this way.

{% endnote %}

## Pricing {#prices}

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

{% endif %}

### Host computing resources {#prices-hosts}

{% if region == "ru"%}

{% include [rub-host.md](../_pricing/managed-redis/rub-host.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-host.md](../_pricing/managed-redis/kzt-host.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-host.md](../_pricing/managed-redis/usd-host.md) %}

{% endif %}

### Storage and backups {#prices-storage}

{% if region == "ru"%}

{% include [rub-storage.md](../_pricing/managed-redis/rub-storage.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-storage.md](../_pricing/managed-redis/kzt-storage.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-storage.md](../_pricing/managed-redis/usd-storage.md) %}

{% endif %}

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

