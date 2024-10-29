# Access control list (ACL)

{{ cloud-desktop-full-name }} leverages [{{ iam-full-name }} roles](../security/index.md) for access control.

{{ cloud-desktop-name }} ACL is a list of permissions for a given [desktop group](desktops-and-groups.md).

By default, an empty ACL is created for each new desktop group. A user with the `vdi.admin` [role](../security/index.md#vdi-admin) can [edit](../operations/desktop-groups/update-acl.md) an ACL.

Using an ACL, you can grant desktop group access to:
* [{{ yandex-cloud }} user](../../iam/concepts/users/accounts.md)
* [Service account](../../iam/concepts/users/service-accounts.md)
* [{{ org-full-name }} user group](../../organization/concepts/groups.md)
* [Public group](../../iam/concepts/access-control/public-group.md)
* [System group](../../iam/concepts/access-control/system-group.md)

Each desktop is assigned to a specific {{ yandex-cloud }} user.

To [connect to a desktop](../operations/desktops/connect.md), the user gets a unique RDP file with a built-in [IAM token](../../iam/concepts/authorization/iam-token.md). This means only a certain user can access the desktop.

The IAM token [lifetime](../../iam/concepts/authorization/iam-token.md#lifetime) is 12 hours. Once it expires, the RDP file is no longer valid. To connect to the desktop, the user needs to request a new RDP file.

If a user is removed from the list of {{ yandex-cloud }} users for any reason, e.g., if they were transferred to a different department or suspected of unauthorized activity, their RDP file becomes invalid regardless of when it was issued.

## Example of access control in {{ cloud-desktop-name }} {#example}

1. The organization administrator (user with the `organization-manager.admin` [role](../../organization/security/index.md#organization-manager-admin) for the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud)) creates a {{ org-full-name }} [user group](../../organization/concepts/groups.md) for which a desktop group will be deployed.
1. The {{ cloud-desktop-name }} administrator (user with the `vdi.admin` [role](../security/index.md#vdi-admin) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder)) [creates](../operations/desktop-groups/create.md) a desktop group and [grants](../operations/desktop-groups/update-acl.md) permissions for it to a user group.

    The administrator can also create a custom [image](images.md) for the desktop group.

1. The {{ cloud-desktop-name }} administrator [creates](../operations/desktops/create.md) a personal desktop for each memeber in the user group.
1. A user group member gets authenticated using [Yandex ID](https://yandex.ru/support/id/index.html) or [Single Sign-On (SSO)](../../organization/concepts/add-federation.md) on the [User desktop showcase](showcase.md) page. The showcase displays the desktops available to a given user.
1. From the showcase, the user group member downloads the RDP file for the appropriate desktop and [connects](../operations/desktops/connect.md) to it.

## See also {#see-also}

* [Getting started with {{ cloud-desktop-name }}](../quickstart.md)
* [Access management](../security/index.md)
* [{#T}](../operations/desktop-groups/update-acl.md)