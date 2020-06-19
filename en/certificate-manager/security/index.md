# Access management

In this section, you'll learn:

* [What resources you can assign roles to](#resources).
* [What roles exist in the service](#roles-list).
* [What roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to. {#resources}

You can assign a role for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) or [certificate](../concepts/index). These roles also apply to nested resources.

## What roles exist in the service {#roles-list}

The diagram shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. A description of each role is given under the diagram.

![image](../../_assets/certificate-manager/service-roles-hierarchy.svg)

Active roles in the service:

* Service roles:
    * {% include [resource-manager.clouds.owner](../../_includes/iam/roles/short-descriptions/resource-manager.clouds.owner.md) %}
* Primitive roles:
    * {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
    * {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
    * {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a given action. You can always assign a role granting more permissions than the role specified. For example, you can assign `editor` instead of `viewer`.

| Action | Methods | Required roles |
| ----- | ----- | ----- |
| **Certificate Manager** |  |
| Get a list of certificates | `list` | `viewer` for the folder |
| Get certificate details | `get` | `viewer` for the certificate or folder |
| [Create](../operations/managed/cert-create.md) a Let's Encrypt<sup>®</sup> certificate | `requestNew` | `editor` for the folder |
| [Edit](../operations/managed/cert-modify.md) or [delete](../operations/managed/cert-delete.md) a Let's Encrypt certificate | `update`, `delete` | `editor` for the certificate or folder |
| [Create](../operations/import/cert-create.md) a user certificate | `create` | `editor` for the folder |
| [Update](../operations/import/cert-update.md), [edit](../operations/import/cert-modify.md), or [delete](../operations/import/cert-delete.md) a user certificate | `update`, `delete` | `editor` for the certificate or folder |
| **IAM** |  |
| [Assign](../../iam/operations/roles/grant.md), [revoke](../../iam/operations/roles/revoke.md), and view roles granted for the resource or cloud | `setAccessBinding`, `updateAccessBindings`, `listAccessBindings` | `admin` for the certificate or folder |

#### What's next {what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Read more about access management in Yandex.Cloud](../../iam/concepts/access-control/index.md).
* [More about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

