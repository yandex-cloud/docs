---
title: "How to get started with {{ sd-full-name }}"
description: "This section describes the steps necessary to start using the {{ sd-name }} service and the tools it provides."
---

# Getting started with {{ sd-full-name }}

The {{ sd-name }} Service provides tools that help ensure data security and compliance with with legal regulations and industry standards.

{% include [note-preview-by-request](../_includes/note-preview-by-request.md) %}

## Getting started {#before-begin}

To start using {{ sd-full-name }}:

1. Log in or sign up to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../resource-manager/operations/folder/create.md).

{{ sd-name }} comprises the following modules: Access Transparency, Data Security Posture Management (DSPM), Cloud Infrastructure Entitlement Management (CIEM), and the Compliance Portal.

To connect a module, switch to the [{{ sd-name }} interface]({{ link-sd-main }}) and click the **Enable** button next to the module's description. You will then be able to learn more about the tool, its capabilities, and terms of use.

## Configure {{ sd-name }} {#configure-sd}

{{ sd-full-name }} modules' resources are stored in folders. From the list of available folders select the folder that will be used for storing the modules' resources.

To get started with {{ sd-name }}, assign the necessary [roles](#required-roles) to the user.

## Access Transparency {#access-transparency}

[Access Transparency]({{ link-sd-main }}trasparency/) is an automated tool designed to view analytical information on the actions that have been performed by {{ yandex-cloud }} engineers with the organization's resources. Such actions may have been taken during technical maintenance, handling [user requests](../support/overview.md), or resolving security issues.

This tool ensures proper transparency and control over the way your data and resources are handled by {{ yandex-cloud }} engineers. The engineers' work logs are automatically analyzed by a pre-trained 
{{ yagpt-name }}-based model. If necessary, you can request additional info and analysis concerning a certain session by raising an escalation to a {{ yandex-cloud }} information security specialist.

## Data Security Posture Management (DSPM) {#dspm}

[Data Security Posture Management (DSPM)]({{ link-sd-main }}dspm/) is a tool that helps to quickly detect sensitive information stored in your {{ objstorage-full-name }} [buckets](../storage/concepts/bucket.md) in order to take timely actions to prevent unauthorized access to such information or its leakage.

## Cloud Infrastructure Entitlement Management (CIEM) {#ciem}

[Cloud Infrastructure Entitlement Management (CIEM)]({{ link-sd-main }}iam-diagnostics/) is a tool that allows you to globally view the complete list of access permissions for organization [resources](../iam/concepts/access-control/resources-with-access-control.md) granted to a particular [subject](../iam/concepts/access-control/index.md#subject): [user](../overview/roles-and-resources.md#users), [service account](../iam/concepts/users/service-accounts.md), [user group](../organization/concepts/groups.md), [system group](../iam/concepts/access-control/system-group.md) or [public group](../iam/concepts/access-control/public-group.md). This tool also allows to easily revoke unnecessary access permissions from subjects.

## Compliance Portal {#compliance}

The {{ sd-name }} [Compliance Portal]({{ link-sd-main }}compliance/) contains all the necessary documents, reports, instructions and additional information on the {{ yandex-cloud }} security system.

This tool allows you to download publicly available documents as well as request access to documents containing confidential data that are only available on request.

## Required roles {#required-roles}

To utilize {{ sd-full-name }}, assign to the user the roles required by the module you are planning to use. The list of required roles may vary depending on the security policies deployed in your organization.

| Module | Service configuration role | User operation role |
| --- | --- | --- |
| Access Transparency | `access-transparency.admin` for the organization | `access-transparency.viewer` for the organization |
| Data Security Posture Management | `dspm.admin` for an individual resource | `dspm.inspector` for the organization |
| Cloud Infrastructure Entitlement Management | `organization-manager-viewer` for the organization | `organization-manager-viewer` for the organization |