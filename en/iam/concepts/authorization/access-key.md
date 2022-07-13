# Static access keys compatible with the AWS API

_Static access keys_ consist of a private key and a key ID used for authentication in services with an AWS-compatible API, such as {{ objstorage-name }}, {{ message-queue-name }}, and {{ ydb-name }} when using Document API. Access keys are only used for [service accounts](../users/service-accounts.md).

Users sign their requests with private keys. {{ yandex-cloud }} finds the key with the specified ID and uses it to verify the received signature. The fact that a private key is linked to a service account ensures that an operation is performed by the account owner.

## Services that support this authentication method {#supported-services}

For information about how to use static access keys, read the documentation on the services that support this authorization method:

* [{{ objstorage-name }}](/docs/storage/)
* [{{ message-queue-name }}](/docs/message-queue/)


* [{{ ydb-name }}](../../../ydb/docapi/tools/aws-setup.md)


#### See also {#see-also}

* [How to create a static access key](../../operations/sa/create-access-key.md)
* [{#T}](./index.md)

