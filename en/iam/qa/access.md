# Logging in and accessing resources

#### How do I log in to the management console?

Go to the [management console page](https://console.cloud.yandex.ru/).

If you are not logged in to your Yandex or Yandex.Connect account, click **Log in**. If you don't have an account yet, click **Register**. For more information, see the [Yandex.Passport documentation](https://yandex.com/support/passport/auth.html).

#### How are access rights verified?

Before performing an operation with a resource, such as creating a VM, [!KEYREF iam-short-name] checks whether the user has all necessary permissions. If the user does not have any of the permissions, the operation will not be performed and Yandex.Cloud will return an error. For more information, see the section [[!TITLE]](../concepts/access-control/index.md).

#### What is a resource?

_A resource_ is a Yandex.Cloud entity that you can perform operations with, such as creating, updating, viewing, or deleting it. Examples of resources: VMs, disks, service accounts, clouds, and folders. For more information, see the section [[!TITLE]](../../resource-manager/concepts/resources-hierarchy.md) of the [!KEYREF resmgr-name] service documentation.

#### What is access binding?

Access rights are set as a list of _role-subject_ bindings. They are called access bindings. You can add or remove these bindings to control access rights to a resource. For more information, see the section [[!TITLE]](../concepts/access-control/index.md#access-bindings).

