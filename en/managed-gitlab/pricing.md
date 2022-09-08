---
editable: false
---

# Pricing for {{ mgl-full-name }}

## What goes into the cost of using {{ mgl-name }} {#rules}

When using {{ mgl-name }}, you pay for the following:
* Allocated instance computing resources (virtual machine).
* Instance data storage (disk) capacity.

Other consumed resources to be additionally paid for:
* The space used in {{ objstorage-full-name }} to store backups.
* Outgoing traffic from {{ yandex-cloud }} to the internet.

In all calculations, 1 GB = 2<sup>10</sup> MB = 2<sup>20</sup> KB = 2<sup>30</sup> bytes.

### Use of computing resources {#rules-hosts-uptime}

The cost is calculated for each hour of VM operation.

The minimum billing unit is one hour (for example, the cost of 1.5 hours of operation is the same as the cost of 2 hours of operation).

### Disk space usage {#rules-storage}

The following is charged:
* Storage allocated for instance data.
* Space used by backups saved in {{ objstorage-name }}.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}

### Instance computing resources {#prices-instance}

{% if region == "ru" %}

{% include [rub-instance-resources.md](../_pricing/managed-gitlab/rub-instance-resources.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-instance-resources.md](../_pricing/managed-gitlab/kzt-instance-resources.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-instance-resources.md](../_pricing/managed-gitlab/usd-instance-resources.md) %}

{% endif %}

### Storage and backups {#prices-storage}

{% if region == "ru" %}

{% include [rub-storage.md](../_pricing/managed-gitlab/rub-storage.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-storage.md](../_pricing/managed-gitlab/kzt-storage.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-storage.md](../_pricing/managed-gitlab/usd-storage.md) %}

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