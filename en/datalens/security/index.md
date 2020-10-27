# Managing access to DataLens

Access to {{ datalens-full-name }} is managed from the {{ yandex-cloud }} console.
To grant a user access, assign them a {{ datalens-short-name }} role.

Permission differentiation in the service is implemented at the object and directory level.
You can grant users permission to each object and directory. They determine what operations are allowed. By default, objects inherit the access rights of the parent folder.

You can grant users access to a directory or any service object:

- Connections
- Datasets
- Charts
- Dashboards

Users can also request permission on their own via the request form. For more information, see [{#T}](../operations/permission/request.md).

## User roles {#users-roles}

Let you define user permissions in a {{ datalens-short-name }} instance:

- `{{ roles-datalens-instances-user }}` — A {{ datalens-short-name }} user with the rights to create, read, and update objects based on [object permissions](#permissions).
- `{{ roles-datalens-instances-admin }}` — The {{ datalens-short-name }} instance administrator. The role is automatically assigned to the instance creator. The administrator has `{{ roles-datalens-instances-user }}` permissions and can also change the pricing plan and purchase paid content in the Cloud Marketplace.

User roles are assigned in the {{ yandex-cloud }} console.

## Adding users {#add-new-user}

You can add [users with a Yandex account](#passport-user) and [federated users](#federated-user).

### Add a user with a Yandex account {#passport-user}

To add a user and grant them access to {{ datalens-short-name }}:

1. {% include [grant-role-console-first-steps](../../_includes/iam/grant-role-console-first-steps.md) %}

1. On the **Users and roles** page, click **Add user** in the upper-right corner.

1. Enter the user's Yandex email address.

1. Click **Add**. When a new user is added to the cloud, they're automatically assigned the cloud member role: [`resource-manager.clouds.member`](../../iam/concepts/access-control/roles.md#member).

    {% note info %}

    It may take several hours before the username of the added user appears in the form for granting permissions.

    {% endnote %}

1. {% include [configure-roles-console](../../_includes/iam/configure-roles-console.md) %}

1. To add a role for a cloud, click ![image](../../_assets/plus-sign.svg) in the **Roles for the cloud <cloud name>** section.

    To add a role for a folder, select the folder and click **Assign role** in the **Roles for folders** section.

1. Choose `{{ roles-datalens-instances-user }}` or `{{ roles-datalens-instances-admin }}` from the list.

### Add federated users {#federated-user}

{% include [include](../../_includes/iam/add-federated-users-before-begin.md) %}

1. Add federated users:

   {% include [include](../../_includes/iam/add-federated-users-instruction.md) %}

1. {% include [configure-roles-console](../../_includes/iam/configure-roles-console.md) %}

1. To add a role for a cloud, click ![image](../../_assets/plus-sign.svg) in the **Roles for the cloud <cloud name>** section.

    To add a role for a folder, select the folder and click **Assign role** in the **Roles for folders** section.

1. Choose `{{ roles-datalens-instances-user }}` from the list.

For more information about assigning roles in {{ yandex-cloud }}, see [Roles](../../iam/concepts/access-control/roles.md).

## Object permissions {#permissions}

You can assign the following permissions to objects and folders in {{ datalens-short-name }}:

### {{ permission-execute }} {#permission-execute}

A user with the `{{ permission-execute }}` permission can make requests to available connections and datasets.
It doesn't let the user view connections or datasets.

{% note warning %}

You can only grant the `{{ permission-execute }}` permission for a connection and dataset.

{% endnote %}

### {{ permission-read }} {#permission-read}

A user with the `{{ permission-read }}` permission can view dashboards, widgets, datasets, and directories.

### {{ permission-write }} {#permission-write}

A user with the `{{ permission-write }}` permission can edit dashboards, widgets, connections, datasets, and directories.

The `{{ permission-write }}` permission includes everything under the `{{ permission-read }}` permission.

### {{ permission-admin }} {#permission-admin}

A user with the `{{ permission-admin }}` permission can edit available objects and directories, as well as edit permissions.

The `{{ permission-admin }}` permission includes everything under the `{{ permission-write }}` permission.

## Table of permissions {#permission-table}

| Access object<br/>Action | {{ permission-execute }} | {{ permission-read }} | {{ permission-write }} | {{ permission-admin }} |
| ---- | ---- | ---- | ---- | ---- |
| **Directory** |
| View directories | N/A | ✔ | ✔ | ✔ |
| Edit directories | N/A | - | ✔ | ✔ |
| Delete directories | N/A | - | - | ✔ |
| Edit permissions | N/A | - | - | ✔ |
| **Connections** |
| Make requests<br/>to a connection | ✔ | ✔ | ✔ | ✔ |
| Create a dataset<br/>over a connection | - | ✔ | ✔ | ✔ |
| View<br/>connection parameters | - | ✔ | ✔ | ✔ |
| Edit connections | - | - | ✔ | ✔ |
| Delete connections | - | - | - | ✔ |
| Edit permissions | - | - | - | ✔ |
| **Datasets** |
| Make requests<br/>to a dataset | ✔ | ✔ | ✔ | ✔ |
| Create charts<br/>on a dataset | ✔ | ✔ | ✔ | ✔ |
| View datasets | - | ✔ | ✔ | ✔ |
| Edit datasets | - | - | ✔ | ✔ |
| Delete datasets | - | - | - | ✔ |
| Edit permissions | - | - | - | ✔ |
| **Charts** |
| View charts | N/A | ✔ | ✔ | ✔ |
| Edit charts | N/A | - | ✔ | ✔ |
| Delete charts | N/A | - | - | ✔ |
| Edit permissions | N/A | - | - | ✔ |
| **Dashboards** |
| View dashboards | N/A | ✔ | ✔ | ✔ |
| Edit dashboards | N/A | - | ✔ | ✔ |
| Deleting dashboards | N/A | - | - | ✔ |
| Edit permissions | N/A | - | - | ✔ |

## Object access audit

A {{ datalens-short-name }} user can get access logs for {{ datalens-short-name }} objects (view, edit, delete).
To get logs, you can contact [technical support]({{ link-console-support }}).

#### What's next {#what-is-next}

- [{#T}](../operations/permission/grant.md)
- [{#T}](../operations/permission/revoke.md)
- [{#T}](../operations/permission/request.md)
- [{#T}](../operations/dataset/manage-row-level-security.md)