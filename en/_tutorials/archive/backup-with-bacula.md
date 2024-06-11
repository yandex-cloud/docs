# Backup to {{ objstorage-full-name }} via Bacula

You can use {{ objstorage-full-name }} for VM backup and recovery via the [Bacula](https://www.bacula.org/) utility.

Bacula consists of several components:
* **Bacula Director**: Controls the backup and recovery process.
* **File Daemon**: Provides access to backup files.
* **Storage Daemon**: Reads and writes files to the hard disk.
* **Catalog**: Maintains the file catalog used for backup. The catalog is stored in a [MariaDB](https://mariadb.com/kb/en/documentation/) database.
* **Bacula Console**: A management console for interacting with Bacula Director.

To set up backup and recovery via Bacula:
1. [Prepare your cloud](#before-you-begin).
1. [Create a VM](#create-vm).
1. [Set up the AWS CLI](#configure-aws).
1. [Install Bacula and additional components](#install-bacula).
1. [Configure MariaDB](#configure-db).
1. [Set up a storage](#configure-storage).
1. [Configure Bacula components](#configure-bacula).
1. [Create a backup](#run-backup).
1. [Recover the files](#run-restore).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost for backup and recovery includes:

* Fee for VM computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* A fee for data storage in a bucket and operations with data (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


### Create a bucket {#create-bucket}

To create a bucket for backups in {{ objstorage-name }}:

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you will perform the operations.
   1. On the folder page, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_storage }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket.
   1. Set the [public access](../../storage/security/public-access.md) parameters to read [objects](../../storage/concepts/object.md) in the bucket, get a list of objects, and read bucket settings, i.e., `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
   1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_class }}** field, select **{{ ui-key.yacloud.storage.bucket.settings.class_value_cold }}**.
   1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

### Create a service account {#create-service-account}

[Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `editor` [role](../../iam/concepts/access-control/roles.md).

### Create static access keys {#create-access-key}

[Create](../../iam/operations/sa/create-access-key.md) static access keys.

Make sure to immediately save the ID `key_id` and secret key `secret`. You will not be able to get the key value again.

## Create a VM {#create-vm}

To create a VM:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}**.
   1. In the **{{ ui-key.yacloud.common.name }}** field, enter the VM name: `bacula-vm`.
   1. Select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, go to the **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}** tab and select a public [CentOS 7](/marketplace/products/yc/centos-7) image.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select:
      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Cascade Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the network and subnet to connect the VM to. If there are no networks available, create one:
      1. Select ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}**.
      1. In the window that opens, enter the network name and specify the folder to host the network.
      1. (Optional) To automatically create subnets, select the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option.
      1. Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

         Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet available, create one by selecting ![image](../../_assets/plus-sign.svg) **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
   1. Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, keep **{{ ui-key.yacloud.component.compute.network-select.switch_auto }}** to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.
   1. Specify the VM access data:
      * Enter the username in the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field.
      * In the **{{ ui-key.yacloud.compute.instances.create.field_key }}** field, paste the contents of the public key file.

         You will need to create a key pair for the SSH connection yourself; see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) for details.
   1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
   1. Wait for the VM status to change to `RUNNING`.

{% endlist %}

## Set up the AWS CLI {#configure-aws}

To set up the AWS CLI utility on your `bacula-vm` instance:

1. In the [management console]({{ link-console-main }}), go to the VM page and find out its public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH.

   The recommended authentication method when connecting over SSH is using a key pair. Set up the generated key pair: the private key must match the public key sent to the VM.
1. Update the packages installed in the system. For this, in the terminal, run:

   ```bash
   yum update -y
   ```

1. Install the AWS CLI:

   ```bash
   yum install awscli -y
   ```

1. Set up the AWS CLI:

   ```bash
   sudo aws configure
   ```

   Specify the parameter values:
   * `AWS Access Key ID`: The `key_id` that you received when [generating the static key](#create-access-key).
   * `AWS Secret Access Key`: The `secret` key that you received when [generating the static key](#create-access-key).
   * `Default region name`: `{{ region-id }}`.
   * `Default output format`: `json`.
1. Make sure that the `/root/.aws/credentials` file contains relevant values for `key_id` and `secret`:

   ```bash
   sudo cat /root/.aws/credentials
   ```

1. Make sure that the `/root/.aws/config` file contains relevant values for `Default region name` and `Default output format`:

   ```bash
   sudo cat /root/.aws/config
   ```

## Install Bacula and additional components {#install-bacula}

1. Install the Bacula components:

   ```bash
   sudo yum install -y bacula-director bacula-storage bacula-console bacula-client
   ```

1. Install [MariaDB](https://mariadb.com/kb/en/documentation/):

   ```bash
   sudo yum install -y mariadb-server
   ```

1. Install the `s3fs` utility to mount the {{ objstorage-name }} bucket to the file system:

   ```bash
   sudo yum install -y epel-release
   sudo yum install -y s3fs-fuse
   ```

1. Install the `nano` text editor:

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

1. Secure your database:

   ```bash
   sudo mysql_secure_installation
   ```

   For the following queries:
   * `Enter current password for root (enter for none)`: Press **Enter** to skip the field.
   * `Set root password? [Y/n]`: Enter `Y`, set the root password, and confirm it. You will need the password in the next step.
   * `Remove anonymous users? [Y/n]`: To accept the default value, press **Enter**.
   * `Disallow root login remotely? [Y/n]`: To accept the default value, press **Enter**.
   * `Remove test database and access to it? [Y/n]`: To accept the default value, press **Enter**.
   * `Reload privilege tables now? [Y/n]`: To accept the default value, press **Enter**.

1. Log in to the DB command line and enter the `root `password created in the previous step:

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

   ```bash
     Selection    Command
   -----------------------------------------------
      1           /usr/lib64/libbaccats-mysql.so
      2           /usr/lib64/libbaccats-sqlite3.so
   *+ 3           /usr/lib64/libbaccats-postgresql.so

   Enter to keep the current selection[+], or type selection number: 1
   ```

## Set up the storage {#configure-storage}

### Prepare a backup folder {#prepare-folder}

1. Create the `/tmp/bacula` backup folder:

   ```bash
   sudo mkdir /tmp/bacula
   ```

1. Set up access rights for the `/tmp/bacula` folder:

   ```bash
   sudo chown -R bacula:bacula /tmp/bacula
   sudo chmod -R 700 /tmp/bacula
   sudo semanage permissive -a bacula_t
   ```

### Mount the bucket to the file system {#mount-bucket}

1. Use the `s3fs` utility to mount the bucket to upload backups to {{ objstorage-name }}. To do this, run the command below and specify the bucket name:

   ```bash
   sudo s3fs <bucket_name> /tmp/bacula \
     -o url=https://{{ s3-storage-host }} \
     -o use_path_request_style \
     -o allow_other \
     -o nonempty \
     -o uid=133,gid=133,mp_umask=077
   ```

   Where:
   * `uid=133`: The ID of the `bacula` user from the `/etc/passwd` file.
   * `gid=133`: The ID of the `bacula` group from the `/etc/passwd` file.

1. Check the access rights for the `/tmp/bacula` folder:

   ```bash
   sudo ls -la /tmp/bacula/
   ```

   Result:

   ```text
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

   1. In the [management console]({{ link-console-main }}), on the folder page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** and make sure the `test.test` file is in the bucket.
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

1. To set up a connection to Bacula Director, go to the `Director` configuration section and add the line `DirAddress = 127.0.0.1`:

   ```text
   ...
   Director {                              # define myself
     Name = bacula-dir
     DIRport = 9101                        # Specify the port (a positive integer) on which the Director daemon will listen for Bacula Console connections.
                                           # This same port number must be specified in the Director resource of the Console configuration file.
                                           # The default is 9101, so normally this directive need not be specified.
                                           # This directive should not be used if you specify the DirAddresses (plural) directive.
     QueryFile = "/etc/bacula/query.sql"
     WorkingDirectory = "/var/spool/bacula"
     PidDirectory = "/var/run"
     Maximum Concurrent Jobs = 1
     Password = "@@DIR_PASSWORD@@"         # Console password
     Messages = Daemon
     DirAddress = 127.0.0.1
   }    
   ...
   ```

1. For your convenience, rename the task `BackupClient1` to `BackupFiles`:

   ```text
   ...
   Job {
     Name = "BackupFiles"
     JobDefs = "DefaultJob"
   }
   ...
   ```

1. To assign `/tmp/bacula-restores` as a folder for your recovered files, add the line `Where = /tmp/bacula-restores` to the `RestoreFiles` job configuration:

   ```text
   ...
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
   ...
   ```

1. Under the `FileSet` configuration section named `Full Set` under `Include`:
   * Add the `compression = GZIP` line to the `Options` section to enable compression during backup.
   * Specify `File = /` to back up the entire file system.

   ```text
   ...
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
   ...
   ```

1. In the [management console]({{ link-console-main }}), go to the VM page and find out its private IP address.
1. To set up an outbound connection to the Storage Daemon, in the `Storage` configuration section, enter the VM's internal IP address in the `Address` field:

   ```text
   ...
   Storage {
     Name = File
   # Do not use "localhost" here
     Address = <internal_IP_address_of_the_VM>  # N.B. Use a fully qualified name here
     SDPort = 9103
     Password = "@@SD_PASSWORD@@"
     Device = FileStorage
     Media Type = File
   }
   ...
   ```

1. To connect to the DB, in the `Catalog` configuration section, specify the database password `dbpassword = "bacula_db_password"` that you created when [setting up MariaDB](#configure-db):

   ```text
   ...
   # Generic catalog service
   Catalog {
     Name = MyCatalog
   # Uncomment the following line if you want the dbi driver
   # dbdriver = "dbi:postgresql"; dbaddress = 127.0.0.1; dbport =
     dbname = "bacula"; dbuser = "bacula"; dbpassword = "bacula_db_password"
   }
   ...
   ```

1. Save the file.
1. Check that the `bacula-dir.conf` file contains no syntax errors:

   ```bash
   sudo bacula-dir -tc /etc/bacula/bacula-dir.conf
   ```

   If there are no error messages, the configuration is correct.

### Configure Storage Daemon {#configure-storage-daemon}

1. Open the Storage Daemon configuration file:

   ```bash
   sudo nano /etc/bacula/bacula-sd.conf
   ```

1. To set up an outbound connection to the Storage Daemon, in the `Storage` configuration section, enter the VM's internal IP address in the `SDAddress` field:

   ```text
   ...
   Storage {                                      # definition of myself
     Name = BackupServer-sd
     SDPort = 9103                                # Specifies port number on which the Storage daemon listens for Director connections. The default is 9103.
     WorkingDirectory = "/var/spool/bacula"
     Pid Directory = "/var/run/bacula"
     Maximum Concurrent Jobs = 20
     SDAddress = <internal_IP_address_of_the_VM>         # This directive is optional, and if it is specified,
                                                  # it will cause the Storage daemon server (for Director and File daemon connections) to bind to the specified IP-Address,
                                                  # which is either a domain name or an IP address specified as a dotted quadruple.
                                                  # If this directive is not specified, the Storage daemon will bind to any available address (the default).
   }
   ...
   ```

1. In the `Device` configuration block, specify the `Archive Device = /tmp/bacula` folder for backups:

   ```text
   ...
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
   ...
   ```

1. Save the file.
1. Check that the `bacula-sd.conf` file doesn't contain any syntax errors:

   ```bash
   sudo bacula-sd -tc /etc/bacula/bacula-sd.conf
   ```

   If there are no error messages, the configuration is correct.

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

1. To set up a backup profile, create a label:

   ```bash
   label
   ```

1. Name the new volume `MyVolume`:

   ```bash
   Enter new Volume name: MyVolume
   ```

1. To select the `File` pool, enter `2`:

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

   To start the `BackupFiles` job, select `1`:

   ```bash
   A job name must be specified.
   The defined Job resources are:
       1: BackupFiles
       2: BackupCatalog
       3: RestoreFiles
   Select Job resource (1-3): 1
   ```

   To confirm the startup, enter `yes`:

   ```bash
   OK to run? (yes/mod/no): yes
   ```

1. Check the backup status:

   ```bash
   status director
   ```

   Result if the backup is running:

   ```text
   Running Jobs:
   Console connected at 12-Sep-19 07:22
    JobId Level   Name                       Status
   ======================================================================
        2 Full    BackupFiles.2019-09-12_07.22.56_03 is running
   ```

   Result if the backup is complete:

   ```text
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

### Check the backup {#check-backup}

To make sure that the backup is complete:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), on the folder page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Open the bucket.
   1. Make sure it contains `MyVolume`.

{% endlist %}

## Recover the files {#run-restore}

1. To check the recovery process, delete an arbitrary file, for example, the `ping` utility:

   ```bash
   sudo rm -f /bin/ping
   ```

1. Make sure that the `ping` utility is deleted:

   ```bash
   ping
   ```

   Result:

   ```text
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

   Enter `5` to start recovering from the latest backup:

   ```bash
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

   To confirm full recovery, enter `done`:

   ```bash
   You are now entering file selection mode where you add (mark) and
   remove (unmark) files to be restored. No files are initially added, unless
   you used the "all" keyword on the command line.
   Enter "done" to leave this mode.

   cwd is: /
   done
   ```

   To confirm the recovery startup, enter `yes`:

   ```bash
   OK to run? (yes/mod/no): yes
   ```

1. Check the recovery status:

   ```bash
   status director
   ```

   Here's the result if the recovery is in progress:

   ```text
   Running Jobs:
   Console connected at 12-Sep-19 07:25
    JobId Level   Name                       Status
   ======================================================================
        3         RestoreFiles.2019-09-12_07.27.42_05 is running
   ```

   Here's the result if the recovery is complete:

   ```text
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

### Check the recovered files {#check-restore}

1. Make sure that the `/tmp/bacula-restores` folder now contains the recovered data:

   ```bash
   sudo ls -la /tmp/bacula-restores
   ```

   Result:

   ```text
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

   ```text
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

   ```text
   PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
   64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.016 ms

   --- 127.0.0.1 ping statistics ---
   1 packets transmitted, 1 received, 0% packet loss, time 0ms
   rtt min/avg/max/mdev = 0.016/0.016/0.016/0.000 ms
   ```

1. To free up disk space, delete the copy of the recovered files:

   ```bash
   sudo rm -rfd /tmp/bacula-restores/*
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
1. [Delete](../../storage/operations/objects/delete-all.md) all objects from the {{ objstorage-name }} bucket:
1. [Delete](../../storage/operations/buckets/delete.md) the {{ objstorage-name }} bucket.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP if you reserved one.
