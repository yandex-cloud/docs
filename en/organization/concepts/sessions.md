---
title: Sessions in {{ org-full-name }}
description: Sessions give users access to services that rely on single sign-on with {{ org-full-name }} as the identity provider (IdP) without re-authentication in {{ org-full-name }}.
---

# Sessions

After a user successfully authenticates to {{ org-full-name }} via [{{ auth-main-host }}](https://{{ auth-main-host }}), a _session_ is created for that user, and a `yc_session` [cookie](../../iam/concepts/authorization/cookie.md) is created for the `{{ auth-main-host }}` domain.

Sessions give you access to services that rely on single sign-on (SSO) with {{ org-full-name }} as the identity provider (IdP) without re-authentication in {{ org-full-name }}.

A session contains the following data about the user's working session in {{ org-full-name }}:

{% include [session-contents-list](../../_includes/organization/session-contents-list.md) %}

## Session lifetime {#session-lifetime}

Session lifetime depends on user account type:

* For [federated](../../iam/concepts/users/accounts.md#saml-federation) users, session lifetime is determined by the [identity federation](./add-federation.md) settings.
* For [local](../../iam/concepts/users/accounts.md#local) users, session lifetime is determined by the [user pool](./user-pools.md) settings.
* For [Yandex account](../../iam/concepts/users/accounts.md#passport) users, session lifetime is 12 hours.

## User session management {#session-management}

A user can [view](../operations/manage-account.md#view-sessions) and [end](../operations/manage-account.md#end-sessions) their current sessions from the [My account](./my-account.md) portal.

An administrator can [view](../operations/manage-sessions.md#view-sessions) and [end](../operations/manage-sessions.md#end-sessions) the sessions of [federated](../../iam/concepts/users/accounts.md#saml-federation) and [local](../../iam/concepts/users/accounts.md#local) users of the organization. The [organization](./organization.md) roles the administrator needs for that are [`organization-manager.federations.userAdmin`](../security/index.md#organization-manager-federations-userAdmin) and [`organization-manager.userpools.userAdmin`](../security/index.md#organization-manager-userpools-userAdmin) or higher, respectively.

{% note info %}

The organization's administrator cannot manage the sessions of other organization users [with a Yandex account](../../iam/concepts/users/accounts.md#passport).

{% endnote %}

A session ends and automatically disappears from the user's session list when its lifetime ends or when the user logs out of the account by clicking ![arrow-right-from-square](../../_assets/console-icons/arrow-right-from-square.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.logout_nXPin }}**.

#### See also {#see-also}

* [{#T}](../../iam/concepts/authorization/cookie.md)
* [{#T}](../operations/manage-sessions.md)
* [{#T}](../operations/manage-account.md)