# Activating {{ tracker-name }}

{% note warning %}

Only users with Yandex accounts are allowed to activate {{ tracker-name }}.

{% endnote %}

To use {{ tracker-name }}:

1. [Activate {{ tracker-name }} for your organization](enable-tracker.md#section_v3j_bq5_1cb).

1. [Add your company's employees to your organization](#section_v3s_wp4_1cb).

1. Your employees will need [full access to {{ tracker-name }}](#access) in order to manage issues.

The cost of using {{ tracker-name }} [is based on the number of users with full access to the platform](pricing.md#sec_price).

## Activate {{ tracker-name }} {#section_v3j_bq5_1cb}

1. Log in to your [Yandex account]({{ link-passport }}). If you don't have an account yet, [create one]({{ support-passport-create }}).

1. Go to the [{{ tracker-name }} page ]({{ link-tracker-promo }}) and click **Free trial**. 

1. If your user account is added to several {{ yandex-cloud }} organizations, select the organization for which you want to activate {{ tracker-name }}.

   If you don't have a {{ yandex-cloud }} organization or want to create a new one, specify a name and a description for your organization and click **Create**.

{{ tracker-full-name }} will be activated for the organization you have selected or created.

To learn more about managing organizations, read the [{{ org-full-name }} documentation](../organization/index.yaml).

## Add users {#section_v3s_wp4_1cb}

To let your employees use {{ tracker-name }}, invite users with Yandex accounts to to join your organization, create user accounts on your domain, or configure an identity federation.

Identity federation allows your employees to log in to {{ tracker-name }} with their corporate accounts in Active Directory, Google Workspace or other credential management service.

#### Invite users {#invite_user}

You can invite others to join your organization using their existing Yandex accounts like `{{ example-account }}`.

1. Go to [{{ tracker-name }}]({{ link-tracker }}) and [log in](user/login.md) to the organization's administrator account.

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Manage user access**.

1. Click **Invite users**.

1. List the email addresses of your employees and click **Invite**.

Users you invite can go to [{{ tracker-name }}]({{ link-tracker }}) and [log in](user/login.md) using their Yandex account.

#### Configure an identity federation {#federation}

Identity federation is a technology with which you can implement a single sign-on system (SSO) and log in to {{ tracker-full-name }} with corporate accounts in Active Directory, Google Workspace or other credential management service that supports the SAML protocol.

To configure an identity federation:

1. Go to [{{ tracker-name }}]({{ link-tracker }}) and [log in](user/login.md) to the organization's administrator account.

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Manage user access**.

1. Click **Add federation**. The {{ org-full-name }} service will open in your browser.

1. Click **Create federation** and configure federation settings.

To [log in](user/login.md) to {{ tracker-name }} users with corporate accounts should use the **Log in via SSO button**.

To learn more about creating federations, read the [{{ org-full-name }} documentation](../organization/add-federation.md).


#### Create user accounts {#create_users}

If you link an email domain to your organization in [Yandex.Mail 360 for business](https://admin.yandex.ru), you will be able to create user accounts on your domain  (for example, `login@example.com`) and add the users with domain accounts to {{ tracker-name }}.

1. Go to [{{ tracker-name }}]({{ link-tracker }}) and [log in](user/login.md) to the organization's administrator account.

1. On the top panel in {{ tracker-name }}, click  ![](../_assets/tracker/tracker-settings.png) → **Manage user access**.

1. To the right of the **Invite users** button, click  ![](../_assets/tracker/add_user.png) and select **Create a user account**.

1. If you don't have a domain linked to your organization, click **Add a domain** and link a domain in Yandex.Mail 360 for business. For details see the [Help of Yandex.Mail 360 for business]({{ support-business-domain }}).

1. In  Yandex.Mail 360 for business create user accounts. For details see the [Help of Yandex.Mail 360 for business]({{ support-business-users }}).

To [log in](user/login.md) to {{ tracker-name }}, the employee with a domain account will need to enter their full email address (such as `login@example.com`) and password.


## Set up access to {{ tracker-name }} {#access}

All employees automatically get free {{ tracker-name }} access, but only in [<q>Read only</q>](#readonly) mode. Employees will need full access to {{ tracker-name }} to manage issues with no restrictions. You can set up full Tracker access in advance. You will only be charged after the trial period.

The cost of using {{ tracker-name }} is based on the number of users with full access to the platform. Teams of no more than 5 employees can use {{ tracker-name }} for free. For more information, see [{#T}](pricing.md).

{% note info %}

You can grant and revoke full access to {{ tracker-name }} at any time. The total cost is automatically recalculated as the number of users with full access changes. To learn more about how subscription costs are calculated, see [{#T}](pricing.md#sec_calculate).

{% endnote %}

#### Configuring access

1. Go to [{{ tracker-name }}]({{ link-tracker }}) and [log in](user/login.md) to the organization's administrator account.

1. On the top panel in {{ tracker-name }}, click  ![](../_assets/tracker/tracker-settings.png) → **Manage user access**.

1. In the **All users** section, find the employees who will manage issues in {{ tracker-name }}. Next to their names, select **Full access** in the **Access** column.

Once you set up access, you can see the number of employees with full access to {{ tracker-name }} and the total monthly cost of using the platform in the lower-left corner of the page. For details see [{#T}](pricing.md).

#### <q>Read only</q> {#readonly}

Access to the following features is restricted in <q>Read only</q> mode:

- Creating issues using the {{ tracker-name }} interface.

- Changing issue fields, statuses, and resolutions.

- leaving comments for issues

- Subscribing to issue changelogs.

However, you can still access all of the {{ tracker-name }} features related to viewing issues, such as:

- Viewing issues, [dashboards](user/dashboard.md), and [issue boards](manager/agile.md#sec_boards).

- Searching for issues using the [filter builder](user/create-filter.md) and [query language](user/query-filter.md).

- Viewing [queue pages](manager/quick-filters.md), [statistics](manager/statistics.md), and other information.

## Pricing {{ tracker-name }} {#sec_price}

To learn more about {{ tracker-name }} service plans and see some examples of how to calculate monthly costs of using the platform, see [{#T}](pricing.md).

[Contact support](troubleshooting.md)

