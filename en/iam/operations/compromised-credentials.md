# Handling secrets that are available in the public domain

{{ yandex-cloud }} uses the following secrets:

* [IAM token](../concepts/authorization/iam-token.md).
* [OAuth token](../concepts/authorization/oauth-token.md).
* [Authorized keys](../concepts/authorization/key.md).
* [JWT](iam-token/create-for-sa.md#via-jwt).
* [Static keys](../concepts/authorization/access-key.md).
* [API keys](../concepts/authorization/api-key.md).
* Browser cookies.

Keep track of how secrets are used to ensure the safety of your data and infrastructure. If your secrets are compromised, be sure to stop using them.


## Revoking and reissuing a secret {#revoke-credentials}

Some secrets can't be revoked, such as an IAM token or JSON Web Token (JWT). If these secrets are compromised, do one of the following:

* Revoke the rights of the account that the secret belongs to.
* Delete the service account or remove the user account from the organization.
* Delete the key that was used for creating the secret. For example, if a JWT or an IAM token created with a JWT is compromised, delete the service account's authorized key.

{{ yandex-cloud }} allows issuing multiple authorized, static, and API keys at the same time. First, issue new keys, grant them to the appropriate services and users, and then revoke the old keys.


### IAM token {#iam-reissue}

You can't delete an IAM token. If you create a new IAM token, the previous one remains valid.

1. To prevent a hacker from using your token:

   * For a service account: [reissue](#key-reissue) the authorized key of the service account that the token is granted for or delete the account.
   * For a Yandex or federated account, do one of the following:

      * [Remove the account](../../organization/edit-account.md) from all organizations while the token is valid.
      * Revoke the rights of the account in any [cloud](users/delete) and [organization](../../organization/roles.md#revoke) for the token's validity period.

         {% note info %}

         IAM tokens are valid for 12 hours maximum. Learn more about the [IAM token lifetime](../concepts/authorization/iam-token.md#lifetime).

         {% endnote %}

2. Create a new IAM token.

   * [Instructions for a Yandex account](iam-token/create.md).
   * [Instructions for a service account](iam-token/create-for-sa.md).
   * [Instructions for a federated account](iam-token/create-for-federation.md).


### OAuth token {#oauth-reissue}

You can revoke an OAuth token. In this case, the IAM token that is obtained using the OAuth token remains valid.

To prevent a hacker from using your token:

1. [Revoke the OAuth token](https://yandex.com/dev/oauth/doc/dg/reference/token-invalidate.html).

1. Revoke the rights of the account that the OAuth token belongs to in one of the following ways:

   * [Remove the account](../../organization/edit-account.md) from all organizations while the IAM token is valid.
   * Revoke the rights of the account in any [cloud](users/delete) and [organization](../../organization/roles.md#revoke) for the IAM token's validity period.

      {% note info %}

      IAM tokens are valid for 12 hours maximum. Learn more about the [IAM token lifetime](../concepts/authorization/iam-token.md#lifetime).

      {% endnote %}

1. [Get a new OAuth token]({{ link-cloud-oauth }}).


### Authorized key {#key-reissue}

If you need to prevent damage from a compromised key as quickly as possible, [delete](sa/delete.md) the service account.

If the continuity of the process that the service account is part of is more important to you, reissue authorized keys:

1. [Create a new authorized key](authorized-key/create.md) for the service account.
1. Grant the new authorized key to the services and users using it.
1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md) for the new authorized key.
1. [Delete the old authorized key](./authorized-key/delete.md).

Once the authorized key is deleted, the respective IAM token becomes invalid. That's all you need to do to prevent any threat from the compromised key.


### JWT {#jwt-reissue}

Follow the steps described in the [Authorized key](#key-reissue) section.


### Static key {#access-key-reissue}

1. [Create a new static key](sa/create-access-key.md) for the service account.
1. Grant the new static key to the services and users using it.
1. [Delete the old static key](./sa/delete-access-key.md).


### API key {#api-key-reissue}

1. [Create a new API key](api-key/create.md) for the service account.
1. Grant the new API key to the services and users using it.
1. [Delete the old API key](./api-key/delete.md).


### Disabling cookies {#cookie-invalidation}

1. [Change your password](https://yandex.com/support/id/profile.html) in Yandex ID.
1. [Log in to Yandex ID](https://passport.yandex.com/) with the new password.


## Monitoring unauthorized actions and resources {#searching-unauthorized-access}

Once you revoke or reissue a secret, analyze access to your {{ yandex-cloud }} resources.

1. [Analyze log records](../../logging/operations/read-logs.md) {{ cloud-logging-name }}.
1. [Search for events in a bucket](../../audit-trails/tutorials/search-bucket.md) and [search for events in a log group](../../audit-trails/tutorials/search-cloud-logging.md) in {{ at-name }}.
1. Make sure that all events, including those related to secret leakage, are consistent with expectations.

{% note tip %}

You can configure [exporting audit logs to a SIEM system](../../audit-trails/concepts/export-siem.md).

{% endnote %}


## Deleting unauthorized resources {#delete-unauthorized-resources}

1. Check that {{ yandex-cloud }} doesn't contain any resources that you haven't created, such as a VM, data store, database, function, or API gateway.
1. Delete unauthorized resources, first of all, those that can process data or compromise your information in any other way.


## Contact support {#support}

Report the incident to the [support team]({{ link-console-support }}). This will help us enhance secret protection in future cloud releases.

Learn more about [requesting technical support](../../support/overview.md).


## Recommendations on building a secure infrastructure {#recommendations}

1. Make sure secrets are separated from your code.

   Don't use secrets in the source code. They may get into public repositories, such as on GitHub, along with the source code and become vulnerable.

1. [Manage secrets in your cloud](../../security/domains/encryption.md#upravlenie-sekretami).
1. [Collect, monitor, and analyze audit logs](../../security/domains/audit-logs.md).
