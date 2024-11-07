---
title: 'Managing access in {{ datalens-full-name }}: data visualization and analysis service'
description: This section describes the roles required to perform a particular action, the resources for which you can assign a role, and the roles existing in the service.
---

# {{ datalens-short-name }} roles

There are two types of roles in {{ datalens-short-name }}:

* For service access: These roles are assigned to an [organization](../concepts/organizations.md) and grant access to {{ datalens-short-name }}.
* For [workbooks and collections](../workbooks-collections/index.md): These roles define the access level to each workbook or collection. They apply to users who [switched to workbooks and collections](../workbooks-collections/index.md#enable-workbooks) to store their objects in {{ datalens-short-name }}.

## Roles required to access the service {#service-roles}

To grant a user access to {{ datalens-short-name }}, [assign](../../organization/security/index.md#add-role) them a role. You can assign roles to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md).

{% list tabs %}

- Before switching to workbooks and collections

  {% include [datalens-instances-user](../../_includes/roles-datalens-user.md) %}

  {% include [datalens-instances-admin](../../_includes/roles-datalens-admin.md) %}

- After switching to workbooks and collections

  {% include [roles-datalens-visitor](../../_includes/roles-datalens-visitor.md) %}

  {% include [roles-datalens-creator](../../_includes/roles-datalens-creator.md) %}

  {% include [roles-datalens-admin-org](../../_includes/roles-datalens-admin-org.md) %}

{% endlist %}

## Roles for workbooks and collections {#workbooks-collections-roles}

These roles are valid for users who adopted the new {{ datalens-short-name }} object storage mechanism: [workbooks and collections](../workbooks-collections/index.md). The roles allow you to define the level of access to each workbook or collection for a user or a user group.

### Roles for workbooks {#workbook-roles}

You can [assign](../workbooks-collections/security.md#wb-coll-grant) a user roles for workbooks.

#### datalens.workbooks.limitedViewer {#datalens-workbooks-limitedViewer}

{% include [datalens.workbooks.limitedViewer](../../_roles/datalens/workbooks/limitedViewer.md) %}

#### datalens.workbooks.viewer {#datalens-workbooks-viewer}

{% include [datalens.workbooks.viewer](../../_roles/datalens/workbooks/viewer.md) %}

#### datalens.workbooks.editor {#datalens-workbooks-editor}

{% include [datalens.workbooks.editor](../../_roles/datalens/workbooks/editor.md) %}

#### datalens.workbooks.admin {#datalens-workbooks-admin}

{% include [datalens.workbooks.admin](../../_roles/datalens/workbooks/admin.md) %}

{% note info %}

The author of a workbook is automatically assigned the `datalens.workbooks.admin` (`Admin`) role for the workbook.

{% endnote %}

### Roles for collections {#collection-roles}

You can [assign](../workbooks-collections/security.md#wb-coll-grant) a user roles for collections.

#### datalens.collections.limitedViewer {#datalens-collections-limitedViewer}

{% include [datalens.collections.limitedViewer](../../_roles/datalens/collections/limitedViewer.md) %}

#### datalens.collections.viewer {#datalens-collections-viewer}

{% include [datalens.collections.viewer](../../_roles/datalens/collections/viewer.md) %}

#### datalens.collections.editor {#datalens-collections-editor}

{% include [datalens.collections.editor](../../_roles/datalens/collections/editor.md) %}

#### datalens.collections.admin {#datalens-collections-admin}

{% include [datalens.collections.admin](../../_roles/datalens/collections/admin.md) %}

{% note info %}

The role granted for a collection applies to all collections and their workbooks. The author of a collection is automatically assigned the `datalens.collections.admin` (`Admin`) role for the collection.

{% endnote %}
