---
title: How to authenticate in the {{ yandex-cloud }} CLI as a service account
description: Follow this guide to get authenticated in the {{ yandex-cloud }} CLI as a service account.
---

# Authenticating in the {{ yandex-cloud }} CLI as a service account

{% note info %}

When performing actions on behalf of a service account, ensure that it has the required [roles](../../../iam/concepts/access-control/roles.md) [assigned](../../../iam/operations/sa/assign-role-for-sa.md) to it.

{% endnote %}

{% note warning %}

Creating service accounts and their [keys](../../../iam/concepts/users/service-accounts.md#sa-key) may be prohibited by [access policies](../../../iam/concepts/access-control/access-policies.md) at the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder), [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud), or [organization](../../../organization/concepts/organization.md) level.

{% endnote %}

Learn how to get authenticated in the {{ yandex-cloud }} CLI:

* [As a service account using impersonation](#use-impersonation)

  {% include [cli-sa-impersonate-intro](../../../_includes/cli/cli-sa-impersonate-intro.md) %}

* [As a service account using an authorized key](#auth-as-sa)

  {% include [cli-sa-key-intro](../../../_includes/cli/cli-sa-key-intro.md) %}

* [As a service account from inside a VM](#vm-auth-as-sa)

  {% include [cli-sa-vm-intro](../../../_includes/cli/cli-sa-vm-intro.md) %}


[Service accounts](../../../iam/concepts/users/service-accounts.md) are different from [Yandex user accounts](../../../iam/concepts/users/accounts.md#passport), [federated user accounts](../../../iam/concepts/federations.md), or [local user accounts](../../../iam/concepts/users/accounts.md#local). You cannot use a service account to log in to the [management console]({{ link-console-main }}) but you can use them to manage {{ yandex-cloud }} resources via the CLI, {{ TF }}, and API.


## Getting started {#before-begin}

If you do not have a service account yet, [create one](../../../iam/operations/sa/create.md) and [configure access permissions for it](../../../iam/operations/sa/assign-role-for-sa.md).


{% note tip %}

{% include [cli-proxy-setup](../../../_includes/cli/cli-proxy-setup.md) %}

{% endnote %}


## Perform actions as a service account using impersonation {#use-impersonation}

{% include [cli-sa-impersonate-intro](../../../_includes/cli/cli-sa-impersonate-intro.md) %}

{% include [impersonation-role-notice](../../../_includes/cli/impersonation-role-notice.md) %}

To perform an action on behalf of a service account:
1. [Install the CLI](../install-cli.md).
1. Authenticate in the CLI as a [Yandex user](user.md), [federated user](federated-user.md), or [local user](local-user.md).
1. {% include [list-sas](../../../_includes/cli/list-sas.md) %}
1. When running {{ yandex-cloud }} CLI commands, use [impersonation](../../../iam/concepts/access-control/impersonation.md) of your service account by specifying its ID in the `--impersonate-service-account-id` parameter.

    For example, to create a [bucket](../../../storage/concepts/bucket.md) named `my-sample-bucket` in the default folder on behalf of a service account, run this command:

    ```bash
    yc storage bucket create \
      --name my-sample-bucket \
      --impersonate-service-account-id <service_account_ID>
    ```

    Where `--impersonate-service-account-id` is the service account ID you got earlier.

Some commands require that you specify unique IDs for your cloud and folder. You can run such commands with the `--cloud-id` and `--folder-id` parameters.

## Get authenticated as a service account using an authorized key {#auth-as-sa}

{% include [cli-sa-key-intro](../../../_includes/cli/cli-sa-key-intro.md) %}

1. [Install the CLI](../install-cli.md).
1. Authenticate in the CLI as a [Yandex user](user.md), [federated user](federated-user.md), or [local user](local-user.md).

    {% note warning %}

    To get authenticated in the CLI with a Yandex account, federated account, or local user account, you need a browser and a GUI.

    To use a service account on a server without a GUI, first complete the preparation steps on a device with a GUI and a browser.

    {% endnote %}

1. Create an authorized key and use it to get authenticated in the CLI:

    {% include [auth-as-sa](../../../_includes/cli/auth-as-sa.md) %}

## Authenticate as a service account from inside a VM {#vm-auth-as-sa}

{% include [cli-sa-vm-intro](../../../_includes/cli/cli-sa-vm-intro.md) %}

{% include [vm-auth-as-sa](../../../_includes/cli/vm-auth-as-sa.md) %}


Read more about working with {{ yandex-cloud }} from a VM in [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).


#### Useful links {#see-also}

- [{#T}](../../concepts/index.md#manage-properties).
- [{#T}](../profile/profile-create.md).
- [{#T}](../profile/profile-activate.md).
- [{#T}](../profile/manage-properties.md).
- [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).

