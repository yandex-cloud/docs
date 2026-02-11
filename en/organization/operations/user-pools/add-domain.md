---
title: How to associate a domain with a user pool or a {{ org-full-name }} federation
description: Follow this guide to associate a domain with a user pool or a {{ org-name }} federation.
---

# Associating a domain


You can associate a [domain](../../concepts/domains.md) with a [user pool](../../concepts/user-pools.md) or [federation](../../concepts/add-federation.md), which allows authentication through the [Login Discovery](../../concepts/domains.md#login-discovery) system. When authenticating, a user with your domain will be redirected to your federation or user pool.

To use a domain in a user pool or federation, domain ownership must be [verified](validate-domain.md) via a DNS record.

{% note warning %}

You can only associate each domain with one user pool or one federation.

{% endnote %}

## Associating a domain with a user pool {#userpool}

{% include [add-domain-to-pool](../../../_includes/organization/add-domain-to-pool.md) %}

## Associating a domain with a federation {#federation}

{% include [add-domain-to-fed](../../../_includes/organization/add-domain-to-fed.md) %}