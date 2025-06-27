# Backing up to {{ objstorage-full-name }} with Bacula

You can use [Bacula](https://www.bacula.org/) to back up and recover your VM in{{ objstorage-full-name }}.

Bacula consists of multiple components:
* **Bacula Director**: Manages backup and recovery.
* **File Daemon**: Provides access to backup files. 
* **Storage Daemon**: Reads files and writes them to the hard disk.
* **Catalog**: Maintains the backup file catalog that resides in the [MariaDB](https://mariadb.com/kb/en/documentation/) database.
* **Bacula Console**: Management console for working with the Bacula Director. 

To configure Bacula backup and recovery:
1. [Get your cloud ready](#before-you-begin).
1. [Create a VM](#create-vm).
1. [Configure the AWS CLI](#configure-aws).
1. [Install Bacula and additional components](#install-bacula).
1. [Configure MariaDB](#configure-db).
1. [Configure a storage](#configure-storage).
1. [Configure the Bacula components](#configure-bacula).
1. [Run a backup job](#run-backup).
1. [Recover the files](#run-restore).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The backup and recovery support costs include:

* Fee for VM computing resources and disks (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for bucket data storage and data operations (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

### Create a bucket {#create-bucket}

To create a backup bucket in {{ objstorage-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder to work with.
  1. On the folder dashboard, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_storage }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, specify the bucket name.
  1. Set [public access](../../storage/security/public-access.md) to read [objects](../../storage/concepts/object.md) in the bucket, get an object list, and read bucket settings, i.e., `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_class }}** field, select **{{ ui-key.yacloud.storage.bucket.settings.class_value_cold }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

### Create a service account {#create-service-account}

[Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) the `editor` role to it.

### Create static access keys {#create-access-key}

[Create](../../iam/operations/authentication/manage-access-keys.md#create-access-key) static access keys.

Save `key_id` and the `secret` key right away. You will not be able to get the key again.

## Create a VM {#create-vm}

To create a VM:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select a public [CentOS 7](/marketplace/products/yc/centos-7) image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../overview/concepts/geo-scope.md) your VM will reside in.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and specify these settings:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `20%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter the ID of a subnet in the new VM’s availability zone. Alternatively, select a [cloud network](../../vpc/concepts/network.md#network) from the list.

          * Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
          * If you do not have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

              * In the window that opens, specify the network name and select the folder to host the network.
              * Optionally, enable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** setting to automatically create subnets in all availability zones.
              * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign a random external IP address from the {{ yandex-cloud }} pool to the VM. Alternatively, select a static address from the list if you reserved one.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a name for the user you want to create on the VM, e.g., `yc-user`.

        {% note alert %}

        Do not use `root` or other reserved usernames. To perform operations requiring root privileges, use the `sudo` command.

        {% endnote %}

      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `bacula-vm`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  1. Wait until the VM status switches to `RUNNING`.

{% endlist %}

## Configure the AWS CLI {#configure-aws}

To configure the AWS CLI on `bacula-vm`:

1. In the [management console]({{ link-console-main }}), navigate to the VM page and get the VM’s public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

    We recommend using a key pair when authenticating over SSH. Configure the generated key pair so that the private key matches the public key sent to the VM.
1. Update the installed packages by running this command in the terminal:

    ```bash
    yum update -y
    ```

1. Install the AWS CLI:

    ```bash
    yum install awscli -y
    ```

1. Configure the AWS CLI:

    ```bash
    sudo aws configure
    ```

    Specify these settings:
    * `AWS Access Key ID`: `key_id` you got when [creating the static key](#create-access-key).
    * `AWS Secret Access Key`: The `secret` key you got when [creating the static key](#create-access-key).
    * `Default region name`: `{{ region-id }}`.
    * `Default output format`: `json`.
1. Make sure the `key_id` and `secret` values in the `/root/.aws/credentials` file are correct:

    ```bash
    sudo cat /root/.aws/credentials
    ```

1. Make sure the `Default region name` and `Default output format` values in the `/root/.aws/config` file are correct:

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

1. Install the `s3fs` tool to mount the {{ objstorage-name }} bucket to the file system:

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

1. Make sure MariaDB is running:

    ```bash
    sudo systemctl status mariadb | grep Active
    ```

1. Configure MariaDB to run at system startup:

    ```bash
    sudo systemctl enable mariadb
    ```

1. Create database tables and configure access permissions:

    ```bash
    /usr/libexec/bacula/grant_mysql_privileges
    /usr/libexec/bacula/create_mysql_database -u root
    /usr/libexec/bacula/make_mysql_tables -u bacula
    ```

1. Configure database security:

    ```bash
    sudo mysql_secure_installation
    ```

    For these queries:
    * `Enter current password for root (enter for none)`: Press **Enter** to skip this field.
    * `Set root password? [Y/n]`: Enter `Y`, specify the root password, and confirm it. You will need the password at the next step.
    * `Remove anonymous users? [Y/n]`: Press **Enter** to accept the default value.
    * `Disallow root login remotely? [Y/n]`: Press **Enter** to accept the default value.
    * `Remove test database and access to it? [Y/n]`: Press **Enter** to accept the default value.
    * `Reload privilege tables now? [Y/n]`: Press **Enter** to accept the default value.

1. Log in to the database and enter the `root` password you created at the previous step:

    ```bash
    mysql -u root -p
    ```

1. Create `bacula_db_password` for the `bacula` user:

    ```bash
    UPDATE mysql.user SET Password=PASSWORD('bacula_db_password') WHERE User='bacula';
    FLUSH PRIVILEGES;
    exit
    ``` 

1. Configure the MySQL library for Bacula:

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

## Configure a storage {#configure-storage}

### Prepare a backup folder {#prepare-folder}

1. Create a backup folder named `/tmp/bacula`:

    ```bash
    sudo mkdir /tmp/bacula
    ``` 

1. Configure access permissions for the `/tmp/bacula` folder:

    ```bash
    sudo chown -R bacula:bacula /tmp/bacula
    sudo chmod -R 700 /tmp/bacula
    sudo semanage permissive -a bacula_t 
    ``` 

### Mount the bucket to the file system {#mount-bucket}

1. To upload backups to {{ objstorage-name }}, use `s3fs` to mount the bucket by running the command below and specifying the bucket name:

    ```bash
    sudo s3fs <bucket_name> /tmp/bacula \
      -o url=https://{{ s3-storage-host }} \
      -o use_path_request_style \
      -o allow_other \
      -o nonempty \
      -o uid=133,gid=133,mp_umask=077
    ```

    Where:
    * `uid=133`: `bacula` user ID from the `/etc/passwd` file.
    * `gid=133`: `bacula` group ID from the `/etc/passwd` file.

1. Check the access permissions for the `/tmp/bacula` folder:

    ```bash
    sudo ls -la /tmp/bacula/
    ```

    Result:

    ```text
    drwx------.  2 bacula bacula        31 Sep 18 09:16 .
    drwxrwxrwt. 10 root   root         265 Sep 18 08:59 ..
    ```

1. Make sure the `bacula` user can create files in the `/tmp/bacula` folder:
    1. Enable the `bash` shell for the `bacula` user:

        ```bash
        sudo sed -i "/^bacula/ s@/sbin/nologin@/bin/bash@" /etc/passwd 
        ```

    1. In the `/tmp/bacula` folder, create a file:

        ```bash
        sudo runuser -l  bacula -c 'touch /tmp/bacula/test.test' 
        ```

    1. Make sure you have created the `test.test` file in the `/tmp/bacula` folder:

        ```bash
        sudo ls -la /tmp/bacula | grep test.test 
        ```

    1. On the folder dashboard of the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** and check whether the `test.test` file is in the bucket.
    1. Delete the test file:

        ```bash
        sudo runuser -l  bacula -c 'rm -f /tmp/bacula/test.test' 
        ```

    1. Disable the `bash` shell for the `bacula` user:

        ```bash
        sudo sed -i "/^bacula/ s@/bin/bash@/sbin/nologin@" /etc/passwd 
        ```

## Configure the Bacula components {#configure-bacula}

### Configure the Bacula Director {#configure-director}

1. Open the Bacula Director configuration file:

    ```bash
    sudo nano /etc/bacula/bacula-dir.conf
    ```

1. To set up a connection to the Bacula Director, add the `DirAddress = 127.0.0.1` line in the `Director` configuration section:

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

1. For your convenience, rename the `BackupClient1` task to `BackupFiles`:

    ```text
    ...
    Job {
      Name = "BackupFiles"
      JobDefs = "DefaultJob"
    }
    ...
    ```

1. To assign `/tmp/bacula-restores` as the folder for your recovered files, add the `Where = /tmp/bacula-restores` line to the `RestoreFiles` job configuration section:

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

1. Under `Include`, in the `FileSet` configuration section named `Full Set`:
    * Add the `compression = GZIP` line to the `Options` section to enable backup compression.
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

1. In the [management console]({{ link-console-main }}), navigate to the VM page and get the VM’s internal IP address.
1. To set up an outbound connection to the Storage Daemon, specify the VM’s internal IP address in the `Address` field of the `Storage` configuration section:

    ```text
    ...
    Storage {
      Name = File
    # Do not use "localhost" here
      Address = <VM_internal_IP_address>  # N.B. Use a fully qualified name here
      SDPort = 9103
      Password = "@@SD_PASSWORD@@"
      Device = FileStorage
      Media Type = File
    }
    ...
    ```

1. To connect to the DB, specify `dbpassword = "bacula_db_password"` that you created when [setting up MariaDB](#configure-db) in the `Catalog` configuration section:

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
1. Make sure the `bacula-dir.conf` file has no syntax errors:

    ```bash
    sudo bacula-dir -tc /etc/bacula/bacula-dir.conf
    ```

    If there are no error messages, the configuration is correct.

### Configure Storage Daemon {#configure-storage-daemon}

1. Open the Storage Daemon configuration file:

    ```bash
    sudo nano /etc/bacula/bacula-sd.conf
    ``` 

1. To set up an outbound connection to the Storage Daemon, specify the VM’s internal IP address in the `SDAddress` field of the `Storage` configuration section:

    ```text
    ...
    Storage {                                      # definition of myself
      Name = BackupServer-sd
      SDPort = 9103                                # Specifies port number on which the Storage daemon listens for Director connections. The default is 9103.
      WorkingDirectory = "/var/spool/bacula"
      Pid Directory = "/var/run/bacula"
      Maximum Concurrent Jobs = 20
      SDAddress = <VM_internal_IP_address>         # This directive is optional, and if it is specified,
                                                   # it will cause the Storage daemon server (for Director and File daemon connections) to bind to the specified IP-Address,
                                                   # which is either a domain name or an IP address specified as a dotted quadruple.
                                                   # If this directive is not specified, the Storage daemon will bind to any available address (the default).
    }
    ...
    ``` 

1. In the `Device` configuration section, specify `Archive Device = /tmp/bacula` as the backup folder:

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
1. Make sure the `bacula-sd.conf` file has no syntax errors:

    ```bash
    sudo bacula-sd -tc /etc/bacula/bacula-sd.conf
    ``` 

    If there are no error messages, the configuration is correct.

### Create passwords for the Bacula components {#create-bacula-passwords}

The Bacula Director, the Storage Daemon, and the File Daemon all use passwords for cross-component authentication.

To set passwords for the Bacula components:
1. Generate passwords for the Bacula Director, the Storage Daemon, and the File Daemon:

    ```bash
    DIR_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
    SD_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
    FD_PASSWORD=`date +%s | sha256sum | base64 | head -c 33`
    ```

1. Store the passwords in the configuration files:

    ```bash
    sudo sed -i "s/@@DIR_PASSWORD@@/${DIR_PASSWORD}/" /etc/bacula/bacula-dir.conf
    sudo sed -i "s/@@DIR_PASSWORD@@/${DIR_PASSWORD}/" /etc/bacula/bconsole.conf
    sudo sed -i "s/@@SD_PASSWORD@@/${SD_PASSWORD}/" /etc/bacula/bacula-sd.conf
    sudo sed -i "s/@@SD_PASSWORD@@/${SD_PASSWORD}/" /etc/bacula/bacula-dir.conf
    sudo sed -i "s/@@FD_PASSWORD@@/${FD_PASSWORD}/" /etc/bacula/bacula-dir.conf
    sudo sed -i "s/@@FD_PASSWORD@@/${FD_PASSWORD}/" /etc/bacula/bacula-fd.conf
    ```

### Run the Bacula components {#run-bacula-components}

1. Start the Bacula components:

    ```bash
    sudo systemctl start bacula-dir
    sudo systemctl start bacula-sd
    sudo systemctl start bacula-fd
    ```

1. Make sure the Bacula components are running:

    ```bash
    sudo systemctl status bacula-dir
    sudo systemctl status bacula-sd
    sudo systemctl status bacula-fd
    ```

1. Configure the Bacula components to run at system startup:

    ```bash
    sudo systemctl enable bacula-dir
    sudo systemctl enable bacula-sd
    sudo systemctl enable bacula-fd
    ```

## Run a backup job {#run-backup}

1. Open the Bacula Console:

    ```bash
    sudo bconsole
    ```  

1. To set up a backup profile, create a label:

    ```bash
    label
    ```

1. Name the new volume as `MyVolume`:

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

1. Run a backup job:

    ```bash
    run    
    ```

    To run the `BackupFiles` job, enter `1`:

    ```bash
    A job name must be specified.
    The defined Job resources are:
        1: BackupFiles
        2: BackupCatalog
        3: RestoreFiles
    Select Job resource (1-3): 1
    ```

    To confirm, enter `yes`:

    ```bash
    OK to run? (yes/mod/no): yes 
    ```

1. Check the backup status:

    ```bash
    status director
    ```

    Result if the backup is in progress:

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

1. Wait for the backup to complete and exit the Bacula Console:

    ```bash
    exit
    ```

### Check the backup {#check-backup}

To make sure the backup has been completed:

{% list tabs group=instructions %}

- Management console {#console}

  1. On the folder dashboard of the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Open the bucket.
  1. Make sure it contains the `MyVolume` object.

{% endlist %}

## Recover the files {#run-restore}

1. To test recovery, begin by deleting a file, e.g., the `ping` tool:

    ```bash
    sudo rm -f /bin/ping
    ```

1. Make sure you have deleted the `ping` tool:

    ```bash
    ping
    ```

    Result:

    ```text
    bash: ping: command not found
    ```

1. Log in to the Bacula Console:

    ```bash
    sudo bconsole
    ```

1. Run a full recovery:

    ```bash
    restore all
    ```

    To run a recovery from the most recent backup, enter `5`:

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

    To confirm running the recovery, enter `yes`:

    ```bash
    OK to run? (yes/mod/no): yes
    ```

1. Check the recovery status:

    ```bash
    status director
    ```

    Result if the recovery is in progress:

    ```text
    Running Jobs:
    Console connected at 12-Sep-19 07:25
     JobId Level   Name                       Status
    ======================================================================
         3         RestoreFiles.2019-09-12_07.27.42_05 is running
    ```

    Result if the recovery is complete:

    ```text
    Terminated Jobs:
     JobId  Level    Files      Bytes   Status   Finished        Name 
    ====================================================================
         2  Full     32,776    483.6 M  OK       12-Sep-19 07:24 BackupFiles
         3           32,776    1.136 G  OK       12-Sep-19 07:27 RestoreFiles
    ```

1. Wait for the recovery to complete and exit the Bacula Console:

    ```bash
    exit
    ```

### Check the files you recovered {#check-restore}

1. Check whether the `/tmp/bacula-restores` folder contains the files you recovered:

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

1. Make sure `ping` is in the `/tmp/bacula-restores` directory:

    ```bash
    sudo ls -la /tmp/bacula-restores/bin/ping
    ```

    Result:

    ```text
    -rwxr-xr-x 1 root root 66176 Aug  4  2017 /tmp/bacula-restores/bin/ping
    ```

1. Copy the `ping` tool to the main file system:

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
1. [Delete](../../storage/operations/objects/delete-all.md) all objects from the {{ objstorage-name }} bucket.
1. [Delete](../../storage/operations/buckets/delete.md) the {{ objstorage-name }} bucket.
1. [Delete](../../vpc/operations/address-delete.md) the static public IP if you reserved one.
