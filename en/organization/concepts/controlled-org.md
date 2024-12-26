---
title: Managed organizations
description: Create an additional organization in another region linked to the main organization.
---

# Managed organizations

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

## Overview


In {{ yandex-cloud }}, there are two [regions](../../overview/concepts/region.md) isolated from each other on all levels. To put your resources in another region, you need to register a separate organization and link your billing account to it. Once you do that, the management console will only show to you the services and resources of the region you select; you will not be able to transfer accounts or synchronize the settings between your organizations. 

You can create a _managed organization_ to create resources in different regions and manage them from a single interface. Use it to put your resources in another region without registering a separate organization for the purpose. A managed organization will allow [linking](../operations/add-region.md) a region to your main organization.

A managed organization is subject to several limitations:

* Users cannot navigate to a managed organization via the {{ org-full-name }} UI. 
* You cannot invite new users to a managed organization. 
* You cannot create user groups or federations or add new users to them in a managed organization.

{% note warning %}

You cannot cancel creating a managed organization or linking a region.

{% endnote %}

When you create a managed organization, the resources in different regions remain isolated from each other. Your data is kept and available only within each individual region.

## Syncing

A managed organization automatically syncs the following entities with the main organization at the organization level:

* [Yandex accounts](../../iam/concepts/users/accounts.md#passport) and [federated accounts](../../iam/concepts/users/accounts.md#saml-federation)
* [User groups](groups.md) and group membership
* [Federations](add-federation.md)
* [Roles](../../iam/concepts/access-control/roles.md)

The quotas for the listed entities get synced when you create a managed organization. They will not be synced from then on.

The roles assigned for clouds, folders, or separate resources are not synced. The {{ oslogin }} setting are not synced either.
