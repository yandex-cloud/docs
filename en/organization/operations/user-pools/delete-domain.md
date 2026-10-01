---
title: How to remove a domain from a {{ org-full-name }} user pool or federation
description: Follow this guide to delete a domain from an {{ org-full-name }} user pool or federation
---

# Deleting a domain


You cannot delete a [domain](../../concepts/domains.md) if:
* This domain is the default one.
* The domain has active user associations, i.e., there are accounts in the user pool or federation that utilize email addresses with this domain.

## Deleting a domain from a user pool {#userpool}

{% include [delete-domain-from-pool](../../../_includes/organization/delete-domain-from-pool.md) %}

## Deleting a domain from a federation {#federation}

{% include [delete-domain-from-fed](../../../_includes/organization/delete-domain-from-fed.md) %}