---
title: "How to create a VM with OS Login"
description: "Follow this guide to create a VM that can be accessed via OS Login."
---

# Creating a VM with OS Login

[OS Login](../../../organization/concepts/os-login.md) is used to provide users with SSH access to VMs through {{ iam-short-name }}. To grant access to a VM that supports OS Login at the OS level, [assign](../../../iam/operations/roles/grant.md) a user the `compute.osLogin` or `compute.osAdminLogin` role.

Please note that you cannot use an [SSH key pair](./ssh.md#creating-ssh-keys) to connect to VMs with OS Login access enabled. However, we recommend specifying SSH keys when creating a VM: this way, you can [connect to a VM over SSH](./ssh.md#vm-connect) if you disable OS Login access for it. You can provide SSH keys to a VM using [metadata](../../concepts/vm-metadata.md).

1. Enable [access via OS Login](../../../organization/operations/os-login-access.md) at the organization level.

1. [Create a VM](../images-with-pre-installed-software/create.md) from the prepared image with access via OS Login These images are available on [{{ marketplace-full-name }}](/marketplace) and contain `OS Login` in their names.

   Enable **{{ ui-key.yacloud.compute.instances.create.field_os-login-access-method }}** when creating a VM.

After the created VM's status changes to `Running`, you will be able to [connect](./os-login.md) to it via OS Login.

To be able to connect to the created VM over SSH, disable OS Login access for it. To do this, [update](../vm-control/vm-update.md) the VM settings by disabling the **{{ ui-key.yacloud.compute.instances.create.field_os-login-access-method }}** option.