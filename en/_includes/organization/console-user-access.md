{% note info %}

To enable a user to access the [management console]({{ link-console-main }}), assign them a role for the [cloud](../../organization/security/index.md#access-binding-cloud) or [organization](../../organization/security/index.md#access-binding-organization). For added security, you can assign one of the least priveleged roles, such as `resource-manager.clouds.member`. However, you may also assign other roles if you know which permissions you want to grant to the invited users.

To grant these permissions to all the organization users at once, assign the role to the `All users in organization X` [system group](../../iam/concepts/access-control/system-group.md#allOrganizationUsers). When using the CLI or API, no additional roles are required.

{% endnote %}