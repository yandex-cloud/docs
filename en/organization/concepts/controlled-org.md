---
title: Controlled organizations
description: Create an additional organization in another region linked to the main organization.
---

# Controlled organizations

A _controlled organization_ is an additional organization that allows you to centrally manage your organization, users, and user access settings across different [regions](*regions) from a single interface. After you [link](../operations/add-region.md) a region, you can manage these entities by setting up an organization in the main region; the resources of the organizations remain isolated and available only within their own region.

If the main and controlled organizations are in different regions, [create](../../billing/operations/create-new-account.md) a separate [billing account](*ba) in the controlled organization’s region to pay for its resources. For businesses and individual entrepreneurs, you need to [activate](../../billing/operations/activate-commercial.md) the new billing account; until you activate it, you will not be able to pay for resources.

If the main and controlled organizations are in the same region, by default you pay for the controlled organization's resources from the billing account linked to the main organization.

{% note warning %}

You cannot cancel creating a controlled organization or linking a region.

{% endnote %}

## Controlled organization in {{ yandex-cloud }} UIs {#controlled-org-in-ui}

A controlled organization is a technical entity which is not displayed in {{ yandex-cloud }} UIs: you will not see it listed among your account's organizations in the management console or in {{ cloud-center }}. You cannot switch to a controlled organization or invite users to it.

For a controlled organization, the workflow will be different from that of a regular organization:

* You manage users, groups, federations, and roles in the main organization. In a controlled organization, you cannot create user groups or federations or add users to them: the required entities are automatically [synchronized](#sync) from the main organization.
* In a linked region, resources are created inside clouds belonging to the controlled organization. You will see such clouds in your account’s general list of clouds; work with them in the management console of the relevant region the same way as with the clouds of the main organization.

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

## How to get started {#get-started}

To get started with resources in another region:

1. [Link](../operations/add-region.md) a region to your main organization: this will create a controlled organization.
1. Wait for the initial [synchronization](#sync) between the main and controlled organizations to complete. It may take several hours.
1. Create a [cloud](../../resource-manager/operations/cloud/create-in-another-region.md) in the linked region.
1. Create resources in the new cloud and manage them via that region’s management console.

[*ba]: {% include notitle [paying-account](../../_popups/billing/paying-account.md#account) %}

[*regions]: {% include notitle [region](../../_popups/overview/region.md#regions) %}
