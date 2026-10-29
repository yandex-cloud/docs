# Logging in and accessing resources

#### How do I log in to the management console? {#console-log-in}

Go to the [management console page]({{ link-console-main }}).

If not logged in to your Yandex or Yandex 360 account yet, click **Log in**. If you do not have an account yet, click **Register**. For more information, see (https://yandex.com/support/passport/auth.html).

#### How do I grant a user access to the management console and a folder? {#console-access}

To grant access to the [management console]({{ link-console-main }}), assign the user the [`{{ roles-cloud-member }}`](../../resource-manager/security/index.md#resource-manager-clouds-member) role for the cloud. Assign resource access permissions for the specific folder or resource. Here is an example:

* A user holding the `{{ roles-cloud-member }}` role for a cloud and `compute.editor` for a folder can work with {{ compute-name }} resources in that folder via the management console.
* A user holding the `{{ roles-cloud-member }}` role for a cloud and `resource-manager.viewer` for a folder can view information about the folder and access permissions assigned for it.

If a user already has the `{{ roles-admin }}` role for a folder but cannot see the folder in the console, check their cloud access role. Assigning the `{{ roles-admin }}` role for the entire cloud is excessive, as this role grants permissions for all folders and resources in that cloud.

For other roles that provide console access, see [Cloud member](../../resource-manager/concepts/resources-hierarchy.md#member). For information on how to assign roles, see [this guide](../../iam/operations/roles/grant.md).

#### What do I do if I get the `User has to accept the End User License Agreement` error when trying to get an IAM token? {#accept-user-agreement}

When getting an IAM token via the {{ yandex-cloud }} CLI, {{ TF }}, or a direct request to the API, you may get one of these errors:

* `User has to accept the End User License Agreement to get an IAM token`
* `User has to accept the End User License Agreement and Privacy Policy to get an IAM token`

The error means that the user requesting the IAM token has not accepted the required agreements yet.

To solve the error, log in to the user’s account and accept the license agreement and privacy policy on the [agreement acceptance page](https://{{ auth-main-host }}/agreement). Then try to get the IAM token again.

If instead of the agreement acceptance page you see a folder in the management console, log out of the account and then log back in. You can also try opening the link in incognito mode or in another browser.

If the agreements are already accepted, make sure the token in the CLI profile, {{ TF }} provider settings, or the API request belongs to the same user. For an OAuth token, you can figure out the owner by [requesting user info](https://yandex.ru/dev/id/doc/en/user-information): the `login` field of the response will contain the Yandex account login.

To work in the CLI as a federated or local user, configure authentication appropriately:

* [{#T}](../../cli/operations/authentication/federated-user.md)
* [{#T}](../../cli/operations/authentication/local-user.md)

#### How are access permissions verified? {#verifying-rights}

Before performing an operation with a resource, such as creating a VM, {{ iam-short-name }} checks whether the user has all the required permissions. If any of the required permissions are missing, the operation will fail and {{ yandex-cloud }} will report an error. For more information, see [{#T}](../../iam/concepts/access-control/index.md).

#### What is a resource? {#resource}

A _resource_ is a {{ yandex-cloud }} entity you can manage through operations, such as creating, updating, viewing, or deleting. Here are some examples of resources: VMs, disks, service accounts, clouds, and folders. For more information, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md) in the {{ resmgr-name }} guides.

#### How do I change the cloud owner? {#change-cloud-owner}

1. [Add the new owner to the organization](../../organization/operations/add-account.md) if they are not already a member.
1. On behalf of the current owner, [assign the user the `{{ roles-cloud-owner }}` role](../../resource-manager/operations/cloud/set-access-bindings.md#access-to-user) for the cloud.
1. Check the new owner’s access. Then [revoke](../../iam/operations/roles/revoke.md) the `{{ roles-cloud-owner }}` role from the previous owner. Optionally, assign them other roles in accordance with their responsibilities.

A cloud must have at least one owner. Changing the organization owner is a [separate operation](#change-organization-owner).

If facing any issues when trying to change the owner, [contact support]({{ link-console-support }}). Specify the cloud and organization IDs and the usernames of the former and new owners.

#### How do I change the organization owner? {#change-organization-owner}

On behalf of the current owner, [assign](../../organization/operations/add-role.md) the `{{ roles-organization-owner }}` role to the new owner. The new owner must be the [organization member](../../organization/operations/add-account.md).

After verifying the new owner’s access, [revoke](../../organization/operations/revoke-role.md) this role from the previous owner. Do not remove the previous owner from the organization unless they no longer need access.

If facing any issues when trying to perform these actions, [contact support]({{ link-console-support }}). Specify the organization ID and the usernames of the former and new owners.
