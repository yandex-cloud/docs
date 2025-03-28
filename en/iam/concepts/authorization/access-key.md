---
title: Static access keys compatible with the AWS API
description: In this article, you will learn about the purpose of a static access key, its format, and about the services supporting this authentication method.
---

# Static access keys compatible with the AWS API


A static access key is required to authenticate a [service account](../users/service-accounts.md) in [AWS-compatible APIs](#supported-services).

It consists of two parts:

* Key ID
* Secret key

Both parts are used in requests to the AWS-compatible API. A key ID is specified in open format. A secret key is used to sign request parameters and is not specified in the request.

It is the client's responsibility to store the secret key. {{ yandex-cloud }} gives access to it only when [creating a static key](../../operations/authentication/manage-access-keys.md#create-access-key).

A static key has no expiration date.

{% note alert %}

Make sure no third party has access to your secret key. Keep your key in a secure location. If your key has become known to a third party, [reissue](../../operations/compromised-credentials.md#access-key-reissue) it.

{% endnote %}

{% include [key-has-last-used-data](../../../_includes/iam/key-has-last-used-data.md) %}

In addition to static access keys, you can use [{{ sts-name }}](sts.md) temporary keys, also compatible with the AWS API, to work with {{ objstorage-full-name }}.

## Static key format {#access-key-format}

### Key ID {#key-id}

A key ID consists of 25 characters and always starts with `YC`. Other characters may include:

* Latin letters.
* Numbers.
* Underscores (`_`) and hyphens (`-`).

Here is an example of a key ID: `YCchbYEDdcsYFBnxSWbcjDJDn`.

### Secret key {#private-key}

A secret key consists of 40 characters and always starts with `YC`. Other characters may include:

* Latin letters.
* Numbers.
* Underscores (`_`) and hyphens (`-`).

Here is an example of a secret key: `YCVdheub7w9bImcGAnd3dZnf08FRbvjeUFvehGvc`.

For an example of using a secret key and its ID in an AWS-compliant API, see the [AWS Command Line Interface](../../../storage/tools/aws-cli.md#config-files) section.

## Services that support this authentication method {#supported-services}

The following services support authentication based on static access keys:

* [{{ objstorage-name }}](../../../storage/s3/index.md)
* [{{ message-queue-name }}](../../../message-queue/api-ref/index.md)
* [{{ ydb-name }}](../../../ydb/docapi/tools/aws-setup.md)
* [{{ yds-full-name }}](../../../data-streams/index.yaml)
* [{{ postbox-full-name }}](../../../postbox/aws-compatible-api/index.md)

#### See also {#see-also}

* [{#T}](../../operations/authentication/manage-access-keys.md#create-access-key)
* [{#T}](./index.md)
* [{#T}](./sts.md)
* [{#T}](../../tutorials/static-key-in-lockbox/index.md)
