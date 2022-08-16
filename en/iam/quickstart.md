# Getting started with {{ iam-short-name }}

{{ iam-short-name }} lets you manage access to resources.

These instructions are intended for cloud [owners](../resource-manager/concepts/resources-hierarchy.md#owner) and [administrators](concepts/access-control/roles.md#admin). You will learn how to:

* [Add users to your cloud](#add-user).
* [Assign users roles](#assign-role).
* [Revoke assigned roles](#revoke-roles).

## Before you start {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you don't have anyone to add to the cloud, you can [create a new account](https://passport.yandex.com/registration) on Yandex grant this account access to the cloud.

## Add a new user to the cloud {#add-user}

To grant a user with a Yandex  account access to cloud resources:

1. [Log in]({{ link-passport-login }}) to the cloud administrator account.
1. [Select](../resource-manager/operations/cloud/switch-cloud.md) a cloud.
1. Go to the [Access rights]({{ link-console-cloud }}?section=resource-acl) tab.
1. Click ![image](../_assets/options.svg) in the upper-right corner of the page.
1. Click **Add user**.
1. Enter the user's Yandex  email address.
1. Click **Add user**.

After that, the user gets the [cloud member role](../iam/concepts/access-control/roles.md#member): `{{ roles-cloud-member }}`. This role is necessary for the user to access resources in the cloud. However, this role doesn't give you the right to perform any operations and is only used in combination with other roles, such as `admin`, `editor`, or `viewer`.

You can also add a user using [{{ org-full-name }}](./operations/users/create.md#passport-user).

## Assign roles to the user {#assign-role}

To specify which operations the user can perform, assign relevant roles to the user. For example, allow the user to view cloud resources and manage folder resources:

{% list tabs %}

- Management console

   1. Assign the user a role in the cloud:

      {% include [set-accessbinding-user-editor-folder-console](../_includes/resource-manager/set-accessbinding-user-viewer-cloud-console.md) %}

   1. Assign the user a role in the folder:

      {% include [set-accessbinding-user-editor-folder-console](../_includes/resource-manager/set-accessbinding-user-editor-folder-console.md) %}

{% endlist %}

## Revoke assigned roles {#revoke-roles}

If the user no longer needs the assigned roles, revoke them:

{% list tabs %}

- Management console

   * To revoke a role only in the folder:

      {% include [update-access-binding-user-console-folder](../_includes/resource-manager/update-access-binding-user-console-folder.md) %}

   * To revoke a role in the cloud:

      {% include [update-access-binding-user-console-cloud](../_includes/resource-manager/update-access-binding-user-console-cloud.md) %}

{% endlist %}

## What's next {#what-is-next}

* The [step-by-step instructions](operations/index.md) will help you perform specific tasks in {{ iam-name }}.
* Learn [about access management in {{ yandex-cloud }}](concepts/access-control/index.md).
* See the [best practices for using {{ yandex-cloud }} securely](best-practices/using-iam-securely.md).
* Learn about [authentication in {{ yandex-cloud }}](concepts/authorization/index.md#authentication).
* [Learn how to work with service accounts](quickstart-sa.md).
* See [answers to frequently asked questions](qa/index.md).
