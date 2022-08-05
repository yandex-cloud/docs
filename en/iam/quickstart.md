# Getting started with {{ iam-short-name }}

{{ iam-short-name }} lets you manage access to resources.

These instructions are intended for cloud [owners](../resource-manager/concepts/resources-hierarchy.md#owner) and [administrators](concepts/access-control/roles.md#admin). You will learn how to:

* [Add users to your cloud](#add-user).
* [Assign users roles](#assign-role).
* [Revoke assigned roles](#revoke-roles).

## Before you start {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
   {% if product == "yandex-cloud" %}
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you don't have anyone to add to the cloud, you can {% if product == "yandex-cloud" %}[create a new account](https://passport.yandex.ru/registration) on Yandex{% endif %}{% if product == "cloud-il" %} [create a new account](https://support.google.com/accounts/answer/27441) on Google{% endif %} grant this account access to the cloud.
   {% endif %}

## Add a new user to the cloud {#add-user}
{% if product == "yandex-cloud" %}

To grant a user with a {% if product == "yandex-cloud" %}Yandex{% endif %} {% if product == "cloud-il" %}Google{% endif %} account access to cloud resources:

1. [Log in]({{ link-passport-login }}) to the cloud administrator account.
1. [Select](../resource-manager/operations/cloud/switch-cloud.md) a cloud.
1. Go to the [Access rights]({{ link-console-cloud }}?section=resource-acl) tab.
1. Click ![image](../_assets/options.svg) in the upper-right corner of the page.
1. Click **Add user**.
1. Enter the user's {% if product == "yandex-cloud" %}Yandex{% endif %} {% if product == "cloud-il" %}Google{% endif %} email address.
1. Click **Add user**.

After that, the user gets the [cloud member role](../iam/concepts/access-control/roles.md#member): `{{ roles-cloud-member }}`. This role is necessary for the user to access resources in the cloud. However, this role doesn't give you the right to perform any operations and is only used in combination with other roles, such as `admin`, `editor`, or `viewer`.

You can also add a user using [{{ org-full-name }}](./operations/users/create.md#passport-user).

{% endif %}
{% if product == "cloud-il" %}

You can add a user to the cloud by using [{{ org-full-name }}](./operations/users/create.md#passport-user).

{% endif %}
## Assign roles to the user {#assign-role}

To specify which operations the user can perform, assign relevant roles to the user. For example, allow them to manage resources in a certain folder:

{% list tabs %}

- Management console

   1. Assign the user a role in the cloud:
      1. On the [start page]({{ link-console-main }}) of the management console, [select](../resource-manager/operations/cloud/switch-cloud.md) the cloud.
      1. Go to **Access rights**.
      1. Enable the **Inherited roles** option to display the users added to the organization.
      1. Select a user from the list and click ![image](../_assets/options.svg) next to the username.
      1. Click **Edit roles**.
      1. In the **Configure access rights** window, click **Add role**.
      1. Choose the `{{ roles-viewer }}` role. This role lets the user view resources in your cloud.
      1. Click **Save**.

   1. Assign the user a role in the folder:
      1. On the [start page]({{ link-console-main }}) of the management console, select the folder.
      1. Go to **Access rights**.
      1. Click **Assign roles**.
      1. In the **Configure access rights** window, click **Select user**.
      1. Select a user from the list or search for a user.
      1. Click **Add role**.
      1. Choose the `{{ roles-editor }}` role. This role allows the user to create and manage resources in this folder.
      1. Click **Save**.

{% endlist %}

## Revoke assigned roles {#revoke-roles}

If the user no longer needs the assigned roles, revoke them:

{% list tabs %}

- Management console

   * To revoke a role only in the folder:

      1. On the [start page]({{ link-console-main }}) of the management console, select the folder.
      1. Go to **Access rights**.
      1. Select a user from the list and click ![image](../_assets/options.svg) next to the username.
      1. Click **Edit roles**.
      1. Click ![image](../_assets/cross.svg) next to the role you wish to revoke.
      1. Click **Save**.

   * To revoke a role in the cloud:

      1. On the [start page]({{ link-console-main }}) of the management console, [select](../resource-manager/operations/cloud/switch-cloud.md) the cloud.
      1. Go to **Access rights**.
      1. Select a user from the list and click ![image](../_assets/options.svg) next to the username.
      1. If you want to revoke all of the user's roles in the cloud, click **Revoke roles** and confirm the revocation.
      1. If you want to revoke individual roles in the cloud:
         1. Click **Edit roles**.
         1. In the **Configure access rights** window, click ![image](../_assets/cross.svg) next to each role you want to revoke.
         1. Click **Save**.

{% endlist %}

## What's next {#what-is-next}

* The [step-by-step instructions](operations/index.md) will help you perform specific tasks in {{ iam-name }}.
* Learn [about access management in {{ yandex-cloud }}](concepts/access-control/index.md).
* See the [best practices for using {{ yandex-cloud }} securely](best-practices/using-iam-securely.md).
* Learn about [authentication in {{ yandex-cloud }}](concepts/authorization/index.md#authentication).
* [Learn how to work with service accounts](quickstart-sa.md).
* See [answers to frequently asked questions](qa/index.md).
