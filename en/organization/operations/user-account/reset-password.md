---
title: How to reset your password for the {{ yandex-cloud }} management console
description: Follow this guide to learn how to reset your password for the {{ yandex-cloud }} management console.
---

# Resetting your password for the {{ yandex-cloud }} management console

In {{ org-full-name }}, an organization administrator can grant users permissions to reset their own passwords.

{% note warning %}

In {{ yandex-cloud }}, self-service password reset is only available to [local](../../../iam/concepts/users/accounts.md#local) users that meet the following conditions:
* The users must belong to a target group of an [MFA policy](../../concepts/mfa.md#mfa-policies) that allows self-service password resets.
* The required [MFA factors](../../concepts/mfa.md#mfa-factors) must be configured in the user accounts.

{% endnote %}

To reset your password for the {{ yandex-cloud }} [management console](../../../console/quickstart/console.md):

1. Go to the [management console]({{ link-console-main }}) page.
1. Enter your login in the input field and click ![arrow-right](../../../_assets/console-icons/arrow-right.svg).
1. In the password input window that opens, click **Forgot password**.
1. In the password reset window, click **Continue**.
1. Follow the on-screen instructions to verify your identity using the suggested authentication methods:

    {% list tabs %}

    - Authenticator app {#app-auth}

      1. Select login verification via one-time password.
      1. Open the **Authenticator app** you added earlier as an MFA factor, e.g.:

          * [Yandex ID](https://yandex.ru/id/about)
          * [Google Authenticator](https://support.google.com/accounts/answer/1066447)
          * [Microsoft Authenticator](https://www.microsoft.com/ru-ru/security/mobile-authenticator-app)
          * [Multifactor](https://multifactor.ru/docs/saml/yandex-cloud-2fa/)
      1. In the list of associated services, find your {{ yandex-cloud }} account and enter the one-time code in the **Enter code from authenticator app** field in your browser.
      1. Click **Next**.

    - Security key {#key-auth}

      1. Select login verification by security key.
      1. Plug in your physical security key, e.g., [Rutoken](https://www.rutoken.ru/) or [JaCarta](https://www.aladdin-rd.ru/catalog/jacarta), to your computer.
      1. Follow the prompts in your browser to authenticate with the key.

    - Biometrics {#bio-auth}

      1. Select login verification using a facial or fingerprint scan.
      1. Follow the prompts in your browser to authenticate with biometrics.

    {% endlist %}

1. If your account has the required MFA factors configured, and you successfully complete verification, a window for setting a new password will open. In this window:

    1. Enter the new password twice.
    1. Click **Save password**.

Your account password is updated. You can now use it to log in to the {{ yandex-cloud }} [management console](../../../console/quickstart/console.md).

If your organization does not have an MFA policy allowing users to reset their passwords, or your account lacks the MFA factors required to verify your identity during a password reset, you will be unable to reset your password on your own. In which case you should contact your organization administrator to reset your password.

#### Useful links {#see-also}

* [{#T}](../../concepts/sspr.md)
* [{#T}](../../concepts/my-account.md)
* [{#T}](../../concepts/mfa.md)
