---
title: Getting started with {{ sd-full-name }}
description: This section describes how to get started with {{ sd-name }} and make use of its tools.
---

# Getting started with {{ sd-full-name }}

{{ sd-name }} offers tools for data security and compliance with regulatory requirements and industry standards.

{% include [note-preview-by-request](../_includes/note-preview-by-request.md) %}

## Getting started {#before-begin}

To get started with {{ sd-name }} in {{ yandex-cloud }}:

1. If you have not signed up to {{ yandex-cloud }} yet, go to the [management console]({{ link-console-main }}) and follow the instructions.
1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../billing/concepts/billing-account.md) linked and its [status](../billing/concepts/billing-account-statuses.md) is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a [folder](../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../resource-manager/operations/folder/create.md).
1. Make sure you have the necessary [permissions](./security/index.md) to work with the {{ sd-name }} modules. You optimal roles are:

    * `security-deck.admin` for the folder to contain {{ sd-name }} resources and modules.
    * `auditor` for the [organization](../organization/concepts/organization.md), [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud), or folder the workspace will control the security of.
1. [Create](../iam/operations/sa/create.md) a [service account](../iam/concepts/users/service-accounts.md) and [assign](../iam/operations/sa/assign-role-for-sa.md) to it the `security-deck.worker` [role](./security/index.md#security-deck-worker) for the organization, cloud, or folder the workspace will control the security of.

## Create a {{ sd-name }} workspace {#create-workspace}

A [workspace](./concepts/workspace.md) is a container holding the {{ sd-name }} module settings and resources, a list of controlled resources, control parameters, and other settings. Workspaces allow for more granular management of {{ yandex-cloud }} infrastructure security.

To create your first {{ sd-name }} workspace:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![vector-circle](../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}** and click **{{ ui-key.yacloud_org.security.workspaces.WorkspacesPlaceholder.createWorkspace_8yAnK }}**.
  1. {% include [workspace-create-step1](../_includes/security-deck/workspace-create-step1.md) %}
  1. {% include [workspace-create-step2](../_includes/security-deck/workspace-create-step2.md) %}
  1. {% include [workspace-create-step3](../_includes/security-deck/workspace-create-step3.md) %}
  1. {% include [workspace-create-step4](../_includes/security-deck/workspace-create-step4.md) %}

{% endlist %}

## {{ sd-full-name }} modules {#modules}

{{ sd-name }} includes the following modules:

* [{{ ycdr-full-name }} ({{ ycdr-name }})](#ycdr)
* [Data Security Posture Management (DSPM)](#dspm)
* [{{ k8s }} Security Posture Management (KSPM)](#kspm)
* [Cloud Infrastructure Entitlement Management (CIEM)](#ciem)
* [Cloud Security Posture Management ({{ cspm-name }})](#cspm)
* [{{ atr-name }}](#access-transparency)
* [Compliance Portal](#compliance)

To use any of the modules, navigate to the [{{ sd-name }} interface]({{ link-sd-main }}) and select the module you need in the left-hand panel. On the page that opens, you can learn more about the tool's features and terms of use. To use the module you select, complete the required setup.

### {{ ycdr-full-name }} {#ycdr}

{{ ycdr-full-name }} ({{ ycdr-name }}) is a module that monitors and responds to {{ yandex-cloud }} infrastructure incidents. {{ ycdr-name }} is built around {{ yandex-cloud }}'s in-house Security Operations Center (SOC). Our information security team will monitor the service for potential threats. {{ ycdr-name }} relies on a proprietary SIEM platform and Security Data Lake for big data analysis algorithms and tools.

### Data Security Posture Management ({{ dspm-name }}) {#dspm}

[Data Security Posture Management, or {{ dspm-name }}]({{ link-sd-main }}dspm/), helps you quickly detect sensitive information stored in {{ objstorage-full-name }} [buckets](../storage/concepts/bucket.md) for timely action to protect it from unauthorized access or leaks. To learn more, see [{#T}](./concepts/dspm.md).

To get started with the {{ dspm-name }} module, follow the guides on how to [create a data source](./operations/dspm/create-data-source.md) and a [scan](./operations/dspm/create-scan.md) for bucket information.

### {{ k8s }} Security Posture Management (KSPM) {#kspm}

{% include [kspm-basic-intro](../_includes/security-deck/kspm-basic-intro.md) %}

### Cloud Infrastructure Entitlement Management ({{ ciem-name }}) {#ciem}

{{ sd-name }} [Cloud Infrastructure Entitlement Management]({{ link-sd-main }}iam-diagnostics/) is a tool providing a centralized [view](./operations/ciem/view-permissions.md) of the full list of accesses to the organization's [resources](../iam/concepts/access-control/resources-with-access-control.md) available to the [subjects](../iam/concepts/access-control/index.md#subject), i.e., [users](../overview/roles-and-resources.md#users), [service accounts](../iam/concepts/users/service-accounts.md), [user groups](../organization/concepts/groups.md), [system groups](../iam/concepts/access-control/system-group.md), and [public groups](../iam/concepts/access-control/public-group.md). The tool also makes it easy to [revoke](./operations/ciem/revoke-permissions.md) excessive access permissions from subjects. To learn more, see [{#T}](./concepts/ciem.md).

To get started with the {{ ciem-name }} module, follow the guides for [viewing](./operations/ciem/view-permissions.md) and [revoking](./operations/ciem/revoke-permissions.md) accesses.

### Cloud Security Posture Management ({{ cspm-name }}) {#cspm}

{% include [cspm-basic-intro](../_includes/security-deck/cspm-basic-intro.md) %}

### {{ atr-name }} {#access-transparency}

[{{ atr-name }}]({{ link-sd-main }}transparency/) is an automated tool you can use to view analytical data about actions by {{ yandex-cloud }} engineers involving the organization's resources, whether when processing [requests](../support/overview.md), addressing security issues, or during maintenance.

The tool ensures transparency of operations and provides control over the actions of {{ yandex-cloud }} engineers: a specially trained {{ yagpt-name }}-based model automatically analyzes their logs and, if necessary, escalates for the session to be checked by {{ yandex-cloud }} information security staff.

{% include [access-transparency-attach-ba-notice](../_includes/security-deck/access-transparency-attach-ba-notice.md) %}

For more information, see [{#T}](./concepts/access-transparency.md).

## What's next {#whats-next}

* Learn [how to view the {{ cspm-name }} module's security control rules and related violations](./operations/cspm/view-rules.md).
* Learn [how to scan buckets for sensitive information](./operations/dspm/create-scan.md) in {{ sd-name }}.
* Learn [how to view a subject's access list](./operations/ciem/view-permissions.md) in {{ sd-name }}.
* Learn about the [required access permissions](./security/index.md) to work with {{ sd-name }}.