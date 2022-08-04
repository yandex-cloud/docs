# Adding users

To collaborate on issues with your colleagues, add them to {{ tracker-name }}. There are multiple ways to do this:

- [Inviting users](#invite_user) who already have Yandex accounts to {{ tracker-name }}.
- [Adding users](../organization/add-account.md) to {{ org-full-name }}.
- [Creating new accounts](#create_users) on the organization's domain.
- [Setting up an identity federation](#federation). With identity federation, your employees can log in to {{ tracker-name }} using their corporate accounts in Active Directory, Google Workspace, or other user account management systems.

{% if audience == "draft" %}{% note warning %}
You can add up to 1000 employee accounts to one company. If you need to add more, please contact [support]({{ link-console-support }}).

{% endnote %}{% endif %}

{% note warning %}

If you enable [automatic full access to new users](access.md#access-new-users) in {{ tracker-name }} settings, the [service cost](https://cloud.yandex.ru/docs/tracker/pricing#sec_price) may increase when you add users to your company.

{% endnote %}

## Inviting users {#invite_user}

You can invite users who have an account on Yandex (such as `{{ example-account }}`) or the organization's domain connected to [{{ ya-360 }}]({{ link-ya-360 }}).

1. Open [{{ tracker-name }} main page]({{ link-tracker }}) and [log in as an administrator](user/login.md).

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Manage users**.

1. Click **Invite users**.

1. Add a comma-separated list of your employees' email addresses (such as `{{ example-account }}`) and click **Add**. Each user will receive an email with an offer to join your company.

To log in to {{ tracker-name }}, the invited employees will need to click the [{{ link-tracker }}]({{ link-tracker }}) link and [log in to their Yandex account](user/login.md).

## Setting up an identity federation {#federation}

An identity federation is a technology that lets you implement a Single Sign-On (SSO) authentication scheme so that your employees can log in to {{tracker-full-name}} using their corporate accounts in Active Directory, Google Workspace, or other SAML-compatible user account management systems.

To create an identity federation:

1. Open [{{ tracker-name }} main page]({{ link-tracker }}) and [log in as an administrator](user/login.md).

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Manage users**.

1. Click **Enable federation**. The {{ org-full-name }} page opens.

1. Specify the federation settings and click **Create federation**.

Users with corporate accounts can [log in to {{ tracker-name }}](user/login.md) by clicking **Log in via SSO**.

To learn more about creating an identity federation, see the [{{ org-full-name }}]({{ link-org-add-federation }}) documentation.

## Creating user accounts {#create_users}

1. Open [{{ tracker-name }} main page]({{ link-tracker }}) and [log in as an administrator](user/login.md).

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Manage users**.

1. To the right of the **Invite users** button, click(../_assets/tracker/add_user.png) and select **Create account on mail domain**.

   {% note info %}

   If your company doesn't have a corporate email domain, click **Connect domain** and add your domain in [{{ ya-360 }}]({{ link-ya-360 }}). For more information, see [Documentation]({{ support-business-domain }}).

   {% endnote %}

1. In {{ ya-360 }}, [create accounts for users]({{ support-business-users }}).

To [log in to {{ tracker-name }}](user/login.md), an employee with an account on the domain will need to enter their full email address (such as `login@example.com`) and password.

