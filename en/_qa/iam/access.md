# Logging in and accessing resources

#### How do I log in to the management console? {#console-log-in}

Go to the [management console page]({{ link-console-main }}).

If you are not logged in to your Yandex or Yandex 360 account, click **Log in**. If you don't have an account yet, click **Register**. For more information, see the [Yandex.Passport documentation](https://yandex.com/support/passport/auth.html).

#### How are access rights verified? {#verifying-rights}

Before performing an operation with a resource, such as creating a VM, {{ iam-short-name }} checks whether the user has all the necessary permissions. If the user does not have any of the permissions, the operation will not be performed and {{ yandex-cloud }} will return an error. For more information, see [{#T}](../../iam/concepts/access-control/index.md).

#### What is a resource? {#resource}

_A resource_ is a {{ yandex-cloud }} entity that you can perform operations with, such as creating, updating, viewing, or deleting it. Examples of resources: VMs, disks, service accounts, clouds, and folders. For more information, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md) in the {{ resmgr-name }} documentation.

#### What is access binding? {#access-binding}

Access rights are set as a list of _role-subject_ bindings. They are called access bindings. You can add or remove these bindings to control access rights to a resource. For more information, see [{#T}](../../iam/concepts/access-control/index.md#access-bindings).

