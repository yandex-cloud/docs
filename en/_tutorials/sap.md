You will learn to configure a server with an installed SAP environment and write your first program. It will export a listing of existing system users in tabular format.

To create an SAP program in {{ yandex-cloud }}:
1. [Before you start](#before-begin).
1. [Create a VM for SAP](#vm-sap).
1. [Set up the VM file system](#fs-settings).
1. [Set up an install configuration](#install-config).
1. [Install SAP](#sap-install).
1. [Configure SAP](#sap-settings).
1. [Check that the program runs as expected](#sap-app).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-begin}

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}



### Required paid resources {#paid-resources}

The cost of an SAP installation includes:
* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../compute/pricing.md)).
* A fee for using a dynamic or a static public IP (see [{{ vpc-full-name }} pricing](../vpc/pricing.md)).


## Create a VM for SAP {#vm-sap}

Create a VM with a public address:

{% list tabs %}

- Management console

   1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

   1. In the **Name** field, enter `vhcalnplci` as a name for your virtual machine. This host name is used in the install script.

   1. Select the [availability zone](../overview/concepts/geo-scope.md): `{{ region-id }}-a`.

   1. Under **Image/boot disk selection**, select operating system image [SLES for SAP 15 SP2](/marketplace/products/yc/sles-for-sap-15-sp2).

   1. Under **Disks** select `SSD` as your boot disk type and specify 40 GB of disk size.

   1. Click **Add disk** to add another disk.
      1. Enter a name for the disk.
      1. Select `HDD` as type.
      1. Specify a size of 90 GB.
      1. Click **Add**.

   1. Under **Computing resources**:
      * Select the [platform](../compute/concepts/vm-platforms.md): Intel Ice Lake.
      * Specify the number of vCPUs and amount of RAM:
         * **vCPU**: 2.
         * **Guaranteed vCPU share**: 100%
         * **RAM**: 8 GB.

   1. Under **Network settings**:
      * Enter a subnet ID or select a [cloud network](../vpc/concepts/network.md#network) from the list.

         If you don't have a network, click **Create network** to create one:
         * In the resulting window, enter a network name and folder to host the network.
         * You can select **Create subnets** to create subnets automatically.
         * Click **Create**.

         Each network must have at least one [subnet](../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **Add subnet**.
      * In the **Public IP** field, select the **Auto** method for assigning an IP address.

   1. Under **Access**, specify the data required to access the VM:
      * Enter the username in the **Login** field.
      * In the **SSH key** field enter the public SSH key. You can create an SSH key pair to connect to the virtual machine by following the [instructions](../compute/operations/vm-connect/ssh#creating-ssh-keys).

   1. Click **Create VM**.

{% endlist %}

## Set up the VM file system {#fs-settings}

Set up the created VM's file structure for the SAP install.

1. [Use SSH to connect](../compute/operations/vm-connect/ssh#vm-connect) to the virtual machine you created with [PuTTY](https://www.putty.org/).

1. Switch to root to get superuser privileges:
   ```bash
   sudo su
   ```

1. Review a list of all the disks:
   ```bash
   lsblk
   ```
   Result:
   ```bash
   vda    254:0    0  40G  0 disk
   ├─vda1 254:1    0   4M  0 part
   └─vda2 254:2    0  40G  0 part /
   vdb    254:16   0  90G  0 disk
   ```
   Where:
   * `vda`: Boot disk.
   * `vdb`: Data disk.

1. Create two partitions on the data disk (`vdb`): 20 GB for the distribution and 70 GB for SAP.
   1. To manage hard drive partitions, run the `fdisk` utility:
      ```bash
      fdisk /dev/vdb
      ```
      If launching `fdisk` returns the `command not found` error, add `fdisk` to `Path`:
      ```bash
      PATH=/sbin:$PATH
      ```
   1. To add your first partition, press `n` followed by **Enter**.
   1. To select `primary`, which is the default type, press **Enter**.
   1. To select default number `1`, press **Enter**.
   1. To select first default sector `2048`, press **Enter**.
   1. Specify size as `+20G` and press **Enter**.
   1. Repeat these steps to add another partition. Do not specify partition size in the last step. It will use the remaining 70 GB of disk space by default.
   1. To save the partitions you created, press `w` followed by **Enter**.

      Result:
      ```bash
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
   1. Check the disk structure:
      ```bash
      lsblk
      ```
      Result:

      ```bash
      NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
      vda    254:0    0  40G  0 disk
      ├─vda1 254:1    0   4M  0 part
      └─vda2 254:2    0  40G  0 part /
      vdb    254:16   0  90G  0 disk
      ├─vdb1 254:17   0  20G  0 part
      └─vdb2 254:18   0  70G  0 part
      ```

1. Configure your `vdb1` and `vdb2` partitions with the `ext4` file system:
   ```bash
   mkfs.ext4 /dev/vdb1
   mkfs.ext4 /dev/vdb2
   ```
   Result:
   ```bash
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

1. Create directories for the distribution and the SAP application server. Mount these to partitions `vdb1` and `vdb2`:
   ```bash
   mkdir /usr/sap
   mkdir /distr
   mount /dev/vdb1 /distr
   mount /dev/vdb2 /usr/sap
   ```

1. For automatic remounting after reboot, edit `/etc/fstab`:
   ```bash
   vi /etc/fstab
   ```
   Make it look like this:
   ```bash
   LABEL=ROOT  /  xfs  defaults  0  1
   /dev/vdb1 /distr ext4 defaults 1 1
   /dev/vdb2 /usr/sap ext4 defaults 1 1
   ```

## Configure install {#install-config}

Add the SAP installation files to your virtual machine and configure the upcoming install.

1. Download the 11 archives with the [SAP NetWeaver AS ABAP Developer Edition 7.52 SP04](https://developers.sap.com/trials-downloads.html) installation files and unpack their contents to a local folder.

1. Save the current PuTTY virtual machine connection session. You can use any name.

1. Install and run [WinSCP](https://winscp.net/eng/download.php).

1. Import the saved PuTTY session settings into WinSCP.
   1. In the `Login` window, click **Tools**.
   1. Select **Import Sites**.
   1. In the `Import from` field, select **PuTTY** and highlight the previously saved session.

1. Connect to the virtual machine via WinSCP.
   1. Select the session imported from PuTTY.
   1. Click **Login**.
   1. Enter the VM username.

1. Import the SAP installation files that you unpacked from the previously downloaded archives into the `/distr` folder on the virtual machine.
   1. In the left-hand window, open the folder with the unpacked SAP files.
   1. Highlight the files and click **Upload**.
   1. Set `/distr/*.*` as the import location on the virtual machine.

   To be able to import the files, you have to be the owner of the `/distr` folder. The other option is to connect via WinSCP as a user with root access or [configure the use of sudo when logging onto the system](https://winscp.net/eng/docs/faq_su).

1. On the virtual machine, install and run UUIDD. This is the [UUIDD](https://datatracker.ietf.org/doc/html/rfc4122) (universally unique identifiers) daemon. It is required for SAP to run:
   ```bash
   zypper install uuidd
   service uuidd start
   ```

1. Check for the `libaio` and `libaio1` libraries:
   ```bash
   rpm -qa | grep libaio
   rpm -qa | grep libaio1
   ```
   The output will display the library versions built into the distribution.

1. Find out the virtual machine's private IP:
   ```bash
   ip addr show
   ```
   Result:
   ```bash
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

1. Add the private IP to `/etc/hosts`.
   1. Open the file:
      ```bash
      vi /etc/hosts
      ```
   1. Add a line to it as below:
      ```
      <inet> vhcalnplci vhcalnplci.{{ region-id }}.internal. 
      ```
      Use an `inet` value from the `eth0` block.

      Result:
      ```
      127.0.0.1 localhost
      10.0.0.29 vhcalnplci vhcalnplci.{{ region-id }}.internal 
      ```

1. Check the host name:
   ```bash
   hostname
   ```
   Result:
   ```bash
   vhcalnplci
   ```

## Install SAP {#sap-install}

1. Modify the permissions to the folder containing the SAP install files.
   ```bash
   chmod -R 777 /distr
   ```

1. Change to `/distr`:
   ```bash
   cd /distr
   ```

1. Run the SAP install script:
   ```bash
   ./install.sh
   ```

1. Accept the terms of the license agreement.

1. Set a master password for the users to be created during the SAP install.

   Password requirements:
   * At least 7 English characters.
   * Contains capital letters and numbers.
   * No special characters.

1. Wait for the installation to complete.

   The install may produce the following error message:

   ```bash
   Abort execution because of Step returns modlib.jslib.caughtException 
   Error: sapinst has finished with an error code, please find logs in /tmp/sapinst_instdir
   Error code: 20
   ```

   The error is related to an expired license. To resolve:
   1. Download `SAP ABAP AS Part License` for SAP NetWeaver AS ABAP Developer Edition 7.52 SP04 from the [official website](https://developers.sap.com/trials-downloads.html).
   1. Unpack and copy it to the `server/TAR/x86_64/` folder on the virtual machine. You can do this using WinSCP.
   1. Run `./install.sh` again to install SAP.


## Run and configure SAP {#sap-settings}

1. Install the [SAP Logon](https://help.sap.com/doc/2e5792a2569b403da415080f35f8bbf6/760.04/en-US/sap_frontend_inst_guide.pdf) front-end client on your computer.

1. Run SAP Logon and configure the connection to the virtual machine.
   * **Application Server**: Public IPv4 address.
   * **Instance number**: `00`.
   * **System ID**: `NPL`.

   Once you log on to SAP, you will see the [SAP Easy Access](https://help.sap.com/viewer/b1c834a22d05483b8a75710743b5ff26/7.40.20/en-US/cb11a43814a54af19c4bcf0221c24eb7.html) user menu on the left-hand side of your screen. This is a user-specific entry point. The user menu only contains those elements that you require for daily tasks.

   You perform SAP configuration via [transaction codes](https://help.sap.com/saphelp_snc700_ehp01/helpdata/en/f9/e1a442dc030e31e10000000a1550b0/frameset.htm). These are related to SAP system functionality. Transaction codes must be input through the [SAP command line](https://help.sap.com/viewer/b1c834a22d05483b8a75710743b5ff26/7.40.20/en-US/f735dd776e724195b5562592a5e88b45.html). For quick access, you can add these to your [bookmarks](https://help.sap.com/viewer/b1c834a22d05483b8a75710743b5ff26/7.40.20/en-US/1e10a82969594103a99e1f7962b205b0.html).

1. Change the standard passwords for security.
   1. Using the SAP Easy Access interface, run transaction `SU01`.
   1. Go to the `Logon Data` section.
   1. Select the user you would like to edit.
   1. Enter a new password.

### Update license {#sap-license}

To continue using SAP, you need to update you license.

1. Using the SAP Easy Access interface, run transaction `SLICENSE`.
1. Copy the value in the `Active Hardware Key` field.
1. Open the [SAP license key page](https://go.support.sap.com/minisap/#/minisap).
1. Select `NPL — SAP NetWeaver 7.x (Sybase ASE)`.
1. Specify the form of address. Enter your name, last name, email, and the previously copied `Active Hardware Key` value.
1. Accept the terms of the license agreement and download the license file called `NPL.tx`.
1. Move the downloaded license file to the virtual machine and add it to the `SLICENSE` transaction.

## Create your first program {#sap-app}

To verify system functionality, create a simple program to export the user list.

1. Log in as `DEVELOPER`.
1. Run the `SE38` transaction. It is the `ABAP Editor`.
1. Call your program `ZTEST`.
1. Add a code:

   ```
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
   ```
   | MANDT| USER        |
   | -----| ----------- |
   | 001  | BWDEVELOPER |
   | 001  | DDIC        |
   | 001  | DEVELOPER   |
   | 001  | SAP*        |
   ```


## How to delete created resources {#clear-out}

To stop paying for the resources created:
* [Deleting a VM](../compute/operations/vm-control/vm-delete.md).
* [Delete the static public IP](../vpc/operations/address-delete.md) if you reserved one specifically for this project.
