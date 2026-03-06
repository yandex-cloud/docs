---
title: How to log in to the {{ yandex-cloud }} console for the first time
description: Follow this guide to log in to the {{ yandex-cloud }} management console for the first time.
---

# First-time login to the console

If invited to a {{ yandex-cloud }} [organization](../../concepts/organization.md), accept the invitation and proceed to your first-time login to the [management console](../../../console/quickstart/console.md). The login procedure depends on your [account type](../../../iam/concepts/users/accounts.md).

{% list tabs group=instructions %}

- Yandex account users {#passport-user}

  To log in to the management console with a [Yandex account](../../../iam/concepts/users/accounts.md#passport):

  1. Open the invitation email.
  1. In the email, click **Accept invitation**.
  1. On the page that opens, click **Accept**.
  1. Select a Yandex account to log in or log in to an existing account.
  1. Navigate to the [management console]({{ link-console-main }}).
  1. If your organization has a [mandatory two-factor authentication policy](../../operations/enable-2fa-access.md) in place, you will be prompted to set up a [second factor](../../concepts/mfa.md). Select the login authentication method available to you:

     {% include [mfa-time-limit](../../../_includes/organization/mfa-time-limit.md) %}

     {% include [mfa-modes-list](../../../_includes/organization/mfa-modes-list.md) %}

  Once you have successfully set up your second factor, you will be redirected to the management console.

- Local users {#local-user}

  [Local users](../../../iam/concepts/users/accounts.md#local) are created by the administrator in the organization's [user pool](../../concepts/user-pools.md). When creating an account, the administrator sets a login and temporary password, which are then shared with the user. You must change your password on your first login.

  To log in to the [management console](../../../console/quickstart/console.md) for the first time:

  1. Go to the [management console]({{ link-console-main }}) page.
  1. Enter the login and temporary password you got from the organization administrator.
  1. You will be prompted to change the password:
     1. Enter your new password twice.
     1. Click **Save password**.
  1. If your organization has a [multi-factor authentication](../../concepts/mfa.md) policy in place for local users, you will need to set up a second factor the first time you log in. Select the login authentication method available to you:

     {% include [mfa-time-limit](../../../_includes/organization/mfa-time-limit.md) %}

     {% include [mfa-modes-list](../../../_includes/organization/mfa-modes-list.md) %}

  Once you have successfully set up your second factor, you will be redirected to the management console.

- Federated users {#federated-user}

  [Federated users](../../../iam/concepts/users/accounts.md#saml-federation) authenticate through an external identity provider. The organization administrator sets up an [identity federation](../../concepts/add-federation.md) and adds users.

  To log in to the [management console](../../../console/quickstart/console.md) for the first time:

  1. Go to the [management console]({{ link-console-main }}) page.
  1. Click **Log in via SSO**.
  1. Enter the federation ID provided by your administrator.
  1. Click **Next**.
  1. You will be redirected to your IdP login page, e.g., your company portal.
  1. Enter the credentials you use in your organization (your corporate login and password).
  1. You will be prompted to change the password:
     1. Enter your new password twice.
     1. Click **Save password**.
  1. If your organization has a [multi-factor authentication](../../concepts/mfa.md) policy in place for federated users, you will need to set up a second factor the first time you log in. Select the login authentication method available to you:

     {% include [mfa-time-limit](../../../_includes/organization/mfa-time-limit.md) %}

     {% include [mfa-modes-list](../../../_includes/organization/mfa-modes-list.md) %}

  Once you have successfully set up your second factor, you will be redirected to the management console.

{% endlist %}

You now have access to the organization and its resources for which the administrator has granted you permissions.

## What's next {#what-is-next}

* [Managing your profile in the My account portal](../manage-account.md)
* [Troubleshooting login issues](troubleshooting.md)
* [Managing login authentication methods](../manage-account.md#manage-mfa)

#### See also {#see-also}

* [{#T}](../../concepts/my-account.md)
* [{#T}](../../concepts/mfa.md)
* [User account types](../../../iam/concepts/users/accounts.md)
