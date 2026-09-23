# Logging in and accessing resources

#### How do I log in to the management console? {#console-log-in}

Go to the [management console page]({{ link-console-main }}).

If not logged in to your Yandex or Yandex 360 account yet, click **Log in**. If you do not have an account yet, click **Register**. For more information, see (https://yandex.com/support/passport/auth.html).

#### How are access permissions verified? {#verifying-rights}

Before performing an operation with a resource, such as creating a VM, {{ iam-short-name }} checks whether the user has all the required permissions. If any of the required permissions are missing, the operation will fail and {{ yandex-cloud }} will report an error. For more information, see [{#T}](../../iam/concepts/access-control/index.md).

#### What is a resource? {#resource}

A _resource_ is a {{ yandex-cloud }} entity you can manage through operations, such as creating, updating, viewing, or deleting. Here are some examples of resources: VMs, disks, service accounts, clouds, and folders. For more information, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md) in the {{ resmgr-name }} guides.