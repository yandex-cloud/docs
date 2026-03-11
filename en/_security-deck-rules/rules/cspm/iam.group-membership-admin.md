### Only authorized administrators manage memberships in user groups {#group-membership-admin}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | iam.group-membership-admin ||
|#

#### Description

Working in the cloud requires following the principle of least privilege and granting users no more permissions than they need to address their respective tasks.

Make sure to manage access permissions to a [user group](https://yandex.cloud/en/docs/organization/concepts/groups) as a resource. Failing to do so may result in users getting excess permissions allowing them to manage the membership of other users in the group.

This check detects cases where users [get](https://yandex.cloud/en/docs/iam/concepts/access-control/roles) such permissions:

* User has the `organization-manager.groups.memberAdmin` role for the organization.
* User has the `organization-manager.groups.memberAdmin` role for a specific group as a resource.
* User has the `organization-manager.organizations.owner` or `admin` role or another privileged role for the whole organization.
* User has the `admin` or `editor` role for a specific group as a resource (this is not recommended).

#### Guides and solutions to use

1. In the left-hand panel of the [Cloud Center interface](https://center.yandex.cloud/organization), select **Groups** and in the list that opens, click the line with the group in question.
2. Navigate to the **Group access rights** tab and enable the **Inherited roles** option.
3. Follow the instructions for revoking a role for an [organization](https://yandex.cloud/en/docs/organization/operations/revoke-role) or [user group](https://yandex.cloud/en/docs/organization/operations/access-manage-group#remove-access-binding) to take away permissions from unauthorized accounts.