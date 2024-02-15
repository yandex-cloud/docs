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

## Service account {#sa}

{% include [sa-def](../../_includes_service/sa-def.md) %}

Service accounts allow you to set up flexible access to your resources and minimize risks associated with excessive permissions. Use this account type for your applications, YC CLI, {{ TF }}, and {{ yandex-cloud }} API. For more information, see [{#T}](service-accounts.md).

## Federated accounts {#saml-federation}

A _federated account_ is a user account from an identity federation, e.g., Active Directory.

{% include [about-saml-federations](../../../_includes/iam/about-saml-federations.md) %}

Use federated accounts if you need to grant {{ yandex-cloud }} access to a large number of employees.

For more information, see [{#T}](../../../organization/concepts/add-federation.md).
