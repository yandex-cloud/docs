# Managing users

{{ tracker-name }} supports organizations from {{ ya-360 }} and {{ yandex-cloud }}. Users and groups from {{ ya-360 }} are added to and displayed in {{ tracker-name }}. For {{ yandex-cloud }} organizations, a special organization is created in {{ ya-360 }} for syncing users and enabling group creation.

To collaborate on issues with your colleagues, add them to {{ tracker-name }}. There are several ways to do this:
- [Inviting users with Yandex accounts to {{ tracker-name }}](#invite_user).
- [Adding users](../organization/add-account.md) to {{ org-full-name }}.
- [Creating new accounts](#create_users) on your organization's domain.
- [Configuring an identity federation](#federation). With an identity federation, your employees can log in to {{ tracker-name }} using their corporate accounts in Active Directory, Google Workspace, or other user account management systems.


{% note warning %}

If [full access for new users](access.md#access-new-users) is enabled automatically in the {{ tracker-name }} settings, the [cost of using the service](https://cloud.yandex.ru/docs/tracker/pricing#sec_price) may increase when adding new users to your organization.

{% endnote %}

## Inviting users to your organization {#invite_user}

You can invite users who have a Yandex account (such as `{{ example-account }}`) to your organization. So far, this add user method doesn't work for users with accounts of a different type.

1. Open the [{{ tracker-name }} page]({{ link-tracker }}) and [log in to the admin account](user/login.md).

1. In the left-hand panel, click **{{ ui-key.startrek.blocks-desktop_b-head.add-user }}**.

1. In the window that opens, specify employees' email addresses separated by commas (such as `{{ example-account }}`) and click **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**. Each user will receive an email prompting to join your organization.

To log in to {{ tracker-name }}, an invited user should follow the link [{{ link-tracker }}]({{ link-tracker }}) and [log in to their Yandex account](user/login.md).

## Setting up an identity federation {#federation}

An identity federation is a technology that lets you implement a Single Sign-On (SSO) authentication scheme so that your employees can log in to {{ tracker-full-name }} using their corporate accounts in Active Directory, Google Workspace, or other SAML-compatible user account management systems.

To create an identity federation:

1. Open the [{{ tracker-name }} page]({{ link-tracker }}) and [log in to the admin account](user/login.md).

1. In the left-hand panel, click **{{ ui-key.startrek.blocks-desktop_b-queues-info.admin }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-orgs }}**.

1. Under **{{ ui-key.startrek.ui_components_page-admin_OrgPanes_CloudOrgPane.source-title }}**, click **{{ ui-key.startrek.ui_components_page-admin_OrgPanes_CloudOrgPane.federation-task-action }}**. The {{ org-full-name }} page opens.

1. Specify the federation settings and click **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

Users with corporate accounts can [log in to {{ tracker-name }}](user/login.md) by clicking **Log in via SSO**.

To learn more about creating an identity federation, see the [{{ org-full-name }}](../organization/add-federation.md) documentation.

## Creating user accounts {#create_users}

To create user accounts, connect your company's email domain in [{{ ya-360 }}]({{ link-ya-360 }}):

1. Open the [{{ tracker-name }} page]({{ link-tracker }}) and [log in to the admin account](user/login.md).

1. In the left-hand panel, click **{{ ui-key.startrek.blocks-desktop_b-queues-info.admin }}** → **{{ ui-key.startrek.ui_components_page-admin_PageAdmin.menu-item-orgs }}**.

1. Under **{{ ui-key.startrek.ui_components_page-admin_OrgPanes_DirectoryOrgPane.source-title }}**, click **{{ ui-key.startrek.ui_components_page-admin_OrganizationSmallPane.add-org-button }}**. A window with your organizations opens. You can create a new organization or go to an existing one.

   {% note info %}

   If your organization has no email domain connected, click **{{ ui-key.startrek.ui_components_page-queue-admin_AliasesEmptyList.action-configure-mail }}** in [{{ ya-360 }}]({{ link-ya-360 }}) and add a domain. To learn more, see [Help for the service]({{ support-business-domain }}).

   {% endnote %}

1. In {{ ya-360 }}, [create user accounts]({{ support-business-users }}).

To [log in to {{ tracker-name }}](user/login.md), an employee with an account on the domain will need to enter their full email address (such as `login@example.com`) and password.

## Deleting a user account {#remove}

To delete a user account from {{ tracker-name }}, remove the employee from the organization they belong to:

- [{{ org-full-name }}](../organization/edit-account.md).

- [{{ ya-360 }}](https://yandex.ru/support/business/users.html#sec_delete).

{% note info %}

To delete a user account registered both in {{ org-full-name }} and {{ ya-360 }}, remove it from the respective organization in {{ org-full-name }}.

{% endnote %}

You can also edit user [permissions](./access.md): <q>Read-only</q> mode is free of charge.
