---
title: Controlled organizations
description: Create an additional organization in another region linked to the main organization.
---

# Controlled organizations

A _controlled organization_ is an additional organization that allows you to centrally manage your organization, users, and user access settings across multiple [regions](../../overview/concepts/region.md) through a single interface. After you [connect](../operations/add-region.md) a region, you can manage these entities by setting up an organization in the main region; in the meantime, the resources of the organizations remain isolated and available only within their own region.

By default, in a controlled organization, charges for resources are debited from the billing account linked to the main organization. To change your payment system (e.g., to pay in your regional currency), contact your account manager.

Users cannot migrate or be invited to a controlled organization. In a controlled organization, you cannot create user groups or federations or add users to them.

{% note warning %}

You cannot cancel creating a controlled organization or linking a region.

{% endnote %}

## Syncing {#sync}

The following entities are automatically synced between the controlled organization and the main one:

* [Yandex accounts](../../iam/concepts/users/accounts.md#passport) and [federated accounts](../../iam/concepts/users/accounts.md#saml-federation).
* [User groups](groups.md) and group membership.
* [Federations](add-federation.md).
* [Roles](../../iam/concepts/access-control/roles.md).
* Quotas for entities created before connecting the controlled organization.

Not synced:

* Quotas for entities created after connecting the controlled organization.
* {{ oslogin }} settings.
