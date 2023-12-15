---
title: "Quotas and limits in {{ dns-full-name }}"
description: "{{ dns-name }} has limits and quotas for the number of zones per cloud, the number of record sets per cloud, and the number of record sets per zone. For more information about the service restrictions, read this article."

editable: false
---

# Quotas and limits in {{ dns-name }}

{{ dns-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [increase-quotas.md](../../_includes/increase-quotas.md) %}

{% include [limits](../../_includes/cloud-dns-limits.md) %}

## Other restrictions {#other-restrictions}

* You cannot create public top-level domain (TLD) zones.
* You cannot immediately add a record with a public IP address to a domain zone while creating a VM.
* Automatic creation of PTR records is only available in internal zones.