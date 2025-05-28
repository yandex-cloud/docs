---
title: Organization membership
description: Organization members are users who belong to an organization and can access the services within it.
---

## Organization membership

[Organization](organization.md) members are [users](../../overview/roles-and-resources.md#users) who belong to an organization and can access the services within it.

Non-members of an organization cannot gain access to the resources within the organization. This does not apply to resources authorized to be accessed from the [public groups](../../iam/concepts/access-control/public-group.md) titled `All users` and `All authenticated users`.

Organization membership may be held by:

* Users invited to join an organization, upon acceptance of the invitation. To get an invitation, ask the organization [owner](../security/index.md#organization-manager-organizations-owner) or [administrator](../security/index.md#organization-manager-admin) to [add](../operations/add-account.md) you.
* Users of an [identity federation](./add-federation.md) created within an organization (they become members automatically).
* Organization owners who either [created](../operations/manage-organizations.md#create-additional-org) the organization or were assigned the relevant role.

A user can be an owner or member of multiple organizations at the same time. You can [switch](../operations/manage-organizations.md#switch-to-another-org) between organizations in the [management console]({{ link-console-main }}) or the [{{ cloud-center }}]({{ cloud-center-link }}) interface.

{% note tip %}

By default, all {{ org-name }} users can view information about all the other users in the same organization. You can [restrict](../operations/hide-user-info.md) this feature by reserving it for specially authorized users only.

{% endnote %}

## Use cases {#examples}

* [{#T}](../../tutorials/security/user-group-access-control.md)
* [{#T}](../../tutorials/security/integration-keycloak.md)