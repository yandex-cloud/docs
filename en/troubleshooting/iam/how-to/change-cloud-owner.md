# How to change the cloud owner


## Scenario description {#case-description}

You need to change the cloud owner, and you have access to the old account.

## Solution {#case-resolution}

To change the cloud owner, you need to:

1. [Add a new user to the organization](https://org.cloud.yandex.ru/users)
2. [Assign a new user the `resource-manager.clouds.owner` role for the cloud](https://console.cloud.yandex.ru/cloud/?section=resource-acl).
3. Revoke the `resource-manager.clouds.owner` role from the old user and assign them other roles, for example, the `admin` role.

{% note info %}

This role allows access to cloud resources and resource management. Instead of the `admin` role, you can assign the user other, more specific roles for the cloud or folders according to their authority. Note: the user owns the organization in which the cloud is created. The owner role applies to all clouds in the organization.

Read more in our documentation:
* [How to add a user to an organization](../../../organization/operations/add-account)
* [How to assign roles to users](../../../iam/operations/roles/grant)
* [About roles and their permissions](../../../resource-manager/concepts/resources-hierarchy).

{% endnote %}

4. To change the owner of the organization, [add a new user to the organization](https://org.cloud.yandex.ru/users) and assign them the `organization-manager.organizations.owner` role.
5. Revoke the `organization-manager.organizations.owner` role from the old user and assign it to new cloud owners.

## If nothing helped {#if-issue-still-persists}

If the above actions did not help resolve the issue, the best option is to create a new Yandex ID account (or specify an existing one: username[@yandex.ru](http://staff.yandex-team.ru/yandex.ru)) and link the organization owner to it by sending us an email containing the signature of the authorized person and the organization's stamp.

Be sure to include in your email:
1. Organization ID (`bpfXXXXXXXXXXXXXXXX`)
2. Old owner's username
3. New owner's username.
