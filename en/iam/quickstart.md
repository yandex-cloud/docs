# Getting started with {{ iam-short-name }}

{{ iam-short-name }} lets you manage access to {{ yandex-cloud }} resources.

Follow these instructions to add a user to an [organization](../organization/) and grant them access to a resource in one of your [clouds](../resource-manager/concepts/resources-hierarchy.md#cloud).

These instructions require the following [roles](./concepts/access-control/roles.md):

* Organization owner (`organization-manager.organizations.owner`) or administrator (`organization-manager.admin`).
* Cloud owner (`resource-manager.clouds.owner`) or administrator (`admin`).


## Before you begin {#before-you-begin}

{% if product == "yandex-cloud" %}

1. Log in to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you don't have anyone to add to the cloud, you can [create a new account](https://passport.yandex.com/registration) on Yandex and grant this account access to the cloud.

{% endif %}
{% if product == "cloud-il" %}

Log in to the [management console]({{ link-console-main }}). If you haven't registered yet, go to the [management console]({{ link-console-main }}) and follow the instructions.

{% endif %}


## Add a user to your organization {#add-organization-member}

You can add a user with a {% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %} account or a [federated](../organization/add-federation.md) user.

To add a user with a {% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %} account:

{% include [add-useraccount](../_includes/organization/add-useraccount.md) %}

{% if product == "yandex-cloud" %}
{% note info %}

You can also add a user directly from a cloud page in the management console. For more, see the [instructions](./operations/users/create.md#add-useraccount).

{% endnote %}
{% endif %}

To grant a user access to a cloud resource, assign the user a role to the resource itself or to a resource container, such as a folder.


## Assign roles to the user {#assign-role}

To specify which operations the user can perform, assign relevant roles to the user. For example, allow the user to view cloud resources and manage a folder:

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
