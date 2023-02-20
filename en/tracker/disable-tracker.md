# Disabling paid features in {{ tracker-name }}

{% note info %}

To avoid paying for {{ tracker-name }}, you can disable paid features, leaving on the free [<q>Read-only</q>](access.md#readonly) access mode for your employees. You can't fully disable {{ tracker-name }}.

{% endnote %}

To stop using paid features {{ tracker-full-name }}, revoke full access to {{ tracker-name }} from your company's employees. If only 5 or fewer users have full access, you can use {{ tracker-name }} free-of-charge. For more information, see [{#T}](pricing.md).

1. In the panel on the left {{ tracker-name }}, click **Administration** → **Users**.

1. Make sure the **Full access for all new users** option is disabled.

1. For the employees whose access needs to be revoked, in the **Access to {{ tracker-name }}** column, select **Read**.

{% if audience == "draft" %}1. To revoke access from all employees at once, select **Departments** on the left-hand panel and then **Read only** in the **All employees row**.{% endif %}

Once you revoke access to {{ tracker-name }} from the employees, they won't be able to create and update issues. However, they'll still be able to view information in {{ tracker-name }}.