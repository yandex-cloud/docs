---
title: How to set up a domain in a {{ org-full-name }} user pool
description: Follow this guide to set up a domain in a {{ org-name }} user pool.
---

# Managing domains in a user pool


{% include [note-preview](../../../_includes/note-preview.md) %}

A [domain](../../concepts/domains.md) allows you to authenticate through the [Login Discovery](../../concepts/domains.md#login-discovery) system. When authenticating, a user with your domain will be redirected to your [user pool](../../concepts/user-pools.md).

## Associating a domain {#add}

{% include [add-domain-to-pool](../../../_includes/organization/add-domain-to-pool.md) %}

## Verifying a domain {#validate}

You can use only verified domains to add users.

{% include [validate-domain-in-pool](../../../_includes/organization/validate-domain-in-pool.md) %}

## Getting a list of domains {#list}

{% include [list-domain-in-pool](../../../_includes/organization/list-domain-in-pool.md) %}

## Viewing information about a domain {#get}

{% include [get-domain-in-pool](../../../_includes/organization/get-domain-in-pool.md) %}

## Deleting a domain {#delete}

You cannot delete the default domain or a domain with associated users.

{% include [delete-domain-from-pool](../../../_includes/organization/delete-domain-from-pool.md) %}
