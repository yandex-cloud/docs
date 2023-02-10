# Getting started with service accounts

{{ iam-short-name }} lets you create [_service accounts_](concepts/users/service-accounts.md). These are auxiliary accounts that your programs can use to perform operations in {{ yandex-cloud }}. Service accounts are free-of-charge and let you flexibly manage access for your programs. Learn more in [{#T}](concepts/users/service-accounts.md).

These instructions are intended for [cloud owners](../resource-manager/concepts/resources-hierarchy.md#owner) and users with the [administrator](concepts/access-control/roles.md#admin) role for a cloud or folder. Users with the [`editor`](concepts/access-control/roles.md#editor) role can also create service accounts, but they can't assign roles, so they can't allow a service account to perform operations in {{ yandex-cloud }}.

You will learn how to:

* [Create service accounts and assign roles to them](#create-sa).
* [Run operations in the CLI](#run-operation-from-sa).
* [Delete service accounts](#delete-sa).

## Before you start {#before-you-begin}

{% if product == "yandex-cloud" %}
1. Open the [management console]({{ link-console-main }}). If you aren't registered at {{ yandex-cloud }}, go to the [management console]({{ link-console-main }}) and follow the instructions.
2. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
{% endif %}
{% if product == "cloud-il" %}
Open the [management console]({{ link-console-main }}). If you aren't registered at {{ yandex-cloud }}, go to the [management console]({{ link-console-main }}) and follow the instructions.
{% endif %}

## Create a service account {#create-sa}

To create a service account and assign roles to it:

{% include [create-sa-via-console](../_includes/iam/create-sa-via-console.md) %}

## Configure the CLI to work on behalf of a service account {#run-operation-from-sa}

You can perform operations on behalf of a service account via the API, CLI, and other tools that support service account based authentication. You can't log in to the management console using a service account.

{% include [cli-set-sa-profile](../_includes/cli-set-sa-profile.md) %}

Now you can perform operations on behalf of a service account, such as viewing the list of folders available to this account:

```
yc resource-manager folder list
```

## Delete the service account {#delete-sa}

If you no longer need the service account, delete it:

{% include [delete-sa-via-console](../_includes/iam/delete-sa-via-console.md) %}

## What's next {#what-is-next}

* [The step-by-step instructions](operations/index.md) will help you with your tasks in {{ iam-name }}.
* [Read more about service accounts](concepts/users/service-accounts.md) in the concepts section.
* See the [best practices for using service accounts securely](best-practices/using-iam-securely.md#use-sa).

