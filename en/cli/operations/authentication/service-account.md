---
title: How to authenticate in the {{ yandex-cloud }} CLI as a service account
description: Follow this guide to get authenticated in the {{ yandex-cloud }} CLI as a service account.
---

# Authenticating as a service account

{% note info %}

When performing actions on behalf of a service account, ensure that it has the required [roles](../../../iam/concepts/access-control/roles.md) [assigned](../../../iam/operations/sa/assign-role-for-sa.md) to it.

{% endnote %}

Learn how to get authenticated in the {{ yandex-cloud }} CLI:

* [On behalf of a service account using impersonation](#use-impersonation). Using [impersonation](../../../iam/concepts/access-control/index.md#impersonation) is the recommended and most secure way to get authenticated in the {{ yandex-cloud }} CLI.
* [On behalf of a service account using an authorized key](#auth-as-sa). Using an [authorized key](../../../iam/concepts/authorization/key.md) allows you to continually get authenticated in the {{ yandex-cloud }} CLI with the same authorized key you generated. Using a long-lived key is less secure than using impersonation.
* [As a service account from inside a VM](#vm-auth-as-sa). Using a [service account](../../../iam/concepts/users/service-accounts.md) attached to the {{ compute-full-name }} [VM](../../../compute/concepts/vm.md) is the recommended method of authentication in the {{ yandex-cloud }} CLI when using a VM.

[Service accounts](../../../iam/concepts/users/service-accounts.md) are different from [user accounts](../../../iam/concepts/users/accounts.md#passport) or [federated user accounts](../../../iam/concepts/federations.md). You cannot use service accounts to log in to the [management console]({{ link-console-main }}), but you can use them to manage resources in {{ yandex-cloud }}.

## Getting started {#before-begin}

1. Authenticate in the CLI as a [user](user.md) or a [federated user](federated-user.md).
1. If you do not have a service account yet, [create one](../../../iam/operations/sa/create.md) and [configure access permissions for it](../../../iam/operations/sa/assign-role-for-sa.md).

## Perform actions on behalf of a service account using impersonation {#use-impersonation}

{% include [impersonation-role-notice](../../../_includes/cli/impersonation-role-notice.md) %}

To perform an action on behalf of a service account:

1. {% include [list-sas](../../../_includes/cli/list-sas.md) %}
1. When running {{ yandex-cloud }} CLI commands, use [impersonation](../../../iam/concepts/access-control/index.md#impersonation) of your service account by specifying its ID in the `--impersonate-service-account-id` parameter.

    For example, to create a [bucket](../../../storage/concepts/bucket.md) named `my-sample-bucket` in the default folder on behalf of a service account, run this command:

    ```bash
    yc storage bucket create \
      --name my-sample-bucket \
      --impersonate-service-account-id <service_account_ID>
    ```

Some commands require that you specify unique IDs for your cloud and folder. You can run such commands with the `--cloud-id` and `--folder-id` parameters.

## Get authenticated on behalf of a service account using an authorized key {#auth-as-sa}

{% include [auth-as-sa](../../../_includes/cli/auth-as-sa.md) %}

## Authenticate as a service account from inside a VM {#vm-auth-as-sa}

{% include [vm-auth-as-sa](../../../_includes/cli/vm-auth-as-sa.md) %}


Read more about working with {{ yandex-cloud }} from a VM in [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).


#### See also

- [{#T}](../../concepts/index.md#manage-properties).
- [{#T}](../profile/profile-create.md).
- [{#T}](../profile/profile-activate.md).
- [{#T}](../profile/manage-properties.md).
- [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).

