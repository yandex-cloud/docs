# Adding a user to the cloud

Add a user to your [organization](../../../organization/) to [grant](../../../iam/operations/roles/grant.md) him or her access to {{ yandex-cloud }} resources.

You can add [users with a Yandexaccount](#passport-user) as well as [federated users](#federated-user). To do this, you need to be the organization administrator (the `organization-manager.admin` role) or owner (the `organization-manager.organizations.owner` role).

The user will become an organization member, and you will be able to grant them access to your cloud resources by [assigning](../roles/grant.md) them a [role](../../concepts/access-control/roles.md). A new organization member will not have access to cloud resources until you assign them a role.

{% include notitle [add-user](../../../_includes/organization/add-user.md) %}

#### What's next {#what-is-next}

* [Assign roles to the new users](../roles/grant.md).
