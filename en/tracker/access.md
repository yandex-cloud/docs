# Configuring access to {{ tracker-name }}

The user's capacity to create or edit issues in {{ tracker-full-name }} depends on their access level. All employees in your company automatically get the [read](#readonly) access. Employees will need full access to {{ tracker-name }} to manage issues without restrictions.

You can grant full access to {{ tracker-name }} to [each user individually](#set) or [automatically grant full access](#access-new-users) to all new employees who joined an organization.

{% note info %}

Teams of up to five employees have full access can use {{ tracker-name }} for free.

{% endnote %}

You need to pay for {{ tracker-name }} if you have more than five users with full access in your company. Before you can grant full access to {{ tracker-name }} for six or more users, you need to [add a billing account](billing-account.md#bind) to pay invoices for the service use.

You can grant and revoke full access to {{ tracker-name }} at any time. The cost of using the service depends on the number of users with full access and is re-calculated automatically. For more information about price and calculating the cost, see [Pricing policy](pricing.md).

{% note info %}

User's access level covers their operations on {{ tracker-name }} entities in the organization. However, you can additionally restrict user access to specific issue queues, components, dashboards, and filters. For more information, see [{#T}](role-model.md).

{% endnote %}


## Configuring access {#set}

1. Open the [{{ tracker-name }} page]({{ link-tracker }}) and [log in to the admin account](user/login.md).

1. In the left-hand panel, click **Administration** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-users }}**.

1. For all employees who need to manage issues, select **{{ ui-key.startrek.ui_components_page-admin_OrgUsersPane.access-level_full-access }}** in the **{{ ui-key.startrek.ui_components_page-admin_OrgUsersPane.title_access }}** column.

{% note info %}

To grant full access to six or more users, you need to [add a billing account](billing-account.md#bind). For more information about cost calculation, see [Pricing policy](pricing.md).

{% endnote %}


## Authorizing a user to invite new users {#invite-users}

For a user to invite new users to the organization, administrator rights are required:
* In {{ org-full-name }}, [assign]({{ link-org-acl }}) the `admin` and `organization-manager.organizations.owner` roles to the user.
* In {{ ya-360 }}, make the user an administrator.


## Full access for new users {#access-new-users}

To make sure all new users added to {{ tracker-name }} automatically get full access, select **Full access for new users**. To enable this option, you need a [billing account](billing-account.md) linked to {{ tracker-name }}.

1. Open the [{{ tracker-name }} page]({{ link-tracker }}) and [log in to the admin account](user/login.md).

1. In the left-hand panel, click **Admin settings** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-users }}**.

1. In the top-right corner of the page, select **Full access for all new users**:

   - If you already linked your billing account to {{ tracker-name }}, click **Enable**.

   - If you have no billing account linked, click **Go to billing** to create a new billing account or link an existing billing account to {{ yandex-cloud }}. For more information, see [Setting up a billing account](billing-account.md).

{% note info %}

When enabling or disabling **Full access for all new users**, the access rights of existing users do not change.

{% endnote %}

## Access for user groups {#group-access}

If your company uses {{ yandex-360 }} for Business, you can create employee groups and set up access for them. For more information about creating a group, see the [Yandex 360 for Business documentation](https://yandex.ru/support/business/projects.html). To configure full access for a group of users, [link a billing account](billing-account.md).

To configure access for a group of users, open **Administration** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-groups }}** and select the required access level for each group.

{% note warning %}

If a user with read access joins a group with full access, the user's access level will change to full.

Otherwise, the user's access level will not change when joining a group.

{% endnote %}


## Read mode {#readonly}

In read mode, users cannot perform actions related to creating, updating, or deleting objects, e.g.:

- Create issues using the {{ tracker-name }} interface.

- Change parameters, statuses, and resolutions in issues.

- Comment on issues.

- Subscribe to changes in issues.

However, you can still perform all actions related to viewing {{ tracker-name }} issues:

- View issues, [dashboards](user/dashboard.md), and [issue boards](manager/agile-new.md).

- Search for issues using the [filter builder](user/create-filter.md) and [query language](user/query-filter.md).

- View [queue pages](manager/quick-filters.md), [statistics](manager/statistics.md), and more.

