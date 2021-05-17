---
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

