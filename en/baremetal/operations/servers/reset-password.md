---
title: How to reset the root password on a {{ baremetal-full-name }} server
description: In this tutorial, you will learn how to reset the root password on a {{ baremetal-name }} server using the Rescue CD boot image.
---

# Resetting the server root password

The system automatically generates a root password during {{ baremetal-name }} server [provisioning](./server-lease.md). You must save this password, as it will become inaccessible after server initialization.

If you have lost your {{ baremetal-name }} server root password, you can create a new one. The recovery method depends on your access level.

{% include [kvm-paste-tip](../../../_includes/baremetal/kvm-paste-tip.md) %}

{% list tabs %}

- If you still have SSH key access to the server

  If you still have root SSH access via the key specified during server setup, you can reset the root password without using Rescue CD:

  1. Connect to the server over SSH:

      ```bash
      ssh root@<server_public_IP_address>
      ```
  1. {% include [reset-root-password](../../../_includes/baremetal/instruction-steps/reset-root-password.md) %}

- If you do not have access to the server

  If you do not have root SSH access to the server, reset the root password using the Rescue CD boot image: Proceed with the following steps in the [KVM console](./server-kvm.md).

  To reset the root password or change other {{ baremetal-name }} server settings:

  1. {% include [rescue-chroot-to-server-fs1](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs1.md) %}
  1. {% include [rescue-chroot-to-server-fs2](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs2.md) %}
  1. {% include [rescue-chroot-to-server-fs3](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs3.md) %}
  1. {% include [rescue-chroot-to-server-fs4](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs4.md) %}
  1. {% include [reset-root-password](../../../_includes/baremetal/instruction-steps/reset-root-password.md) %}
  1. {% include [rescue-chroot-to-server-fs5](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs5.md) %}
  1. {% include [rescue-chroot-to-server-fs6](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs6.md) %}
  1. {% include [disconnect-kvm-cd](../../../_includes/baremetal/disconnect-kvm-cd.md) %}
  1. {% include [rescue-chroot-to-server-fs7](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs7.md) %}

{% endlist %}

#### See also {#see-also}

* [{#T}](./rescue-boot.md)
* [{#T}](./add-new-ssh-key.md)
* [{#T}](./restore-grub.md)
* [{#T}](./switch-raid-member.md)