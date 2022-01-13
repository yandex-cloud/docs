# Adding users

To collaborate on issues with your colleagues, add them to {{ tracker-name }}. You can invite users who have Yandex accounts to {{ tracker-name }}, create new accounts on your company's domain, or set up an identity federation.

With an identity federation, your employees can log in to {{ tracker-name }} using their corporate accounts in Active Directory, Google Workspace, or other user account management systems.

{% if audience == "draft" %}{% note warning %}
You can add up to 1000 employee accounts to one company. If you need to add more, please contact [support]({{ link-console-support }}).

{% endnote %}{% endif %}

## Inviting users {#invite_user}

You can invite others to join your organization by using their existing Yandex accounts, for example `{{ example-account }}`:

1. Go to the [{{ tracker-name }}]({{ link-tracker }}) and [log in to your organization's admin account](user/login.md).

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Manage users**.

1. Click **Invite users**.

1. Add a comma-separated list of your employees' Yandex email addresses (such as `{{ example-account }}`) and click **Add**. {% if audience == "draft" %}Each user will receive an email with an offer to join your company.{% endif %}

To log in to {{ tracker-name }}, the invited employees will need to click the [{{ link-tracker }}]({{ link-tracker }}) link and [log in to their Yandex account](user/login.md).

## Setting up an identity federation {#federation}

An identity federation is a technology that lets you implement a Single Sign-On (SSO) authentication scheme so that your employees can log in to {{tracker-full-name}} using their corporate accounts in Active Directory, Google Workspace, or other SAML-compatible user account management systems.

To create an identity federation:

1. Go to the [{{ tracker-name }}]({{ link-tracker }}) and [log in to your organization's admin account](user/login.md).

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Manage users**.

1. Click **Enable federation**. The {{ org-full-name }} page opens.

1. Specify the federation settings and click **Create federation**.

Users with corporate accounts can [log in to {{ tracker-name }}](user/login.md) by clicking **Log in via SSO**.

To learn more about creating an identity federation, see the [{{ org-full-name }}]({{ link-org-add-federation }}) documentation.

## Creating user accounts {#create_users}

1. Go to the [{{ tracker-name }}]({{ link-tracker }}) and [log in to your organization's admin account](user/login.md).

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Manage users**.

1. To the right of the **Invite users** button, click![](../_assets/tracker/add_user.png) and select **Create account on mail domain**.

   {% note info %}

   If your company doesn't have an email domain connected, click **Connect domain** and add your domain in [Yandex 360 for Business](https://admin.yandex.ru). For more information, see [Help of Yandex.Mail 360 for business]({{ support-business-domain }}).

   {% endnote %}

1. In Yandex 360 for Business, [create accounts for users]({{ support-business-users }}).

To [log in to {{ tracker-name }}](user/login.md), an employee with an account on the domain will need to enter their full email address (such as `login@example.com`) and password.