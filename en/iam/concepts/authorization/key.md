# Authorized keys

_Authorized keys_ are a pair of public and private keys that are used when creating a [JSON Web Token](https://tools.ietf.org/html/rfc7519). A JSON Web Token is necessary for requesting an [IAM token](iam-token.md) for a [service account](../users/service-accounts.md).

A private key is returned when creating a new pair of keys, while a public key is contained in the [Key](../../api-ref/Key/index.md) resource.

{% note alert %}

The private key of a service account is the confidential information which allows you to perform operations in {{ yandex-cloud }}. Keep your private key in a secure location.

{% endnote %}

#### See also {#see-also}

* [{#T}](../../operations/authorized-key/create.md)
