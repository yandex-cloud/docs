# Disabling paid features in {{ tracker-name }}

{% note info %}

To avoid paying for {{ tracker-name }}, you can disable the paid features, leaving the free [<q>{{ ui-key.startrek.ui_components_page-admin_OrgUsersPane.access-level_read_only }}</q>](access.md#readonly) mode for your employees. You can't fully disable {{ tracker-name }}.

{% endnote %}

To stop using paid features {{ tracker-full-name }}, revoke full access to {{ tracker-name }} from your company's employees. If only 5 or fewer users have full access, you can use {{ tracker-name }} free-of-charge. For more information, see [{#T}](pricing.md).

1. In the {{ tracker-name }} left-hand panel, click **{{ ui-key.startrek.blocks-desktop_b-queues-info.admin }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-users }}**.

1. Make sure the **Full access for all new users** option is disabled.

1. For the employees whose access needs to be revoked, in the **{{ ui-key.startrek.ui_components_page-admin_OrgUsersPane.title_access }}** column, select **{{ ui-key.startrek.ui_components_page-admin_OrgUsersPane.access-level_read_only }}**.


Once you revoke access to {{ tracker-name }} from the employees, they won't be able to create and update issues. However, they'll still be able to view information in {{ tracker-name }}.