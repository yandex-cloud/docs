# Authorization in Yandex Cloud

> [!NOTE]
>
> _Authentication_ and _authorization_ are different concepts; please do not confuse them.
>
> _Authentication_ proves that you are who you say you are. Checking that you know your account password is a form of authentication.
>
> _Authorization_ checks that you are allowed to perform an operation with the requested resource. Checking that you are allowed to create a virtual machine in a given folder is authorization.

Authorization in Yandex Cloud leverages the [Role Based Access Control](https://en.wikipedia.org/wiki/Role-based_access_control)  policy (RBAC). When you do something with a resource in Yandex Cloud, IAM checks whether you have the necessary access rights to perform this operation. The list of access rights depends on the roles you have been assigned for this resource.

Resource access rights can be inherited from other resources. For example, a new disk is created in a folder, while the folder is created in the cloud. Disk access rights are inherited from the rights for the folder and cloud that are hosting the disk. Learn more about rights inheritance and the Yandex Cloud resource model in the section [[!TITLE]](../../../resource-manager/concepts/resources-hierarchy.md) of Yandex Resource Manager documentation.

For authorization in Yandex Сloud, an IAM token is used. This token is issued in exchange for an OAuth token that authenticates you. AS a result, Yandex Cloud uses the IAM token to understand who is performing the operation with the resource and check which operations are allowed for you.

## Authorization of a normal user {#user-auth}

_A normal user_ is a user who has registered with Yandex Cloud.

The user's steps to get authorized in Yandex Cloud depends on the interface used.

#### Management Console

The procedure for obtaining and using tokens is hidden from the user. The user is authenticated when logging in to their Yandex account.

#### CLI

The IAM token is requested automatically based on an [OAuth token](oauth-token.md). To do this, specify your OAuth token during initialization.

#### API

1. The user requests an IAM token in exchange for an OAuth token.
2. The IAM token must be specified in every HTTP request other than the IAM token request. The IAM token is passed in the `Authorization` header in the following format:

    ```
    Authorization: Bearer [IAM-token]
    ```

