---
title: Getting started with {{ sd-full-name }}
description: This section describes how to get started with {{ sd-name }} and make use of its tools.
---

# Getting started with {{ sd-full-name }}

{{ sd-name }} offers tools for data security and compliance with regulatory requirements and industry standards.

{% include [note-preview-by-request](../_includes/note-preview-by-request.md) %}

## Getting started {#before-begin}

To get started with {{ sd-name }} in {{ yandex-cloud }}:

1. Log in to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../billing/concepts/billing-account.md) linked and its [status](../billing/concepts/billing-account-statuses.md) is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a [folder](../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../resource-manager/operations/folder/create.md).

{{ sd-name }} is comprised of the following modules: Access Transparency, Data Security Posture Management (DSPM), Cloud Infrastructure Entitlement Management (CIEM), and Compliance Portal.

To connect any of these modules, go to the [{{ sd-name }} interface]({{ link-sd-main }}) and click **Connect** next to the module description. You will then be able to learn more about the tool's features and terms of use.

## Configuring {{ sd-name }} {#configure-sd}

The resources of {{ sd-full-name }} modules are located in folders. From the list of available folders, you need to select a folder to store the {{ sd-full-name }} resource modules in.

To get started, assign [roles](./security/index.md) required to work with {{ sd-name }}.

## Access Transparency {#access-transparency}

[Access Transparency]({{ link-sd-main }}trasparency/) is an automated tool you can use to view the analytical data about {{ yandex-cloud }} engineers' actions with the organization's resources – whether during maintenance, [request](../support/overview.md) processing, or when addressing security issues.

The tool ensures transparency of operations and control over the actions of {{ yandex-cloud }} engineers: their action logs are automatically analyzed by a specially trained {{ yagpt-name }}-based model, and issues, if any, can be escalated to have the session checked by a {{ yandex-cloud }} information security specialist.

For more information, see [{#T}](./concepts/access-transparency.md).

## Data Security Posture Management (DSPM) {#dspm}

[Data Security Posture Management or DSPM]({{ link-sd-main }}dspm/) is a tool that helps to quickly detect sensitive information stored in {{ objstorage-full-name }} [buckets](../storage/concepts/bucket.md) for timely action to protect it from unauthorized access or leaks. For more information, see [{#T}](./concepts/dspm.md).

To get started with the DSPM module, follow the guides on how to [create a data source](./operations/dspm/create-data-source.md) and to [create a scan](./operations/dspm/create-scan.md) for the bucket information.

## Cloud Infrastructure Entitlement Management (CIEM) {#ciem}

{{ sd-name }} [Cloud Infrastructure Entitlement Management]({{ link-sd-main }}iam-diagnostics/) is a tool that provides a centralized [view](./operations/ciem/view-permissions.md) of the full list of accesses to the organization's [resources](../iam/concepts/access-control/resources-with-access-control.md) available to the [subjects](../iam/concepts/access-control/index.md#subject): [users](../overview/roles-and-resources.md#users), [service accounts](../iam/concepts/users/service-accounts.md), [user groups](../organization/concepts/groups.md), [system groups](../iam/concepts/access-control/system-group.md), and [public groups](../iam/concepts/access-control/public-group.md). The tool also makes it easy to [revoke](./operations/ciem/revoke-permissions.md) accesses from subjects. For more information, see [{#T}](./concepts/ciem.md).

To get started with the CIEM module, follow the guide for [viewing](./operations/ciem/view-permissions.md) and [revoking](./operations/ciem/revoke-permissions.md) accesses.

## Compliance Portal {#compliance}

{{ sd-name }} [Compliance Portal]({{ link-sd-main }}compliance/) contains all the required documents, reports, guides, and additional information about the {{ yandex-cloud }} security system.

Here you can download public documents or request documents containing confidential data, if available.

For more information, see [{#T}](./concepts/compliance.md).

## Required roles {#required-roles}

To work with {{ sd-name }}, assign the user the required [roles](./security/index.md) for each module. The list of required roles may depend on your organization's security policies.

| Module | Service setup role | User role |
| --- | --- | --- |
| Access Transparency | `access-transparency.admin` for organization | `access-transparency.viewer` for organization |
| Data Security Posture Management (DSPM) | `dspm.admin` for individual resource | `dspm.inspector` for organization |
| Cloud Infrastructure Entitlement Management (CIEM) | `organization-manager-viewer` for organization | `organization-manager-viewer` for organization |

## What's next {#whats-next}

* Learn [how to scan buckets for sensitive information](./operations/dspm/create-scan.md) in {{ sd-name }}.
* Learn [how to view a subject's access list](./operations/ciem/view-permissions.md) in {{ sd-name }}.
* Learn about the [required access permissions](./security/index.md) to work with {{ sd-name }}.