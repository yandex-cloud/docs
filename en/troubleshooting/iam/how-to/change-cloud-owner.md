# How to change the cloud owner



## Case description {#case-description}

You need to change the cloud owner, and you have access to the old account.

## Solution {#case-resolution}

To change the cloud owner, you need to do the following:

1. [Add a new user to the organization](https://org.yandex.cloud/users).
1. [Assign the `{{ roles-cloud-owner }}` role for the cloud to the new user]({{ link-console-main }}/cloud/?section=resource-acl). 
1. Revoke the `{{ roles-cloud-owner }}` role from the old user and assign them other roles, e.g., `{{ roles-admin }}`. 
1. To change the organization owner, [add a new user to the organization](https://org.yandex.cloud/users) and assign the `{{ roles-organization-owner }}` role to them.
1. As the new cloud owner, revoke the `{{ roles-organization-owner }}` role from the old user.

{% note info %}

This role allows access to cloud resources and resource management. Instead of `{{ roles-admin }}`, you can assign more specific roles to the user for the cloud or folders, as required. 

The user owns the organization in which the cloud is created. The owner role applies to all clouds in the organization.

For more information, see these help guides:

* [How to add a user to an organization](../../../organization/operations/add-account.md)
* [How to assign roles to users](../../../iam/operations/roles/grant.md)
* [Roles and their permissions](../../../resource-manager/concepts/resources-hierarchy.md)

{% endnote %}

## If nothing helped {#if-nothing-worked}

If the above measures did not help, the best option is to create a new Yandex ID account or specify the one you already have, `username@yandex.ru`, and link the organization owner to it. To do this, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:
 
1. Organization ID, in `bpf*****************` format.
1. Old owner username.
1. New owner username.