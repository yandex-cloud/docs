---
title: How to create a VM with {{ oslogin }}
description: Follow this guide to create a VM that can be accessed via {{ oslogin }}.
---

# Create a virtual machine with {{ oslogin }}

[{{ oslogin }}](../../../organization/concepts/os-login.md) is used to provide users and service accounts with SSH access to VMs using {{ iam-short-name }}. To grant access to a VM that supports {{ oslogin }} at the OS level, [assign](../../../iam/operations/roles/grant.md) the following roles to a user:

{% include [os-login-roles-needed-for-vm-access](../../../_includes/organization/os-login-roles-needed-for-vm-access.md) %}

You can use either the [YC CLI](os-login.md#connect-with-yc-cli) or a [standard SSH client](os-login.md#connect-with-ssh-client) to connect to VMs with enabled {{ oslogin }} access. For connection, you can use an SSH certificate or SSH key, which you first need to [add](../../../organization/operations/add-ssh.md) to the {{ oslogin }} profile of a {{ org-full-name }} user or service account.

The recommended way is to create a local user on the new VM and provide a separate SSH key for that user: thus you will still be able to [connect to the VM over SSH](./ssh.md#vm-connect) if you disable {{ oslogin }} access for it. You can create a local user and provide an SSH key for them using [metadata](../../concepts/vm-metadata.md#how-to-send-metadata):

{% include [metadata-keys](../../../_includes/compute/os-login-enablement-notice.md) %}

{% include [metadata-keys](../../../_includes/compute/metadata-keys.md) %}

To create a VM with {{ oslogin }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. Enable [access via {{ oslogin }}](../../../organization/operations/os-login-access.md) at the organization level.

  1. [Create a VM](../images-with-pre-installed-software/create.md) from a ready-made image with {{ oslogin }} access support. Such images are available on [{{ marketplace-full-name }}](/marketplace).
  
     When creating the VM, under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, enable **Access via OS Login**. That option would not be available if the selected image does not support {{ oslogin }} access.
  
     To be able to [connect](./ssh.md#vm-connect) to the VM over SSH without {{ oslogin }}, [update](../vm-control/vm-update.md) the VM settings by disabling this option.

- CLI {#cli}

  1. Enable [access via {{ oslogin }}](../../../organization/operations/os-login-access.md) at the organization level.

  1. [Create a VM](../images-with-pre-installed-software/create.md) from a ready-made image with {{ oslogin }} access support.
  
     When creating a VM, add a flag to enable access via {{ oslogin }}:

     ```bash
     --metadata enable-oslogin=true
     ```

- API {#api}

  1. Enable [access via {{ oslogin }}](../../../organization/operations/os-login-access.md) at the organization level.

  1. [Create a VM](../vm-create/create-linux-vm.md) using the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/) resource from a public image with {{ oslogin }} access support:

     When creating the VM, provide the `enable-oslogin=true` pair in the `metadata` field.

{% endlist %}

After the created VM changes its status to `Running`, you will be able to [connect](./os-login.md) to it via {{ oslogin }}.