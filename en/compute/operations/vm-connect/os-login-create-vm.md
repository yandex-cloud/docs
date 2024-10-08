---
title: How to create a VM with OS Login
description: Follow this guide to create a VM that can be accessed via OS Login.
---

# Creating a VM with OS Login

[OS Login](../../../organization/concepts/os-login.md) is used to provide users with SSH access to VMs through {{ iam-short-name }}. To grant access to a VM that supports OS Login at the OS level, [assign](../../../iam/operations/roles/grant.md) a user the `compute.osLogin` or `compute.osAdminLogin` role.

You can connect to a VM with OS Login access enabled using an SSH certificate [over the YC CLI](os-login.md#connect-via-cli) or a [standard SSH client](os-login.md#connect-via-exported-certificate), as well as over the YC CLI [using an SSH key](os-login.md#connect-via-key) previously added to the organization user profile in {{ org-full-name }}.

However, we recommend specifying SSH keys when creating a VM: this way, you can [connect to a VM over SSH](./ssh.md#vm-connect) if you disable OS Login access for it. You can provide SSH keys to a VM using [metadata](../../concepts/vm-metadata.md#how-to-send-metadata).

{% include [metadata-keys](../../../_includes/compute/metadata-keys.md) %}

To create a VM with OS Login:

{% list tabs group=instructions %}

- Management console {#console}

   1. Enable [access via OS Login](../../../organization/operations/os-login-access.md) at the organization level.

   1. [Create a VM](../images-with-pre-installed-software/create.md) from the prepared image supporting access via OS Login. These images are available on [{{ marketplace-full-name }}](/marketplace) and contain `OS Login` in their names.

      Enable **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}** when creating a VM.

      To be able to [connect](./ssh.md#vm-connect) to the VM over SSH without using OS Login, [update](../vm-control/vm-update.md) the VM settings by disabling **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}**.

- CLI {#cli}

   1. Enable [access via OS Login](../../../organization/operations/os-login-access.md) at the organization level.

   1. [Create a VM](../images-with-pre-installed-software/create.md) from the prepared image supporting access via OS Login.

      When creating a VM, add a flag to enable access via OS Login:

      ```bash
      --metadata enable-oslogin=true
      ```

- API {#api}

   1. Enable [access via OS Login](../../../organization/operations/os-login-access.md) at the organization level.

   1. [Create a VM](../vm-create/create-linux-vm.md) using the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/) resource from a public image with OS Login access support:

      When creating a VM, provide the `enable-oslogin=true` pair in the `metadata` field.

{% endlist %}

After the created VM changes its status to `Running`, you will be able to [connect](./os-login.md) to it via OS Login.