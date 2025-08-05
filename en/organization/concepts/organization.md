---
title: Organization
description: Organization is a workspace that combines various types of {{ yandex-cloud }} resources and enables users to work with them.
---

# Organization

An _organization_ is the highest resource in the {{ yandex-cloud }} resource model hierarchy that consolidates the resources of all other services. Organizations are also used to manage users and their authentication and authorization settings.

When working with {{ yandex-cloud }} services, you create resources, such as managed database clusters, virtual machines, disks, networks, etc. Most services store their resources in [folders](../../resource-manager/concepts/resources-hierarchy.md#folder). Folders belong to [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud), and clouds belong to organizations. A cloud may only belong to one organization, but you can move clouds between organizations. [{{ resmgr-full-name }}](../../resource-manager/concepts/resources-hierarchy.md) is a service that manages clouds and folders; {{ org-name }} manages organizations. Access to {{ yandex-cloud }} resources is managed via roles.

{{ yandex-cloud }} organization structure:

![users-and-resources](../../_assets/overview/users-resources.svg "Users and resources hierarchy")

## Access management in an organization {#access-management}

Within an organization, users deal with {{ yandex-cloud }} resources. Organizations do not interact with one another, which is why an organization's resources are available only to [its members](membership.md). This does not apply to resources authorized to be accessed from the [public groups](../../iam/concepts/access-control/public-group.md) titled `All users` and `All authenticated users`.

You can set up access to an organization's resources for individual users or user groups. You have the following tools for that:

* [User groups](groups.md): Allow issuing identical access permissions to several users at the same time.
* [Identity federation](add-federation.md): Implements a single sign-on system for users within an organization – even users without a Yandex account.
* [User pools](user-pools.md): Allow grouping [local users](../../iam/concepts/users/accounts.md#local) into containers.
* [{{ iam-full-name }}](../../iam/concepts/index.md): Provides users with roles they need to perform specific operations with a particular {{ yandex-cloud }} resource.

## Organization security management {#security}

These practices can help you manage security of your organization:

* [Use refresh tokens in the {{ yandex-cloud }} CLI](../operations/enable-refresh-tokens.md).
* [Set up {{ oslogin }} access](../operations/os-login-access.md).
* [Require two-factor authentication](../operations/enable-2fa-access.md).
* [Block users from viewing information about organization members](../operations/hide-user-info.md).

## Service management {#service-management}

Most {{ yandex-cloud }} services store their resources in [folders](../../resource-manager/concepts/resources-hierarchy.md#folder) within an [organization](organization.md). However, some services are separate from the common resource and role model. They operate at the organization level and can exchange data with other services within the same organization. These services include:

* [{{ tracker-full-name }}]({{ link-tracker }})
* [{{ datalens-full-name }}]({{ link-datalens-main }})
* [{{ wiki-full-name }}]({{ link-wiki }})
* [{{ forms-full-name }}]({{ link-forms-b2b }})
* [{{ ml-platform-full-name }}]({{ link-datasphere-main }})
* [{{ speechsense-full-name }}]({{ link-speechsense-main }})

To start managing the services:

1. [Log in]({{ link-passport }}) as the organization administrator or owner.

1. Go to [{{ cloud-center }}]({{ cloud-center-link }}).

1. If you want to manage one of the separate services, find and click it in the list of services on the right-hand panel.

   To manage other services, click **{{ ui-key.yacloud_org.dashboard.products.action.console }}** in the top-right corner.

## Use cases {#examples}

* [{#T}](../../tutorials/security/user-group-access-control.md)
* [{#T}](../../tutorials/security/integration-gworkspace.md)
* [{#T}](../../tutorials/security/integration-azure.md)
* [{#T}](../../tutorials/security/integration-adfs.md)

## What's next {#what-is-next}

* [{#T}](membership.md)
* [Managing organizations](../operations/organizations-overview.md)
* [Managing user groups](../operations/manage-groups.md)
* [Managing identity federations](../operations/manage-federations.md)
* [{#T}](os-login.md)
* [Getting started with {{ sd-full-name }}](../../security-deck/quickstart-overview.md)
* [{#T}](../tutorials/user-group-access-control.md)
