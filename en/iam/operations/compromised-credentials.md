# Handling secrets that are available in the public domain

{{ yandex-cloud }} automatically [scans the public domain for secrets](../../security/operations/search-secrets.md). Keep track of how secrets are used to ensure the safety of your data and infrastructure. If your secrets are compromised:

1. [Revoke and reissue secrets](#revoke-credentials).
1. [Check for any unauthorized actions](#searching-unauthorized-access).
1. [Delete unauthorized resources](#delete-unauthorized-resources).
1. [Contact support](#support).
1. [Follow our recommendations on building a secure infrastructure](#recommendations).

## Revoke and reissue secrets {#revoke-credentials}

### IAM token {#iam-reissue}

You cannot delete an IAM token. If you create a new IAM token, the previous one remains valid.

To prevent a hacker from using your token:

1. Perform the following actions with the service account the IAM token was issued for:

   * For a service account: [reissue](#key-reissue) the authorized key of the service account that the token is granted for or delete the account.
   * For a Yandex or federated account, do one of the following:

      * [Remove the account](../../organization/operations/edit-account.md) from all organizations while the token is valid.
      * Revoke the rights of the account in any [cloud](users/delete) and [organization](../../organization/security/index.md#revoke) for the token validity period.

         {% note info %}

         IAM tokens are valid for [up to 12 hours](../concepts/authorization/iam-token.md#lifetime).

         {% endnote %}

2. Create a new IAM token.

   * [Guide for a Yandex account](iam-token/create.md).
   * [Guide for a service account](iam-token/create-for-sa.md).
   * [Guide for a federated account](iam-token/create-for-federation.md).

### OAuth token {#oauth-reissue}

You can revoke an OAuth token. In this case, the IAM token that is obtained using the OAuth token remains valid.

To prevent a hacker from using your token:

1. [Revoke the OAuth token](https://yandex.com/dev/oauth/doc/dg/reference/token-invalidate.html).

1. Revoke the rights of the account that the OAuth token belongs to in one of the following ways:

   * [Remove the account](../../organization/operations/edit-account.md) from all organizations while the IAM token is valid.
   * Revoke the rights of the account in any [cloud](users/delete) and [organization](../../organization/security/index.md#revoke) for the IAM token validity period.

      {% note info %}

      IAM tokens are valid for up to 12 hours. Learn more about the [IAM token lifetime](../concepts/authorization/iam-token.md#lifetime).

      {% endnote %}

1. [Get a new OAuth token]({{ link-cloud-oauth }}).

### Authorized key {#key-reissue}

If you need to prevent damage from a compromised key as quickly as possible, [delete](sa/delete.md) the service account.

If the continuity of the process that the service account is part of is more important to you, reissue authorized keys:

1. [Create a new authorized key](authorized-key/create.md) for the service account.
1. Grant the new authorized key to the services and users using it.
1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md) for the new authorized key.
1. [Delete the old authorized key](./authorized-key/delete.md).

Once you delete the authorized key, the respective IAM token becomes invalid. That is enough to prevent any threat from the compromised key.

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

### {{ captcha-name }} server key {#captcha-server-key}

[Create a new CAPTCHA](../../smartcaptcha/quickstart.md#creat-captcha) and, on the website page, replace the old CAPTCHA, whose [server key](../../smartcaptcha/concepts/keys.md) was compromised, with the new one.

### Cookies {#cookie-invalidation}

Disable cookies:

1. [Change your password](https://yandex.com/support/id/profile.html) in Yandex ID.
1. [Log in to Yandex ID](https://passport.yandex.com/) with the new password.

## Check for any unauthorized actions {#searching-unauthorized-access}

Analyze access to your {{ yandex-cloud }} resources:

1. [Analyze log records](../../logging/operations/read-logs.md) {{ cloud-logging-name }}.
1. [Search for events in a bucket](../../audit-trails/tutorials/search-bucket.md) and [search for events in a log group](../../audit-trails/tutorials/search-cloud-logging.md) in {{ at-name }}.
1. Make sure that all events, including those related to secret leakage, are consistent with expectations.

{% note tip %}

You can configure [exporting audit logs to a SIEM system](../../audit-trails/concepts/export-siem.md).

{% endnote %}

## Delete unauthorized resources {#delete-unauthorized-resources}

1. Check that {{ yandex-cloud }} does not contain any resources that you have not created, such as a VM, data store, database, function, API gateway, etc.
1. Delete unauthorized resources.

## Contact support {#support}

Report the incident to the [support team]({{ link-console-support }}). This will help us enhance secret protection in future {{ yandex-cloud }} releases.

Learn more about [requesting technical support](../../support/overview.md).

## Follow our recommendations on building a secure infrastructure {#recommendations}

1. Make sure secrets are separated from the source code. This will help you avoid adding them to public repositories, such as GitHub, along with the code and making them vulnerable.
1. [Manage secrets in your cloud](../../security/domains/encryption.md#upravlenie-sekretami).
1. [Collect, monitor, and analyze audit logs](../../security/domains/audit-logs.md).
