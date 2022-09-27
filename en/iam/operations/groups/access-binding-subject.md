# Granting permissions to a user group

Grant a [group](../../../organization/manage-groups.md) access bindings to a resource. To grant a [subject](../../concepts/access-control/index.md#subject) group access bindings, follow the [{#T}](access-binding-object.md) instructions.

[Access](../../concepts/access-control/index.md#how-do-i-perform-access-management) management in {{ yandex-cloud }} is based on roles.

In the management console, you can assign a group a role for a cloud, folder, or service account. In the {{ org-full-name }} service, a group can only be granted a role for another group. To assign a group a role for an organization, use the CLI.

## Assigning a role for a cloud or folder {#access-binding-cloud}

{% include [accessbinding-group-as-object](../../../_includes/organization/accessbinding-group-as-subject.md) %}

## Assigning a role for an organization {#access-binding-organization}

{% list tabs %}

- CLI

   {% include [accessbinding-group-as-subject-org](../../../_includes/organization/accessbinding-group-as-subject-org.md) %}

{% endlist %}