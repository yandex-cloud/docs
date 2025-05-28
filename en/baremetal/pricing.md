---
title: '{{ baremetal-full-name }} pricing policy'
description: This article covers the {{ baremetal-name }} pricing policy.
editable: false
---

# {{ baremetal-full-name }} pricing policy



In {{ baremetal-name }}, you pay for leasing a server of a [certain configuration](concepts/server-configurations.md). A leased server is billable for the entire lease period, whether it is on or off.

The monthly prices are based on 720 hours per month.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}




All prices are per month and do not include VAT.

{% include [usd-servers.md](../_pricing/baremetal/usd-servers.md) %}


{% note info %}

[Quarantined](./concepts/servers.md#quarantine) servers are free of charge. However, if a server is not restored for further use during the quarantine, the time it spent in quarantine will be included in the paid lease term.

{% endnote %}

### Public subnets {#public-subnets}

{% note info %}

The prices for public subnets are effective from May 15, 2025.

{% endnote %}



All prices do not include VAT.

{% include [usd-subnets](../_pricing/baremetal/usd-subnets.md) %}


^1^ The price per month is provided for reference only, assuming a 720-hour (30-day) month. The cost per hour is used in {{ billing-name }} calculations.
