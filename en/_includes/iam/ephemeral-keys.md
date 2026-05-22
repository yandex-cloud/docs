# Ephemeral access keys compatible with AWS APIs


Ephemeral access keys are temporary credentials for authenticating [Yandex accounts](../../iam/concepts/users/accounts.md#passport), [federated accounts](../../iam/concepts/users/accounts.md#saml-federation), [local users](../../iam/concepts/users/accounts.md#local), and [service accounts](../../iam/concepts/users/service-accounts.md).

{% include [access-control-sa-ephemeralkey-notice](./access-control-sa-ephemeralkey-notice.md) %}

Authentication with ephemeral access keys is only supported in [{{ objstorage-full-name }}](../../storage/).

You can [create](../../iam/operations/authentication/manage-ephemeral-keys.md#create) an ephemeral key for the current user or for a service account you have access to.

Ephemeral keys are issued based on the current session's [IAM token](../../iam/concepts/authorization/iam-token.md). They may be valid from 15 minutes to 12 hours. If lifetime is not set during creation, it is limited to the IAM token's validity period.

{% note warning %}

You cannot revoke an ephemeral key. It automatically expires after its lifetime.

{% endnote %}

To set up access permissions for the key, you need an [access policy](../../storage/security/policy.md) in JSON format based on [this schema](../../storage/s3/api-ref/policy/scheme.md).

{% include [sts-sa-access-backets-list](sts-sa-access-backets-list.md) %}


## Ephemeral key format {#ephemeral-key-format}

Ephemeral keys consist of three parts:

* Key ID
* Secret key
* Session token

Requests to the AWS-compatible API use all the three parts. The key ID is specified in open format. The secret key is used to sign request parameters, and the session token serves to verify temporary credentials.


### Key ID {#key-id}

Consists of 20 characters. These characters may include:

* Latin letters
* Numbers

Here is an example of a key ID: `abcdefg1234h********`.


### Secret key {#private-key}

A secret key consists of 43 characters and always starts with `YC`. Other characters may include:

* Latin letters
* Numbers
* Underscores (`_`) and hyphens (`-`)

Here is an example of a secret key: `YCabcdefg1234hi5678jk9AbCdEfG1234hI********`.


### Session token {#session-token}

The session token has a variable length of approximately 285 characters and is used to verify temporary credentials. Token example: `s1.9muilY...`.