---
title: '{{ sd-full-name }} workspaces'
description: A {{ sd-full-name }} workspace is a container holding the {{ sd-name }} module settings and resources, a list of controlled resources, control parameters, and other settings.
---

# {{ sd-name }} workspaces

{% include [note-preview](../../_includes/note-preview.md) %}

A _{{ sd-name }} workspace_ is a container holding the {{ sd-name }} module settings and resources, a list of controlled resources, control parameters, and other settings. Workspaces allow for more granular management of {{ yandex-cloud }} infrastructure security by monitoring it for compliance with industry security standards.

You can choose {{ org-full-name }} [organizations](../../organization/concepts/organization.md), individual [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folders](../../resource-manager/concepts/resources-hierarchy.md#folder) as resources controlled by the workspace. The workspace accesses its controlled resources via [connectors](#connectors).

To create and manage workspaces, the user needs the following roles:

* `security-deck.admin` for the folder to contain {{ sd-name }} resources and modules.
* `auditor` for the [organization](../../organization/concepts/organization.md), [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), or folder the workspace will control the security of.

## Workspace settings {#settings}

The settings and resources of the {{ sd-name }} modules used by the workspace are stored in the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you specify when [creating](../operations/workspaces/create.md) the workspace. Once the workspace is created, you cannot change this folder.

{% note tip %}

{% include [workspace-resources-in-isolated-folder](../../_includes/security-deck/workspace-resources-in-isolated-folder.md) %}

{% endnote %}

### Security standards {#standards}

In the {{ sd-name }} workspace settings, you should specify the industry security standards and regulations your controlled resources will be monitored against:

{% include [workspace-sec-standard-list](../../_includes/security-deck/workspace-sec-standard-list.md) %}

For a single workspace, you can select several security standards at the same time: Depending on what standards you select, the workspace will use the {{ sd-name }} modules called [Cloud Security Posture Management ({{ cspm-name }})](./cspm.md) and/or [{{ k8s }} Kubernetes Security Posture Management (KSPM)](./kspm.md).

### Connectors {#connectors}

Access to {{ sd-name }} resources controlled within a workspace takes place via _connectors_ that access the resources under a [service account](../../iam/concepts/users/service-accounts.md) associated with the connector. Connectors ensure uniform access to both {{ yandex-cloud }} internal resources and external resources, e.g., [{{ yandex-360 }}](https://360.yandex.ru/).

The resources that are going to be monitored for security compliance must be explicitly assigned to the connector associated with the workspace. You can associate controlled resources with a workspace when creating or updating it.

The service account the connector will use to access the controlled resources must have the `security-deck.worker` [role](../../security-deck/security/index.md#security-deck-worker) assigned for them.

When you [delete](../operations/workspaces/delete.md) the workspace, its connector will be preserved.

### Alert sinks {#alert-sinks}

The {{ sd-name }} workspace also gets an associated _alert sink_ to receive [alerts](./alerts.md) coming from all {{ sd-name }} modules. The alert sink must reside in the same folder you specified when creating the workspace.

When you [delete](../operations/workspaces/delete.md) the workspace, its alert sink will be preserved.

## Workspace access {#access}

By default, access to a workspace is limited to the user who created it. 

For other users to be able to use the workspace, you should [grant](../operations/workspaces/manage-access.md) them access to it. The user who gets access to the workspace must also have access to the folder used for the workspace's resources and the cloud that folder is in.

Depending on expected scope of work, the user should get the `security-deck.viewer` [role](../security/index.md#security-deckviewer-security-deck-viewer) or higher for the workspace.

## Workspace dashboard {#dashboard}

Depending on the {{ sd-name }} [modules](../quickstart-overview.md#modules) configured in the workspace, the dashboard contains these general information cards:

{% include [dashboard-contents](../../_includes/security-deck/dashboard-contents.md) %}

#### See also {#see-also}

* [{#T}](../operations/workspaces/create.md)
* [{#T}](../operations/workspaces/view-dashboard.md)
* [{#T}](../operations/workspaces/update.md)
* [{#T}](../operations/workspaces/manage-access.md)
* [{#T}](../operations/workspaces/delete.md)