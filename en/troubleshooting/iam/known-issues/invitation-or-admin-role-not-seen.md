# User cannot see an invitation to an organization or the `{{ roles-admin }}` role


## Issue description {#issue-description}

After inviting users to the organization and assigning them the `{{ roles-admin }}` role for a folder or specific service, the user cannot see the invitation.

## Solution {#issue-resolution}

{{ yandex-cloud }} resource hierarchy looks like this:

* Organization.
* Cloud.
* Folder.
* Individual resource if the relevant service supports such granular access management.

To learn more, see [this article](../../../resource-manager/concepts/resources-hierarchy.md).

Thus, to provide a user with access to the folder, you first need to grant them permissions for the cloud.

For example, you can [assign](../../../iam/operations/roles/grant.md#access-to-user) the `{{ roles-cloud-member }}` role for the cloud and `{{ roles-admin }}`, for the folder. If a user needs to view all clouds, assign the [`{{ roles-cloud-member }}` role](../../../iam/security/index.md#cloud-member) at the organization level and grant granular access permissions for the relevant clouds or folders.

{% note info %}

Following the hierarchy and permission inheritance from the organization down to the cloud and then to the folder, assigning the `{{ roles-admin }}` role for the cloud grants the user the `{{ roles-admin }}` permissions for all nested folders and associated resources.

{% endnote %}