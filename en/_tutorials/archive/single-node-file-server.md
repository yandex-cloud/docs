# Single-node file server

To create a single-node file server:

1. [Create a VM for the file server](#create-vm)
1. [Set up Samba and NFS](#setup-samba-nfs)
1. [Test the file server operation](#test-file-server)

## Before you start {#before-begin}

Before creating a VM:

1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you want to perform the operations.
1. Make sure the selected folder has a network with a subnet that the VM can be connected to. To do this, click the **Virtual Private Cloud** tile on the folder page. If the list contains a network, click on its name to see the list of subnets. If there aren't any networks or subnets, [create them](../../vpc/quickstart.md).

## 1. Create a VM for the file server {#create-vm}

To create a VM:

1. On the folder page of the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter the VM name: `fileserver-tutorial`.

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to locate the VM in.

1. Select the **Ubuntu** or **CentOS** public image.

1. In the **Computing resources** section:
    - Choose the platform.
    - Specify the required amount of vCPUs and RAM.

   Recommended values for the file server:
   * **Guaranteed vCPU share**: 100%.
   * **vCPU**: 8 or more.
   * **RAM**: 56 GB or more.

1. In the **Disks** section, click **Add disk**. In the **Add disk** window, specify the disk settings for data storage:
   * **Name**: `fileserver-tutorial-disk`.
   * **Size**: 100 GB.
   * **Disk type**: SSD.
   * **Content**: Empty.

   Click **Add**.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.

1. Specify data required for accessing the VM.
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file.
You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.

1. Click **Create VM**.

Creating the VM may take several minutes. When the VM's status changes to `RUNNING`, you can [set up NFS and Samba](#setup-samba-nfs).

When a VM is created, it is assigned an IP address and hostname (FQDN). This data can be used for SSH access.

## 2. Set up Samba and NFS {#setup-samba-nfs}

After the `fileserver-tutorial` VM's status changes to `RUNNING`, do the following:

1. Go to the VM page of the [management console]({{ link-console-main }}). In the **Network** section, find the VM's public IP address.

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH. You can use the `ssh` tool on Linux and macOS and [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) for Windows.

      The recommended authentication method when connecting over SSH is using a key pair.  Don't forget to set up the created key pair: the private key must match the public key sent to the VM.

1. Download and install Samba:

   {% list tabs %}

   - Ubuntu

     ```bash
     $ sudo apt-get update
     $ sudo apt-get install nfs-kernel-server samba
     ```

   - CentOS

     ```bash
     $ sudo yum check-update
     $ sudo yum -y install nfs-utils nfs-utils-lib samba nano
     $ sudo chkconfig smb on
     $ sudo chkconfig nfs on
     ```

   {% endlist %}

1. Prepare and mount the file system on the data storage disk:

   ```bash
   $ sudo mkfs -t ext4 -L data /dev/vdb
   $ sudo mkdir /data
   $ echo "LABEL=data /data ext4 defaults 0 0" | sudo tee -a /etc/fstab
   $ sudo mount /data
   ```

1. Set the NFS configuration in the `/etc/exports` file. You can edit the file using the `nano` utility:

   ```bash
   $ sudo nano /etc/exports
   ```

   Add the following lines to the file:

   ```bash
   /data <IP address>(rw,no_subtree_check,fsid=100)
   /data 127.0.0.1(rw,no_subtree_check,fsid=100)
   ```

   Instead of`<IP address>`, specify the IP address of the computer to which you are going to connect the network data disk via NFS.

1. Set the Samba configuration in the `/etc/samba/smb.conf` file. You can edit the file using the `nano` utility:

   ```bash
   $ sudo nano /etc/samba/smb.conf
   ```

   Make the file look like:

   {% list tabs %}

   - Ubuntu

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
        passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
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

   - CentOS 6

     ```
     [global]
        workgroup = MYGROUP
        server string = Samba Server Version %v
        log file = /var/log/samba/log.%m
        max log size = 50
        security = user
        passdb backend = tdbsam
        load printers = yes
        cups options = raw
        map to guest = bad user
     [homes]
        comment = Home Directories
        browseable = no
        writable = yes
     [printers]
        comment = All Printers
        path = /var/spool/samba
        browseable = no
        guest ok = no
        writable = no
        printable = yes
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

   - CentOS 7

     ```
     [global]
             workgroup = SAMBA
             security = user

             passdb backend = tdbsam

             printing = cups
             printcap name = cups
             load printers = yes
             cups options = raw

     [homes]
             comment = Home Directories
             valid users = %S, %D%w%S
             browseable = No
             read only = No
             inherit acls = Yes

     [printers]
             comment = All Printers
             path = /var/tmp
             printable = Yes
             create mask = 0600
             browseable = No

     [print$]
             comment = Printer Drivers
             path = /var/lib/samba/drivers
             write list = @printadmin root
             force group = @printadmin
             create mask = 0664
             directory mask = 0775
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

   {% endlist %}

   In the `[data]` section, instead of `<IP address>`, specify the IP address of the computer to which you are going to connect the network data disk via NFS.

1. Restart NFS and Samba; for CentOS 6 and 7, first allow reading files in the `/data` directory:

   {% list tabs %}

   - Ubuntu

     ```bash
     $ sudo service nfs-kernel-server restart
     $ sudo service smbd restart
     ```

   - CentOS

     ```bash
     $ sudo chcon -t samba_share_t /data
     $ sudo semanage fcontext -a -t samba_share_t "/data(/.*)?"
     $ sudo restorecon -R -v /data
     $ sudo service rpcbind restart
     $ sudo service nfs restart
     $ sudo service smb restart
     ```

   {% endlist %}

1. This step should only be performed on a VM running CentOS 6.

   Allow network access to the VM using the `iptables` utility:

   ```bash
   $ sudo iptables -I INPUT -p tcp -s <IP address> -j ACCEPT
   $ sudo iptables -I INPUT -p udp -s <IP address> -j ACCEPT
   $ sudo iptables-save | sudo tee /etc/sysconfig/iptables
   ```

   Instead of`<IP address>`, specify the IP address of the computer to which you are going to connect the network data disk via NFS.

## 3. Test the file server operation {#test-file-server}

1. On the `fileserver-tutorial` VM, create a test directory with a file as follows:

   ```bash
   $ sudo mkdir /data/fileserver-tutorial
   $ sudo setfacl -m u:<your user's name>:w /data/fileserver-tutorial
   $ echo "Hello world!" > /data/fileserver-tutorial/test.txt
   ```

1. Connect the network disk to your computer via NFS and check if the test file is available:

   {% list tabs %}

   - Linux/macOS

     Run the command `mount -t nfs <external IP>:/data /<mount point>`.

     The test directory and its file must be available at the specified mount point.

   - Windows
     1. Run the **cmd.exe** utility. To do this, use the keyboard shortcut **Windows**+**R** and run the command `cmd`.
     1. From the command line, run:

         ```
         net use x: \\<VM's public IP address>\data
         ```

     The test directory and its file must be available on disk X.

   {% endlist %}

