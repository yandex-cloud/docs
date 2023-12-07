## Disabling {{ tracker-name }}

## Disabling {{ tracker-name }} automatically {#auto-disabling}

If you have no [billing account](billing-account.md) activated, and if no user has logged in to the interface nor performed any actions for a period of one month, {{ tracker-name }} will be disabled automatically.

After your tracker is disabled due to a month of inactivity, all your data in {{ tracker-name }} will be deleted in:

* One month if there are issues created in {{ tracker-name }} earlier.
* One week if there are no issues.

To avoid service deactivation and deletion of your data, log in to {{ tracker-name }}. To make sure the service is not disabled due to inactivity, [activate a billing account](billing-account.md#create).

## How to disable paid features in {{ tracker-name }} {#disable-payments}

{% note info %}

To avoid paying for {{ tracker-name }}, you can disable the paid features, leaving the free [<q>{{ ui-key.startrek.ui_components_page-admin_OrgUsersPane.access-level_read_only }}</q>](access.md#readonly) mode for your employees. You cannot fully disable {{ tracker-name }}.

{% endnote %}

To stop using the paid features {{ tracker-full-name }}, revoke full access to {{ tracker-name }} from your company's employees. If only 5 or fewer users have full access, you can use {{ tracker-name }} free of charge. For more information, see [{#T}](pricing.md).

1. In the {{ tracker-name }} left-hand panel, click **Configure** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-users }}**.

1. Make sure the **Full access for all new users** option is disabled.

1. For the employees whose access needs to be revoked, in the **{{ ui-key.startrek.ui_components_page-admin_OrgUsersPane.title_access }}** column, select **{{ ui-key.startrek.ui_components_page-admin_OrgUsersPane.access-level_read_only }}**.


Once you revoke access to {{ tracker-name }} from the employees, they will not be able to create and update issues. However, they will still be able to view information in {{ tracker-name }}.