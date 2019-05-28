# General questions

#### What is the [!KEYREF iam-full-name] service used for?

[!INCLUDE-NOTITLE [iam-def](../../_includes/iam-def.md)]

[!KEYREF iam-short-name] allows you to:

* Invite new users to the cloud and delete them from it.
* Manage access rights to resources by assigning and revoking roles.
* Create [service accounts](../concepts/users/service-accounts.md), i.e., special accounts used for managing Yandex.Cloud resources via the API.
* Get an IAM token that is required for authorization via the API.

Other Yandex.Cloud services use the [!KEYREF iam-short-name] API to provide you with more control over access to these services' resources. For example, [!KEYREF compute-full-name] grants an additional role of `compute.images.user` to control access to disk images.

#### How do I get started with IAM?

To start working with IAM, you need to register with Yandex.Cloud. After registration, you will be able to use the IAM features.

See [[!TITLE]](../quickstart.md) to find out how to add a new user to your cloud and assign them a role.

#### How much does it cost to use [!KEYREF iam-short-name]?

The [!KEYREF iam-short-name] service can be used free of charge.

