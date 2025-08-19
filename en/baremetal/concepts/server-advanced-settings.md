---
title: How to customize a {{ baremetal-full-name }} server
description: Follow this guide to customize your {{ baremetal-full-name }} server's hardware for a specific OS and tasks.
---

# Advanced server settings

{% include [bios-settings-warning](../../_includes/baremetal/bios-settings-warning.md) %}

To implement some use cases for your server, you may need to modify its default basic settings. For example, to [install](../operations/servers/reinstall-os-from-own-image.md) the [Windows Server](https://en.wikipedia.org/wiki/Windows_Server) OS onto a partition created in a fault-tolerant [RAID](https://en.wikipedia.org/wiki/RAID), you can [create](#creating-rst-raids) the RAID on the integrated controller of your server’s motherboard (if your server’s motherboard has an integrated RAID controller).

## Server disk space management {#storage-management}

When you lease a server with an OS [installed](../operations/servers/reinstall-os-from-marketplace.md) from a {{ marketplace-short-name }} image, one or more [software-based RAIDs](https://en.wikipedia.org/wiki/RAID#Software-based) of the [RAID 1](https://en.wikipedia.org/wiki/Standard_RAID_levels#RAID_1) and/or [RAID 10](https://en.wikipedia.org/wiki/Nested_RAID_levels#RAID_10) levels are created on the server’s disks depending on its default configuration. The number of arrays created by default depends on how many different disk types your server uses.

In the lease form for a server with a pre-installed OS, click **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}** to reconfigure its default RAIDs, repartition the disk space into software-based RAIDs, or opt out of their use.

{% note alert %}

The use of RAIDs ensures fault tolerance and may prevent data loss if one or more disks fail, depending on your RAID level. The exception is [RAID 0](https://en.wikipedia.org/wiki/Standard_RAID_levels#RAID_0), which provides no fault tolerance.

{% endnote %}

### Managing disk space when installing an OS from a custom image {#manual-storage-management}

When you lease a server without an OS, the server's disks are not arranged into RAIDs.

You can manually manage the server’s disk space when installing an OS from a custom image:
* Create software RAIDs during OS installation if this technology is supported at the OS [kernel](https://en.wikipedia.org/wiki/Kernel_(operating_system)) level (e.g., in [Linux](https://en.wikipedia.org/wiki/Linux) systems).

    Some operating systems and software products do not allow you to create software RAIDs during installation (e.g., [Microsoft Windows](https://en.wikipedia.org/wiki/Microsoft_Windows) or VMware [ESXi](https://en.wikipedia.org/wiki/VMware_ESXi)).

    The exact supported levels of software RAIDs may vary based on your selected OS.
* [Create](#creating-rst-raids) logical RAIDs before OS installation if your server's motherboard has integrated RAID controllers ([RST](https://en.wikipedia.org/wiki/Intel_Rapid_Storage_Technology) or `Fake-RAID`). For your OS to use such RAIDs, you may need to pre-install a driver for the integrated RAID controller.

    Some operating systems and software products do not support RAIDs created on fake-RAID controllers (e.g., VMware [ESXi](https://en.wikipedia.org/wiki/VMware_ESXi)).
* Opt out of using RAIDs and create [partitions](https://en.wikipedia.org/wiki/Disk_partitioning) directly on [HDDs](https://en.wikipedia.org/wiki/Hard_disk_drive), [SSDs](https://en.wikipedia.org/wiki/Solid-state_drive), or [NVMe](https://en.wikipedia.org/wiki/NVM_Express) disks.

    This option does not provide disk fault tolerance: if a disk fails, any data stored on that disk will be lost.

### Features of RAIDs created on integrated RAID controllers {#rst-raids}

Depending on the specific model, a {{ baremetal-name }} server's motherboard may have one or two integrated RAID controllers or none at all.

Here are the possible types of interated RAID controllers on server motherboards:
* SATA (Serial AT Attachment): Supports only the [SATA](https://en.wikipedia.org/wiki/SATA) interface.
* SCU (Storage Controller Unit): Supports the SATA and [SAS](https://en.wikipedia.org/wiki/Serial_Attached_SCSI) interfaces.

Integrated RAID controllers are implemented at the motherboard firmware level, emulating a block device with the basic bootloader functionality; full operation at the OS level requires installing a dedicated driver.

{% note warning %}

When installing Linux in legacy mode onto a RAID created using an integrated RAID controller, you may be unable to select the boot disk for starting the OS. To resolve this issue, exclude one physical disk from any RAIDs or [install](#install-os-uefi) the OS in UEFI mode.

{% endnote %}

#### Supported RAID levels {#supported-raid-levels}

You can use integrated RAID controllers to create RAIDs at the following levels:

* [RAID 0](https://en.wikipedia.org/wiki/Standard_RAID_levels#RAID_0): Striping. Such an array may consist of two to six disks. This RAID type improves the read and write speed but reduces fault tolerance: if any single disk in the array fails, your data will be lost.
* [RAID 1](https://en.wikipedia.org/wiki/Standard_RAID_levels#RAID_1): Mirroring. Such an array may consist of two disks. This RAID type does not improve the speed of reading or writing data but provides fault tolerance: you will not lose data if one of the disks fails.
* [RAID 5](https://en.wikipedia.org/wiki/Standard_RAID_levels#RAID_5): Striping with distributed parity. Such an array may consist of three to six disks. This RAID type improves the read speed and ensures fault tolerance: you will not lose data if one of the disks fails.

    {% note info %}

    In some motherboard models, the SCU RAID controller does not support creating RAID 5 arrays.

    {% endnote %}

* [RAID 10](https://en.wikipedia.org/wiki/Nested_RAID_levels#RAID_10): `RAID1` striping. Such an array may consist of 4 to 12 disks, and their total number must always be even. This RAID type improves both the read and write speed while providing fault tolerance: data will be lost only if both disks in a `RAID1` within the `RAID10` fail.

#### RAID creation limitations {#raid-array-limitations}

When using integrated RAID controllers to create RAIDs, the following limitations apply:

* You can create a maximum of two RAIDs on a single disk group.
* You can set the size only for the _first_ RAID you create on a disk group.

    The _second_ RAID created on the same disk group will use all the unallocated disk space left after the first RAID was created.
* The _second_ RAID you create using a certain disk must comprise exactly the same disks as the first array. 

    For example, if your first `RAID0` array contains three disks, `A`, `B`, and `C`, the second array you can create from these disks may be either another `RAID0` array or a `RAID5` array since only these two levels support three-disk configurations. You will not be able to create the second array made up of two disks (e.g., `A` and `B`), other three disks (e.g., `C`, `D`, and `F`), or four disks (e.g., `A`, `B`, `C`, and `D`), because the second array must use exactly the same three disks as the first one: `A`, `B`, and `C`. However, you can create one more array on disks `E` and `F`.

### Creating RAIDs with an integrated RAID controller {#creating-rst-raids}

{% include [motherboard-specific-bios-warn](../../_includes/baremetal/motherboard-specific-bios-warn.md) %}

The process for creating RAIDs with integrated RAID controllers depends on your server's boot [mode](#boot-mode). To create a RAID:

1. Enable RAID mode on disk controllers:

    1. In the [KVM console](../operations/servers/server-kvm.md), access the BIOS/UEFI system settings menu by pressing **F11** or **Del** during server startup when the [POST](https://en.wikipedia.org/wiki/Power-on_self-test) screen appears. You will see the following message: `Entering Setup...`.
    1. Wait for the system settings menu to open, then use the **←** and **→** keys to navigate to the **Advanced** section.

        1. Select **SATA Configuration** and press **Enter**.
        1. In the section that opens, select **SATA Mode**, press **Enter**, and select **RAID Mode**.
        1. Press **Esc** to return to the previous menu section.
        1. Select **SCU Configuration** and press **Enter**.
        1. In the section that opens, select **SCU RAID Option ROM/UEFI Driver**, press **Enter**, and select **Enabled**.
        1. Press **Esc** to return to the previous menu section.
    1. Use the **←** and **→** keys to navigate to **Save & Exit**, select **Save Changes and Reset**, and press **Enter**.
    1. Confirm by pressing **Yes** to restart the server.
1. Configure RAIDs:

    {% list tabs %}

    - Legacy mode

      1. Launch the RAID configuration utility by pressing **Ctrl** + **I** during server startup when you see the list of connected physical disks on the [POST](https://en.wikipedia.org/wiki/Power-on_self-test) screen.

          If the disks are connected to both the SATA and SCU server RAID controllers, the tables listing the disk will be displayed twice: the first table will have the `SATA Option ROM` header, and the second one, `SCU Option ROM`. You must access and configure each controller's settings separately.
      1. To create a RAID, select **1. Create RAID Volume** and press **Enter**. In the window that opens:

          1. Configure the parameters of the new RAID.

              Use the **Tab** key to switch between menu items, **↑** and **↓** to view available options, and **Enter** to select a value.
          1. Select **Create Volume** and press **Enter**.
          1. Type `Y` to confirm.
      1. To delete a RAID, select **2. Delete RAID Volume** and press **Enter**. In the window that opens:

          1. Select the RAID you want to delete and press **Del**.
          1. Type `Y` to confirm.
          1. Press **Esc** to return to the previous menu section.
      1. To exit the RAID configuration utility, select **4. Exit** and press **Enter**.
      1. Type `Y` to confirm.

    - UEFI mode

      1. During the restart, press **F11** or **Del** again to enter the system settings menu and wait for it to open.
      1. Use the **←** and **→** keys to navigate to the **Advanced** section.
      1. To create RAIDs from disks connected to the SCU RAID controller, select **Intel RSTe SCU Controller** and press **Enter**.

          {% include [uefi-create-raid-arrays](../../_includes/baremetal/uefi-create-raid-arrays.md) %}

      1. To create RAIDs from disks connected to the SATA RAID controller, select **Intel RSTe SATA Controller** and press **Enter**.

          {% include [uefi-create-raid-arrays](../../_includes/baremetal/uefi-create-raid-arrays.md) %}

      1. Use the **←** and **→** keys to navigate to **Save & Exit**, select **Save Changes and Reset**, and press **Enter**.
      1. Confirm by pressing **Yes** to restart the server.

    {% endlist %}

## OS boot mode {#boot-mode}

{% include [motherboard-specific-bios-warn](../../_includes/baremetal/motherboard-specific-bios-warn.md) %}

{{ baremetal-name }} server motherboards support the _Legacy_ and _UEFI_ OS boot modes. The server's OS boot mode is configured in its motherboard's [BIOS](https://en.wikipedia.org/wiki/BIOS)/[UEFI](https://en.wikipedia.org/wiki/UEFI) system settings.

When you [install](../operations/servers/reinstall-os-from-marketplace.md) a server OS from a {{ marketplace-short-name }} image, it is always installed and booted in Legacy mode.

### Installing an OS in UEFI mode {#install-os-uefi}

You can [install](../operations/servers/reinstall-os-from-own-image.md) an OS in UEFI mode from a custom image. During installation, boot the server from the CD drive with the mounted OS installation image in UEFI mode. To do this, in the [KVM console](../operations/servers/server-kvm.md):

1. Select **Media** → **Virtual Media Wizard...** or click the CD icon in the top menu of the KVM console. In the window that opens:

    1. In the **CD/DVD Media1** section, click **Browse** and select the [previously uploaded](../operations/image-upload.md) ISO OS image in the `user-iso` directory.
    1. Click **Connect CD/DVD**.
    1. Check the **Virtual CD 1** device **Status** section to make sure the **Connected To** field now shows your selected ISO path, then click **Close**.
1. Click **Reboot to CD-ROM** in the top-right corner of the KVM console.
1. Access the BIOS/UEFI system settings menu by pressing **F11** or **Del** during server startup when the [POST](https://en.wikipedia.org/wiki/Power-on_self-test) screen appears. You will see the following message: `Entering Setup...`.
1. Wait for the system settings menu to open.
1. If you plan to install the OS onto RAIDs [created](#creating-rst-raids) with an integrated RAID controller, use the **←** and **→** keys to navigate to the **Advanced** section.

    1. Select **PCIe/PCI/PnP Configuration** and press **Enter**.
    1. In the section that opens, select **Launch Storage OpROM policy**, press **Enter**, and select **UEFI only**.
    1. Press **Esc** to return to the previous menu section.
1. Use the **←** and **→** keys to navigate to the **Save & Exit** section.
1. If you changed any settings in the previous steps, save them: select **Save Changes**, press **Enter**, and confirm the action in the window that opens.
1. In the **Boot Override** section, select `UEFI: AMI Virtual CDROM0 1.00` and press **Enter**.

    If there is no such option in the **Boot Override** section, go to **Boot** settings and add it under **UEFI Boot Drive BBS Priorities**.

The server will restart and boot from the virtual CD drive in `UEFI` mode. In this mode, the OS installed from the image mounted on the CD drive will also be set up using `UEFI`.

### Booting an OS in UEFI mode {#start-os-uefi}

To successfully boot an OS installed in UEFI mode on your server, select the correct boot device in the BIOS/UEFI settings. To do this, in the [KVM console](../operations/servers/server-kvm.md):

1. When restarting your server after the OS installation is complete, navigate to the BIOS/UEFI system settings menu again. To do this, during server startup, press **F11** or **Del** on the [POST](https://en.wikipedia.org/wiki/Power-on_self-test) screen and wait for the system settings menu to open.
1. If the OS is installed onto RAIDs [created](#creating-rst-raids) with an integrated RAID controller, use the **←** and **→** keys to navigate to the **Advanced** section.

    1. Select **PCIe/PCI/PnP Configuration** and press **Enter**.
    1. In the section that opens, check that the **Launch Storage OpROM policy** option is set to **UEFI only**.

        {% note info %}

        If **Launch Storage OpROM policy** is set to a different value, change it to **UEFI only**. Save the changes, restart the server, and open the BIOS/UEFI settings menu again to proceed with boot device selection.

        {% endnote %}

    1. Press **Esc** to return to the previous menu section.
1. Use the **←** and **→** keys to navigate to the **Boot** section.

    1. Select **UEFI Boot Drive BBS Priorities** and press **Enter**. In the section that opens, do the following:

        1. In the **1st Device** field, press **Enter** select an option based on the installed OS, e.g., `UEFI OS`, `Ubuntu`, `Windows Boot Manager`, etc.
        1. Press **Esc** to return to the previous menu section.
    1. In the **Set Boot Priority** section, set **1st Boot Device** to the same value you selected in **UEFI Boot Drive BBS Priorities**.
1. Use the **←** and **→** keys to navigate to **Save & Exit**, select **Save Changes and Reset**, and press **Enter**. Press **Yes** to confirm.

After completing these steps, your server OS will boot from the selected boot device in UEFI mode.