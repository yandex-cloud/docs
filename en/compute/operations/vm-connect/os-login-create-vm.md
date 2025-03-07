---
title: How to create a VM with {{ oslogin }}
description: Follow this guide to create a VM that can be accessed via {{ oslogin }}.
---

# Creating a VM with {{ oslogin }}

With [{{ oslogin }}](../../../organization/concepts/os-login.md), you can provide users and [service accounts](../../../iam/concepts/users/service-accounts.md) access to [VMs](../../../compute/concepts/vm.md#project) relying solely on the [{{ iam-full-name }}](../../../iam/concepts/index.md) mechanisms. There is no need to upload SSH keys to each new VM when creating it.

{% include [os-login-enablement-notice](../../../_includes/compute/os-login-enablement-notice.md) %}

{% include [os-login-roles-needed-for-vm-access](../../../_includes/organization/os-login-roles-needed-for-vm-access.md) %}

You can use either the [YC CLI](os-login.md#connect-with-yc-cli) or a [standard SSH client](os-login.md#connect-with-ssh-client) to connect to VMs with {{ oslogin }} access enabled. To connect, you can use an SSH certificate or SSH key, which you first need to [add](../../../organization/operations/add-ssh.md) to the {{ oslogin }} profile of a {{ org-full-name }} user or service account.

{% note info %}

We recommend creating a local user on the new VM and providing a separate SSH key for that user: this way you will still be able to [connect to the VM via SSH](./ssh.md#vm-connect) even if you disable the {{ oslogin }} access for it. You can create a local user and provide an SSH key for them using [metadata](../../concepts/vm-metadata.md#how-to-send-metadata):

{% include [metadata-keys](../../../_includes/compute/metadata-keys.md) %}

{% endnote %}

To create a VM with {{ oslogin }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. Enable [access via {{ oslogin }}](../../../organization/operations/os-login-access.md) at the organization level.

  1. [Create a VM](../images-with-pre-installed-software/create.md) from a pre-built image with {{ oslogin }} access support. Such images are available on [{{ marketplace-full-name }}](/marketplace).
  
     When creating a VM, select **{{ ui-key.yacloud.compute.instance.access-method.field_os-login-access-method }}** under **{{ ui-key.yacloud.compute.instances.create.section_access }}**. If this option is not available, the selected image does not support {{ oslogin }} access.
  
     To be able to [connect](./ssh.md#vm-connect) to the VM via SSH without {{ oslogin }}, [update](../vm-control/vm-update.md) the VM settings and select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** under **{{ ui-key.yacloud.compute.instances.create.section_access }}**.

- CLI {#cli}

  1. Enable [access via {{ oslogin }}](../../../organization/operations/os-login-access.md) at the organization level.

  1. [Create a VM](../images-with-pre-installed-software/create.md) from a pre-built image with {{ oslogin }} access support.
  
     When creating a VM, specify this parameter for access via {{ oslogin }}:

     ```bash
     --metadata enable-oslogin=true
     ```

- {{ TF }} {#tf}

  1. Enable [access via {{ oslogin }}](../../../organization/operations/os-login-access.md) at the organization level.

  1. [Create a VM](../images-with-pre-installed-software/create.md) from a pre-built image with {{ oslogin }} access support.
  
     When creating a VM for the `yandex_compute_instance` resource, specify the following parameter in the `metadata` parameter section to enable access via {{ oslogin }}:

     ```hcl
     metadata = {
       enable-oslogin = true
     }
     ```

- API {#api}

  1. Enable [access via {{ oslogin }}](../../../organization/operations/os-login-access.md) at the organization level.

  1. [Create a VM](../vm-create/create-linux-vm.md) using the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/) resource from a public image with {{ oslogin }} access support:

     When creating the VM, provide `enable-oslogin=true` in the `metadata` field.

{% endlist %}

After the created VM changes its status to `Running`, you will be able to [connect](./os-login.md) to it via {{ oslogin }}.
