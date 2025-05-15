---
title: Processing secrets that have become publicly available in {{ yandex-cloud }}
description: In this tutorial, you will learn what you should do if your secrets leaked to the public domain.
---

# Handling secrets that are available in the public domain

{{ yandex-cloud }} automatically [searches for publicly available secrets](../../security/operations/search-secrets.md). Keep track of how secrets are used to ensure the safety of your data and infrastructure. If your secrets are compromised:

1. [Revoke and reissue secrets](#revoke-credentials).
1. [Check for any unauthorized actions](#searching-unauthorized-access).
1. [Delete unauthorized resources](#delete-unauthorized-resources).
1. [Contact support](#support).
1. [Follow our recommendations on building a secure infrastructure](#recommendations).

## Revoke and reissue secrets {#revoke-credentials}

### IAM token {#iam-reissue}

To prevent a hacker from using your token:

1. [Revoke](./iam-token/revoke-iam-token.md) the compromised IAM token.
1. Create a new IAM token.

    * [For a Yandex account](iam-token/create.md).
    * [For a service account](iam-token/create-for-sa.md).
    * [For a federated account](iam-token/create-for-federation.md).

### OAuth token {#oauth-reissue}

You can revoke an OAuth token. In this case, the IAM tokens obtained using the OAuth token will remain valid. Therefore, you must also revoke all such IAM tokens.

To prevent a hacker from using your token:

1. [Revoke the OAuth token](https://yandex.com/dev/oauth/doc/dg/reference/token-invalidate.html).
1. [Revoke](./iam-token/revoke-iam-token.md) all IAM tokens obtained using the compromised OAuth token.
1. [Get a new OAuth token]({{ link-cloud-oauth }}).

### Authorized key {#key-reissue}

If you need to prevent damage from a compromised key as quickly as possible, [delete](sa/delete.md) the service account.

If the continuity of the process that the service account is part of is more important to you, reissue authorized keys:

1. [Create a new authorized key](authentication/manage-authorized-keys.md#create-authorized-key) for the service account.
1. Grant the new authorized key to the services and users using it.
1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md) for the new authorized key.
1. [Delete the old authorized key](./authentication/manage-authorized-keys.md#delete-authorized-key).

Once you delete the authorized key, the respective IAM token becomes invalid. That is enough to prevent any threat from the compromised key.

### JWT {#jwt-reissue}

Follow the steps described in the [Authorized key](#key-reissue) section.

### Static key {#access-key-reissue}

1. [Create a new static key](authentication/manage-access-keys.md#create-access-key) for the service account.
1. Grant the new static key to the services and users using it.
1. [Delete the old static key](authentication/manage-access-keys.md#delete-access-key).

### API key {#api-key-reissue}

1. [Create a new API key](authentication/manage-api-keys.md#create-api-key) for the service account.
1. Grant the new API key to the services and users using it.
1. [Delete the old API key](./authentication/manage-api-keys.md#delete-api-key).

### {{ captcha-name }} server key {#captcha-server-key}

[Create a new CAPTCHA](../../smartcaptcha/quickstart.md#creat-captcha) and, on the website page, replace the old CAPTCHA, whose [server key](../../smartcaptcha/concepts/keys.md) was compromised, with the new one.

### Cookie {#cookie-invalidation}

Disable cookies:

1. [Change](https://yandex.com/support/id/profile.html) your Yandex ID password. 
1. [Log in to Yandex ID](https://passport.yandex.com/) with your new password.

## Check for any unauthorized actions {#searching-unauthorized-access}

Analyze access to your {{ yandex-cloud }} resources:

1. [Analyze log records](../../logging/operations/read-logs.md) {{ cloud-logging-name }}.
1. [Search for events](../../audit-trails/tutorials/search-events-audit-logs/index.md) in a bucket or log group in {{ at-name }}.
1. Make sure that all events, including those related to secret leakage, are consistent with expectations.

{% note tip %}

You can configure [exporting audit logs to a SIEM system](../../audit-trails/concepts/export-siem.md).

{% endnote %}

## Delete unauthorized resources {#delete-unauthorized-resources}

1. Check that {{ yandex-cloud }} does not contain any resources that you have not created, such as a VM, data store, database, function, API gateway, etc.
1. Delete unauthorized resources.

## Contact support {#support}

Report the incident to the [support]({{ link-console-support }}). This will help us enhance secret protection in future {{ yandex-cloud }} releases.

You can learn more about the support terms [here](../../support/overview.md).

## Follow our recommendations on building a secure infrastructure {#recommendations}

1. Make sure secrets are separated from the source code. This will help you avoid adding them to public repositories, such as GitHub, along with the code and making them vulnerable.
1. [Manage secrets in your cloud](../../security/standard/encryption.md).
1. [Collect, monitor, and analyze audit logs](../../security/standard/audit-logs.md).
