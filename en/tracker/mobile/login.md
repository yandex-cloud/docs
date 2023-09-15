# Logging in to {{ tracker-name }}

If {{ tracker-full-name }} is connected for your organization, to work with your issues, log into your account.

{% note info %}

If you haven't connected {{ tracker-name }} yet, use the instructions in the [Connecting to {{ tracker-name }}](enable-tracker.md) section.

{% endnote %}

Depending on your organization settings, you can use accounts of different types when working in {{ tracker-name }}. Ask the administrator of your organization about which account should be used for logging in:

* Yandex account, for example `{{ example-account }}`.

* Account on the domain connected to [{{ ya-360 }}]({{ link-ya-360 }}) (for example, `login@example.com`).

* Account in the corporate account management system, e.g., Active Directory or Google Workspace, if [single sign-on](../../organization/add-federation.md) is enabled.

To create and edit issues, you will need [full access](../access.md) to {{ tracker-name }}. If you have read-only access to {{ tracker-name }}, contact your organization's administrator.

## Logging in to {{ tracker-name }} {#auth}

To log in to {{ tracker-full-name }}:

1. Open the [{{ tracker-name }} mobile app](../mobile.md).

1. When you launch the app for the first time, log in to the account you use to work with {{ tracker-name }}:

   * To log in using your Yandex email address or the email address on your company's domain, tap **{{ ui-key.startrek.ui_components_PageHiThere.wrong-user-btn }}** and enter your username, such as `{{ example-account }}` or `login@example.com`. If you do not have an organization, one will be created automatically the [first time you log in](enable-tracker.md) to the app.

   * If your organization uses the Single Sign-On authentication scheme with an [identity federation](../add-users.md#federation), click **Log in via SSO**, specify the federation ID, and log in to your corporate account.

      {% note info %}

      Get your federation ID from your administrator.

      {% endnote %}

1. If you're simultaneously involved in multiple organizations, you'll see the one you used last.

   After you log in, you can [change the organization](#change-org) or [switch to a different account](#change-user).

## Switching organizations {#change-org}

If you are simultaneously involved in multiple organizations, you will see the last one you used. To switch to a different organization:

1. In the top-right corner, tap on your profile picture.

1. Tap on the name of the current organization.

1. Select an organization from the list.

## Switching user accounts {#change-user}

To switch the user account that was used to log in to {{ tracker-name }}:

1. In the top-right corner, tap on your profile picture.

1. Tap on the username and choose how to change accounts:

   * To switch your Yandex account or the account on your company's domain, tap **Account**. Select a user from the list or tap **Add account**. If you choose **Add account**, you need to [log in](#auth).

   * To switch a [federated user](../add-users.md#federation) account, tap **Log in via SSO**. Enter the federation ID and log in to your corporate account.

