---
editable: false
---

# Pricing for {{ mgl-full-name }}

## What goes into the cost of using {{ mgl-name }} {#rules}

When running {{ mgl-name }}, you pay for:
* Computing resources of your VM instance.
* Data storage used by the instance.

Other consumed resources to be additionally paid for:
* The space used in {{ objstorage-full-name }} to store backups.
* Egress traffic from {{ yandex-cloud }}.

In all calculations, 1 GB = 2<sup>10</sup> MB = 2<sup>20</sup> KB = 2<sup>30</sup> bytes.

### Using computing resources {#rules-hosts-uptime}

You are charged per hour of VM use.

The minimum billing unit is one hour (it means that you'll pay the same amount for 1.5 and 2 hours of your VM operation, for example).

### Disk space usage {#rules-storage}

The following is charged:
* Size of the data storage allocated for your instance.
* Size of backups stored in {{ objstorage-name }}.

The cost is specified for one month of use. The minimum billing unit is 1 GB per hour (for example, the cost of storing 1 GB for 1.5 hours is equal to the cost of storage for 2 hours).

## Pricing {#prices}

### Computing resources of instances {#prices-instance}




{% include [usd-instance-resources.md](../_pricing/managed-gitlab/usd-instance-resources.md) %}


### Storage and backups {#prices-storage}




{% include [usd-storage.md](../_pricing/managed-gitlab/usd-storage.md) %}


### Egress traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}


## Licenses {#license}

By default, {{ mgl-name }} uses Community Edition {{ GL }}. If you have a paid {{ GL }} [license](https://about.gitlab.com/pricing/)(`Premium` or `Ultimate`), contact [support]({{ link-console-support }}) or your account manager to use it in {{ mgl-name }}.