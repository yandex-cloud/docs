# Access

All operations in {{ ig-name }} are performed on behalf of the service account.

Service accounts are special accounts that can be used by services and applications to interact with other {{ yandex-cloud }} APIs on your behalf. For more information about service accounts and access management in {{ yandex-cloud }}, see the documentation for [{{ iam-full-name }}](../../../iam/).

{{ ig-name }} applications use service account [authorized keys](../../../iam/concepts/authorization/key.md) for authorization in the set of APIs and to perform operations on resources within the roles granted to this service account. For example, {{ ig-name }} uses a service account for creating, updating, and deleting instances. {{ ig-name }} is easily authenticated in the {{ compute-name }} API without embedding private keys or user credentials in the application code.

An instance group can have only one service account created in the same folder as the group.

#### See also {#see-also}

- [{#T}](../../quickstart/ig.md).
- [{#T}](../../../iam/operations/sa/create.md).
