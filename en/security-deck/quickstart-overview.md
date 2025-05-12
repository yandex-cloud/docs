---
title: Getting started with {{ sd-full-name }}
description: This section describes how to get started with {{ sd-name }} and make use of its tools.
---

# Getting started with {{ sd-full-name }}

{{ sd-name }} offers tools for data security and compliance with regulatory requirements and industry standards.

{% include [note-preview-by-request](../_includes/note-preview-by-request.md) %}

## Getting started {#before-begin}

To get started with {{ sd-name }} in {{ yandex-cloud }}:

1. Log in to the [management console]({{ link-console-main }}). If you have not signed up yet, navigate to the management console and follow the on-screen instructions.
1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../billing/concepts/billing-account.md) linked and its [status](../billing/concepts/billing-account-statuses.md) is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a [folder](../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../resource-manager/operations/folder/create.md).

{{ sd-name }} includes the following modules: {{ atr-name }}, Data Security Posture Management (DSPM), Cloud Infrastructure Entitlement Management (CIEM), and Compliance Portal.

To connect any of these modules, go to the [{{ sd-name }} interface]({{ link-sd-main }}) and click **Connect** next to the module description. You will then be able to learn more about the tool's features and terms of use.

## Configuring {{ sd-name }} {#configure-sd}

The resources of {{ sd-full-name }} modules are located in folders. From the list of available folders, you need to select a folder to store the {{ sd-full-name }} resource modules in.

To get started, assign [roles](./security/index.md) required to work with {{ sd-name }}.

## {{ atr-name }} {#access-transparency}

[{{ atr-name }}]({{ link-sd-main }}transparency/) is an automated tool you can use to view analytical data about actions by {{ yandex-cloud }} engineers involving the organization's resources, whether when processing [requests](../support/overview.md), addressing security issues, or during maintenance.

The tool ensures operations are transparent and provides control over actions by {{ yandex-cloud }} engineers: a specially trained {{ yagpt-name }}-based model automatically analyzes their action logs and escalates issues, if any, so that a {{ yandex-cloud }} information security specialist can check the session.

{% include [access-transparency-attach-ba-notice](../_includes/security-deck/access-transparency-attach-ba-notice.md) %}

To learn more, see [{#T}](./concepts/access-transparency.md).

## Data Security Posture Management ({{ dspm-name }}) {#dspm}

[Data Security Posture Management, or {{ dspm-name }}]({{ link-sd-main }}dspm/), helps you quickly detect sensitive information stored in {{ objstorage-full-name }} [buckets](../storage/concepts/bucket.md) for timely action to protect it from unauthorized access or leaks. To learn more, see [{#T}](./concepts/dspm.md).

To get started with the {{ dspm-name }} module, follow the guides on how to [create a data source](./operations/dspm/create-data-source.md) and a [scan](./operations/dspm/create-scan.md) for bucket information.

## Cloud Infrastructure Entitlement Management ({{ ciem-name }}) {#ciem}

{{ sd-name }} [Cloud Infrastructure Entitlement Management]({{ link-sd-main }}iam-diagnostics/) provides a centralized [view](./operations/ciem/view-permissions.md) of the full list of accesses to the organization's [resources](../iam/concepts/access-control/resources-with-access-control.md) available to [subjects](../iam/concepts/access-control/index.md#subject): [users](../overview/roles-and-resources.md#users), [service accounts](../iam/concepts/users/service-accounts.md), [user groups](../organization/concepts/groups.md), [system groups](../iam/concepts/access-control/system-group.md), and [public groups](../iam/concepts/access-control/public-group.md). The tool also makes it easy to [revoke](./operations/ciem/revoke-permissions.md) accesses from subjects. To learn more, see [{#T}](./concepts/ciem.md).

To get started with the {{ ciem-name }} module, follow the guides for [viewing](./operations/ciem/view-permissions.md) and [revoking](./operations/ciem/revoke-permissions.md) accesses.


## Required roles {#required-roles}

To work with {{ sd-name }}, assign the required [roles](./security/index.md) to the user for each module. The list of required roles may depend on your organization's security policies.

| Module | Service setup role | User role |
| --- | --- | --- |
| {{ atr-name }} | `access-transparency.admin` for organization | `access-transparency.viewer` for organization |
| Data Security Posture Management ({{ dspm-name }}) | `dspm.admin` for individual resource | `dspm.inspector` for organization |
| Cloud Infrastructure Entitlement Management ({{ ciem-name }}) | `organization-manager-viewer` for organization | `organization-manager-viewer` for organization |

## What's next {#whats-next}

* Learn [how to scan buckets for sensitive information](./operations/dspm/create-scan.md) in {{ sd-name }}.
* Learn [how to view a subject's access list](./operations/ciem/view-permissions.md) in {{ sd-name }}.
* Learn about the [required access permissions](./security/index.md) to work with {{ sd-name }}.