# Logging in and accessing resources

#### How do I log in to the management console? {#console-log-in}

Go to the [management console page]({{ link-console-main }}).

If you are not logged in to your Yandex or Yandex 360 account, click **Log in**. If you don't have an account yet, click **Register**. For more information, see [Yandex ID Help](https://yandex.com/support/passport/auth.html).

#### How are access permissions verified? {#verifying-rights}

Before performing an operation with a resource, such as creating a VM, {{ iam-short-name }} checks whether the user has all the required permissions. If the user doesn't have any of the permissions, the operation isn't performed and {{ yandex-cloud }} returns an error. For more information, see [{#T}](../../iam/concepts/access-control/index.md).

#### What is a resource? {#resource}

A _resource_ is a {{ yandex-cloud }} entity that you can perform operations with, such as creating, updating, viewing, or deleting it. Examples of resources: VMs, disks, service accounts, clouds, and folders. For more information, see the [{#T}](../../resource-manager/concepts/resources-hierarchy.md) section of the {{ resmgr-name }} documentation.