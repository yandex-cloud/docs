---
title: Adding a new user SSH key
description: Follow this guide to add a new Linux user SSH key to the {{ baremetal-name }} server using a Rescue CD boot image.
---

# Adding a new user SSH key

The public SSH key of the root user is added when you [lease](./server-lease.md) a {{ baremetal-name }} server. To connect to the server over SSH, the user needs the private part of the SSH key.

If you have lost the private part of the SSH key you specified when leasing the server, you can add a new public SSH key to the root user profile.

## Create a new SSH key pair {#create-new-key}

Before you add a key to the {{ baremetal-name }} server, create a new SSH key pair on your local computer for the root user to access the server over SSH:

{% include [vm-ssh-prepare-key](../../../_includes/vm-ssh-prepare-key.md) %}

## Add a new key to the root user profile {#add-the-new-key}

Depending on the situation, you can use several methods for adding a new SSH key.

{% include [kvm-paste-tip](../../../_includes/baremetal/kvm-paste-tip.md) %}

{% list tabs %}

- If you still can access the server with your password

  If you still can connect to the server as a root user with the password generated when leasing the server, you can add a new public SSH key without Rescue CD:

  1. [Connect](./server-kvm.md) to the {{ baremetal-name }} server's KVM console.
  1. Authenticate as a root user in the KVM console terminal:

      * When prompted for username , type `root` and press **ENTER**:

          ```bash
          my-server login: root
          ```
      * In the `Password:` row, enter the root user's password generated when leasing the server.
  1. {% include [reset-authorized-keys1](../../../_includes/baremetal/instruction-steps/reset-authorized-keys1.md) %}
  1. {% include [reset-authorized-keys2](../../../_includes/baremetal/instruction-steps/reset-authorized-keys2.md) %}
  1. Log out of the root user profile in the KVM console:

      ```bash
      logout
      ```
  1. {% include [reset-authorized-keys3](../../../_includes/baremetal/instruction-steps/reset-authorized-keys3.md) %}

- If you have no access to the server

  If you cannot connect to the server as a root user with the password generated when leasing the server, you can add a new public SSH key using the Rescue CD boot image. Proceed in the [KVM console](./server-kvm.md).

  To add a new SSH key of the root user or to change other {{ baremetal-name }} server settings:

  1. {% include [rescue-chroot-to-server-fs1](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs1.md) %}
  1. {% include [rescue-chroot-to-server-fs2](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs2.md) %}
  1. {% include [rescue-chroot-to-server-fs3](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs3.md) %}
  1. {% include [rescue-chroot-to-server-fs4](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs4.md) %}
  1. {% include [reset-authorized-keys1](../../../_includes/baremetal/instruction-steps/reset-authorized-keys1.md) %}
  1. {% include [reset-authorized-keys2](../../../_includes/baremetal/instruction-steps/reset-authorized-keys2.md) %}
  1. {% include [rescue-chroot-to-server-fs5](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs5.md) %}
  1. {% include [rescue-chroot-to-server-fs6](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs6.md) %}
  1. {% include [disconnect-kvm-cd](../../../_includes/baremetal/disconnect-kvm-cd.md) %}
  1. {% include [rescue-chroot-to-server-fs7](../../../_includes/baremetal/instruction-steps/rescue-chroot-to-server-fs7.md) %}
  1. {% include [reset-authorized-keys3](../../../_includes/baremetal/instruction-steps/reset-authorized-keys3.md) %}

{% endlist %}

#### See also {#see-also}

* [{#T}](./rescue-boot.md)
* [{#T}](./reset-password.md)
* [{#T}](./restore-grub.md)
* [{#T}](./switch-raid-member.md)