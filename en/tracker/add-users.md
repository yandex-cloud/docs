# Managing users

{{ tracker-name }} supports organizations from {{ ya-360 }} and [{{ yandex-cloud }}]({{ link-org-main }}). You can [enable](https://tracker.yandex.ru/admin/orgs) an additional organization on the {{ tracker-name }} administration page. When enabling the second organization, users and groups are synced in {{ tracker-name }} automatically.

To collaborate on issues with your colleagues, add them to {{ tracker-name }}. There are several ways to do this:
- [Inviting users with Yandex accounts to {{ tracker-name }}](#invite_user).
- [Adding users](../organization/operations/add-account.md) to {{ org-full-name }}.
- [Creating new accounts](#create_users) on your organization's domain.
- [Configuring an identity federation](#federation). With an identity federation, your employees can log in to {{ tracker-name }} using their corporate accounts in Active Directory, Google Workspace, or other user account management systems.


{% note warning %}

If [full access for new users](access.md#access-new-users) is enabled automatically in the {{ tracker-name }} settings, the [cost of using the service](./pricing.md#sec_price) may increase when adding new users to your organization.

{% endnote %}

## Inviting users to your organization {#invite_user}

To invite a user to an organization:

{% list tabs %}

- {{ org-full-name }}

  1. Open the [{{ tracker-name }} page]({{ link-tracker }}) and [log in to the admin account](user/login.md).

  1. In the left-hand panel, click ![](../_assets/tracker/svg/add-user.svg) **Add users**.

  1. In the window that opens, specify employees' email addresses (such as `{{ example-account }}`) separated by commas and click **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**. Each user will receive an email prompting to join your organization.

      You can send invitations to any email address. Invited users will be able to select the appropriate Yandex account once they accept the invitation.

  To log in to {{ tracker-name }}, the invited user should follow the link from the email, accept the invitation, and select the account to log in with.

  You can also invite users in {{ org-full-name }}. For more information, see the [documentation](../organization/operations/add-account.md).

  The administrator can [grant user permissions](../organization/operations/roles.md) only after the user accepts the invitation. To make sure the user gets the appropriate permissions or joins a [group](../organization/concepts/groups.md) immediately after accepting the invitation, you can add them to the {{ org-full-name }} group. To do this:

  1. [Send an invitation](../_includes/organization/add-user.md#useraccount) to {{ org-full-name }}.

  1. In the left-hand panel, select **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../_assets/console-icons/persons.svg) and click the line with the group name.

  1. Go to the **{{ ui-key.yacloud_org.entity.group.title_tab-members }}** tab.

  1. Click **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.

  1. In the **{{ ui-key.yacloud_org.component.subject-select-dialog.title_dialog }}** window, select a user from the **Invitee accounts** list or search by user.

  1. Click **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

- {{ ya-360 }}

  Users can be added to an organization only in [{{ ya-360 }}]({{ link-ya-360 }}). Do that on the organization management page. For more information about adding users to {{ ya-360 }}, see the [documentation](https://yandex.com/support/business/users.html#add-users).

{% endlist %}

## Setting up an identity federation {#federation}

An identity federation is a technology that allows you to implement a Single Sign-On (SSO) authentication scheme so that your employees can log in to {{ tracker-full-name }} using their corporate accounts in Active Directory, Google Workspace, or other SAML-compatible user account management systems.

To create an identity federation for an organization:

{% list tabs %}

- {{ org-full-name }}

  1. Open the [{{ tracker-name }} page]({{ link-tracker }}) and [log in to the admin account](user/login.md).

  1. In the left-hand panel, click **Configure** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-orgs }}**.

  1. Under **{{ ui-key.startrek.ui_components_page-admin_OrgPanes_CloudOrgPane.source-title }}**, click **{{ ui-key.startrek.ui_components_page-admin_OrgPanes_CloudOrgPane.federation-task-action }}**. The {{ org-full-name }} page opens.

  1. Specify the federation settings and click **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

  Users with corporate accounts can [log in to {{ tracker-name }}](user/login.md) by clicking **Log in via SSO**.

  To learn more about creating an identity federation, see the [{{ org-full-name }} documentation](../organization/concepts/add-federation.md).

- {{ ya-360 }}

  Follow the [guide](https://yandex.ru/support/business/sso/setup.html) in the {{ ya-360 }} documentation.

{% endlist %}

## Creating user accounts {#create_users}

To create user accounts, connect your company's email domain in [{{ ya-360 }}]({{ link-ya-360 }}):

1. Open the [{{ tracker-name }} page]({{ link-tracker }}) and [log in to the admin account](user/login.md).

1. In the left-hand panel, click **Configure** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-orgs }}**.

1. Under **{{ ui-key.startrek.ui_components_page-admin_OrgPanes_DirectoryOrgPane.source-title }}**, click **{{ ui-key.startrek.ui_components_page-admin_OrganizationSmallPane.add-org-button }}**. A window with your organizations will open. You can create a new organization or go to an existing one.

   {% note info %}

   If your organization has no email domain connected, click **Configure mail** in [{{ ya-360 }}]({{ link-ya-360 }}) and add a domain. To learn more, see [Help for the service]({{ support-business-domain }}).

   {% endnote %}

1. In {{ ya-360 }}, [create user accounts]({{ support-business-users }}).

To [log in to {{ tracker-name }}](user/login.md), an employee with an account on the domain will need to enter their full email address (such as `login@example.com`) and password.

## Deleting a user account {#remove}

To delete a user account from {{ tracker-name }}, remove the employee from the organization they belong to:

- [{{ org-full-name }}](../organization/operations/edit-account.md).

- [{{ ya-360 }}](https://yandex.ru/support/business/users.html#sec_delete).

{% note info %}

To delete a user account registered both in {{ org-full-name }} and {{ ya-360 }}, remove it from both organizations.

{% endnote %}

You can also edit user [permissions](./access.md): <q>Read-only</q> mode is free of charge.
