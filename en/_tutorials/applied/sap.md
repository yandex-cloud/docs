

You will learn to configure an SAP server and write your first program exporting a list of system users in tabular format.

To create an SAP program in {{ yandex-cloud }}:
1. [Get your cloud ready](#before-begin).
1. [Create a VM for SAP](#vm-sap).
1. [Set up the VM file system](#fs-settings).
1. [Set up an install configuration](#install-config).
1. [Install SAP](#sap-install).
1. [Configure SAP](#sap-settings).
1. [Make sure the program runs correctly](#sap-app).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of an SAP installation includes:
* Fee for a continuously running [VM](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for a dynamic or static [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create an SAP VM {#vm-sap}

Create a VM and give it a public IP address:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [folder dashboard](../../resource-manager/concepts/resources-hierarchy.md#folder) in the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the `SLES for SAP 15 SP2` image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**:

      * Select the `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}` boot disk [type](../../compute/concepts/disk.md#disks_types) and specify the disk size: `40 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
      * Create a secondary disk:
          * Click **{{ ui-key.yacloud.common.add }}**.
          * Select the [disk type](../../compute/concepts/disk.md#disks_types): `{{ ui-key.yacloud.compute.value_disk-type-network-ssd }}`.
          * Specify the disk size: `24 {{ ui-key.yacloud.common.units.label_gigabyte }}`. 
          * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required platform, number of vCPUs, and the amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `8 {{ ui-key.yacloud.common.units.label_gigabyte }}`

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network and subnet to connect your VM to. If the required [network](../../vpc/concepts/network.md#network) or [subnet](../../vpc/concepts/network.md#subnet) is not listed, [create it](../../vpc/operations/subnet-create.md).
      * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, keep `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter a username. Do not use `root` or other usernames reserved for the OS. To perform operations requiring root privileges, use the `sudo` command.

      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `vhcalnplci` that will be used in the SAP installation script.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %} 

## Set up your VM file system {#fs-settings}

Create a file system structure for SAP installation.
1. Connect to your VM over [SSH](../../compute/operations/vm-connect/ssh.md#vm-connect) via [PuTTY](https://www.putty.org/).
1. Switch to the `root` account:

   ```bash
   sudo su
   ```

1. List all available disks:

   ```bash
   lsblk
   ```

   Result:

   ```text
   vda    254:0    0  40G  0 disk
   ├─vda1 254:1    0   4M  0 part
   └─vda2 254:2    0  40G  0 part /
   vdb    254:16   0  90G  0 disk
   ```

   Where:
   * `vda`: Boot disk
   * `vdb`: Data disk
1. Create two partitions on the data disk: 20 GB for the installation files and 70 GB for the SAP application server.
   1. Run `fdisk` to manage partitions:

      ```bash
      fdisk /dev/vdb
      ```

      If you get `command not found`, add `fdisk` to `Path`:

      ```bash
      PATH=/sbin:$PATH
      ```

   1. To create a new partition, type `n` and press **Enter**.
   1. Press **Enter** to select the `primary` partition type.
   1. Press **Enter** to accept the default partition number: `1`.
   1. Press **Enter** to accept the default first sector: `2048`.
   1. Type `+20G` to set the partition size and press **Enter**.
   1. Repeat these steps to add another partition. On the last step, do not type anything and press **Enter**. The partition will use the remaining available space: 70 GB.
   1. Type `w` and press **Enter** to save the changes.

      Result:

      ```text
      Welcome to fdisk (util-linux 2.33.1).
      Changes will remain in memory only, until you decide to write them.
      Be careful before using the write command.

      Device does not contain a recognized partition table.
      Created a new DOS disklabel with disk identifier 0xb58ce40a.

      Command (m for help): n
      Partition type
      p   primary (0 primary, 0 extended, 4 free)
      e   extended (container for logical partitions)
      Select (default p):

      Using default response p.
      Partition number (1-4, default 1):
      First sector (2048-182452223, default 2048):
      Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-182452223, default 182452223): +20G

      Created a new partition 1 of type 'Linux' and of size 20 GiB.

      Command (m for help): n
      Partition type
      p   primary (1 primary, 0 extended, 3 free)
      e   extended (container for logical partitions)
      Select (default p):

      Using default response p.
      Partition number (2-4, default 2):
      First sector (41945088-182452223, default 41945088):
      Last sector, +/-sectors or +/-size{K,M,G,T,P} (41945088-182452223, default 182452223):

      Created a new partition 2 of type 'Linux' and of size 70 GiB.

      Command (m for help): w
      The partition table has been altered.
      Calling ioctl() to re-read partition table.
      Syncing disks.
      ```

   1. List all available disks:

      ```bash
      lsblk
      ```

      Result:

      ```text       
      NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
      vda    254:0    0  40G  0 disk
      ├─vda1 254:1    0   4M  0 part
      └─vda2 254:2    0  40G  0 part /
      vdb    254:16   0  90G  0 disk
      ├─vdb1 254:17   0  20G  0 part
      └─vdb2 254:18   0  70G  0 part
      ```

1. Create an `ext4` file system on `vdb1` and `vdb2` partitions:

   ```bash
   mkfs.ext4 /dev/vdb1
   mkfs.ext4 /dev/vdb2
   ```

   Result:

   ```text
   mke2fs 1.43.8 (1-Jan-2018)
   Creating filesystem with 5242880 4k blocks and 1310720 inodes
   Filesystem UUID: e878b21b-da84-42f9-ba9f-b6ad3c6edab6
   Superblock backups stored on blocks:
      32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
      4096000

   Allocating group tables: done
   Writing inode tables: done
   Creating journal (32768 blocks): done
   Writing superblocks and filesystem accounting information: done

   ...

   mke2fs 1.43.8 (1-Jan-2018)
   Creating filesystem with 17563392 4k blocks and 4390912 inodes
   Filesystem UUID: 14be2468-6a99-4178-a77b-26096c3fcad4
   Superblock backups stored on blocks:
     32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
     4096000, 7962624, 11239424

   Allocating group tables: done
   Writing inode tables: done
   Creating journal (131072 blocks): done
   Writing superblocks and filesystem accounting information: done
   ```

1. Create directories for installation files and the SAP application server and mount them to `vdb1` and `vdb2` partitions, respectively:

   ```bash
   mkdir /usr/sap
   mkdir /distr
   mount /dev/vdb1 /distr
   mount /dev/vdb2 /usr/sap
   ```

1. For automatic remounting after reboot, edit the `/etc/fstab` file:

   ```bash
   vi /etc/fstab
   ```

   Make it look like this:

   ```text
   LABEL=ROOT  /  xfs  defaults  0  1
   /dev/vdb1 /distr ext4 defaults 1 1
   /dev/vdb2 /usr/sap ext4 defaults 1 1
   ```

## Configure SAP installation {#install-config}

Copy the installation files to your VM and configure SAP installation.

1. Download 11 [SAP NetWeaver AS ABAP Developer Edition 7.52 SP04](https://developers.sap.com/trials-downloads.html) archives on your computer and unpack them.
1. Save your current VM `PuTTY` session under any name you want.
1. Install and run [WinSCP](https://winscp.net/eng/download.php).
1. Import the saved PuTTY session into `WinSCP`.
   1. In the `Login` window, click **Tools**.
   1. Select **Import Sites**.
   1. In the `Import from` field, select **PuTTY** and then select the previously saved session.
1. Connect to your VM via `WinSCP`.
   1. Select the session imported from `PuTTY`.
   1. Click **Login**.
   1. Enter your VM username.
1. Import SAP installation files to your VM `/distr` folder.
   1. In the left-hand window, open the folder where you unpacked SAP files.
   1. Select all files and click **Upload**.
   1. Set `/distr/*.*` as the import destination.

   To import files, you should be the `/distr` folder owner. Alternatively, you should connect with root privileges or [configure the use of sudo upon logging in](https://winscp.net/eng/docs/faq_su).
1. Install and run the UUIDD: [UUID](https://datatracker.ietf.org/doc/html/rfc4122) (universally unique identifiers) daemon required for SAP to work:

   ```bash
   zypper install uuidd
   service uuidd start
   ```

1. Check for the `libaio` and `libaio1` packages:

   ```bash
   rpm -qa | grep libaio
   rpm -qa | grep libaio1
   ```

   The command output will display the distribution package versions.
1. Get your VM [internal IP address](../../vpc/concepts/address.md#internal-addresses):

   ```bash
   ip addr show
   ```

   Result:

   ```text
   1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     inet 127.0.0.1/8 scope host lo
     valid_lft forever preferred_lft forever
     inet6 ::1/128 scope host
     valid_lft forever preferred_lft forever
   2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
     link/ether d0:0d:11:31:ee:a6 brd ff:ff:ff:ff:ff:ff
     inet 10.0.0.29/24 brd 10.0.0.255 scope global eth0
     valid_lft forever preferred_lft forever
     inet6 fe80::d20d:11ff:fe31:eea6/64 scope link
     valid_lft forever preferred_lft forever
   ```

1. Add your VM internal IP address to `/etc/hosts`.
   1. Open the file:

      ```bash
      vi /etc/hosts
      ```

   1. Add the following line:

      ```text
      <inet> vhcalnplci vhcalnplci.{{ region-id }}.internal.
      ```

      Where `inet` is an IP address following the `inet` parameter in the `eth0` section of the previous command output.

      Result:

      ```text
      127.0.0.1 localhost
      10.0.0.29 vhcalnplci vhcalnplci.{{ region-id }}.internal
      ```

1. Check the host name:

   ```bash
   hostname
   ```

   Result:

   ```text
   vhcalnplci
   ```

## Install SAP {#sap-install}

1. Change the permissions for the SAP installation folder.

   ```bash
   chmod -R 777 /distr
   ```

1. Navigate to `/distr`:

   ```bash
   cd /distr
   ```

1. Run the SAP installation script:

   ```bash
   ./install.sh
   ```

1. Accept the license agreement terms.
1. Set a master password for standard SAP users.

   Password requirements:
   * At least 7 Latin characters.
   * Contains uppercase and lowercase letters and numbers.
   * No special characters.
1. Wait for the installation to complete.

   The installation may fail with the following error message:

   ```bash
   Abort execution because of Step returns modlib.jslib.caughtException 
   Error: sapinst has finished with an error code, please find logs in /tmp/sapinst_instdir
   Error code: 20
   ```

   This error is caused by an expired license. To resolve this problem:
   1. Download `SAP ABAP AS Part License` for SAP NetWeaver AS ABAP Developer Edition 7.52 SP04 from the [official website](https://developers.sap.com/trials-downloads.html).
   1. Unpack and copy the license file to your VM’s `server/TAR/x86_64/` directory via WinSCP.
   1. Run `./install.sh` again.

## Start and configure SAP {#sap-settings}

1. Install the [SAP logon client](https://help.sap.com/doc/2e5792a2569b403da415080f35f8bbf6/760.04/en-US/sap_frontend_inst_guide.pdf) on your computer.
1. Run SAP logon and configure a connection to your VM:
   * **Application Server**: Your VM public IP address
   * **Instance number**: `00`
   * **System ID**: `NPL`

   Once you log on to SAP, you will see the [SAP Easy Access](https://help.sap.com/viewer/b1c834a22d05483b8a75710743b5ff26/7.40.20/en-US/cb11a43814a54af19c4bcf0221c24eb7.html) menu on the left. This is a custom user menu containing the items you will need for daily tasks.

   To configure SAP, you can use [transaction codes](https://help.sap.com/saphelp_snc700_ehp01/helpdata/en/f9/e1a442dc030e31e10000000a1550b0/frameset.htm) linked to the SAP system functions. Enter these codes in the [SAP command line](https://help.sap.com/viewer/b1c834a22d05483b8a75710743b5ff26/7.40.20/en-US/f735dd776e724195b5562592a5e88b45.html) or add them to [bookmarks](https://help.sap.com/viewer/b1c834a22d05483b8a75710743b5ff26/7.40.20/en-US/1e10a82969594103a99e1f7962b205b0.html) for quick access.
1. Change the default passwords to ensure optimal security:
   1. From SAP Easy Access, run `SU01`.
   1. Navigate to `Logon Data`.
   1. Select the user you want to modify.
   1. Specify a new password.

### Update your license {#sap-license}

To continue using SAP, you need to update your license:
1. From SAP Easy Access, run `SLICENSE`.
1. Copy the `Active Hardware Key`.
1. Open the [SAP license key page](https://go.support.sap.com/minisap/#/minisap).
1. Select `NPL — SAP NetWeaver 7.x (Sybase ASE)`.
1. Specify the salutation, your first and last names, email address, and the `Active Hardware Key` you copied earlier.
1. Accept the license agreement terms and download the `NPL.tx` license file.
1. Copy the license file to your VM and upload it to `SLICENSE`.

## Create your first program {#sap-app}

To test whether your system works properly, create a simple program exporting a user list.
1. Log in as `DEVELOPER`.
1. Run `SE38` (`ABAP Editor`).
1. Name your program as `ZTEST`.
1. Add program code:

   ```text
   TYPE-POOLS: slis.

   *&---------------------------------------------------------------------*

   *& Data Declaration

   *&---------------------------------------------------------------------*

   DATA: it_usr01     TYPE TABLE OF USR01.
   DATA: it_fieldcat  TYPE slis_t_fieldcat_alv,
     wa_fieldcat  TYPE slis_fieldcat_alv.`

   *&---------------------------------------------------------------------*

   *& START-OF-SELECTION`

   *&---------------------------------------------------------------------*

   START-OF-SELECTION.
   *Fetch data from the database
   SELECT * FROM USR01 INTO TABLE it_usr01.

   *Build field catalog
   wa_fieldcat-fieldname  = 'MANDT'.
   wa_fieldcat-seltext_m  = 'MANDT'.
   APPEND wa_fieldcat TO it_fieldcat.

   wa_fieldcat-fieldname  = 'BNAME'.
   wa_fieldcat-seltext_m  = 'USER'.
   APPEND wa_fieldcat TO it_fieldcat.

   * display ALV list
   CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
     EXPORTING
     it_fieldcat   = it_fieldcat
     TABLES
     t_outtab      = it_usr01
     EXCEPTIONS
     program_error = 1
     OTHERS        = 2
   ```

   Result:

   ```text
   | MANDT| USER        |
   | -----| ----------- |
   | 001  | BWDEVELOPER |
   | 001  | DDIC        |
   | 001  | DEVELOPER   |
   | 001  | SAP*        |
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
* If you reserved a [static public IP address](../../vpc/operations/address-delete.md) for this project, delete it.