# Logging in to {{ tracker-name }}

If {{ tracker-full-name }} is connected for your organization, to work with your issues, log into your account.

{% note info %}

If you haven't connected {{ tracker-name }} yet, use the instructions in the [Connecting to {{ tracker-name }}](../enable-tracker.md) section.

{% endnote %}

Depending on your organization settings, you can use accounts of different types when working in {{ tracker-name }}. Ask the administrator of your organization about which account should be used for logging in:

* Yandex account, for example `{{ example-account }}`.

* Account on the domain connected to [{{ ya-360 }}]({{ link-ya-360 }}) (for example, `login@example.com`).

* Account in the corporate account management system, e.g., Active Directory or Google Workspace, if [single sign-on](../../organization/concepts/add-federation.md) is enabled.

To create and edit issues, you will need [full access](../access.md) to {{ tracker-name }}. If you have read-only access to {{ tracker-name }}, contact your organization's administrator.

## Logging in to {{ tracker-name }} {#auth}

To log in to {{ tracker-full-name }}:

1. Go to the [{{ tracker-name }}]({{ link-tracker }}). Click **{{ ui-key.startrek.ui_Common_pages_promo_Page.login-button-label }}**.

1. Select an account you use to work in {{ tracker-name }}:

   * To log in using your Yandex or corporate email address, click **Log in to Yandex ID** and enter your username, such as `{{ example-account }}` or `login@example.com`. If you have not created an [organization in {{ yandex-cloud }}](../../organization/), it will be created at your first login to {{ tracker-name }}.

   * If your organization uses the Single Sign-On authentication scheme with an [identity federation](../add-users.md#federation), click **Log in via SSO**, specify the federation ID, and log in to your corporate account.

      {% note info %}

      Get your federation ID from your administrator.

      {% endnote %}

1. If you're simultaneously involved in multiple organizations, you'll see the one you used last.

   After you log in, you can [change the organization](#change-org) or [switch to a different account](#change-user).

## Switching organizations {#change-org}

If you're simultaneously involved in multiple organizations, you'll see the one you used last. To switch to a different organization:

1. In the bottom-left panel, click the profile photo.

1. Select an organization from the available list.

   {% note info %}

   If you're logged in through identity federation, log out of your current account to switch accounts. For this, in the bottom-left panel, click the profile photo and the ![](../../_assets/tracker/svg/logout.svg) button.

   {% endnote %}

## Switching user accounts {#change-user}

To switch the user account that was used to log in to {{ tracker-name }}:

1. In the bottom-left panel, click the profile photo.

1. Click ![](../../_assets/tracker/svg/logout.svg) **{{ ui-key.yacloud.common.button_logout }}** next to your username.

1. Select a different user from the list or click **Log in to a different account**.

   {% note info %}

   If you're logged in through identity federation, log out of your current account to switch accounts. For this, in the bottom-left panel, click the profile photo and the ![](../../_assets/tracker/svg/logout.svg) button.

   {% endnote %}
