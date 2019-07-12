# Getting started with Yandex Resource Manager

When a user registers with Yandex.Cloud, a _cloud_ is created for the user. The cloud is a separate workspace with this user as the owner.

{% note info %}

Currently, users are not allowed to create clouds themselves.

{% endnote %}

The owner can create folders and resources in this cloud, and manage access rights to them.

1. To create your first folder in the cloud:

    {% include [create-folder](../_includes/create-folder.md) %}

2. Grant users access to the folder you have created:
    1. {% include [grant-role-console-first-steps](../_includes/iam/grant-role-console-first-steps.md) %}
    1. In the line with the appropriate user name, click **Configure roles**.
    1. Make sure that the user has one of the following roles for the cloud: `resource-manager.clouds.member` or `resource-manager.clouds.owner`.
    1. Select a folder in **Roles in folders**  and click **Assign role**.
    1. Select a role from the list. For example, grant the user access to create resources in the folder by assigning the role of `editor`.

{% note info %}

When a new user is created in the cloud, they are automatically assigned the role of a `resource-manager.clouds.member` for this cloud. This role is necessary for the user to access resources in the cloud. The role of `resource-manager.clouds.member` is used in combination with other roles, such as `admin`, `editor` or `viewer` role. For more information about roles, see the [Roles](../iam/concepts/access-control/roles.md) section.

{% endnote %}

