# Authorization in Yandex.Cloud

When a user does something with a resource in Yandex.Cloud, IAM checks whether the user has the necessary access rights to perform this operation.

Users get permissions along with resource roles. For more information about how roles are assigned and how the list of permissions is checked, see [[!TITLE]](../access-control/index.md).

Authorization is performed in different ways, depending on the type of account and the interface used.

## Authorization with a Yandex.Passport account {#passport}

---

**[!TAB Management console]**

Log in to your Yandex or Yandex.Connect account.

**[!TAB CLI]**

To log in, enter your [OAuth token](oauth-token.md) during [profile initialization](../../../cli/quickstart.md#initialize) in the CLI. The token will be saved in the profile configuration and authorization will be granted automatically.

**[!TAB API]**

To log in:

1. [Get an IAM token](../../operations/iam-token/create.md) in exchange for your [OAuth token](oauth-token.md)

2. [!INCLUDE [iam-token-usage](../../../_includes/iam-token-usage.md)]

    [!INCLUDE [iam-token-usage](../../../_includes/iam-token-lifetime.md)]

---

## Service account authorization {#sa}

Service accounts are authorized via the Yandex.Cloud API using an [IAM token](iam-token.md) and [authorized keys](key.md), and in services with an AWS-compatible API via [static access keys](access-key.md) (for instance, in [!KEYREF objstorage-name]).

#### What's next

* [How to get an IAM token for a user account](../../operations/iam-token/create.md)
* [How to get an IAM token for a service account](../../operations/iam-token/create-for-sa.md).
* [How to use the API in [!KEYREF objstorage-name]](../../../storage/s3/index.md)
* [[!TITLE]](../../operations/sa/create-access-key.md)

