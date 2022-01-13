# Configuring access to {{ tracker-name }}

All employees in your company automatically get free access to {{ tracker-name }} in [<q>Read only</q>](#readonly) mode. Employees will need full access to {{ tracker-name }} to manage issues without restrictions.

You can grant full access to [each user individually](#set) or automatically grant [full access to all new employees](#access-new-users) who joined {{ tracker-name }}.

The cost of using {{ tracker-name }} depends on the number of users with full access. Teams of up to five employees can use {{ tracker-name }} for free. To grant full access to six or more users, you need to [add a billing account](#billing).

You can grant and revoke full access to {{ tracker-name }} at any time. The total cost is automatically recalculated as the number of users with full access changes. To learn more, see [Tracker cost calculation](pricing.md#sec_calculate).

## Configuring access {#set}

1. Go to the [{{ tracker-name }}]({{ link-tracker }}) and [log in to your organization's admin account](user/login.md).

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Manage users**.

1. For all employees who need {{ tracker-name }} to manage issues, in the **Access** column, select **Full access**.

Once you set up access to {{ tracker-name }}, the total number of employees with full access to it and the total monthly cost of using the platform will be displayed in the lower-left corner of the page. For more information about cost calculation, see [Pricing policy](pricing.md).

## Full access for new users {#access-new-users}

To make sure all new users added to {{ tracker-name }} automatically get full access, select **Full access for all new users**. To enable this option, you need a [billing account](#billing) linked to {{ tracker-name }}.

1. Go to the [{{ tracker-name }}]({{ link-tracker }}) and [log in to your organization's admin account](user/login.md).

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Manage users**.

1. In the upper-right corner of the page, select **Full access for all new users**:

   - If you already linked your billing account to {{ tracker-name }}, click **Enable**.

   - If not, choose an existing {{ yandex-cloud }} billing account or [create a new one](#billing). Then click **Enable now**.

{% note info %}

When enabling or disabling **Full access for all new users**, the access rights of existing users do not change.

{% endnote %}

## Adding a billing account {#billing}

You need a {{ yandex-cloud }} billing account to pay your invoices for using {{ tracker-name }} if full access to the platform is granted to six or more users. To learn more about service plans and take a look at some examples of how to calculate monthly costs, see [Pricing policy](pricing.md).

A window that prompts you to link your billing account to {{ tracker-name }} appears when granting full access to a new user (if five of your employees already have full access) or when enabling [automatic full access](#access-new-users) for all new users.

If you already have a billing account in {{ yandex-cloud }}, you can link it to {{ tracker-name }}. If you don't have an account, create one:

1. There are two ways to pay for Tracker: as an individual or legal entity.

1. Enter your details or the details of your company.

1. If you are planning to pay for the service as a legal entity, choose a payment method. Then specify your payment details or link your bank card.

   If you're planning to pay for the service as an individual, link your bank card.

1. Click **Activate**.

To check your billing account balance or view your payment history, on the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Billing**.

## <q>Read only</q> mode {#readonly}

Access to the following features is restricted in <q>Read only</q> mode:

- Creating issues using the {{ tracker-name }} interface.

- Changing issue fields, statuses, and resolutions.

- Leaving comments for issues.

- Subscribing to issue changelogs.

However, you can still do everything related to viewing {{ tracker-name }} issues, such as:

- View issues, [dashboards](user/dashboard.md), and [issue boards](manager/agile.md#sec_boards).

- Search for issues using the [filter builder](user/create-filter.md) and [query language](user/query-filter.md).

- View [queue pages](manager/quick-filters.md), [statistics](manager/statistics.md), and more.

