# Access

By default, all operations in Instance Groups are performed on behalf of a service account.

Service accounts are special accounts that can be used by services and applications to interact with other Yandex.Cloud APIs on your behalf. For more information about service accounts and access management in Yandex.Cloud, see the documentation at [Yandex Identity and Access Management](../../../iam/).

Instance Groups applications use service account [authorized  keys](../../../iam/concepts/authorization/key.md) for authorization in the set of APIs and to perform operations on resources within the roles granted to this service account. For example, Instance Groups uses a service account for creating, updating, and deleting instances. Instance Groups is easily authenticated in the Compute Cloud API without embedding private keys or user credentials in the application code.

An instance group can have only one service account created in the same folder as the group.

#### See also {#see-also}

- [#T](../../quickstart/ig.md).
- [#T](../../../iam/operations/sa/create.md).