## Authorized keys {#keys}

_Authorized keys_ are a pair of public and private keys that are used when creating a [JSON Web Token](https://tools.ietf.org/html/rfc7519). A JSON Web Token is required when requesting an IAM token for a service account.

A private key is returned when creating a new pair of keys, while a public key is contained in the [Key](/docs/iam/api-ref/Key/) resource.

> [!IMPORTANT]
>
> The private key of a service account is the confidential information which allows you to perform operations in Yandex.Cloud. Keep your private key in a secure location.

