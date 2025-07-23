# Accounts in {{ yandex-cloud }}

{{ yandex-cloud }} uses [Yandex accounts](#passport), [service accounts](#sa), and [federated accounts](#saml-federation).

{% note info %}

Billing accounts are not used for managing resources in {{ yandex-cloud }} and are not part of {{ iam-short-name }}. For more information, see [{#T}](../../../billing/concepts/billing-account.md) in the {{ billing-name }} documentation.

{% endnote %}

## Yandex account {#passport}

_Yandex account_: Your [Yandex](https://yandex.ru/support/passport/index.html) or [Yandex 360](https://360.yandex.ru/) account. Use this account type in the following cases:

* If you do not need to set up access permissions for your applications. Otherwise, use a [service account](#sa).
* For smaller teams if you did not set up an identity federation in your organization (e.g., with Active Directory or Google Workspace). Otherwise, use [federated accounts](#saml-federation).

{% include [yandex-account-2fa-warning.md](../../../_includes/iam/yandex-account-2fa-warning.md) %}

### Use cases {#examples-passport}

* [{#T}](../../../tutorials/serverless/websocket-app.md)

## Federated account {#saml-federation}

A _federated account_ is a user account from an identity federation, e.g., Active Directory.

{% include [about-saml-federations](../../../_includes/iam/about-saml-federations.md) %}

Use federated accounts if you need to grant {{ yandex-cloud }} access to a large number of employees.

For more information, see [{#T}](../../../organization/concepts/add-federation.md).

### Use cases {#examples-saml-federation}

* [{#T}](../../../tutorials/security/vault-secret.md)

## Local user {#local}

_Local users_ are linked only to the [domain](../../../organization/concepts/domains.md), their credentials are stored only in {{ yandex-cloud }} as part of a [user pool](../../../organization/concepts/user-pools.md). Local users are created in a user pool, exist within a single organization, and cannot create a new one.

{% note info %}

User pools are currently at the [Preview](../../../overview/concepts/launch-stages.md) stage.

{% endnote %}

Local users get authenticated in {{ yandex-cloud }} with the help of [Login Discovery](../../../organization/concepts/domains.md#login-discovery) without using any external authentication providers.

## Service account {#sa}

{% include [sa-def](../../_includes_service/sa-def.md) %}

Service accounts allow you to set up flexible access to your resources and minimize risks associated with excessive permissions. Use this account type for your applications, CLI, {{ TF }}, and {{ yandex-cloud }} API. For more information, see [{#T}](service-accounts.md).

### Use cases {#examples-sa}

* [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md)
