---
title: Adding a new SSH key for a user
description: In this tutorial, you will learn how to add a new SSH key for a Linux user on the {{ baremetal-name }} server using a Rescue CD boot image.
---

# Adding a new SSH key for a user

When you [lease](./server-lease.md) a {{ baremetal-name }} server, the root user’s public SSH key is preconfigured. To connect to the server over SSH, you need a private key corresponding to the authorized public key.

If you lose your private SSH key specified when leasing the server, you can add a new public SSH key to the root user account.

## Create a new SSH key pair {#create-new-key}

Generate a new SSH key pair locally before adding the public key to the {{ baremetal-name }} server to enable root access over SSH:

{% include [vm-ssh-prepare-key](../../../_includes/vm-ssh-prepare-key.md) %}

## Add a new key to the root user account {#add-the-new-key}

You can use the following methods for adding a new SSH key.

{% include [kvm-paste-tip](../../../_includes/baremetal/kvm-paste-tip.md) %}

{% list tabs %}

- If you still can log in to the server using your password

  If you can connect to the server as root with the password generated when leasing the server, you can add a new public SSH key without using a Rescue CD:

  1. [Connect](./server-kvm.md) to the {{ baremetal-name }} server’s KVM console.
  1. Authenticate as root in the KVM console:

      * When prompted for username, type `root` and press **ENTER**:

          ```bash
          my-server login: root
          ```
      * In the `Password:` prompt that appears, enter the root password generated when leasing the server.
  1. {% include [reset-authorized-keys1](../../../_includes/baremetal/instruction-steps/reset-authorized-keys1.md) %}
  1. {% include [reset-authorized-keys2](../../../_includes/baremetal/instruction-steps/reset-authorized-keys2.md) %}
  1. Log out from the root session in the KVM console:

      ```bash
      logout
      ```
  1. {% include [reset-authorized-keys3](../../../_includes/baremetal/instruction-steps/reset-authorized-keys3.md) %}

- If you have no server access

  If you can no longer authenticate as root with the password generated when leasing the server, you can add a new public SSH key using the Rescue CD boot image. Proceed with the following steps in the [KVM console](./server-kvm.md).

  To add a new SSH key for root or modify {{ baremetal-name }} server settings:

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