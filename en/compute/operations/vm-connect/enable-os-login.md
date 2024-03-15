---
title: "How to set up OS Login access on an existing VM"
description: "Follow this guide to set up access to an existing VM via OS Login."
---

# Setting up OS Login access on an existing VM

If you need to set up a connection to a deployed VM via OS Login, you can install the OS Login agent on the VM yourself.

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

You can now [connect](./os-login.md) to the VM via OS Login. This disables [connections to the VM over SSH](./ssh.md#vm-connect).

To be able to connect to the VM over SSH again, disable OS Login access for the VM. To do this, [update](../vm-control/vm-update.md) the VM settings by disabling the **{{ ui-key.yacloud.compute.instances.create.field_os-login-access-method }}** option.