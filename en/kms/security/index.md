# Access management

In this section, you'll learn:

* [What resources you can assign the](#resources) role to.
* [What roles exist in the service](#roles-list).
* [What roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to. {#resources}

Now you can assign roles for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). These roles also apply to nested resources.

## What roles exist in the service {#roles-list}

The diagram shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. A description of each role is given under the diagram.

![image](../../_assets/kms/service-roles-hierarchy.svg)

Active roles in the service:
* {% include [viewer](../../_includes/iam/roles/short-descriptions/viewer.md) %}
* {% include [editor](../../_includes/iam/roles/short-descriptions/editor.md) %}
* {% include [admin](../../_includes/iam/roles/short-descriptions/admin.md) %}

## What roles do I need {#required-roles}

The table below lists the roles needed to perform a given action. You can always assign a role granting more permissions than the role specified. For example, you can assign `editor` instead of `viewer`.

| Action | Methods | Required roles |
| ----- | ----- | ----- |
| **KMS** |  |
| Get information about keys and versions | `get`, `list`, `listVersions` | `viewer` for the folder with keys |
| [Create](../operations/key.md#create) and [update](../operations/key.md#update) a key | `create`, `update` | `editor` for the folder with the key |
| Encryption and decryption operations | `encrypt`, `decrypt`, `reencrypt`, `generatedatakey` | `editor` for the folder with the key |
| [Rotate a key](../operations/key.md#rotate) and [change the primary version](../operations/version.md#make-primary) | `rotate`, `setPrimaryVersion` | `admin` for the folder with the key |
| [Destroy a key](../operations/key.md#delete) and [version](../operations/version.md#delete) | `delete`, `scheduleVersionDestruction`, `cancelVersionDestruction` | `admin` for the folder with the keys |
| **IAM** |  |
| [Grant roles](../../iam/operations/roles/grant.md), [revoke roles](../../iam/operations/roles/revoke.md), and view roles granted for the resource or cloud | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the folder or cloud |

#### What's next

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Read more about access management in Yandex.Cloud](../../iam/concepts/access-control/index.md).
* [More about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

