---
title: How to reset the root user password on a {{ baremetal-full-name }} server
description: Follow this guide to reset the password on a {{ baremetal-name }} server with the help of a Rescue CD boot image.
---

# Resetting the root user password on a server

The root user password is generated when [leasing](./server-lease.md) a {{ baremetal-name }} server. You must save this password because you cannot view or restore it after the server starts.

If you have lost your {{ baremetal-name }} server root user password, you can create a new one. Depending on the situation, you can do it in different ways.

{% include [kvm-paste-tip](../../../_includes/baremetal/kvm-paste-tip.md) %}

{% list tabs %}

- If you still can access the server with your SSH key

  If you still can connect to the server as the root user using the SSH key specified when leasing the server, you can change the root user password without Rescue CD:

  1. Connect to the server over SSH:

      ```bash
      ssh root@<server_public_IP_address>
      ```
  1. {% include [reset-root-password](../../../_includes/baremetal/instruction-steps/reset-root-password.md) %}

- If you have no access to the server

  If you are unable to connect to the server using the SSH key specified when leasing the server, recover the root user password with the help of the Rescue CD boot image. Proceed in the [KVM console](./server-kvm.md).

  To change the root user password or other {{ baremetal-name }} server settings:

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