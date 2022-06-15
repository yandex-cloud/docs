# Getting started with {{ iam-short-name }}

{{ iam-short-name }} lets you manage access to resources.

These instructions are intended for cloud [owners](../resource-manager/concepts/resources-hierarchy.md#owner) and [administrators](concepts/access-control/roles.md#admin). You will learn how to:

* [Add users to your cloud](#add-user).
* [Assign roles to users](#assign-role).
* [Revoke assigned roles](#revoke-roles).

## Before you start {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
2. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
3. If you have no one to add to the cloud, you can [create a new Yandex account](https://passport.yandex.com/registration) and grant access to the cloud to this account.

## Add a new user to the cloud {#add-user}

To grant access to resources for a user with a Yandex account:

1. [Log in to the account]({{ link-passport-login }}) your organization's administrator.
1. [Select](../resource-manager/operations/cloud/switch-cloud.md) the cloud.
1. Go to [Access bindings]({{ link-console-cloud }}?section=resource-acl).
1. Select ![image](../_assets/options.svg) in the upper-right corner.
1. Click **Add user**.
1. Enter the user's Yandex email.
1. Click **Add**.

The user will get the [member role](../iam/concepts/access-control/roles.md#member) — `{{ roles-cloud-member }}`. 

You can also add a user by using [{{ org-full-name }}](./operations/users/create.md#passport-user).


## Assign roles to the user {#assign-role}

To specify which operations the user can perform, assign relevant roles to the user. For example, allow them to manage resources in a certain folder:

{% list tabs %}

- Management console

   1. Assign a role to the user in the cloud:

      1. [Select](../resource-manager/operations/cloud/switch-cloud.md) the cloud.
      1. Go to [Access bindings]({{ link-console-cloud }}?section=resource-acl).
      1. Select the user in the list and click ![image](../_assets/options.svg) next to the name.
      1. Click **Edit roles**.
      1. In the **Configuring access bindings** dialog, click **Add role**.
      1. Select `{{ roles-viewer }}`. This role enables viewing resources in the cloud.
      1. Click **Save**.

   1. Assign a role to the user in the folder:

      1. Open the target folder. You can select it on the [main page]({{ link-console-main }}) of the management console. This page shows folders of the selected cloud.
      2. Go to **Access bindings**.
      3. In the **Configuring access bindings** dialog, click **Select subject**.
      4. Select the user. To discover the user, start typing the name in the search field.
      5. Click **Add role**.
      6. Select `{{ roles-editor }}`. This role enables creating resources in this folder and managing them.
      7. Click **Save**.

{% endlist %}


## Revoke assigned roles {#revoke-roles}

If the assigned roles are no longer needed, you can revoke them:

{% list tabs %}

- Management console

   * To revoke  a role in the folder:

      1. Open the target folder. You can select it on the [main page]({{ link-console-main }}) of the management console. This page shows folders of the selected cloud.
      1. Go to [Access bindings]({{ link-console-cloud }}?section=resource-acl).
      1. Select the user in the list and click ![image](../_assets/options.svg)  next to the name.
      1. Click **Edit roles**.
      1. Click ![image](../_assets/cross.svg) next to the role you want to revoke.
      1. Click **Save**.

   * To revoke a role in the cloud:

      1. [Select](../resource-manager/operations/cloud/switch-cloud.md) the cloud.
      1. Go to [Access bindings]({{ link-console-cloud }}?section=resource-acl).
      1. Select the user in the list and click ![image](../_assets/options.svg) next to the name.
      1. If you want to revoke all the user's roles, click **Remove bindings**.
      1. If you want to revoke certain roles:
         1. Click **Edit roles**.
         1. In the **Configuring access bindings** dialog, click ![image](../_assets/cross.svg) next to each role you want to revoke.
         1. Click **Save**.

{% endlist %}

## What's next {#what-is-next}

* [The step-by-step instructions](operations/index.md) will help you with your tasks in {{ iam-name }}.
* Learn about [access management in {{ yandex-cloud }}](concepts/access-control/index.md).
* See the [best practices for using {{ yandex-cloud }}](best-practices/using-iam-securely.md) securely.
* Learn about [authentication in {{ yandex-cloud }}](concepts/authorization/index.md#authentication).
* [Learn how to work with service accounts](quickstart-sa.md).
* See [answers to frequently asked questions](qa/index.md).

