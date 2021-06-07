# Activating {{ tracker-name }}

{% note warning %}

Only users who have a Yandex account can activate {{ tracker-name }}.

{% endnote %}

To get started with {{ tracker-full-name }}:

1. [Activate {{ tracker-name }}](enable-tracker.md#enable).

1. [Add your company's employees to {{ tracker-name }}](#add-users).

1. Your employees will need [full access to {{ tracker-name }}](#access) in order to manage issues.

The cost of using {{ tracker-name }} [is based on the number of users with full access to the platform](pricing.md#sec_price).

## Activate {{ tracker-name }} {#enable}

1. Log in to your [Yandex account]({{ link-passport }}). If you don't have an account yet, [create]({{ support-passport-create }}) it.

1. Go to the [{{ tracker-name }}]({{ link-tracker-promo }}) and click **Free trial**. 

1. If your account is added to one or more organizations in {{ yandex-cloud }}, select the organization you want to activate {{ tracker-name }} in and click **Log in**.

   If you have no organization in {{ yandex-cloud }} or you want to create a new one, specify a name for your organization, add its description, and click **Create**.

{{ tracker-full-name }} is automatically activated for the organization you selected or created.

To learn more about managing organizations, see the documentation for [{{ org-full-name }}]({{ link-org-main }}).

## Add users {#add-users}

Invite users who have Yandex accounts to {{ tracker-name }}, create new accounts on your organization's domain, or set up identity federation.

With identity federation, your employees can log in to {{ tracker-name }} using their corporate accounts in Active Directory, Google Workspace, or other user account management systems.

<!--{% note warning %}
You can add up to 1000 accounts to one organization. If you need to add more, [please contact support]({{ link-console-support }}).
{% endnote %}-->

#### Invite users {#invite_user}

You can invite others to join your organization using their existing Yandex accounts like `{{ example-account }}`:

1. Open the [{{ tracker-name }}]({{ link-tracker }}) and [log in to your organization's admin account](user/login.md).

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Manage access**.

1. Click **Invite users**.

1. Add a comma-separated list of your employees' Yandex email addresses (such as `{{ example-account }}`) and click **Invite**.

<!--1. To create an invite link, turn on the **Enable link access** option. Such links can be easily sent via a messenger or posted on a website.-->

To log in to {{ tracker-name }}, the invited employees will need to click the [{{ link-tracker }}]({{ link-tracker }}) link and [log in to their Yandex account](user/login.md).

#### Set up identity federation {#federation}

Identity federation is a technology that lets you implement a Single Sign-On (SSO) authentication scheme so that your employees could log in to {{tracker-full-name}} using their corporate accounts in Active Directory, Google Workspace, or other SAML-compatible user account management systems.

To create an identity federation:

1. Open the [{{ tracker-name }}]({{ link-tracker }}) and [log in to your organization's admin account](user/login.md).

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Manage access**.

1. Click **Enable federation**. The {{ org-full-name }} page opens.

1. Click **Create federation** and specify its settings.

Users with corporate accounts can [log in to {{ tracker-name }}](user/login.md) by clicking **Log in via SSO**.

To learn more about creating an identity federation, see the documentation for [{{ org-full-name }}]({{ link-org-add-federation }}).

#### Create user accounts {#create_users}

To create a new user account:

1. Open the [{{ tracker-name }}]({{ link-tracker }}) and [log in to your organization's admin account](user/login.md).

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Manage access**.

1. To the right of the **Invite users** button, ![]click (../_assets/tracker/add_user.png) and select **Create a user account**.

{% note info %}

   If your company doesn't have an email domain connected, click **Connect domain** and add your domain in [Yandex.Mail 360 for Business](https://admin.yandex.ru). For more information, see the [Help of Yandex.Mail 360 for business]({{ support-business-domain }}). Then go back to the {{ tracker-name }} administrator account and click **Create user account**.

  {% endnote %}

1. Fill out the **New user account** form and click **Add**.

To [log in to {{ tracker-name }}](user/login.md), an employee with an account on the domain will need to enter their full email address (such as, `login@example.com`) and password.

## Set up access to {{ tracker-name }} {#access}

All employees in your company automatically get free access to {{ tracker-name }} in [<q>Read only</q>](#readonly) mode. Employees will need full access to {{ tracker-name }} to manage issues with no restrictions.

The cost of using {{ tracker-name }} is based on the number of users with full access to the platform. Teams of no more than 5 employees can use {{ tracker-name }} for free.

You can grant and revoke full access to {{ tracker-name }} at any time. The total cost is automatically recalculated as the number of users with full access changes. To learn more, see [Tracker cost calculation](pricing.md#sec_calculate).

#### Configuring access

<!--1. If you are setting up access to {{ tracker-name }} for the first time, [enter your information to create a billing account](pricing.md#payment_data).

    {% note info %}

    Payment information is required to pay for services under [paid {{ tracker-name }} service plans](pricing.md#sec_price).
    {% endnote %}-->

1. Open the [{{ tracker-name }}]({{ link-tracker }}) and [log in to your organization's admin account](user/login.md).

1. On the top panel in {{ tracker-name }}, click  ![](../_assets/tracker/tracker-burger.png) → **Manage access**.

1. In the **All users** section, find the employees who will manage issues in {{ tracker-name }}. Next to their names, select **Full access** in the **Access** column.

{% if audience == "internal" %}

    If a user has restricted access to access rights selection, then their access level is configured on the team or company level.

1. To configure {{ tracker-name }} access rights for the entire team, select **Teams** on the left-hand panel and then select **Full access** or **Read only** in the row with the team name.

    To configure {{ tracker-name }} access rights for your company, select **Departments** on the left-hand panel.

{% endif %}

Once you set up access, you can see the number of employees with full access to {{ tracker-name }} and the total monthly cost of using the platform in the lower-left corner of the page. For more information, see [Pricing](pricing.md).

#### <q>Read only</q> {#readonly}

Access to the following features is restricted in <q>Read only</q> mode:

- Creating issues using the {{ tracker-name }} interface.

- Changing issue fields, statuses, and resolutions.

- Leaving comments for issues.

- Subscribing to issue changelogs.

However, you can still access all of the {{ tracker-name }} features related to viewing issues, such as:

- Viewing issues, [dashboards](user/dashboard.md), and [issue boards](manager/agile.md#sec_boards).

- Searching for issues using the [filter builder](user/create-filter.md) and [query language](user/query-filter.md).

- Viewing [queue pages](manager/quick-filters.md), [statistics](manager/statistics.md), and other information.

## Pricing {{ tracker-name }} {#sec_price}

<!--All employees can use {{ tracker-name }} for 30 days for free without any restrictions. As the trial period ends, employees can continue using {{ tracker-name }} for free in [<q>Read only</q>](#readonly) mode. Grant [full access](#access) to {{ tracker-name }} so that your employees can use all of its features.-->

To learn more about service plans and take a look at some examples of how to calculate monthly costs of using {{ tracker-name }}, see [Pricing](pricing.md).

