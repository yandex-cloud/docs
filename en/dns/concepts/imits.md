---
title: Quotas and limits in Cloud DNS
description: 'The Cloud DNS service has limits and quotas on the number of zones in one cloud, the number of record sets in one cloud, and the number of record sets in one zone. See this article for more information about the limitations in the service.'

editable: false
---

# Quotas and limits

{{ dns-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

{% include [limits](../../_includes/cloud-dns-limits.md) %}

## Other restrictions {#other-restrictions}

* You can't create public top-level domain (TLD) zones.
* You can't immediately add a record with a public IP address to a domain zone while creating a VM.
* Automatic creation of PTR records is only available in internal zones.
