# Assigning a role to a user group

Assign a role to a [user group](../../organization/operations/manage-groups.md) to grant access to a resource. To grant group access permissions to a [subject](../../iam/operations/groups/access-binding-object.md), see [{#T}](../../iam/concepts/access-control/index.md#subject).

In {{ org-full-name }}, you can assign a group a role for an organization, cloud, folder, another group, or service account.

## Assigning a role for a cloud or folder {#access-binding-cloud}

{% include [accessbinding-group-as-subject](../../_includes/organization/accessbinding-group-as-subject.md) %}

## Assigning a role for an organization {#access-binding-organization}

{% include [accessbinding-group-as-subject-org](../../_includes/organization/accessbinding-group-as-subject-org.md) %}

#### See also {#see-also}

* [{#T}](../../iam/operations/sa/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)
