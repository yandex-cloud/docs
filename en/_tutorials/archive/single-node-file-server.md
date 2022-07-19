# Single-node file server

You will learn to create a single-node file server using [Samba](https://www.samba.org/) and [NFS](https://docs.microsoft.com/en-us/windows-server/storage/nfs/nfs-overview) as well as connect to it from computers running Linux, macOS, and Windows.

To create a single-node file server:

1. [Prepare your cloud](#before-you-begin).
1. [Create a virtual machine for your file server](#create-vm).
1. [Set up Samba and NFS](#setup-samba-nfs).
1. [Test your file server](#test-file-server).

If you no longer need these resources, [delete them](#clear-out).


## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of hosting a static website includes:

* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create cloud networks and subnets {#before-you-begin}

Before creating a VM:

1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you will perform the operations.

1. Make sure the selected folder has a network with a subnet that the VM can be connected to. To do this, select **Virtual Private Cloud** on the folder page. If the list contains a network, click on its name to see the list of subnets. If there is neither network nor subnet, [create them](../../vpc/quickstart.md).


## Create a virtual machine for your file server {#create-vm}

To create a VM:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter the VM name: `fileserver-tutorial`.

1. Select an [availability zone](../../overview/concepts/geo-scope.md) to put your virtual machine in.

1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, and select the [Ubuntu](/marketplace?tab=software&search=Ubuntu&categories=os) public image.

1. In the **Computing resources** section:
    - Choose the platform.
    - Specify the required amount of vCPUs and RAM.

   Recommended values for the file server:
   * **Guaranteed vCPU share**: 100%.
   * **vCPU**: 8 or more.
   * **RAM**: 56 GB or more.

1. In the **Disks** section, click **Add disk**. In the **Add disk** window, specify the disk settings for data storage:

   * **Name**: `fileserver-tutorial-disk`.
   * **Disk type**: SSD.
   * **Size**: 100 GB.
   * **Content**: Empty.

   Click **Add**.

1. Under **Computing resources**:
   * Choose a [platform](../../compute/concepts/vm-platforms.md).
   * Specify the necessary number of vCPUs and amount of RAM.

   Recommended values for the file server:
   * **Guaranteed vCPU share**: 100%
   * **vCPU**: 8 or more.
   * **RAM**: 56 GB or more.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.

1. Specify data required for accessing the VM:

   * Enter the username in the **Login** field.
   * In the **SSH key** field, paste the contents of the public key file. You need to [create](../../compute/operations/images-with-pre-installed-software/operate.md#creating-ssh-keys) the SSH key pair yourself.

1. Click **Create VM**.

Creating the VM may take several minutes. When the virtual machine's status changes to `RUNNING`, you can [set up NFS and Samba](#setup-samba-nfs).

When a VM is created, it is assigned an IP address and hostname (FQDN). This data can be used for SSH access.


## Set up Samba and NFS {#setup-samba-nfs}

After the `fileserver-tutorial` VM's status changes to `RUNNING`, do the following:
1. Go to the VM page of the [management console]({{ link-console-main }}). In the **Network** section, find the VM's public IP address.

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

   The recommended authentication method when connecting over SSH is using a key pair. Don't forget to set up the created key pair: the private key must match the public key sent to the VM.
1. Download and install Samba:

   {% list tabs %}

   - Ubuntu
      ```bash
      sudo apt-get update
      sudo apt-get install nfs-kernel-server samba
      ```
   {% endlist %}

1. Prepare and mount the file system on the data storage disk:

   ```bash
   sudo mkfs -t ext4 -L data /dev/vdb
   sudo mkdir /data
   echo "LABEL=data /data ext4 defaults 0 0" | sudo tee -a /etc/fstab
   sudo mount /data
   ```

1. Set the NFS configuration in the `/etc/exports` file. You can edit the file using the `nano` utility:
   ```bash
   sudo nano /etc/exports
   ```
   Add the following lines to the file:
   ```bash
   /data <IP address>(rw,no_subtree_check,fsid=100)
   /data 127.0.0.1(rw,no_subtree_check,fsid=100)
   ```
   Where `<IP address>` is the IP address of the computer to which you are going to connect the network data disk via NFS.

1. Set the Samba configuration in the `/etc/samba/smb.conf` file. You can edit the file using the `nano` utility:

   ```bash
   sudo nano /etc/samba/smb.conf
   ```
   Make the file look like:

   ```
   [global]
      workgroup = WORKGROUP
      server string = %h server (Samba)
      dns proxy = no
      log file = /var/log/samba/log.%m
      max log size = 1000
      syslog = 0
      panic action = /usr/share/samba/panic-action %d
      server role = standalone server
      passdb backend = tdbsam
      obey pam restrictions = yes
      unix password sync = yes
      passwd program = /usr/bin/passwd %u
      passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully*.
      pam password change = yes
      map to guest = bad user
      usershare allow guests = yes
   [printers]
      comment = All Printers
      browseable = no
      path = /var/spool/samba
      printable = yes
      guest ok = no
      read only = yes
      create mask = 0700
   [print$]
      comment = Printer Drivers
      path = /var/lib/samba/printers
      browseable = yes
      read only = yes
      guest ok = no
   [data]
      comment = /data
      path = /data
      browseable = yes
      read only = no
      writable = yes
      guest ok = yes
      hosts allow = <IP address> 127.0.0.1
      hosts deny = 0.0.0.0/0
   ```

   Where `<IP address>` of the `[data]` section is the IP address of the computer to which you are going to connect the network data disk via NFS.

1. Restart Samba and NFS:

   ```bash
   sudo service nfs-kernel-server restart
   sudo service smbd restart
   ```


## Test your file server {#test-file-server}

1. On the `fileserver-tutorial` VM, create a test directory with a file as follows:

   {% list tabs %}

   - Ubuntu
      ```bash
      sudo mkdir /data/fileserver-tutorial
      sudo setfacl -m u:<your username>:xw /data/fileserver-tutorial
      echo "Hello world!" > /data/fileserver-tutorial/test.txt
      ```
   {% endlist %}

1. Connect the network disk to your computer via NFS and check if the test file is available:

   {% list tabs %}

   - Linux/macOS

      Run the command `mount -t nfs <external IP>:/data /<mount point>`.

      The test directory and its file must be available at the specified mount point.

   - Windows

      1. Run the **cmd.exe** utility. To do this, use the **Windows** + **R** keyboard shortcut and run the command `cmd`.
      1. From the command line, run:
         ```
         net use x: \\<VM's public IP address>\data
         ```

      The test directory and its file must be available on disk X.

   {% endlist %}


## How to delete created resources {#clear-out}

To stop paying for your deployed server, just delete the [created virtual machine](../../compute/operations/vm-control/vm-delete.md) `fileserver-tutorial`.

If you reserved a static public IP address specifically for this VM:

1. Open the **Virtual Private Cloud** in your folder.
1. Go to the **IP addresses** tab.
1. Find the required address, click ![ellipsis](../../_assets/options.svg), and select **Delete**.
