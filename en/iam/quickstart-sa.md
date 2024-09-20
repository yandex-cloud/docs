# Getting started with service accounts

In {{ iam-short-name }}, you can create [_service accounts_](concepts/users/service-accounts.md). These are auxiliary accounts that your programs can use to perform operations in {{ yandex-cloud }}. Service accounts are free of charge. They allow you to flexibly manage access for your programs. For more information, see [{#T}](concepts/users/service-accounts.md).

This guide is intended for [cloud owners](../resource-manager/concepts/resources-hierarchy.md#owner) and users with the [administrator](./roles-reference.md#admin) role for a cloud or folder. Users with the [`editor`](./roles-reference.md#editor) role can also create service accounts, but they cannot assign roles, so they cannot allow a service account to perform operations in {{ yandex-cloud }}.

Checking for required roles is described in [{#T}](#before-you-begin).

You will learn how to:

* [Create service accounts and assign roles to them](#create-sa).
* [Run operations in the CLI](#run-operation-from-sa).
* [Delete service accounts](#delete-sa).

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. Make sure that you have the required [roles](./concepts/access-control/roles.md):

    1. In the management console, select the appropriate cloud from the list on the left, e.g.:

        ![image](../_assets/resource-manager/switch-cloud-n-n.png)

    1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
    1. Specify your account in the search bar.
    1. Check that your account has the following roles:

        * Organization owner (`organization-manager.organizations.owner`) or administrator (`organization-manager.admin`)
        * Cloud owner (`resource-manager.clouds.owner`) or administrator (`admin`)


1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).


## Create a service account {#create-sa}

To create a service account and assign roles to it:

{% include [create-sa-via-console](../_includes/iam/create-sa-via-console.md) %}

{% note info %}

Other users can also use the service account you created. To allow them to do this, [assign](operations/sa/set-access-bindings.md#assign-role-to-sa) them the required [roles](./security/index.md#service-roles) for this account.

{% endnote %}

## Configure the CLI to work on behalf of a service account {#run-operation-from-sa}

You can perform operations on behalf of a service account via the API, CLI, and other tools that support service account based authentication. You cannot log in to the management console using a service account.

{% include [cli-set-sa-profile](../_includes/cli-set-sa-profile.md) %}

Now you can perform operations on behalf of a service account, such as viewing the list of folders available to this account:

```bash
yc resource-manager folder list
```

## Delete the service account {#delete-sa}

If you no longer need the service account, delete it:

{% include [delete-sa-via-console](../_includes/iam/delete-sa-via-console.md) %}

## What's next {#what-is-next}

* The [step-by-step guides](operations/index.md) will help you perform specific tasks in {{ iam-name }}.
* [Read more about service accounts](concepts/users/service-accounts.md) in the concepts section.
* See the [best practices for using service accounts securely](best-practices/using-iam-securely.md#use-sa).
