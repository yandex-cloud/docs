# Managing access to DataLens

Access to {{ datalens-full-name }} is regulated by assigning permissions:

* To a {{ datalens-short-name }} instance at the enterprise level: using the [organization's](../concepts/organizations.md) service.
* To a {{ datalens-short-name }} instance at the cloud folder level: via the {{ yandex-cloud }} [console]({{ link-console-main }}).

To grant a user access, assign them a {{ datalens-short-name }} role.

{{ datalens-short-name }} access control is implemented at the object and the folder level.
You can grant users permission to each object and directory. They determine which operations are allowed. If you created or copied a directory or object, they will have the same permissions as their new parent folder.

You can grant users access to a directory or any service object:

* Connection
* Datasets
* Charts
* Dashboards

Users can also request permissions on their own via the request form. For more information, see [{#T}](../operations/permission/request.md).

## User roles {#users-roles}

Roles enable you define user permissions in a {{ datalens-short-name }} instance:

* `{{ roles-datalens-instances-user }}` — A {{ datalens-short-name }} user with permissions to create, read, and update objects based on [object permissions](#permissions).
* `{{ roles-datalens-instances-admin }}`— The {{ datalens-short-name }} instance administrator. The role is automatically assigned to the instance creator. An administrator has `{{ roles-datalens-instances-user }}` permissions. They have access to [{{ datalens-short-name }}]({{ link-datalens-settings }}) settings.

User roles are assigned:

* To a {{ datalens-short-name }} instance at the enterprise level: using the [organization's](../concepts/organizations.md) service.
* To a {{ datalens-short-name }} instance at the cloud folder level: via the {{ yandex-cloud }} [console]({{ link-console-main }}).

## Adding a user {#add-new-user}

You can add [users with a Yandex account](#passport-user) as well as [federated users](#federated-user).

### Add a user with a Yandex account {#passport-user}

To add a user and grant them access to {{ datalens-short-name }}:

{% list tabs %}

- To an organization

   {% include [grant-role-console-first-steps](../../_includes/datalens/operations/datalens-add-user-organization.md) %}

- To a cloud

   1. {% include [grant-role-console-first-steps](../../_includes/iam/grant-role-console-first-steps.md) %}
   1. On the **Users and roles** page, click **Add user** in the upper-right corner.
   1. Enter the user's Yandex email address.
   1. Click **Add**. When a new user is added to the cloud, they're automatically assigned the cloud member role: [`resource-manager.clouds.member`](../../iam/concepts/access-control/roles.md#member).

      {% note info %}

      It may take several hours before the username of the added user appears in the form for granting permissions.

      {% endnote %}

   1. {% include [configure-roles-console](../../_includes/iam/configure-roles-console.md) %}
   1. To add a cloud role, click ![image](../../_assets/plus-sign.svg) in the **Roles for cloud <cloud name>** section.

      To add a role for a folder, select the folder and click **Assign role** in the **Roles for folders** section.
   1. Choose `{{ roles-datalens-instances-user }}` or `{{ roles-datalens-instances-admin }}` from the list.

{% endlist %}

### Add federated users {#federated-user}

{% include [include](../../_includes/iam/add-federated-users-before-begin.md) %}

#### Add federated users to an organization {#federated-user-org}

To add federated users to an organization and grant them access to {{ datalens-short-name }}:

1. Add federated users:

   {% list tabs %}

   - Management console

     1. Make sure you are authorized in {{ yandex-cloud }} as an administrator or owner of the organization (your user holds the `admin` or `owner` role for the organization). In the top left-hand corner, click ![image](../../_assets/datalens/all-services.svg) and select **Resources and management** → **Manage organization services** or click the [link](https://org.cloud.yandex.com/users).
     1. In the upper-right corner, click on the arrow next to the **Add user** button. Select **Add federated users**.
     1. Select the identity federation to add users from.
     1. List the Name IDs of users, separating them with line breaks.
     1. Click **Add**. This will give the users access to the organization.

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     1. View a description of the add user command:

        ```
        yc organization-manager federation saml add-user-accounts --help
        ```

     1. Add users by listing their Name IDs separated by a comma:

        ```
        yc organization-manager federation saml add-user-accounts --name my-federation \
           --name-ids=alice@example.com,bob@example.com,charlie@example.com
        ```

   - API

     1. Create a file with the request body (for example, `body.json`). In the request body, specify the array of Name IDs of users you want to add:

        ```json
        {
           "nameIds": [
             "alice@example.com",
             "bob@example.com",
             "charlie@example.com"
           ]
        }
        ```
     1. Send the request by specifying the Federation ID in the parameters:

        ```bash
        $ curl -X POST \
           -H "Content-Type: application/json" \
           -H "Authorization: Bearer <IAM token>" \
           -d '@body.json' \
           https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/federations/<federation ID>:addUserAccounts
        ```

   {% endlist %}

1. Assign roles to users for {{ datalens-short-name }} access:

   1. {% include [configure-roles-console](../../_includes/iam/configure-roles-console.md) %}
   1. In the **Configure access rights** window, click **![image](../../_assets/plus-sign.svg) Add role**. Choose the `{{ roles-datalens-instances-user }}` role from the list.
   1. Click **Save**. The user will gain access to {{ datalens-short-name }}.

#### Add federated users to a cloud {#federated-user-cloud}

To add federated users to a cloud and grant them access to {{ datalens-short-name }}:

1. Add federated users:

   {% include [include](../../_includes/iam/add-federated-users-instruction.md) %}

1. {% include [configure-roles-console](../../_includes/iam/configure-roles-console.md) %}
1. To add a cloud role, click ![image](../../_assets/plus-sign.svg) in the **Roles for cloud <cloud name>** section.

   To add a role for a folder, select the folder and click **Assign role** in the **Roles for folders** section.

1. Choose `{{ roles-datalens-instances-user }}` from the list.

For more information about assigning roles in {{ yandex-cloud }}, see [Roles](../../iam/concepts/access-control/roles.md).

## Object permissions {#permissions}

Permissions can be assigned to individual users or the **All** group that includes users who passed [authentication](../../iam/concepts/authorization/index.md#authentication).

You can assign the following permissions to objects and directories in {{ datalens-short-name }}:

* [{{ permission-execute }}](#permission-execute)
* [{{ permission-read }}](#permission-read)
* [{{ permission-write }}](#permission-write)
* [{{ permission-admin }}](#permission-admin)

### {{ permission-execute }} {#permission-execute}

A user with the `{{ permission-execute }}` permission for a connection can make requests to it, but can't create datasets. Regardless of dataset permissions, the user can't access a list of tables in a dataset or view the SQL subquery that the dataset is based on.

A user with `{{ permission-execute }}` access to a dataset can run queries against the dataset but is unable to create or edit charts or view the dataset.

{% note warning %}

You can only grant the `{{ permission-execute }}` permission for connections and datasets.

{% endnote %}

Granting users the `{{ permission-execute }}` permission lets you:

* Reduce the number of requests to the source, thereby reducing the load on the connection source.

* Better control what data can be shown from a dataset. You can hide some source fields so that users can't view all fields.

* Restrict the creation of subqueries to the source database. A user with the `{{ permission-execute }}` permission can't write subqueries.

### {{ permission-read }} {#permission-read}

A user with the `{{ permission-read }}` permission can view dashboards, widgets, datasets, and directories.

{% note warning %}

The `{{ permission-read }}` permission doesn't allow copying datasets, because they contain [RLS](row-level-security.md) settings. A user can only copy datasets if granted the `{{ permission-write }}` or `{{ permission-admin }}` permission.

{% endnote %}

### {{ permission-write }} {#permission-write}

A user with the `{{ permission-write }}` permission can edit dashboards, widgets, connections, datasets, and directories.

The `{{ permission-write }}` permission includes everything included in the `{{ permission-read }}` permission.

### {{ permission-admin }} {#permission-admin}

A user with the `{{ permission-admin }}` permission can edit available objects and directories, as well as change permissions.

The `{{ permission-admin }}` permission includes everything included in the `{{ permission-write }}` permission.

## Table of permissions {#permission-table}

| Access object<br/>Action | {{ permission-execute }} | {{ permission-read }} | {{ permission-write }} | {{ permission-admin }} |
| ---- | ---- | ---- | ---- | ---- |
| **Directory** |
| View directories | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Edit directories | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Delete directories | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Edit permissions | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| **Connection** |
| Make requests<br/>to a connection | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Create a dataset<br/>over a connection | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| View<br/>connection parameters | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Edit connections | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Delete connections | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Edit permissions | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| **Dataset** |
| Make requests<br/>to a dataset | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Create charts<br/>on a dataset | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| View datasets | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Edit datasets | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Delete datasets | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Edit permissions | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| **Chart** |
| View charts | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Edit charts | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Delete charts | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Edit permissions | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Grant public access | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| **Dashboard** |
| View dashboards | N/A | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Edit dashboards | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) |
| Delete dashboards | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Edit permissions | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |
| Grant public access | N/A | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) |

## Object access audit {#audit-access}

A {{ datalens-short-name }} user can get access logs for {{ datalens-short-name }} objects (view, edit, delete).
To retrieve logs, [please contact technical support]({{ link-console-support }}).

#### What's next {#what-is-next}

* [{#T}](../operations/permission/grant.md)
* [{#T}](../operations/permission/revoke.md)
* [{#T}](../operations/permission/request.md)
* [{#T}](../operations/dataset/manage-row-level-security.md)
