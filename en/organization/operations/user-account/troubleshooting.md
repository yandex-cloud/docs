---
title: Troubleshooting user account issues
description: This section describes fixes to common issues when signing in and working with a user account.
---

# Troubleshooting

This section describes fixes to common issues when managing a user account in {{ org-full-name }}:

* [Second factor registration time expired](#mfa-timeout).
* [No access to an application or resource](#no-access).
* [Unable to sign in with a Yandex account](#passport-login-issue).
* [Unable to sign in as a local user](#local-user-login-issue).
* [Unable to sign in as a federated user](#federated-user-login-issue).
* [Unable to delete or modify your login authentication method](#mfa-management-issue).
* [Account deactivated](#account-blocked).
* [Additional help](#additional-help).

## Second factor registration time expired {#mfa-timeout}

You get this error at sign-in: `Account login is not possible. The deadline for adding the second factor has expired. Contact the organization's administrator`.

### Solution {#mfa-timeout-solution}

You have to configure a [second authentication factor](../../concepts/mfa.md) during your first sign-in to the [management console](../../../console/quickstart/console.md). You are given a limited time to complete the setup. You can learn the time you have for the operation from your [organization administrator](../../security/index.md#organization-manager-admin). On your request, the organization administrator can:

* Reset the second-factor verification date for your account.
* Temporarily disable the [multi-factor authentication policy](../../concepts/mfa.md) for your account.

{% note tip %}

Prepare an authentication [application](https://www.rustore.ru/catalog/app/ru.yandex.key) or security key to configure a second-factor.

{% endnote %}

After the second-factor verification date is reset, complete the setup:

1. Close all browser tabs with the {{ yandex-cloud }} management console.
1. [Clear](https://browser.yandex.ru/help/en/personal-data-protection/deleting-data) your browser cache and cookies for `console.yandex.cloud` and `yandex.cloud`, or use your browser's [incognito mode](https://browser.yandex.ru/help/en/personal-data-protection/incognito-mode).
1. [Log in](first-login.md) to the [management console]({{ link-console-main }}) once again under the proper account.
1. Complete the second-factor setup within the given time.

## No access to an application or resource {#no-access}

On some [management console]({{ link-console-main }}) pages, you see this message: `Access denied. You do not have permission to view this section. Contact the organization's administrator`.

### Solution {#no-access-solution}

This error indicates that you did not get the necessary [roles](../../../iam/concepts/access-control/roles.md) to access the resource. To gain access, contact your [organization administrator](../../security/index.md#organization-manager-admin) or the resource owner. They will give you the relevant role. Go to the [management console]({{ link-console-main }}) page and check your access to the resource.

## Unable to sign in with a Yandex account {#passport-login-issue}

When attempting to sign in with a [Yandex account](../../../iam/concepts/users/accounts.md#passport), you get an error message or the sign-in fails.

### Solution {#passport-login-issue-solution}

1. Make sure you are using the right [Yandex account](../../../iam/concepts/users/accounts.md#passport): the one that got invited to the [organization](../../concepts/organization.md).
1. Check that you have accepted the invitation by opening the email and clicking **Accept invitation**.
1. If your organization has a [mandatory two-factor authentication policy](../enable-2fa-access.md) in place, make sure it is configured for your account:
   1. Go to the [Yandex passport](https://passport.yandex.ru/profile) page.
   1. On the left side of the page, select **Security**. If the **Login method** section has the standard login method (username and password only) selected, two-factor authentication is off. Follow [this guide](first-login.md#passport-user) to configure it.
1. [Clear](https://browser.yandex.ru/help/en/personal-data-protection/deleting-data) your browser cache and cookies for `console.yandex.cloud` and `yandex.cloud`, or use your browser's [incognito mode](https://browser.yandex.ru/help/en/personal-data-protection/incognito-mode).
1. [Log in](first-login.md) to the [management console]({{ link-console-main }}) once again under the proper account.

If the error persists, contact your [organization administrator](../../security/index.md#organization-manager-admin).

## Unable to sign in as a local user {#local-user-login-issue}

When attempting to sign in as a local user, you get this error: `Incorrect username or password`.

### Solution {#local-user-login-issue-solution}

1. Make sure you are entering the username and password correctly. Pay attention to character case.
1. Verify that you are using the correct [organization](../../concepts/organization.md) ID or [user pool](../../concepts/user-pools.md) domain.
1. Make sure your account is active. The administrator may have [deactivated](../user-pools/deactivate-user.md) your account. Contact the administrator to check your account status.
1. If you have forgotten your password, contact your [organization administrator](../../security/index.md#organization-manager-admin) to reset it.

## Unable to sign in as a federated user {#federated-user-login-issue}

When attempting to sign in via an identity federation, you get an error message or the sign-in fails.

### Solution {#federated-user-login-issue-solution}

1. Make sure you are using the correct [federation](../../concepts/add-federation.md) ID. Confirm it with your [organization administrator](../../security/index.md#organization-manager-admin).
1. Verify that you are entering the correct credentials on the identity provider's page.
1. If you see an error on the identity provider's page, contact your corporate authentication system administrator.
1. If successful authentication with the identity provider does not redirect you to the {{ yandex-cloud }} console, contact your organization administrator. The [federation](../../concepts/add-federation.md) may have been configured incorrectly.
1. For more information about the federation errors, refer to the following sections:
   * [{#T}](../../diagnostics.md)
   * [{#T}](../../saml-diagnostics.md)

## Unable to delete or modify your login authentication method {#mfa-management-issue}

You get an error when attempting to delete or change your login authentication method on your [My account]({{ link-my-account }}) portal.

### Solution {#mfa-management-issue-solution}

To delete an existing login authentication method, you must first add a new one:

1. Go to the [My account]({{ link-my-account }}) portal.
1. In the left-hand panel, select ![alt](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.security_7zQ3g }}**.
1. Under **{{ ui-key.yacloud_org.my-account.security.login-confirmation.header }}**, click **Add authentication method**.
1. Select a new authentication method (e.g., security key or biometrics).
1. Follow the on-screen instructions to configure a new method.
1. After you successfully add a new method, you can delete the old one:
   1. Under **{{ ui-key.yacloud_org.my-account.security.login-confirmation.header }}**, locate the method you want to delete.
   1. Click ![alt](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.myaccount.security.LoginConfirmationTable.delete-action }}**.

## Account deactivated {#account-blocked}

When attempting to sign in, you get a message saying that your account is [deactivated](../user-pools/deactivate-user.md).

### Solution {#account-blocked-solution}

Contact your [organization administrator](../../security/index.md#organization-manager-admin). They will check your account status and [activate](../user-pools/activate-user.md) it.

## Additional help {#additional-help}

If you did not find a solution to your issue in this section:

1. Contact your organization administrator.
1. Check out the relevant troubleshooting guides:
   * [{#T}](../../diagnostics.md)
   * [{#T}](../../saml-diagnostics.md)
   * [{#T}](../../userpool-diagnostics.md)
   * [{#T}](../../yandex-id-diagnostics.md)
1. Contact [{{ yandex-cloud }} support]({{ link-console-support }}).

#### See also {#see-also}

* [{#T}](first-login.md)
* [{#T}](../manage-account.md)
* [{#T}](../../concepts/mfa.md)
