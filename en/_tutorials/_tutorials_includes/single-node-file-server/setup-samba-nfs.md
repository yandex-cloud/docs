After the `fileserver-tutorial` VM enters the `RUNNING` status, run:

1. On the VM page of the [management console]({{ link-console-main }}), under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, find the VM's public IP address.

1. [Connect](../../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

   We recommend using a key pair when authenticating over SSH. Make sure to set up the created key pair so that the private key matches the public key sent to the VM.

1. Configure Samba and NFS:

   {% list tabs group=operating_system %}

   - Ubuntu {#ubuntu}

     1. Download and install Samba:

        ```bash
        sudo apt-get update
        sudo apt-get install nfs-kernel-server samba
        ```

     1. Prepare and mount the file system on the disk:

        ```bash
        sudo mkfs -t ext4 -L data /dev/vdb
        ```

     1. Prepare and mount a folder named `my_folder` for data storage on the disk:

        ```bash
        sudo mkdir /my_folder
        echo "LABEL=data /my_folder ext4 defaults 0 0" | sudo tee -a /etc/fstab
        sudo mount /my_folder
        ```

     1. Set the NFS configuration in the `/etc/exports` file. You can edit the file using `nano`:

        ```bash
        sudo nano /etc/exports
        ```

        Add the following lines to the file:

        ```bash
        /my_folder <IP_address>(rw,no_subtree_check,fsid=100)
        /my_folder 127.0.0.1(rw,no_subtree_check,fsid=100)
        ```

        Where `<IP_address>` is the IP address of the computer you are going to connect the network data disk to via NFS.

     1. Set the Samba configuration in the `/etc/samba/smb.conf` file. You can edit the file using `nano`:

        ```bash
        sudo nano /etc/samba/smb.conf
        ```

        Edit the file as follows:

        ```bash
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
           comment = /my_folder
           path = /my_folder
           browseable = yes
           read only = no
           writable = yes
           guest ok = yes
           hosts allow = <IP_address> 127.0.0.1
           hosts deny = 0.0.0.0/0
        ```

        Where `<IP_address>` in the `[data]` section is the IP address of the computer you are going to connect the network data disk to via NFS.

     1. Restart Samba and NFS:

        ```bash
        sudo service nfs-kernel-server restart
        sudo service smbd restart
        ```

   {% endlist %}
