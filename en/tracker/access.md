# Configuring access to {{ tracker-name }}

The user's capacity to create or edit issues in {{ tracker-full-name }} depends on their access level. All employees in your company automatically get access to [<q>Read</q>](#readonly) mode. Employees will need full access to {{ tracker-name }} to manage issues without restrictions.

You can grant full access to {{ tracker-name }} to [each user individually](#set) or [automatically grant full access](#access-new-users) to all new employees who joined an organization.

{% note info %}

Teams of up to five employees have full access can use {{ tracker-name }} for free.

{% endnote %}

You need to pay for {{ tracker-name }} if you have more than five users with full access in your company. Before you can grant full access to {{ tracker-name }} for six or more users, you need to [add a billing account](#billing) to pay invoices for the service use.

You can grant and revoke full access to {{ tracker-name }} at any time. The cost of using the service depends on the number of users with full access and is re-calculated automatically. For more information about price and calculating the cost, see [Pricing policy](pricing.md).

{% note info %}

The user's access level applies throughout the {{ tracker-name }} organization structure. On top of this, however, you can restrict user access to specific issue queues, components, dashboards, and filters. For more information, see [{#T}](role-model.md).

{% endnote %}


## Configuring access {#set}

1. Open the [{{ tracker-name }} page]({{ link-tracker }}) and [log in to the admin account](user/login.md).

1. In the left-hand panel, click **{{ ui-key.startrek.blocks-desktop_b-queues-info.admin }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-users }}**.

1. For all employees who need to manage issues, select **{{ ui-key.startrek.ui_components_page-admin_OrgUsersPane.access-level_full-access }}** in the **{{ ui-key.startrek.ui_components_page-admin_OrgUsersPane.title_access }}** column.

{% note info %}

To grant full access to six or more users, you need to [add a billing account](#billing). For more information about cost calculation, see [Pricing policy](pricing.md).

{% endnote %}


## Full access for new users {#access-new-users}

To make sure all new users added to {{ tracker-name }} automatically get full access, select **Full access for new users**. To enable this option, you need a [billing account](#billing) linked to {{ tracker-name }}.

1. Open the [{{ tracker-name }} page]({{ link-tracker }}) and [log in to the admin account](user/login.md).

1. In the left-hand panel, click **{{ ui-key.startrek.blocks-desktop_b-queues-info.admin }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-users }}**.

1. In the top-right corner of the page, select **{{ ui-key.startrek.components_Licenses.default-full-access-label }}**:

   - If you already linked your billing account to {{ tracker-name }}, click **{{ ui-key.startrek.components_LicensesDefaultFullAccessModal.button-submit--toEnable }}** in the window that opens.

   - If you have no billing account linked, click **Go to billing** to create a new billing account or link an existing billing account to {{ yandex-cloud }}. For more information, see [Setting up a billing account](billing-account.md)

{% note info %}

When enabling or disabling **{{ ui-key.startrek.components_Licenses.default-full-access-label }}**, the access rights of existing users do not change.

{% endnote %}

## Access for user groups {#group-access}

If your company uses {{ yandex-360 }} for Business, you can create employee groups and set up access for them. For more information about creating a group, see the [Yandex 360 for Business documentation](https://yandex.ru/support/business/projects.html).

To set up access for a group of users, go to **{{ ui-key.startrek.blocks-desktop_b-queues-info.admin }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-groups }}** and select the appropriate access level for each group from the drop-down list.

The access level of a group doesn't override the access level of an individual user in the group. But if at least one of the groups that include the user has full access, the user will have full access.

## <q>Read</q> mode {#readonly}

Access to the following features is restricted in <q>Read</q> mode:

- Creating issues using the {{ tracker-name }} interface.

- Change parameters, statuses, and resolutions in issues.

- Comment on issues.

- Subscribe to changes in issues.

However, you can still do everything related to viewing {{ tracker-name }} issues, such as:

- View issues, [dashboards](user/dashboard.md), and [issue boards](manager/agile.md#sec_boards).

- Search for issues using the [filter builder](user/create-filter.md) and [query language](user/query-filter.md).

- View [queue pages](manager/quick-filters.md), [statistics](manager/statistics.md), and more.

