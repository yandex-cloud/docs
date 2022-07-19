# Backup to {{ objstorage-full-name }} via Bacula on Centos 7

In these instructions, you'll learn how to create backups in {{ objstorage-full-name }} and recover data via [Bacula](https://www.bacula.org/) on CentOS 7 in the {{ yandex-cloud }} infrastructure.

Bacula consists of several components:

* **Bacula Director**: Controls the backup and recovery process.
* **File Daemon**: Provides access to backup files.
* **Storage Daemon**: Reads and writes files to the hard disk.
* **Catalog**: Maintains the file catalog used for backups. The catalog is stored in an SQL database.
* **Bacula Console**: A management console for interacting with Bacula Director.

To back up and recover your data via Bacula:

1. [Before you start](#before-you-begin).
1. [Create a VM](#create-vm).
1. [Install Bacula and the additional components](#install-bacula).
1. [Configure MariaDB](#configure-db).
1. [Configure backup storage](#configure-storage).
1. [Configure the Bacula components](#configure-bacula).
1. [Create a backup](#run-backup).
1. [Check the backup](#check-backup).
1. [Run the recovery process](#run-restore).
1. [Check the recovered data](#check-restore).

If you no longer need the backup or recovered data, [delete all related resources](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost for backup and recovery includes:

* A fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing)).
* A fee for data storage (see [{{ objstorage-full-name }} pricing](../../storage/pricing)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing)).


## Creating VMs {#create-vm}

To create a VM:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter a name for the VM: `bacula-vm`.

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, and select the public [CentOS 7](/marketplace/products/yc/centos-7) image.

1. Under **Computing resources**, select:
    * **Platform**: Intel Cascade Lake.
    * **Guaranteed vCPU share**: 20%.
    * **vCPU**: 2.
    * **RAM**: 2 GB.

1. In the **Network settings** section, select the network and subnet to connect the VM to. If you don't have a network or subnet, create them right on the VM creation page.

1. In the **Public address** field, leave the **Auto** value to assign a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.

1. Specify data required for accessing the VM:

    - Enter the username in the **Login** field.

    - In the **SSH key** field, paste the contents of the public key file.

       You need to create a key pair for the SSH connection yourself. Learn [how to connect to VMs via SSH](../../compute/operations/vm-connect/ssh.md).

     {% note alert %}

     The IP address and host name (FQDN) to connect to the VM are assigned on VM creation. If you selected **No address** in the **Public address** field, you won't be able to access the VM from the internet.

     {% endnote %}

1. Click **Create VM**.

Creating the VM may take several minutes.

When the VM is created, it is assigned a public IP address and hostname (FQDN). This data can be used for SSH access.

## Create a bucket {#create-bucket}

To create a bucket for backups in {{ objstorage-name }}:

1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you want to perform the operations.

1. On the folder page, click **Create resource** and select **Bucket**.

1. In the **Name** field, enter a name for the bucket: `bacula-bucket`.

1. In the **Bucket access** field, select **Restricted**.

1. In the **Storage class** field, select **Cold**.

1. Click **Create bucket**.

## Create a service account {#create-service-account}

Create a [service account](../../iam/operations/sa/create.md) and [assign it the role](../../iam/operations/sa/assign-role-for-sa) `editor`.

## Create static access keys {#create-access-key}

Create [static access keys](../../iam/operations/sa/create-access-key.md).

Make sure to immediately save the `key_id` ID and `secret` secret key. You will not be able to get the key value again.

## Set up the AWS CLI {#configure-aws}

After `bacula-vm` switches to `RUNNING`:

1. You can learn the IP address of the VM under **Network** on the VM page in the [management console]({{ link-console-main }}).

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH. You can use the `ssh` tool in Linux and macOS or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) for Windows.

    The recommended authentication method when connecting over SSH is using a key pair. Don't forget to set up the created key pair: the private key must match the public key sent to the VM.

1. Install the yum repository:

    ```bash
    sudo yum install epel-release -y
    ```

1. Install `pip`:

    ```bash
    sudo yum install python-pip -y
    ```

1. Install the AWS CLI:

    ```bash
    sudo pip install awscli --upgrade
    ```

1. Set up the AWS CLI:

    ```bash
    sudo aws configure
    ```

    The command will request values for parameters:
    * `AWS Access Key ID`: Enter the `key_id` ID that you received when [generating the static key](#create-access-key).
    * `AWS Secret Access Key`: Enter the `secret` key that you received when [creating the static key](#create-access-key).
    * `Default region name`: `{{ region-id }}`.
    * `Default output format`: `json`.

1. Check that the `/root/.aws/credentials` file contains the correct `key_id` and `secret` values:

    ```bash
    sudo cat /root/.aws/credentials
    ```

1. Check that the `/root/.aws/config` file contains the correct `Default region name` and `Default output format` values:

    ```bash
    sudo cat /root/.aws/config
    ```

## Install Bacula and additional components {#install-bacula}

1. Install the Bacula components:

    ```bash
    sudo yum install -y bacula-director bacula-storage bacula-console bacula-client
    ```

1. Install MariaDB:

    ```bash
    sudo yum install -y mariadb-server
    ```

1. Install `s3fs` to mount the {{ objstorage-name }} bucket on the server:

    ```bash
    sudo yum install -y s3fs-fuse
    ```

1. Install the text editor `nano`:

    ```bash
    sudo yum install -y nano
    ```

## Configure MariaDB {#configure-db}

1. Run MariaDB:

    ```bash
    sudo systemctl start mariadb
    ```

1. Check that MariaDB is running:

    ```bash
    sudo systemctl status mariadb | grep Active
    ```

1. Enable MariaDB to run at system startup:

    ```bash
    sudo systemctl enable mariadb
    ```

1. Create database tables and configure access rights:

    ```bash
    /usr/libexec/bacula/grant_mysql_privileges
    /usr/libexec/bacula/create_mysql_database -u root
    /usr/libexec/bacula/make_mysql_tables -u bacula    
    ```

1. Configure the database security parameters:

    ```bash
    sudo mysql_secure_installation
    ```
    * `Enter current password for root (enter for none)`: Press **Enter** to skip the field.
    * `Set root password? [Y/n]`: Enter `Y`, set the root password, and confirm it. You will need the password in the next step.
    * `Remove anonymous users? [Y/n]`: Press **Enter** to accept the default value.
    * `Disallow root login remotely? [Y/n]`: Press **Enter** to accept the default value.
    * `Remove test database and access to it? [Y/n]`: Press **Enter** to accept the default value.
    * `Reload privilege tables now? [Y/n]`: Press **Enter** to accept the default value.

1. Log in to the DB command line and enter the `root` password created in the previous step:

    ```bash
    mysql -u root -p
    ```

1. Create the password `bacula_db_password` for the `bacula` user:

    ```bash
    UPDATE mysql.user SET Password=PASSWORD('bacula_db_password') WHERE User='bacula';
    FLUSH PRIVILEGES;
    exit
    ```

1. Enable the MySQL library for Bacula:

    ```bash
    sudo alternatives --config libbaccats.so
    ```

    Enter `1` to select MySQL:

    ```
      Selection    Command
    -----------------------------------------------
       1           /usr/lib64/libbaccats-mysql.so
       2           /usr/lib64/libbaccats-sqlite3.so
    *+ 3           /usr/lib64/libbaccats-postgresql.so
    
    Enter to keep the current selection[+], or type selection number: 1
    ```

## Configure backup storage {#configure-storage}

### Prepare a backup folder {#prepare-folder}

1. Create the `/tmp/bacula` backup folder:

    ```bash
    sudo mkdir /tmp/bacula
    ```

1. Configure access rights to `/tmp/bacula`:

    ```bash
    sudo chown -R bacula:bacula /tmp/bacula
    sudo chmod -R 700 /tmp/bacula  
    sudo semanage permissive -a bacula_t 
    ```

### Mount the bucket to the file system {#mount-bucket}

Mount the bucket to the file system to upload copied files to {{ objstorage-name }}:

1. Mount the bucket using `s3fs`:

    ```bash
    sudo s3fs bacula-bucket /tmp/bacula -o url=https://{{ s3-storage-host }} -o use_path_request_style -o allow_other -o nonempty -o uid=133,gid=133,mp_umask=077
    ```

    Where:

    * `bacula-bucket`: The name of the bucket in {{ objstorage-name }}.
    * `uid=133`: The ID of the `bacula` user from the `/etc/passwd` file.
    * `gid=133`: The ID of the `bacula` group from the `/etc/passwd` file.

1. Check the access rights for the `/tmp/bacula` folder:

    ```bash
    sudo ls -la /tmp/bacula/
    ```

    Result:

    ```
    drwx------.  2 bacula bacula        31 Sep 18 09:16 .
    drwxrwxrwt. 10 root   root         265 Sep 18 08:59 ..
    ```

1. Check that the `bacula` user can create files in the `/tmp/bacula` folder:

    1. Temporarily enable the `bash` shell for the `bacula` user:

        ```bash
        sudo sed -i "/^bacula/ s@/sbin/nologin@/bin/bash@" /etc/passwd 
        ```

    1. Create an arbitrary file in the `/tmp/bacula` folder:

        ```bash
        sudo runuser -l  bacula -c 'touch /tmp/bacula/test.test' 
        ```

    1. Make sure that the file `test.test` was created in the `/tmp/bacula` folder:

        ```bash
        sudo ls -la /tmp/bacula | grep test.test 
        ```

    1. On the catalog page in the [management console]({{ link-console-main }}), open **Object Storage**. Make sure the file `test.test` is visible in the `bacula-bucket` bucket.

    1. Delete the test file:

        ```bash
        sudo runuser -l  bacula -c 'rm -f /tmp/bacula/test.test' 
        ```

    1. Disable the `bash` shell for the `bacula` user:

        ```bash
        sudo sed -i "/^bacula/ s@/bin/bash@/sbin/nologin@" /etc/passwd 
        ```

## Configure Bacula components {#configure-bacula}

### Configure Bacula Director {#configure-director}

1. Open the Bacula Director configuration file:

    ```bash
    sudo nano /etc/bacula/bacula-dir.conf
    ```

1. In the `Director` configuration block, add the line `DirAddress = 127.0.0.1` to set up a connection with Bacula Director:

    ```
    Director {                            # define myself
      Name = bacula-dir
      DIRport = 9101                # where we listen for UA connections
      QueryFile = "/etc/bacula/query.sql"
      WorkingDirectory = "/var/spool/bacula"
      PidDirectory = "/var/run"
      Maximum Concurrent Jobs = 1
      Password = "@@DIR_PASSWORD@@"         # Console password
      Messages = Daemon
      DirAddress = 127.0.0.1
    }    
    ```

1. For your convenience, rename the task `BackupClient1` to `BackupFiles`:

    ```
    Job {
      Name = "BackupFiles"
      JobDefs = "DefaultJob"
    }
    ```

1. In the `RestoreFiles` task configuration, add the line `Where = /tmp/bacula-restores` to make `/tmp/bacula-restores` a folder for restored files:

    ```
    Job {
      Name = "RestoreFiles"
      Type = Restore
      Client=bacula-fd
      FileSet="Full Set"
      Storage = File
      Pool = Default
      Messages = Standard
      Where = /tmp/bacula-restores
    }
    ```

1. Under the `FileSet` configuration section named `Full Set` under `Include`:
    * Add the `compression = GZIP` line to the `Options` section to enable compression during backup.
    * Specify `File = /` to back up the entire file system.

    ```
    	FileSet {
    	  Name = "Full Set"
    	  Include {
    		Options {
    		  signature = MD5
    		  compression = GZIP
    		}
    		File = /
    	  }
    	  Exclude {
    		File = /var/spool/bacula
    		File = /tmp
    		File = /proc
    		File = /tmp
    		File = /.journal
    		File = /.fsck
    	  }
    	}
    ```

1. You can find the internal IP address of the VM under **Network** on the VM page in the [management console]({{ link-console-main }}).

1. In the `Storage` configuration block, enter the internal IP address of the VM in the `Address` field to set up a connection with Storage Daemon:

    ```
    Storage {
      Name = File
    # Do not use "localhost" here
      Address = <VM internal IP address> # N.B. Use a fully qualified name here
      SDPort = 9103
      Password = "@@SD_PASSWORD@@"
      Device = FileStorage
      Media Type = File
    }
    ```

1. To connect to the DB, in the `Catalog` configuration block, enter the database password `dbpassword = "bacula_db_password"` created when [configuring MariaDB](#configure-db):

    ```
    # Generic catalog service
    Catalog {
      Name = MyCatalog
    # Uncomment the following line if you want the dbi driver
    # dbdriver = "dbi:postgresql"; dbaddress = 127.0.0.1; dbport =
      dbname = "bacula"; dbuser = "bacula"; dbpassword = "bacula_db_password"
    }
    ```

1. Save the file.

1. Check that the `bacula-dir.conf` file doesn't contain any syntax errors:

    ```bash
    sudo bacula-dir -tc /etc/bacula/bacula-dir.conf
    ```

    If there aren't any error messages, the configuration is correct.

### Configure Storage Daemon {#configure-storage-daemon}

1. Open the Storage Daemon configuration file:

    ```bash
    sudo nano /etc/bacula/bacula-sd.conf
    ```

1. You can find the internal IP address of the VM under **Network** on the VM page in the [management console]({{ link-console-main }}).

1. In the `Storage` configuration block, enter the internal IP address of the VM in the `SDAddress` field to set up a connection with Storage Daemon:

    ```
    Storage {                             # definition of myself
      Name = BackupServer-sd
      SDPort = 9103                  # Director's port
      WorkingDirectory = "/var/spool/bacula"
      Pid Directory = "/var/run/bacula"
      Maximum Concurrent Jobs = 20
      SDAddress = <VM internal IP address> 
    }
    ```

1. In the `Device` configuration block, specify the `Archive Device = /tmp/bacula` folder for backups:

    ```
    Device {
      Name = FileStorage
      Media Type = File
      Archive Device = /tmp/bacula 
      LabelMedia = yes;                   # lets Bacula label unlabeled media
      Random Access = Yes;
      AutomaticMount = yes;               # when device opened, read it
      RemovableMedia = no;
      AlwaysOpen = no;
    }
    ```

1. Save the file.

1. Check that the `bacula-sd.conf` file doesn't contain any syntax errors:

    ```bash
    sudo bacula-sd -tc /etc/bacula/bacula-sd.conf
    ```

    If there aren't any error messages, the configuration is correct.

### Create passwords for Bacula components {#create-bacula-passwords}

Bacula Director, Storage Daemon, and File Daemon use passwords for inter-component authentication.

To set passwords for Bacula components:

1. Generate passwords for Bacula Director, Storage Daemon, and File Daemon:

    ```bash
    DIR_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
    SD_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
    FD_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
    ```

1. Put the passwords in the configuration files:

    ```bash
    sudo sed -i "s/@@DIR_PASSWORD@@/${DIR_PASSWORD}/" /etc/bacula/bacula-dir.conf
    sudo sed -i "s/@@DIR_PASSWORD@@/${DIR_PASSWORD}/" /etc/bacula/bconsole.conf
    sudo sed -i "s/@@SD_PASSWORD@@/${SD_PASSWORD}/" /etc/bacula/bacula-sd.conf
    sudo sed -i "s/@@SD_PASSWORD@@/${SD_PASSWORD}/" /etc/bacula/bacula-dir.conf
    sudo sed -i "s/@@FD_PASSWORD@@/${FD_PASSWORD}/" /etc/bacula/bacula-dir.conf
    sudo sed -i "s/@@FD_PASSWORD@@/${FD_PASSWORD}/" /etc/bacula/bacula-fd.conf
    ```

### Run the Bacula components {#run-bacula-components}

1. Run the Bacula components:

    ```bash
    sudo systemctl start bacula-dir
    sudo systemctl start bacula-sd
    sudo systemctl start bacula-fd
    ```

1. Check that the Bacula components are running:

    ```bash
    sudo systemctl status bacula-dir
    sudo systemctl status bacula-sd
    sudo systemctl status bacula-fd
    ```

1. Set up the Bacula components to launch at system startup:

    ```bash
    sudo systemctl enable bacula-dir
    sudo systemctl enable bacula-sd
    sudo systemctl enable bacula-fd
    ```

## Create a backup {#run-backup}

1. Open Bacula Console:

    ```bash
    sudo bconsole
    ```

1. Create a label to set up a backup profile:

    ```bash
    label
    ```

1. Name the new volume `MyVolume`:

    ```bash
    Enter new Volume name: MyVolume
    ```

1. Enter `2` to select the `File` pool:

    ```bash
    Defined Pools:
         1: Default
         2: File
         3: Scratch
    Select the Pool (1-3): 2
    ```

1. Run the backup process:

    ```bash
    run    
    ```

    Select `1` to start the `BackupFiles` task:

    ```bash
    A job name must be specified.
    The defined Job resources are:
        1: BackupFiles
        2: BackupCatalog
        3: RestoreFiles
    Select Job resource (1-3): 1    
    ```

    Enter `yes` to confirm the backup process launch:

    ```bash
    OK to run? (yes/mod/no): yes 
    ```

1. Check the backup status:

    ```bash
    status director
    ```

    Result if the backup is running:

    ```
    Running Jobs:
    Console connected at 12-Sep-19 07:22
     JobId Level   Name                       Status
    ======================================================================
         2 Full    BackupFiles.2019-09-12_07.22.56_03 is running
    ```

    Result if the backup is complete:

    ```
    Running Jobs:
    Console connected at 12-Sep-19 07:25
    No Jobs running.
    ====
    
    Terminated Jobs:
     JobId  Level    Files      Bytes   Status   Finished        Name 
    ====================================================================
         2  Full     32,776    483.6 M  OK       12-Sep-19 07:24 BackupFiles    
    ```

1. Wait for the backup to complete and exit Bacula Console:

    ```bash
    exit
    ```

## Check the backup {#check-backup}

To make sure that the backup is complete:

1. On the catalog page in the [management console]({{ link-console-main }}), open **Object Storage**.
1. Open the `bacula-bucket` bucket.
1. Make sure it contains `MyVolume`.

## Run the recovery process {#run-restore}

1. Delete an arbitrary file, like the `ping` utility, to check the recovery:

    ```bash
    sudo rm -f /bin/ping
    ```

1. Make sure that the `ping` utility is deleted:

    ```bash
    ping
    ```

    The command output should look as follows:

    ```bash
    bash: ping: command not found
    ```

1. Log in to Bacula Console:

    ```bash
    sudo bconsole
    ```

1. Run a full recovery:

    ```bash
    restore all
    ```

    Select `5` to start a recovery from the latest backup:

    ```
    To select the JobIds, you have the following choices:
        1: List last 20 Jobs run
        2: List Jobs where a given File is saved
        3: Enter list of comma separated JobIds to select
        4: Enter SQL list command
        5: Select the most recent backup for a client
        6: Select backup for a client before a specified time
        7: Enter a list of files to restore
        8: Enter a list of files to restore before a specified time
        9: Find the JobIds of the most recent backup for a client
        10: Find the JobIds for a backup for a client before a specified time
        11: Enter a list of directories to restore for found JobIds
        12: Select full restore to a specified Job date
        13: Cancel
    Select item:  (1-13): 5
    ```

    Enter `done` to confirm the full recovery:

    ```
    You are now entering file selection mode where you add (mark) and
    remove (unmark) files to be restored. No files are initially added, unless
    you used the "all" keyword on the command line.
    Enter "done" to leave this mode.
    
    cwd is: /
    done
    ```

    Enter `yes` to confirm the recovery process launch:

    ```
    OK to run? (yes/mod/no): yes
    ```

1. Check the recovery status:

    ```
    status director
    ```

    Result if the recovery is running:

    ```
    Running Jobs:
    Console connected at 12-Sep-19 07:25
     JobId Level   Name                       Status
    ======================================================================
         3         RestoreFiles.2019-09-12_07.27.42_05 is running
    ```

    Result if the recovery is complete:

    ```
    Terminated Jobs:
     JobId  Level    Files      Bytes   Status   Finished        Name 
    ====================================================================
         2  Full     32,776    483.6 M  OK       12-Sep-19 07:24 BackupFiles
         3           32,776    1.136 G  OK       12-Sep-19 07:27 RestoreFiles
    ```

1. Wait for the recovery to complete and exit Bacula Console:

    ```bash
    exit
    ```

## Check the recovery {#check-restore}

1. Make sure that the `/tmp/bacula-restores` folder now contains the recovered data:

    ```bash
    sudo ls -la /tmp/bacula-restores
    ```

    Result:

    ```bash
    total 16
    dr-xr-xr-x. 15 root   root    201 Sep 12 07:09 .
    drwx------.  4 bacula bacula   35 Sep 12 07:09 ..
    lrwxrwxrwx   1 root   root      7 Sep 12 07:27 bin -> usr/bin
    dr-xr-xr-x   5 root   root   4096 Sep 12 07:01 boot
    drwxr-xr-x   2 root   root      6 Sep 12 07:22 dev
    drwxr-xr-x  79 root   root   8192 Sep 12 07:07 etc
    drwxr-xr-x   3 root   root     18 Sep 12 07:01 home
    lrwxrwxrwx   1 root   root      7 Sep 12 07:27 lib -> usr/lib
    lrwxrwxrwx   1 root   root      9 Sep 12 07:27 lib64 -> usr/lib64
    drwxr-xr-x   2 root   root      6 Apr 11  2018 media
    drwxr-xr-x   2 root   root      6 Apr 11  2018 mnt
    drwxr-xr-x   2 root   root      6 Apr 11  2018 opt
    dr-xr-x---   3 root   root    217 Sep 12 07:21 root
    drwxr-xr-x   2 root   root      6 Sep 12 07:22 run
    lrwxrwxrwx   1 root   root      8 Sep 12 07:27 sbin -> usr/sbin
    drwxr-xr-x   2 root   root      6 Apr 11  2018 srv
    dr-xr-xr-x   2 root   root      6 Sep 12 07:22 sys
    drwxr-xr-x  13 root   root    155 Mar  4  2019 usr
    drwxr-xr-x  19 root   root    267 Sep 12 07:01 var
    ```

1. Make sure that the `ping` utility is in the `/tmp/bacula-restores` folder:

    ```bash
    sudo ls -la /tmp/bacula-restores/bin/ping
    ```

    Result:

    ```bash
    -rwxr-xr-x 1 root root 66176 Aug  4  2017 /tmp/bacula-restores/bin/ping
    ```

1. Copy the `ping` utility to the main file system:

    ```bash
    sudo cp /tmp/bacula-restores/bin/ping /bin/ping
    ```

1. Make sure that `ping` works:

    ```bash
    sudo ping 127.0.0.1 -c 1
    ```

    Result:

    ```bash
    PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
    64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.016 ms
    
    --- 127.0.0.1 ping statistics ---
    1 packets transmitted, 1 received, 0% packet loss, time 0ms
    rtt min/avg/max/mdev = 0.016/0.016/0.016/0.000 ms
    ```

1. Delete a copy of recovered files to free up disk space:

    ```bash
    sudo rm -rfd /tmp/bacula-restores/*
    ```

## How to delete created resources {#clear-out}

To stop paying for data storage, delete the [VM](../../compute/operations/vm-control/vm-delete.md) and [{{ objstorage-name }} bucket](../../storage/operations/buckets/delete).

If you reserved a static public IP address specifically for this VM:

1. Open the **Virtual Private Cloud** in your folder.
2. Go to the **IP addresses** tab.
3. Find the address you need, click ![ellipsis](../../_assets/options.svg), and select **Delete**.

