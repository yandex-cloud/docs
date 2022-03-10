# Getting started with {{ resmgr-full-name }}

When a user registers with {{ yandex-cloud }}, a _cloud_ is created for the user. The cloud is a separate workspace with this user as the owner.

The owner can create folders and resources in this cloud, and manage access rights to them.

1. To create your first folder in the cloud:

    {% include [create-folder](../_includes/create-folder.md) %}

2. Grant users access to the folder you have created:
    1. {% include [grant-role-console-first-steps](../_includes/iam/grant-role-console-first-steps.md) %}
    1. In the line with the appropriate user name, click **Configure roles**.
    1. Make sure that the user has one of the following roles for the cloud: `{{ roles-cloud-member }}` or `{{ roles-cloud-owner }}`.
    1. Select a folder in **Roles in folders** and click **Assign role**.
    1. Select a role from the list. For example, grant the user access to create resources in the folder by assigning them the `{{ roles-editor }}` role.

{% note info %}

When a new user is created in a cloud, they're automatically assigned the `{{ roles-cloud-member }}` role. This role is necessary for the user to access resources in the cloud. The `{{ roles-cloud-member }}` role is used in combination with other roles, such as `{{ roles-admin }}`, `{{ roles-editor }}`, or `{{ roles-viewer }}`. For more information about roles, see the [Roles](../iam/concepts/access-control/roles.md) section.

{% endnote %}

