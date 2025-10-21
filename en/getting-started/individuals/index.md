---
title: '{{ yandex-cloud }}: Getting started for individuals'
description: These articles will help you get started with {{ yandex-cloud }} as an individual. Find the answers to FAQs about a billing account and paid consumption, the initial grant, and documents.
---

# Getting started for individuals

The {{ yandex-cloud }} platform is a suite of reliable and secure services for all kinds of business scenarios. The platform's services use a single pool of unified hardware resources. This makes the platform readily scalable and allows to automatically ramp up infrastructure capacity as needed at minimal cost. The user interacts with {{ yandex-cloud }} resources by means of _organizations_.

An organization is the highest resource in the [resource model](../../resource-manager/concepts/resources-hierarchy.md) hierarchy in {{ yandex-cloud }} that consolidates the resources of all other services. Organizations are also used to manage users and their authentication and authorization settings.

When working with {{ yandex-cloud }} services, you create resources, such as managed database clusters, virtual machines, disks, networks, etc. Most services store their resources in [folders](../../resource-manager/concepts/resources-hierarchy.md#folder). Folders belong to [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud), and clouds belong to organizations. A cloud may only belong to one organization, but you can move clouds between organizations. [{{ resmgr-full-name }}](../../resource-manager/concepts/resources-hierarchy.md) is a service that manages clouds and folders; {{ org-name }} manages organizations. Access to {{ yandex-cloud }} resources is managed via roles.

{{ yandex-cloud }} organization structure:

![users-and-resources](../../_assets/overview/users-resources.svg "Users and resources hierarchy")

{{ yandex-cloud }} has several user interfaces, e.g., the [management console]({{ link-console-main }}), the [command line interface](../../cli/), {{ TF }}, the REST API, and the gRPC API. All actions in this tutorial will be performed through the management console.

To access any user interface, you will need a _user account_. This can be a personal Yandex account (Yandex ID) or a Yandex 360 account. For detailed instructions, see Help for [Yandex ID](https://yandex.com/support/passport/authorization/registration.html) and [Yandex 360](https://yandex.com/support/business/add-users.html).

When a user registers with {{ yandex-cloud }}, a _cloud_ is created for the user. The cloud is a separate workspace with this user as the owner. In this cloud, the `default` folder and `default` network will be created. The owner can create new folders and resources in this cloud, and manage access rights to them. [Learn more about the resource hierarchy in {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md).

In this tutorial, you will:

1. [Create a billing account](registration.md).
1. [Top up your account and configure spending control](payments.md).
1. [Select your support plan](service-plan.md).
1. [Create a VM](create-vm.md) and connect to it over SSH.

This way, you will get started with {{ yandex-cloud }}.
