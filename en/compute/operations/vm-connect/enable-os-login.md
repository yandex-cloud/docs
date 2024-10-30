---
title: How to set up OS Login access on an existing VM
description: Follow this guide to set up access to an existing VM via OS Login.
---

# Setting up OS Login access on an existing VM

If you need to set up a connection to a deployed VM via OS Login, you can install the OS Login agent on the VM yourself.

## Enabling access via OS Login {#enable-os-login}

To set up OS Login access to an existing VM:

1. Enable [access via OS Login](../../../organization/operations/os-login-access.md) at the organization level.

1. [Connect](./ssh.md#vm-connect) to the VM over SSH.

1. Install the OS Login agent on the VM. Depending on the VM's OS, run one of the following commands:

    {% list tabs %}

    - Ubuntu 22.04

      ```bash
      curl https://{{ s3-storage-host }}/oslogin-configs/ubuntu-22.04/config_oslogin.sh | bash
      ```

    - Ubuntu 20.04

      ```bash
      curl https://{{ s3-storage-host }}/oslogin-configs/ubuntu-20.04/config_oslogin.sh | bash
      ```

    - Ubuntu 18.04

      ```bash
      curl https://{{ s3-storage-host }}/oslogin-configs/ubuntu-18.04/config_oslogin.sh | bash
      ```

    - CentOS 7

      ```bash
      curl https://{{ s3-storage-host }}/oslogin-configs/centos-7/config_oslogin.sh | bash
      ```

    - Debian 11

      ```bash
      curl https://{{ s3-storage-host }}/oslogin-configs/debian-11/config_oslogin.sh | bash
      ```

    {% endlist %}

1. [Enable](../vm-control/vm-update.md#enable-oslogin-access) access via OS Login on the VM.

You can now connect to the VM via OS Login using either the [YC CLI](os-login.md#connect-with-yc-cli) or a [standard SSH client](os-login.md#connect-with-ssh-client). For connection, you can use an SSH certificate or SSH key, which you first need to [add](../../../organization/operations/add-ssh.md) to the OS Login profile of a {{ org-full-name }} user or service account.

## Disabling access via OS Login {#disable-os-login}

To enable access without OS Login, the VM must contain the public part of the SSH key. If the VM was [created](../../../compute/operations/vm-create/create-linux-vm.md) without an SSH key or the key was lost, [add](../../../compute/operations/vm-connect/recovery-access.md#ssh-recovery) the key and user manually before disabling OS Login access.

To be able to [connect](ssh.md) to the VM over SSH without using OS Login:

1. Disable access via OS Login.

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select the folder the VM belongs to.
        1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
        1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}** and click the name of the VM.
        1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.compute.instance.overview.button_action-edit }}**.
        1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, enable **Access via OS Login**.
        1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

    - CLI {#cli}

      Run this command:

      ```bash
      yc compute instance update --name <VM_name> \
      --folder-id <folder_ID> \
      --metadata enable-oslogin=false
      ```

      Make sure OS Login access is disabled:

      ```bash
      yc compute ssh --name <VM_name> --folder-id <folder_ID>
      ```

      Result:

      ```text
      ...
      username@12.345.***.***: Permission denied (publickey).
      ...
      ```

    {% endlist %}

1. [Connect](./ssh.md#vm-connect) to the VM over SSH.

1. Run the following command to delete OS Login packets:

    {% list tabs %}

    - Linux {#linux}

      ```bash
      curl https://storage.yandexcloud.net/oslogin-configs/common/remove_oslogin.sh | bash
      ```

      When deleting, you will be prompted to confirm the deletion of the `cron` and `unscd` packets. To confirm, type `y` and press **Enter**.

    {% endlist %}