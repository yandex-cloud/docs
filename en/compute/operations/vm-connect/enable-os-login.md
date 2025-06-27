---
title: Configuring {{ oslogin }} access on an existing VM
description: Follow this guide to configure access to an existing VM via {{ oslogin }}.
---


# Configuring {{ oslogin }} access on an existing VM

To configure {{ oslogin }} access for an already deployed VM, you can manually install the {{ oslogin }} agent.


## Enabling access via {{ oslogin }} {#enable-os-login}

{% include [metadata-keys](../../../_includes/compute/os-login-enablement-notice.md) %}

To configure {{ oslogin }} access for an existing VM:

1. Enable [access via {{ oslogin }}](../../../organization/operations/os-login-access.md) at the organization level.

1. [Connect](./ssh.md#vm-connect) to the VM over SSH.

1. Install the {{ oslogin }} agent on the VM. Run the command below based on the VM OS:

    {% note info %}

    The [Ubuntu 24.04](/marketplace/products/yc/ubuntu-2404-lts-oslogin) public comes with the pre-installed {{ oslogin }} agent, so you do not need to install it manually.

    {% endnote %}

    {% list tabs %}

    - Ubuntu

      * Ubuntu 24.04

        ```bash
        curl {{ link-oslogin-configs }}/ubuntu-24.04/config_oslogin.sh | bash
        ```

      * Ubuntu 22.04

        ```bash
        curl {{ link-oslogin-configs }}/ubuntu-22.04/config_oslogin.sh | bash
        ```

      * Ubuntu 20.04

        ```bash
        curl {{ link-oslogin-configs }}/ubuntu-20.04/config_oslogin.sh | bash
        ```

      * Ubuntu 18.04

        ```bash
        curl {{ link-oslogin-configs }}/ubuntu-18.04/config_oslogin.sh | bash
        ```

    - CentOS 7

      ```bash
      curl {{ link-oslogin-configs }}/centos-7/config_oslogin.sh | bash
      ```

    - Debian 11

      ```bash
      curl {{ link-oslogin-configs }}/debian-11/config_oslogin.sh | bash
      ```

    - AlmaLinux 9

      ```bash
      curl {{ link-oslogin-configs }}/almalinux-9/config_oslogin.sh | bash
      ```

    {% endlist %}

1. [Enable](../vm-control/vm-update.md#enable-oslogin-access) access via {{ oslogin }} on the VM.

You can now connect to the VM via {{ oslogin }} using either the [YC CLI](os-login.md#connect-with-yc-cli) or a [standard SSH client](os-login.md#connect-with-ssh-client). To connect, you can use an SSH certificate or SSH key, which you first need to [add](../../../organization/operations/add-ssh.md) to the profile of a {{ org-full-name }} user or service account.


## Disabling access via {{ oslogin }} {#disable-os-login}

To access a VM without {{ oslogin }}, the VM must store the public part of the SSH key. If the VM was [created](../../../compute/operations/vm-create/create-linux-vm.md) without an SSH key or the key was lost, [add](../../../compute/operations/vm-connect/recovery-access.md#ssh-recovery) an SSH key and a local user to the VM manually before disabling {{ oslogin }} access.

To get back the ability to [connect](ssh.md) to the VM over SSH without using {{ oslogin }}:

1. Disable access via {{ oslogin }}.

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder this VM belongs to.
        1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
        1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** and click the name of the VM in question.
        1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}**.
        1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      yc compute instance update
        --name <VM_name> \
        --folder-id <catalog_ID> \
        --metadata enable-oslogin=false
      ```

      Make sure {{ oslogin }} access is now disabled:

      ```bash
      yc compute ssh
        --name <VM_name> \
        --folder-id <catalog_ID>
      ```

      Result:

      ```text
      ...
      username@12.345.***.***: Permission denied (publickey).
      ...
      ```

    {% endlist %}

1. [Connect](./ssh.md#vm-connect) to the VM over SSH.

1. Run the following command to delete {{ oslogin }} packets:

    {% list tabs %}

    - Linux {#linux}

      ```bash
      curl {{ link-oslogin-configs }}/common/remove_oslogin.sh | bash
      ```

      When deleting, you will be prompted to confirm the deletion of the `cron` and `unscd` packets. To confirm, type `y` and press **Enter**.

    {% endlist %}

{% note alert %}

{% include [sudo-and-oslogin](../../../_includes/compute/sudo-and-oslogin.md) %}

{% endnote %}