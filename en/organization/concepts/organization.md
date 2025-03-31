---
title: Organization
description: Organization is a global workspace that combines various types of {{ yandex-cloud }} resources and enables users to work with them.
---

# Organization

An organization is the highest resource in the {{ yandex-cloud }} resource model hierarchy. Organizations store the resources of all other services. Also, organizations are used for managing users and their authentication and [authorization](#access-management) settings. For more information, see [{#T}](#organizations-and-yc-resources).

## Relationships between organizations and {{ yandex-cloud }} resources {#organizations-and-yc-resources}

Organizations store the resources of {{ yandex-cloud }} services. The resources of an organization cannot interact with the resources of another organization using {{ yandex-cloud }} tools. Organizations are managed by {{ org-name }}.

Each organization owns one or more [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud). A cloud may only belong to one organization, but you can move clouds between organizations.

A cloud contains [folders](../../resource-manager/concepts/resources-hierarchy.md#folder). Each folder belongs to a single cloud. There are no folders outside a cloud. You cannot create a folder inside another folder. [{{ resmgr-full-name }}](../../resource-manager/concepts/resources-hierarchy.md) manages clouds and folders.

Most {{ yandex-cloud }} resources, such as managed database clusters, virtual machines, disks, networks, and others, reside in folders. You specify a folder when creating a resource. However, some services are separate from the common resource and role model and operate at the organization level. These services include:

* [{{ tracker-full-name }}]({{ link-tracker }})
* [{{ datalens-full-name }}]({{ link-datalens-main }})
* [{{ wiki-full-name }}]({{ link-wiki }})
* [{{ forms-full-name }}]({{ link-forms-b2b }})
* [{{ ml-platform-full-name }}]({{ link-datasphere-main }})
* [{{ speechsense-full-name }}]({{ link-speechsense-main }})

You can see the relationships between organizations and {{ yandex-cloud }} resources in the diagram below:

![users-and-resources](../../_assets/overview/users-resources.svg "Users and resources hierarchy")

## Access management in an organization {#access-management}

An organization is a basic object where users interact with {{ yandex-cloud }} resources. Only [members of an organization](membership.md) can access its resources. This does not apply to resources access to which is granted to the `All users` and `All authenticated users` [public groups](../../iam/concepts/access-control/public-group.md).

You can also configure access management within an organization for specific users, user groups, or services. To do this, you can use these tools:

* [User groups](groups.md): These allow you to give identical access permissions to multiple users simultaneously.
* [Identity federation](add-federation.md): Implements a single sign-on system for the organization’s users, even if they do not have a Yandex account.
* [{{ iam-full-name }}](../../iam/concepts/index.md): Allows you to provide users with roles required for performing certain operations with a certain {{ yandex-cloud }} resource.

## Service management {#service-management}

Most {{ yandex-cloud }} services store their resources in [folders](../../resource-manager/concepts/resources-hierarchy.md#folder) within an [organization](organization.md). To manage such services:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. [Log in]({{ link-passport }}) as the organization administrator or owner.

  1. Go to [{{ cloud-center }}]({{ cloud-center-link }}).

  1. Click **Cloud Console** in the top-right corner.

{% endlist %}

Some services are separate from the common resource and role model. They operate at the organization level and can exchange data with other services within the same organization. These services include:

* [{{ tracker-full-name }}]({{ link-tracker }})
* [{{ datalens-full-name }}]({{ link-datalens-main }})
* [{{ wiki-full-name }}]({{ link-wiki }})
* [{{ forms-full-name }}]({{ link-forms-b2b }})
* [{{ ml-platform-full-name }}]({{ link-datasphere-main }})
* [{{ speechsense-full-name }}]({{ link-speechsense-main }})

To start managing such services:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. [Log in]({{ link-passport }}) as the organization administrator or owner.

  1. Go to [{{ cloud-center }}]({{ cloud-center-link }}).

  1. Find the service you need in the list of services on the right-hand panel and click it.      

{% endlist %}

## What's next {#what-is-next}

* [{#T}](membership.md)
* [Managing organizations](../operations/organizations-overview.md)
* [Managing user groups](../operations/manage-groups.md)
* [Managing identity federations](../operations/manage-federations.md)
* [{#T}](os-login.md)
* [Getting started with {{ sd-full-name }}](../../security-deck/quickstart-overview.md)
* [{#T}](../tutorials/user-group-access-control.md)
