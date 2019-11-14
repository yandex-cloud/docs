# Access management

Access to {{ datalens-full-name }} is managed from the Yandex.Cloud console.
To grant access, assign a user the `{{ roles-datalens-instances-user }}` role.

Permission differentiation in the service is implemented at the object and directory level.
You can grant users permission to each object and directory. They determine what operations are allowed.

You can grant users access to a directory or any service object:

- Connections
- Datasets
- Charts
- Dashboards

Users can also request permission on their own via the request form. For more information, see [{#T}](../operations/permission/request.md).

## Adding users {#add-new-user}

To add a user and grant them access to {{ datalens-short-name }}:

1. {% include [grant-role-console-first-steps](../../_includes/iam/grant-role-console-first-steps.md) %}

1. On the **Users and roles** page, click **Add user** in the upper-right corner.

1. Enter the user's Yandex email address.

1. Click **Add**. When a new user is added to the cloud, they're automatically assigned the cloud member role: [`resource-manager.clouds.member`](../../iam/concepts/access-control/roles.md#member).

1. {% include [configure-roles-console](../../_includes/iam/configure-roles-console.md) %}

1. To add a role for a cloud, click ![image](../../_assets/plus-sign.svg) in the **Roles for the cloud <cloud name>** section.

    To add a role for a folder, select the folder and click **Assign role** in the **Roles for folders** section.

1. Choose `{{ roles-datalens-instances-user }}` from the list.

For more information about assigning roles in Yandex.Cloud, see [Roles](../../iam/concepts/access-control/roles.md).

## Permissions {#permissions}

You can assign the following permissions to objects and folders in {{ datalens-short-name }}:

### {{ permission-execute }} {#permission-execute}

A user with the `{{ permission-execute }}` permission can make requests to available connections and datasets.
It doesn't let the user view connections or datasets.

{% note important %}

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
| Edit permissions | N/A | - | - | ✔ |
| **Connections** |
| Make requests<br/>to a connection | ✔ | ✔ | ✔ | ✔ |
| Create datasets<br/>on a connection | ✔ | ✔ | ✔ | ✔ |
| View<br/>connection parameters | - | ✔ | ✔ | ✔ |
| Edit connections | - | - | ✔ | ✔ |
| Edit permissions | - | - | - | ✔ |
| **Datasets** |
| Make requests<br/>to a dataset | ✔ | ✔ | ✔ | ✔ |
| Create charts<br/>on a dataset | ✔ | ✔ | ✔ | ✔ |
| View datasets | - | ✔ | ✔ | ✔ |
| Edit datasets | - | - | ✔ | ✔ |
| Edit permissions | - | - | - | ✔ |
| **Charts** |
| View charts | N/A | ✔ | ✔ | ✔ |
| Edit charts | N/A | - | ✔ | ✔ |
| Edit permissions | N/A | - | - | ✔ |
| **Dashboards** |
| View dashboards | N/A | ✔ | ✔ | ✔ |
| Edit dashboards | N/A | - | ✔ | ✔ |
| Edit permissions | N/A | - | - | ✔ |

#### What's next

- [{#T}](../operations/permission/grant.md)
- [{#T}](../operations/permission/revoke.md)
- [{#T}](../operations/permission/request.md)

