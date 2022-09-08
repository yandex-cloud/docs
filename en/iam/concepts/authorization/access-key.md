# Static access keys compatible with the AWS API

A static access key is required to authenticate a [service account](../users/service-accounts.md) in [AWS-compatible APIs](#supported-services).

It consists of two parts:

* Key ID.
* Private key.

Both parts are used in requests to the AWS-compatible API. A key ID is specified in open format. Users sign request parameters with a private key. The private key itself is not specified in the request.

The secret key is stored by the user. {{ yandex-cloud }} gives access to it only when the [static key is created](../../operations/sa/create-access-key.md).

Static keys do not expire.

{% note alert %}

Make sure that no third party has access to the secret key. Keep your key in a secure location. If the key becomes known to a third party, [reissue](../../operations/compromised-credentials.md#access-key-reissue) it.

{% endnote %}

## Static key format {#access-key-format}

### Key ID {#key-id}

It consists of 25 characters and always starts with the letters `YC`. Other characters may be:

* Latin letters.
* Numbers.
* `_` and `-`.

Example of a key ID: `YCchbYEDdcsYFBnxSWbcjDJDn`.

### Private key {#private-key}

It consists of 40 characters and always starts with the letters `YC`. Other characters may be:

* Latin letters.
* Numbers.
* `_` and `-`.

Example of a private key: `YCVdheub7w9bImcGAnd3dZnf08FRbvjeUFvehGvc`.

## Services that support this authentication method {#supported-services}

For information about how to use static access keys, read the documentation on the services that support this authorization method:

* [{{ objstorage-name }}](../../../storage/s3/index.md)
* [{{ message-queue-name }}](../../../message-queue/api-ref/index.md)
* [{{ ydb-name }}](../../../ydb/docapi/tools/aws-setup.md)

#### See also {#see-also}

* [How to create a static access key](../../operations/sa/create-access-key.md)
* [{#T}](./index.md)