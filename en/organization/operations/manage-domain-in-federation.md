---
title: How to set up a domain in an identity federation in {{ org-full-name }}
description: Follow this guide to set up a domain in an identity federation in {{ org-name }}.
---

# Setting up a domain in an identity federation


A [domain](../concepts/domains.md) allows you to authenticate through [Login Discovery](../concepts/domains.md#login-discovery). When authenticating, a user with your domain will be redirected to your [identity federation](../concepts/add-federation.md).

## Associating a domain {#add}

{% include [add-domain-to-fed](../../_includes/organization/add-domain-to-fed.md) %}


## Getting a list of domains {#list}

{% include [list-domain-in-fed](../../_includes/organization/list-domain-in-fed.md) %}

## Viewing information about a domain {#get}

{% include [get-domain-in-fed](../../_includes/organization/get-domain-in-fed.md) %}

## Deleting a domain {#delete}

You cannot delete the default domain or a domain with associated users.

{% include [delete-domain-from-fed](../../_includes/organization/delete-domain-from-fed.md) %}