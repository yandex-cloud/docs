# Access

In {{ ig-name }}, all operations are performed on behalf of a service account.

Service accounts are special accounts that can be used by services and applications to interact with other {{ yandex-cloud }} APIs on your behalf. For more information about service accounts and access management in {{ yandex-cloud }}, see the [{{ iam-full-name }} documentation](../../../iam/).

{{ ig-name }} applications use service account [authorized keys](../../../iam/concepts/authorization/key.md) for authorization in the APIs and perform operations on resources within the roles granted to the service account in question. For example, {{ ig-name }} can use a service account for creating, updating, and deleting VM instances. {{ ig-name }} can easily get authenticated in the {{ compute-name }} API without embedding private keys or user credentials in the application code.

An instance group may only have one service account created in the same folder as the group.

{% note info %}

{% include [sa-dependence](../../../_includes/instance-groups/sa-dependence.md) %}

{% endnote %}

#### See also {#see-also}

- [{#T}](../../quickstart/ig.md).
- [{#T}](../../../iam/operations/sa/create.md).
