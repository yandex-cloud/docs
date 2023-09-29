---
title: "Managing {{ yandex-cloud }} resources in {{ org-full-name }}"
description: "Use {{ org-full-name }} to expand the capabilities of your business. A cloud is your organization's workspace. All the clouds connected to your organization are displayed in the \"Clouds and services\" section."
---


# Managing clouds and services

Use {{ org-full-name }} to expand the capabilities of your business. Create a [cloud](#cloud) and connect [collaboration and business intelligence services](#collaboration).

Collaboration services and business intelligence tools are available to all organizations. To use [{{ yandex-cloud }} services]({{ link-cloud-services }}), create a cloud.

{% note info %}

All clouds and services can be managed by users with the `organization-manager.organizations.owner` role. For information on assigning roles to users, see [Roles](../security/index.md#admin).

{% endnote %}

To go to cloud and service management:

1. [Log in]({{link-passport}}) to the organization's administrator or owner account.

1. Go to [{{org-full-name}}]({{link-org-main}}).

1. In the panel on the left, select [Clouds and services]({{link-org-services}}) ![icon-services](../../_assets/organization/icon-services.svg).

   The page displays a list of clouds connected to the organization and the following services: {{ tracker-full-name }}, {{ wiki-full-name }}, {{ forms-full-name }}, {{ datalens-full-name }}, and {{ ml-platform-full-name }}.

1. To go to a service, click the service card.

   To open a cloud in the {{ yandex-cloud }} console, click the cloud name.



## Cloud {#cloud}

A cloud is your organization's workspace. All the clouds connected to your organization are displayed in the **Clouds and services** section.

A corporate administrator can create new directories and resources in the cloud, connect {{ yandex-cloud }} services, and manage relevant access. Learn more about using {{ yandex-cloud }} resources in the [{{ resmgr-full-name }} documentation](../../resource-manager/concepts/resources-hierarchy.md).

An organization's first cloud will connect automatically when an administrator logs in to the [{{ yandex-cloud }} console]({{ link-console-main }}). To connect an additional cloud, you need to create a [billing account](../../billing/quickstart/).

If there are multiple organizations registered in your account, you can [move](../../resource-manager/operations/cloud/change-organization.md) clouds between them.


## Collaboration and business intelligence services {#collaboration}

Collaboration services and business intelligence tools are available to all organizations and connect automatically when any organization user logs in for the first time. 

* [{{ tracker-full-name }}]({{ link-tracker }}) is a service to manage your organization's tasks and projects. {{ tracker-name }} will help you allocate resources, set tasks, and track task implementation.

   For more information about the service and its features, see the [{{ tracker-full-name }} documentation](../../tracker/).

* [{{ wiki-full-name }}]({{ link-wiki }}) is a service to create a corporate knowledge base for company employees to populate and update. {{ wiki-name}} gives company employees additional capabilities for collaboration: they can share information, search for answers to frequently asked questions, and hold discussions in the page comment section.

   For more information about the service and its features, see the [{{ wiki-full-name }} documentation](../../wiki/).

* [{{ forms-full-name }}]({{ link-forms-b2b }}) is a service that enables you to administer surveys among co-workers or customers, collect feedback, and accept applications. Corporate users have access to advanced functions in [{{ forms-full-name }} for business](../../forms/forms-for-org.md), such as integration with {{ tracker-name }} and {{ wiki-name}}, form access management, as well as special question sections.

   For more information about the service and its features, see the [{{ forms-full-name }} documentation](../../forms/).

* [{{ datalens-full-name }}]({{ link-datalens-main }}) is a service that enables you to track product and business metrics and make data-informed decisions. In {{ datalens-full-name }}, you can connect various data sources, build visualizations and dashboards, and share results.

   For more information about the service and its features, see the [{{ datalens-full-name }} documentation](../../datalens/).

* [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) is a full-cycle ML development service. {{ ml-platform-full-name }} is part of the data platform and offers powerful features to easily work with {{ yandex-cloud }} services. {{ ml-platform-name }} helps significantly reduce the cost of ML as compared to computing on your own hardware or other cloud platforms thanks to automatic maintenance of computing resources.

   For more information about the service and its features, see the [{{ ml-platform-full-name }} documentation](../../datasphere/)
