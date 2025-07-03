---
title: Simple Linux VM creation
description: To quickstart with {{ compute-name }}, create a Linux VM using a simple form in the {{ yandex-cloud }} management console. You can access a Linux VM over SSH using the console or PuTTY. To connect to a Linux VM, specify its public address.
keywords:
  - vm simple creation
  - linux
  - linux vm
  - linux instance
  - linux virtual machine
  - virtual machine
  - vm
---

# Simple Linux VM creation

To quickstart with {{ compute-name }}, create a Linux [VM](../concepts/vm.md) using a simple form in the {{ yandex-cloud }} management console. After the VM starts, you can connect to it over SSH.

{% note tip %}

This simple form allows you to create a VM with basic settings. To configure advanced VM settings, see [{#T}](quick-create-linux.md).

{% endnote %}

## Getting started {#before-you-begin}

{% include [before-you-begin-linux](../../_includes/compute/before-you-begin-linux.md) %}

## Create a VM {#create-vm}

1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
1. Select **{{ ui-key.yacloud.compute.instances.create.option_create-form-simple-title }}**.

    {% include [console-default-variant](../../_includes/compute/console-default-variant.md) %}

1. Under **{{ ui-key.yacloud.compute.instances.create.section_simple-image }}**, select an [image](../concepts/image.md) and a Linux-based OS version.

    To see the list of all available images, click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select one of the preset configurations or create a custom one. To create a custom configuration:
    * Select ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.yacloud.component.compute.resources.option_resources-custom-config }}**.
    * Specify the required number of vCPUs, [guaranteed vCPU share](../concepts/performance-levels.md), and amount of RAM.
    * Make your VM [preemptible](../concepts/preemptible-vm.md), if required.
1. Optionally, configure the boot [disk](../concepts/disk.md) under **{{ ui-key.yacloud.compute.instances.create.section_disks }}**:
    * Select the [disk type](../concepts/disk.md#disks_types).
    * Specify the required disk size.
1. Optionally, add a secondary disk:
    * Under **{{ ui-key.yacloud.compute.instances.create.section_disks }}**, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.
    * Select the [disk type](../concepts/disk.md#disks_types).
    * Specify the required disk size.
1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**:
    * In the **{{ ui-key.yacloud.compute.instances.create.field_instance-name }}** field, specify the VM name.

      {% include [name-format](../../_includes/name-format.md) %}

    * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter the username.

      {% note alert %}

      Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.

      {% endnote %}

    * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

      {% include [vm-connect-linux](../../_includes/vm-connect-linux.md) %}

    * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select an IP address assignment method:
      * `{{ ui-key.yacloud.component.compute.network-select.switch_dynamic }}`: To assign a random IP address from the {{ yandex-cloud }} IP address pool.

        Stopping a VM releases its dynamic IP address. When you start the VM again, it will get a new public IP address. If you reboot a VM, it retains its dynamic public IP address.

      * `{{ ui-key.yacloud.component.compute.network-select.switch_static }}`: To select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../vpc/operations/set-static-ip.md).

1. Expand the **{{ ui-key.yacloud.compute.instances.create.section_predefined }}** section and view the default VM parameters.

    To customize these parameters, see the tutorial for [advanced VM creation](quick-create-linux.md).

1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

The VM will appear in the list. The new VM will get an [IP address](../../vpc/concepts/address.md) and a [host name](../../vpc/concepts/address.md#fqdn) (FQDN).

## Connect to the VM {#connect-to-vm}

{% include notitle [vm-connect-ssh](../operations/vm-connect/ssh.md#vm-connect) %}

## Delete the VM {#delete-vm}

If you no longer plan to use the VM, [delete it](../operations/vm-control/vm-delete.md).

## What's next {#what-is-next}

* [{#T}](quick-create-linux.md)
* [{#T}](../concepts/index.md)
* [{#T}](../operations/index.md)