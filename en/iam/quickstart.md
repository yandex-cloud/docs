# Getting started with {{ iam-short-name }}

{{ iam-short-name }} lets you manage access to resources.

These instructions are intended for cloud [owners](../resource-manager/concepts/resources-hierarchy.md#owner) and [administrators](concepts/access-control/roles.md#admin). You will learn how to:

* [Add users to your cloud](#add-user).
* [Assign roles to users](#assign-role).
* [Revoke assigned roles](#revoke-roles).

## Before you start {#before-you-begin}

1. Log in to the [management console](https://console.cloud.yandex.com). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page](https://console.cloud.yandex.com/billing), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you have no one to add to the cloud, you can [create a new account](https://passport.yandex.com/registration) on Yandex and grant access to the cloud to this account.

## Add a new user to the cloud {#add-user}

To grant a user access to resources, add them to the [organization](../organization/enable-org.md) assigned to the cloud:

1. [Log in to the account]({{ link-passport-login }}) your organization's administrator.
1. Go to [{{ org-full-name }}]({{ link-org-main }}).
1. In the left panel, select [Users](https://org.cloud.yandex.com/users) ![icon-users](../_assets/organization/icon-users.png).
1. In the upper-right corner, click **Add user**.
1. Enter the user's Yandex email address.
1. Click **Add**.

Now the user will gain access to the services enabled for the organization. When a new user is added to an organization, they are automatically assigned the [cloud member role](../iam/concepts/access-control/roles.md#member): `{{ roles-cloud-member }}`. This role is necessary for the user to access resources in the cloud. However, this role doesn't give you the right to perform any operations and is only used in combination with other roles, such as `admin`, `editor`, or `viewer`.

## Assign roles to the user {#assign-role}

To specify which operations the user can perform, assign relevant roles to the user. For example, allow them to manage resources in a certain folder:

1. {% include [configure-roles-console](../_includes/iam/configure-roles-console.md) %}
1. Under **Roles for the cloud <cloud name>**, click the ![image](../_assets/plus-sign.svg) icon.
1. Choose the `{{ roles-viewer }}` role. This role lets the user view resources in your cloud.
1. Select a folder in **Roles in folders** and click **Assign role**.
1. Choose the `{{ roles-editor }}` role. This role allows the user to create and manage resources in this folder.
1. Click **Close**.

## Revoke assigned roles {#revoke-roles}

If the user no longer needs the assigned roles, revoke them:

1. Open the page [Access management]({{ link-console-access-management }}).

1. {% include [configure-roles-console](../_includes/iam/configure-roles-console.md) %}

1. Click the ![image](../_assets/cross.svg) icon next to each role you want to revoke.

1. Click **Close**.

    If the user doesn't have any more roles for your cloud, this user disappears from the list.

{% note tip %}

If you want to revoke all roles at once, [delete the user](operations/users/delete.md) from your cloud.

{% endnote %}

## What's next {#what-is-next}

* [The step-by-step instructions](operations/index.md) will help you with your tasks in {{ iam-name }}.
* Learn about [access management in {{ yandex-cloud }}](concepts/access-control/index.md).
* See the [best practices for using {{ yandex-cloud }}](best-practices/using-iam-securely.md) securely.
* Learn about [authentication in {{ yandex-cloud }}](concepts/authorization/index.md#authentication).
* [Learn how to work with service accounts](quickstart-sa.md).
* See [answers to frequently asked questions](qa/index.md).

