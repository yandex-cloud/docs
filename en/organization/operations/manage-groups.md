# Managing user groups

For organizations with a lot of employees, multiple users may need to be granted the same access rights to {{ yandex-cloud }} resources. In this case, it's more convenient to grant roles and permissions to a group rather than individually.

You can group users by any criteria: for example, by their duties or department.

{% note info %}

Groups may only have a one-level structure.

The following limits apply to groups by default:
* The number of groups per organization: 100.
* The number of members per group: 1000.
* The number of groups a user may belong to: 1000.

To increase the quotas, contact [support]({{ link-console-support }}).

{% endnote %}

## Creating a group {#create-group}

{% include [create-group-org](../../_includes/organization/create-group-org.md) %}

## Adding members {#add-member}

{% include [group-add-member.md](../../_includes/organization/group-add-member.md) %}

## Editing a group {#edit-group}

{% include [group-edit](../../_includes/organization/group-edit.md) %}

## Setting up permissions to manage a group {#access-manage-group}

Change a [subject's](../../iam/concepts/access-control/index.md#subject) access bindings to a group as a resource.

### Assigning a role {#set-access-binding}

{% include [accessbinding-group-as-object](../../_includes/organization/accessbinding-group-as-object.md) %}

### Revoking a role {#remove-access-binding}

{% include [accessbinding-remove](../../_includes/organization/accessbinding-remove.md) %}

## Setting up a group's access to use {{ yandex-cloud }}{#access}

To enable group members to work with {{ yandex-cloud }} services, assign the appropriate [roles](../../iam/concepts/access-control/roles.md) to the group.

### Assigning a role for a separate resource {#access-services}

In the management console, you can assign a role for a cloud, folder, or service account.

To grant a group access to a resource:

{% include [accessbinding-group-as-subject](../../_includes/organization/accessbinding-group-as-subject.md) %}

### Assigning a role for an entire organization {#access-organization}

A role granted for the entire organization allows group members to manage any {{ yandex-cloud }} resources activated for the organization as per the role's permissions.

{% list tabs %}

- CLI

   {% include [accessbinding-group-as-subject-org](../../_includes/organization/accessbinding-group-as-subject-org.md) %}

{% endlist %}