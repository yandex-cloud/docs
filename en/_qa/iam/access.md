# Logging in and accessing resources

#### How do I log in to the management console? {#console-log-in}

Go to the [management console page]({{ link-console-main }}).

If not logged in to your Yandex or Yandex 360 account yet, click **Log in**. If you do not have an account yet, click **Register**. For more information, see (https://yandex.com/support/passport/auth.html).

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
