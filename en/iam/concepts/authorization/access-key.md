# Static access keys compatible with the AWS API

A static access key is required to authenticate a [service account](../users/service-accounts.md) in [AWS-compatible APIs](#supported-services).

It consists of two parts:

* Key ID
* Secret key

Both parts are used in requests to the AWS-compatible API. A key ID is specified in open format. A secret key is used to sign request parameters and is not specified in the request.

The secret key is stored by the user on their own. {{ yandex-cloud }} gives access to it only while the [static key is being created](../../operations/sa/create-access-key.md).

Static keys do not expire.

{% note alert %}

Make sure no third party has access to the secret key. Keep your key in a secure location. If the key becomes known to a third party, [reissue](../../operations/compromised-credentials.md#access-key-reissue) it.

{% endnote %}

## Static key format {#access-key-format}

### Key ID {#key-id}

A key ID consists of 25 characters and always starts with `YC`. Other characters may be:

* Latin letters
* Numbers
* Underscores (`_`) and hyphens (`-`)

Here is an example of a key ID: `YCchbYEDdcsYFBnxSWbcjDJDn`.

### Secret key {#private-key}

A secret consists of 40 characters and always starts with `YC`. Other characters may be:

* Latin letters
* Numbers
* Underscores (`_`) and hyphens (`-`)

Here is an example of a secret key: `YCVdheub7w9bImcGAnd3dZnf08FRbvjeUFvehGvc`.

For an example of using a secret key and its ID in an AWS-compliant API, see the [AWS Command Line Interface](../../../storage/tools/aws-cli.md#config-files) section.

## Services that support this authentication method {#supported-services}

The following services support authentication based on static access keys:

* [{{ objstorage-name }}](../../../storage/s3/index.md)
* [{{ message-queue-name }}](../../../message-queue/api-ref/index.md)
* [{{ ydb-name }}](../../../ydb/docapi/tools/aws-setup.md)

#### See also {#see-also}

* [{#T}](../../operations/sa/create-access-key.md)
* [{#T}](./index.md)
