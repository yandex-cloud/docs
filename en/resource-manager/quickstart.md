# Getting started with [!KEYREF resmgr-full-name]

When a user registers with Yandex.Cloud, a _cloud_ is created for the user. The cloud is a separate workspace with this user as the owner.

> [!NOTE]
>
> Currently, users are not allowed to create clouds themselves.

The owner can create folders and resources in this cloud, and manage access rights to them.

1. To create your first folder in the cloud:

    [!INCLUDE [create-folder](../_includes/create-folder.md)]

2. Grant users access to the folder you have created:
    1. In the management console, click ![image](../_assets/ugly-sandwich.svg) and go to **Access management**.
    2. Select the **Users and roles** tab.
    3. In the line with the appropriate user name, click **Set up roles**.
    4. Make sure that the user has one of the following roles for the cloud: `[!KEYREF roles-cloud-member]` or `[!KEYREF roles-cloud-owner]`.
    5. Select a folder in **Roles in folders**  and click **Assign role**.
    6. Select a role from the list. For example, grant the user access to create resources in the folder by assigning the role of `[!KEYREF roles-editor]`.

> [!NOTE]
>
> When a new user is created in the cloud, they are automatically assigned the role of a `[!KEYREF roles-cloud-member]` for this cloud. This role is necessary for the user to access resources in the cloud. The role of `[!KEYREF roles-cloud-member]` is used in combination with other roles, such as `[!KEYREF roles-admin]`, `[!KEYREF roles-editor]` or `[!KEYREF roles-viewer]` role. For more information about roles, see the [Roles](../iam/concepts/access-control/roles.md) section.

