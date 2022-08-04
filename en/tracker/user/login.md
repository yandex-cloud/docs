# Logging in to {{ tracker-name }}

If {{ tracker-full-name }} is connected to your company, log in to your account to manage your issues.

{% note info %}

If you haven't activated {{ tracker-name }} yet, follow the instructions in the [Activating Yandex Tracker {{ tracker-name }}](../enable-tracker.md) section.

{% endnote %}

Depending on your company settings, you can use several different account types for managing issues in {{ tracker-name }}. Ask your organization's admin about the account type you should use to log in:

* A Yandex account, such as `{{ example-account }}`.

* An account hosted on a domain connected to [{{ ya-360 }}]({{ link-ya-360 }}) (for example, `login@example.com`).

* A CMS account (such as Active Directory or Google Workspace). Only applicable if you have set up the [Single Sign-On (SSO) authentication scheme](../../organization/add-federation.md).

To create and edit issues, you will need [full access rights](../access.md) within {{ tracker-name }}. If {{ tracker-name }} is only accessible in read-only mode, contact your organization's admin.

## Logging in to {{ tracker-name }} {#auth}

{% list tabs %}

- Web interface

    To log in to {{ tracker-full-name }}:

    1. Go to the [{{ tracker-name }}]({{ link-tracker }}).

    1. Log in to the account you use to work in {{ tracker-name }}:

        * To log in using your Yandex email address or the email address on your organization's domain, click **Log in to Yandex account** and enter your username like `{{ example-account }}` or `login@example.com`. If you haven't registered an organization yet, one will be created automatically the first time you log in to {{ tracker-name }}.

        * If your company uses a Single Sign-On authentication scheme with an [identity federation](../add-users.md#federation), click **Log in via SSO**, specify the federation ID, and log in to your corporate account.

            {% note info %}

            To find out the federation ID, contact your organization's admin.

            {% endnote %}

    1. If you're simultaneously involved in multiple organizations, you'll see the one you used last.

    After you log in, you can [change the organization](#change-org) or [switch to a different account](#change-user).

- Mobile app

    To log in to {{ tracker-full-name }}:

    1. Open [the {{ tracker-name }} mobile app](../mobile.md).

    1. When you launch the app for the first time, log in to the account you use to work with {{ tracker-name }}:

    * To log in using your Yandex email address or the email address on your organization's domain, tap **Log in** and enter your username, for example `{{ example-account }}` or `login@example.com`. If you haven't registered an organization yet, one will be created automatically the [first time you log in](../enable-tracker.md) to the app.

    * If your company uses a Single Sign-On authentication scheme with [identity federation](../add-users.md#federation), tap **Log in via SSO**, specify the federation ID, and log in to your corporate account.

    {% note info %}

    To find out the federation ID, contact your organization's admin.

    {% endnote %}

    1. If you're simultaneously involved in multiple organizations, you'll see the one you used last.

    After you log in, you can [change the organization](#change-org) or [switch to a different account](#change-user).

{% endlist %}

## Switching organizations {#change-org}

{% list tabs %}

- Web interface

    If you're simultaneously involved in multiple organizations, you'll see the one you used last. To switch to a different organization:

    1. In the upper-right corner, click on your profile picture.

    1. Click on the organization name. Select an organization from the list of available ones or click **+ Add organization** to [create a new one](../../organization/enable-org.md).

        {% note info %}

        If you're logged in through an identity federation, log out of your current account to switch organizations. To do this, in the upper-right corner, click on the profile picture and then click ![](../../_assets/tracker/logout-fed.png).

        {% endnote %}

- Mobile app

    If you're simultaneously involved in multiple organizations, you'll see the one you used last. To switch to a different organization:

    1. In the upper-right corner, tap on your profile picture.

    1. Tap on the name of the current organization.

    1. Select an organization from the list.

{% endlist %}

## Switching user accounts {#change-user}

{% list tabs %}

- Web interface

    To switch the user account that was used to log in to {{ tracker-name }}:

    1. In the upper-right corner, click on your profile picture.

    1. Select a different user from the list or click **Add account**.

    1. If you choose **Add account**, you need to [log in](#auth).

        {% note info %}

        If you're logged in through identity federation, log out of your current account to switch accounts. To do this, in the upper-right corner, click on the profile picture and then click ![](../../_assets/tracker/logout-fed.png).

        {% endnote %}

- Mobile app

    To switch the user account that was used to log in to {{ tracker-name }}:

    1. In the upper-right corner, tap on your profile picture.

    1. Tap on the username and choose how to change accounts:

    * To switch your Yandex account or the account on your organization's domain, tap **Account**. Select a user from the list or tap **Add account**. If you choose **Add account**, you need to [log in](#auth).

    * To switch a [federated user](../add-users.md#federation) account, tap **Log in via SSO**. Enter the federation ID and log in to your corporate account.

{% endlist %}

