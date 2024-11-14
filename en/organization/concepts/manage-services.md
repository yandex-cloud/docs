---
title: Managing {{ yandex-cloud }} resources in {{ org-full-name }}
description: Use {{ org-full-name }} to expand the capabilities of your business. A cloud is your organization's workspace. All clouds connected to your organization are displayed in the "Clouds and services" section.
---

# Managing clouds and services

Use {{ org-full-name }} to expand the capabilities of your business. Create a [cloud](#cloud) and connect [collaboration and business intelligence services](#collaboration).

Collaboration services and business intelligence tools are available to all organizations. To use [{{ yandex-cloud }} services]({{ link-cloud-services }}), create a cloud.

{% note info %}

All clouds and services can be managed by a user with the `{{ roles-organization-owner }}` role. To learn how to grant roles to a user, see [Roles](../security/index.md#admin).

{% endnote %}

To go to cloud and service management:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. [Log in]({{ link-passport }}) as the organization administrator or owner.

  1. Go to [{{ cloud-center }}]({{ cloud-center-link }}).

  1. On the page that opens, there is a list of services in the right-hand panel: {{ console-full-name }}, {{ tracker-full-name }}, {{ datalens-full-name }}, {{ wiki-full-name }}, {{ forms-full-name }}, {{ ml-platform-full-name }}, and {{ speechsense-full-name }}.

      To go to a service, click one in the list.

  1. Go to the [management console]({{ link-console-main }}) to view a list of clouds connected to the organization.

{% endlist %}

## Cloud {#cloud}

A cloud is your organization's workspace. All clouds connected to your organization are displayed in the [{{ yandex-cloud }} management console]({{ link-console-main }}).

A corporate administrator can create new directories and resources in the cloud, connect {{ yandex-cloud }} services, and manage relevant access. Learn more about using {{ yandex-cloud }} resources in the [{{ resmgr-full-name }} documentation](../../resource-manager/concepts/resources-hierarchy.md).

The organization's first cloud will connect automatically when an administrator logs in to the management console. To connect an additional cloud, you need to create a [billing account](../../billing/quickstart/).

If there are multiple organizations registered in your account, you can [move](../../resource-manager/operations/cloud/change-organization.md) clouds between them. To do this, you need the `{{ roles-cloud-owner }}` [role](../security/index.md#organization-manager-organizations-owner) for the cloud being transferred and the `{{ roles-organization-owner }}` [role](../../resource-manager/security/index.md#resource-manager-clouds-owner) for the organization to transfer the cloud to.

## Collaboration and business intelligence services {#collaboration}


Collaboration services and business intelligence tools are available to all organizations and connect automatically when any organization user logs in for the first time.

* [{{ console-full-name }}]({{ link-console-main }}) provides an interface to work with {{ yandex-cloud }}. In {{ console-name }}, you can manage cloud resources, set up notifications, and contact support.

    For more information about the service and its features, see the [{{ console-full-name }} documentation](../../console/index.yaml).

* [{{ tracker-full-name }}]({{ link-tracker }}) is a service to manage your organization's tasks and projects. {{ tracker-name }} helps you allocate resources, set tasks, and track task completion.

    For more information about the service and its features, see the [{{ tracker-full-name }} documentation](../../tracker/index.yaml).

* [{{ datalens-full-name }}]({{ link-datalens-main }}) is a service that enables you to track product and business metrics and make data-informed decisions. In {{ datalens-full-name }}, you can connect various data sources, build visualizations and dashboards, and share results.

    For more information about the service and its features, see the [{{ datalens-full-name }} documentation](../../datalens/index.yaml).

* [{{ wiki-full-name }}]({{ link-wiki }}) is a service to create a corporate knowledge base for company employees to populate and update. {{ wiki-name}} gives employees extra collaboration capabilities: they can share information, get answers to frequently asked questions, and hold discussions in the page comment section.

    For more information about the service and its features, see the [{{ wiki-full-name }} documentation](../../wiki/index.yaml).

* [{{ forms-full-name }}]({{ link-forms-b2b }}) is a service that enables you to administer surveys among co-workers or customers, collect feedback, and accept applications. Corporate users have access to [{{ forms-full-name }} advanced business functions](../../forms/forms-for-org.md), such as integration with {{ tracker-name }} and {{ wiki-name}}, form access management, as well as special question sections.

    For more information about the service and its features, see the [{{ forms-full-name }} documentation](../../forms/index.yaml).

* [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) is a full-cycle ML development service. {{ ml-platform-full-name }} is part of the data platform and provides powerful features to work with {{ yandex-cloud }} services. {{ ml-platform-name }} helps significantly reduce the cost of ML as compared to computing on your own hardware or other cloud platforms due to automatic maintenance of computing resources.

    For more information about the service and its features, see the [{{ ml-platform-full-name }} documentation](../../datasphere/index.yaml).

* [{{ speechsense-full-name }}]({{ link-speechsense-main }}) is a speech recognition and analysis service. {{ speechsense-name }} provides flexible tools for collecting statistics and integrating with your business communication channels, such as phone calls, chats, PBX and CRM systems.

    For more information about the service and its features, see the [{{ speechsense-full-name }} documentation](../../speechsense/index.yaml).


