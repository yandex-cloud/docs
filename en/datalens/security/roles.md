# {{ datalens-short-name }} roles

There are two types of roles in {{ datalens-short-name }}:

* For service access: These roles are assigned for an [organization](../concepts/organizations.md) and grant access to {{ datalens-short-name }}.
* For [workbooks and collections](../workbooks-collections/index.md): These roles define the access level to each workbook or collection. They apply to users who [switched to workbooks and collections](../workbooks-collections/index.md#enable-workbooks) to store their objects in {{ datalens-short-name }}.

## Roles required to access the service {#service-roles}

To grant a user access to {{ datalens-short-name }}, assign them a role. Roles can be assigned to a Yandex account, a [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), a [user group](../../organization/operations/manage-groups.md), or a [system group](../../iam/concepts/access-control/system-group.md).


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

These roles apply to users who switched to a new approach to storing {{ datalens-short-name }} objects: in [workbooks and collections](../workbooks-collections/index.md). The roles allow you to define the level of access to each workbook or collection for a user or a user group.

### Roles for workbooks {#workbook-roles}

You can [assign](../workbooks-collections/security.md#wb-coll-grant) a user roles for workbooks.

#### Limited viewer {#workbooks-limitedViewer}

The `Limited viewer` role allows you to view all [charts](../concepts/chart/index.md) and [dashboards](../concepts/dashboard.md) inside a workbook without editing them.

#### Viewer {#workbooks-viewer}

The `Viewer` role allows you to view workbook contents without editing them.

#### Editor {#workbooks-editor}

The `Editor` role allows you to edit and copy workbook contents.

#### Admin {#workbooks-admin}

The `Admin` role allows you to view and edit workbook contents, move, copy, and delete workbooks, and manage access to them.

{% note info %}

The author of a workbook is automatically assigned the `Admin` role for the workbook.

{% endnote %}

### Roles for collections {#collection-roles}

You can [assign](../workbooks-collections/security.md#wb-coll-grant) a user roles for collections.

#### Limited viewer {#collections-limitedViewer}

The `Limited viewer` role allows you to view collections and their workbooks without editing them. Within workbooks, users can only view [charts](../concepts/chart/index.md) and [dashboards](../concepts/dashboard.md).

#### Viewer {#collections-viewer}

The `Viewer` role allows you to view collection contents without editing them.

#### Editor {#collections-editor}

The `Editor` role allows users to edit collections: create and edit collections and their workbooks.

#### Admin {#collections-admin}

The `Admin` role grants full access to collections and their contents, including permission to manage access to them and move collections and their contents.

{% note info %}

The role granted for a collection applies to all collections and their workbooks. The author of a collection is automatically assigned the `Admin` role for the collection.

{% endnote %}
