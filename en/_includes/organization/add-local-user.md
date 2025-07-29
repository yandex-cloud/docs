{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.
  1. In the left-hand panel, click ![userpool](../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** and select the [user pool](../../organization/concepts/user-pools.md).
  1. In the **{{ ui-key.yacloud_org.organization.userpools.title_userpool_members }}** tab, click **{{ ui-key.yacloud_org.organization.userpools.action_create-user }}**.
  1. Enter the user login and select the [domain](../../organization/concepts/domains.md) from the list. The login must be unique for the current user pool.
  
      If the domain is not on the list, [add a new one](../../organization/operations/user-pools/add-domain.md).
  1. In the **{{ ui-key.yacloud_org.organization.userpools.field_full-name }}** field, specify the full name of the user in any format.  
  1. Optionally, add the user’s email address.
  1. In the **{{ ui-key.yacloud_org.organization.userpools.field_password }}** field, you can view the automatically generated user password and generate a new one.
  
      The user must change this password on their first login to {{ yandex-cloud }}.
  1. Enable **{{ ui-key.yacloud_org.organization.userpools.field_active }}** if you need to activate the user immediately upon adding them. Activated users gain access to the organization resources.
  1. Optionally, specify the user's first name, last name, and phone number under **{{ ui-key.yacloud_org.organization.userpools.title_personal-info }}**.
  1. Click **{{ ui-key.yacloud_org.organization.userpools.action_create-user }}**.

{% endlist %}