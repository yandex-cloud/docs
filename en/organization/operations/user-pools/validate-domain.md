---
title: How to verify a domain in a {{ org-full-name }} user pool or federation
description: Follow this guide to verify a domain in an {{ org-name }} user pool or federation.
---

# Verifying a domain


{% include [note-preview](../../../_includes/note-preview.md) %}

You can use only verified [domains](../../concepts/domains.md) to add users.

To validate a domain, you must be its owner and have the credentials to modify DNS records on the website of your domain’s DNS provider.

## Verifying a domain in a user pool {#userpool}

{% include [validate-domain-in-pool](../../../_includes/organization/validate-domain-in-pool.md) %}

## Verifying a domain in an identity federation {#federation}

{% include [validate-domain-in-fed](../../../_includes/organization/validate-domain-in-fed.md) %}