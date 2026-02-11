---
title: How to manage a user in the My account portal
description: Follow this guide to manage a user in the {{ org-full-name }} My account portal.
---

# Managing a user in the My account portal

What you can do in the [_My account_](../concepts/my-account.md) portal depends on your account type:

| | [Yandex account](../../iam/concepts/users/accounts.md#passport) | [Federated account](../../iam/concepts/users/accounts.md#saml-federation) | [Local account](../../iam/concepts/users/accounts.md#local) |
---|---|---|---
[Viewing attributes](#view-profile) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) |
[Updating attributes](#edit-profile) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/yes.svg) |
[Changing a password](#edit-password) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/yes.svg) |
[Deleting refresh tokens](#delete-refresh-token) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) |
[Managing login authentication methods](#manage-mfa) | ![alt](../../_assets/common/no.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) |
[Viewing groups](#view-groups) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg)
[Viewing logs](#view-logs) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg) | ![alt](../../_assets/common/yes.svg)

## Viewing attributes {#view-profile}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to the [_My account_]({{ link-my-account }}) portal.
  1. In the left-hand panel, select ![alt](../../_assets/console-icons/passport.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.profile_8kyBA }}**.
  1. Under **{{ ui-key.yacloud_org.my-account.ProfileEditPageLayout.main_breadcrumb }}**, you will see your account’s attributes.

{% endlist %}

## Updating attributes {#edit-profile}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to the [_My account_]({{ link-my-account }}) portal.
  1. In the left-hand panel, select ![alt](../../_assets/console-icons/passport.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.profile_8kyBA }}**.
  1. Click ![alt](../../_assets/console-icons/person-pencil.svg) **{{ ui-key.yacloud_org.my-account.ProfilePage.edit_action }}**.
  1. Edit the first name, last name, and contact details.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Changing a password {#edit-password}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to the [_My account_]({{ link-my-account }}) portal.
  1. In the left-hand panel, select ![alt](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.security_7zQ3g }}**.
  1. Under **{{ ui-key.yacloud_org.my-account.login.entry-methods.header }}**, click ![alt](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.myaccount.security.EntryMethodsTable.change-action }}**.
  1. Enter your current password and enter the new one twice.
  1. Click **{{ ui-key.yacloud_org.organization.idp.PasswordDialog.action_save-password_gaB2s }}**.

{% endlist %}

## Deleting refresh tokens {#delete-refresh-token}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to the [_My account_]({{ link-my-account }}) portal.
  1. In the left-hand panel, select ![alt](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.security_7zQ3g }}**.
  1. Navigate to the **{{ ui-key.yacloud_org.my-account.SecurityPageLayout.refresh_breadcrumb }}** tab.
  1. You will see all the applications you added [refresh tokens](../../iam/concepts/authorization/refresh-token.md) for.
  1. Click ![alt](../../_assets/console-icons/trash-bin.svg) next to the application whose refresh token you want to delete.
  1. To delete all refresh tokens, click ![alt](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.my-account.refresh-tokens.action_remove_all }}**. 

{% endlist %}

## Managing login authentication methods {#manage-mfa}

To manage login authentication methods, a user must be added to the [MFA policy](../concepts/mfa.md).

### Adding a login authentication method {#mfa-add}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to the [_My account_]({{ link-my-account }}) portal.
  1. In the left-hand panel, select ![alt](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.security_7zQ3g }}**.
  1. Under **{{ ui-key.yacloud_org.my-account.security.login-confirmation.header }}**, click **Add authentication method**.
  1. Select the login authentication method you need.

{% endlist %}

### Deleting a login authentication method {#mfa-delete}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to the [_My account_]({{ link-my-account }}) portal.
  1. In the left-hand panel, select ![alt](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.security_7zQ3g }}**.
  1. Under **{{ ui-key.yacloud_org.my-account.security.login-confirmation.header }}**, you will see your login authentication methods and their last use dates.
  1. Click ![alt](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.myaccount.security.LoginConfirmationTable.delete-action }}** next to the relevant login authentication method.

{% endlist %}

## Viewing groups {#view-groups}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to the [_My account_]({{ link-my-account }}) portal.
  1. In the left-hand panel, select ![alt](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.groups_pqQRu }}**.
  1. On the **{{ ui-key.yacloud_org.my-account.GroupsPageLayout.header }}** page, you will see all your groups and their IDs.

{% endlist %}

## Viewing logs {#view-logs}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to the [_My account_]({{ link-my-account }}) portal.
  1. In the left-hand panel, select ![alt](../../_assets/console-icons/clock.svg) **{{ ui-key.yacloud_org.center-layout.MyAccountLayout.activity_kyqSv }}**.
  1. The page that opens will show your audit [logs](../concepts/logs.md).
  1. Click an entry to view more details about the event.

     You can use also use filters at the top of the page to find the logs you need.

  To view logs of all the users of the [organization](../concepts/organization.md) or [pool](../concepts/user-pools.md) you administer, see [{#T}](./user-pools/user-get-logs.md).

{% endlist %}
