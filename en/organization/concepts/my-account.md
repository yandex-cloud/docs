---
title: My account portal in {{ org-full-name }}
description: My account is a user's personal workspace where they can manage their {{ org-name }} account.
---

# My account portal

{% include [note-preview](../../_includes/note-preview.md) %}

[_My account_]({{ link-my-account }}) is a user's personal workspace where they can manage their account. Currently, there are two sections available:

* ![alt](../../_assets/console-icons/passport.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.profile_8kyBA }}**: User information.
* ![alt](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.security_7zQ3g }}**: Managing user password, [login authentication methods](./mfa.md), and [refresh tokens](../../iam/concepts/authorization/refresh-token.md).
* ![alt](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.groups_pqQRu }}**: Viewing user groups.

[What you can do](../../iam/concepts/users/accounts.md) in the _My account_ portal depends on your [account type](../operations/manage-account.md).

#### See also {#see-also}

* [{#T}](../operations/manage-account.md)
* [{#T}](../../iam/concepts/users/accounts.md)