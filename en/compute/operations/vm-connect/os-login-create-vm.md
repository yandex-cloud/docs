---
title: How to create a VM with OS Login
description: Follow this guide to create a VM that can be accessed via OS Login.
---

# Creating a VM with OS Login

[OS Login](../../../organization/concepts/os-login.md) is used to provide users and service accounts with SSH access to VMs via SSH using {{ iam-short-name }}. To grant access to a VM that supports OS Login at the OS level, [assign](../../../iam/operations/roles/grant.md) the following roles to a user:

{% include [os-login-roles-needed-for-vm-access](../../../_includes/organization/os-login-roles-needed-for-vm-access.md) %}

You can use either the [YC CLI](os-login.md#connect-with-yc-cli) or a [standard SSH client](os-login.md#connect-with-ssh-client) to connect to VMs with enabled OS Login access. For connection, you can use an SSH certificate or SSH key, which you first need to [add](../../../organization/operations/add-ssh.md) to the OS Login profile of a {{ org-full-name }} user or service account.

However, we recommend creating a local user on the new VM and providing a separate SSH key for that user: this way, you will be able to [connect to the VM over SSH](./ssh.md#vm-connect) even if you disable OS Login access for it. You can create a local user and provide an SSH key for them using [metadata](../../concepts/vm-metadata.md#how-to-send-metadata):

{% include [metadata-keys](../../../_includes/compute/metadata-keys.md) %}

To create a VM with OS Login:

{% list tabs group=instructions %}

- Management console {#console}

  1. Enable [access via OS Login](../../../organization/operations/os-login-access.md) at the organization level.

  1. [Create a VM](../images-with-pre-installed-software/create.md) from the prepared image supporting access via OS Login. These images are available on [{{ marketplace-full-name }}](/marketplace).

     When creating the VM, under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, enable **Access via OS Login**.

     To be able to [connect](./ssh.md#vm-connect) to the VM over SSH without OS Login, [update](../vm-control/vm-update.md) the VM settings by disabling this option.

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

     When creating the VM, provide the `enable-oslogin=true` pair in the `metadata` field.

{% endlist %}

After the created VM changes its status to `Running`, you will be able to [connect](./os-login.md) to it via OS Login.