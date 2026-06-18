---
title: 'Managing access in {{ datalens-full-name }}: data visualization and analysis service'
description: This section describes the roles required for specific actions, the resources for which you can assign a role, and the roles existing in {{ datalens-full-name }}.
---

# {{ datalens-full-name }} roles


There are two types of roles in {{ datalens-short-name }}:

* For service access: These roles are assigned to an [organization](../concepts/organizations.md) and grant access to {{ datalens-short-name }}.
* For [workbooks and collections](../workbooks-collections/index.md): These roles define the access level to each workbook or collection. They apply to users who [switched to workbooks and collections](../workbooks-collections/index.md#enable-workbooks) to store their objects in {{ datalens-short-name }}.

## Roles required to access the service {#service-roles}

To grant a user access to {{ datalens-short-name }}, [assign](../../organization/security/index.md#add-role) them a role. You can assign roles to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) users, [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md).

{% list tabs group=datalens_roles %}

- After switching to workbooks and collections {#after-workbooks-collections}

  #### datalens.visitor {#datalens-visitor}

  {% include [datalens-visitor](../../_roles/datalens/visitor.md) %}

  #### datalens.creator {#datalens-creator}

  {% include [datalens-creator](../../_roles/datalens/creator.md) %}

  #### datalens.admin {#datalens-admin}

  {% include [datalens-creator](../../_roles/datalens/admin.md) %}

- Before switching to workbooks and collections {#before-workbooks-collections}

  #### datalens.instances.user {#datalens-instances-user}

  {% include [datalens-instances-user](../../_roles/datalens/instances/user.md) %}

  #### datalens.instances.admin {#datalens-instances-admin}

  {% include [datalens-instances-admin](../../_roles/datalens/instances/admin.md) %}

{% endlist %}

## Roles to work with the API {#api-roles}

#### datalens.metaReader {#datalens-metaReader}

{% include [datalens-metaReader](../../_roles/datalens/metaReader.md) %}

## Roles for workbooks, collections, and shared objects {#workbooks-collections-roles}

These roles are valid for users who adopted the new {{ datalens-short-name }} object layout: in [workbooks and collections](../workbooks-collections/index.md). Roles allow you to define the level of access a user or group of users has to each workbook, collection, or shared object.

### Roles for workbooks {#workbook-roles}

You can [assign](../workbooks-collections/workbooks-operations.md#wb-coll-grant) roles for workbooks to a user.

#### datalens.workbooks.limitedViewer {#datalens-workbooks-limitedViewer}

{% include [datalens.workbooks.limitedViewer](../../_roles/datalens/workbooks/limitedViewer.md) %}

#### datalens.workbooks.viewer {#datalens-workbooks-viewer}

{% include [datalens.workbooks.viewer](../../_roles/datalens/workbooks/viewer.md) %}

#### datalens.workbooks.editor {#datalens-workbooks-editor}

{% include [datalens.workbooks.editor](../../_roles/datalens/workbooks/editor.md) %}

#### datalens.workbooks.admin {#datalens-workbooks-admin}

{% include [datalens.workbooks.admin](../../_roles/datalens/workbooks/admin.md) %}

{% note info %}

The workbook author automatically gets the `datalens.workbooks.admin` (`Admin`) role for the workbook as soon as it is created.

{% endnote %}

### Roles for collections {#collection-roles}

You can [assign](../workbooks-collections/collections-operations.md#wb-coll-grant) a user roles for collections.

#### datalens.collections.visitor {#datalens-collections-visitor}

{% include [datalens.collections.visitor](../../_roles/datalens/collections/visitor.md) %}

#### datalens.collections.limitedViewer {#datalens-collections-limitedViewer}

{% include [datalens.collections.limitedViewer](../../_roles/datalens/collections/limitedViewer.md) %}

#### datalens.collections.viewer {#datalens-collections-viewer}

{% include [datalens.collections.viewer](../../_roles/datalens/collections/viewer.md) %}

#### datalens.collections.limitedEntryBindingCreator {#datalens-collections-limitedEntryBindingCreator}

{% include [datalens.collections.limitedEntryBindingCreator](../../_roles/datalens/collections/limitedEntryBindingCreator.md) %}

#### datalens.collections.entryBindingCreator {#datalens-collections-entryBindingCreator}

{% include [datalens.collections.entryBindingCreator](../../_roles/datalens/collections/entryBindingCreator.md) %}

#### datalens.collections.creator {#datalens-collections-creator}

{% include [datalens.collections.creator](../../_roles/datalens/collections/creator.md) %}

#### datalens.collections.editor {#datalens-collections-editor}

{% include [datalens.collections.editor](../../_roles/datalens/collections/editor.md) %}

#### datalens.collections.admin {#datalens-collections-admin}

{% include [datalens.collections.admin](../../_roles/datalens/collections/admin.md) %}

This role includes the `datalens.collections.editor` and `datalens.workbooks.admin` permissions.

{% note info %}

The role granted for a collection applies to all collections and their workbooks. The collection author automatically gets the `datalens.collections.admin` (`Admin`) role for the collection as soon as it is created.

{% endnote %}

### Roles for shared objects {#shared-entry-roles}

#### datalens.sharedEntries.limitedViewer {#datalens-sharedEntries-limitedViewer}

{% include [datalens.sharedEntries.limitedViewer](../../_roles/datalens/sharedEntries/limitedViewer.md) %}

#### datalens.sharedEntries.viewer {#datalens-sharedEntries-viewer}

{% include [datalens.sharedEntries.viewer](../../_roles/datalens/sharedEntries/viewer.md) %}

#### datalens.sharedEntries.limitedEntryBindingCreator {#datalens-sharedEntries-limitedEntryBindingCreator}

{% include [datalens.sharedEntries.limitedEntryBindingCreator](../../_roles/datalens/sharedEntries/limitedEntryBindingCreator.md) %}

#### datalens.sharedEntries.entryBindingCreator {#datalens-sharedEntries-entryBindingCreator}

{% include [datalens.sharedEntries.entryBindingCreator](../../_roles/datalens/sharedEntries/entryBindingCreator.md) %}

#### datalens.sharedEntries.editor {#datalens-sharedEntries-editor}

{% include [datalens.sharedEntries.editor](../../_roles/datalens/sharedEntries/editor.md) %}

#### datalens.sharedEntries.admin {#datalens-sharedEntries-admin}

{% include [datalens.sharedEntries.admin](../../_roles/datalens/sharedEntries/admin.md) %}


