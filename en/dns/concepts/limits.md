---
title: Quotas and Limits in {{ dns-name }}
description: 'The {{ dns-name }} service has limits and quotas for the number of zones in one cloud, the number of record sets in one cloud, the number of record sets in one zone. You will learn more about the limitations of the service in this article.'

editable: false
---

# Quotas and limits in {{ dns-name }}

{{ dns-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [limits](../../_includes/cloud-dns-limits.md) %}

## Other restrictions {#other-restrictions}

* You can't create public top-level domain (TLD) zones.
* You can't immediately add a record with a public IP address to a domain zone while creating a VM.
* Automatic creation of PTR records is only available in internal zones.