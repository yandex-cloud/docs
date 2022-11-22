# Configuring an SFTP server on Centos 7

In this guide, you will learn how to:

* Deploy an [SFTP](https://ru.wikipedia.org/wiki/SFTP) server in the {{ yandex-cloud }} infrastructure.
* Perform scheduled backups of configuration files from the SFTP client to the SFTP server.

To deploy the necessary infrastructure, follow the instructions:

1. [Before you start](#before-you-begin).
1. [Create a VM for the SFTP server](#create-vm-sftp-server).
1. [Configure the SFTP server](#config-sftp-server).
1. [Create an SFTP user](#create-sftp-user).
1. [Create a VM for the SFTP client](#create-vm-sftp-client).
1. [Back up configuration files to the SFTP server](#backup).
1. [Set up a backup schedule](#schedule).
1. [Make sure backups work](#check-backup).
1. [Restore settings from a backup](#restore).
1. [Check the restore results](#check-restore).
1. [Delete the created cloud resources](#cleanup).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources

The infrastructure cost in the example includes:

* A fee for two continuously running VMs (see [Pricing for {{ compute-full-name }}](../../compute/pricing.md)):
    * A VM for the SFTP client.
    * A VM for the SFTP server.
* A fee for using a dynamic or static external IP address (see [Pricing for {{ vpc-full-name }}](../../vpc/pricing.md)).


## Create a VM for the SFTP server {#create-vm-sftp-server}

To create a VM:

1. On the folder page in the [management console]({{ link-console-main }}), click **Create resource**, and select **Virtual machine**.

1. In the **Name** field, enter a name for the VM, like `sftp-server`.

    {% include [name-format](../../_includes/name-format.md) %}

1. Select the [availability zone](../../overview/concepts/geo-scope.md) to host the VM in.

1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, and select the [CentOS 7](/marketplace/products/yc/centos-7) image.

1. In the **Computing resources** section, select the following configuration:
   * **Platform**: Intel Cascade Lake.
   * **Guaranteed vCPU share**: 20%.
   * **vCPU**: 2.
   * **RAM**: 2 GB.

1. In the **Network settings** section, select the network and subnet to connect the VM to. If you don't have a network or subnet yet, you can create them on the VM creation page.

1. In the **Public address** field, leave the **Automatically** value to assign a random external IP address from the {{ yandex-cloud }} pool. To ensure that the external IP address doesn't change after the VM is stopped, [make it static](../../vpc/operations/set-static-ip.md).

1. Specify data required for accessing the VM:
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file. You need to create a key pair for the SSH connection yourself. Learn [how to connect to VMs via SSH](../../compute/operations/vm-connect/ssh.md).

    {% note alert %}

     The IP address and host name (FQDN) for connecting to the VM will be assigned when it's created. If you selected the **No address** option in the **Public address** field, you won't be able to access the VM from the internet.

    {% endnote %}

1. Click **Create VM**.

Creating the VM may take several minutes.

## Configure the SFTP server {#config-sftp-server}

SFTP server functionality is included in the standard SSH program that comes with the Centos 7 distribution. To configure the SFTP server, edit the `/etc/ssh/sshd_config` configuration file:

1. Open the configuration file with the vi editor. The editor comes with the distribution and doesn't have to be installed. If you aren't familiar with this editor, you can learn more in the [official documentation](https://www.vim.org/docs.php).

    ```bash
    sudo vi /etc/ssh/sshd_config
    ```

1. Add the following lines at the end of the file:

    ```
    Match User fuser
    ForceCommand internal-sftp
    PasswordAuthentication no
    ChrootDirectory /var/sftp
    PermitTunnel no
    AllowAgentForwarding no
    AllowTcpForwarding no
    X11Forwarding no
    ```

    Where:

    * `Match User fuser`: Indicates that all subsequent rows will be applied only when connecting the user `fuser`.
    * `ForceCommand internal-sftp`: Connect the user only in SFTP mode and disable access to the shell.
    * `PasswordAuthentication no`: Disable login and password-based access.
    * `ChrootDirectory /var/sftp`: Restrict user access only within the `/var/sftp` directory.
    * `PermitTunnel no`, `AllowAgentForwarding no`, `AllowTcpForwarding no`, `X11Forwarding no`: Disable tunneling and port and graphical app forwarding via an SSH session.

1. Save the file.

1. Output the configuration file without commented or empty lines:

    ```bash
    cat /etc/ssh/sshd_config | grep -v -e '^#' -e '^$'
    ```

1. Make sure that the output of the previous command matches the following lines:

    ```
    HostKey /etc/ssh/ssh_host_rsa_key
    HostKey /etc/ssh/ssh_host_ecdsa_key
    HostKey /etc/ssh/ssh_host_ed25519_key
    SyslogFacility AUTHPRIV
    AuthorizedKeysFile .ssh/authorized_keys
    PasswordAuthentication no
    ChallengeResponseAuthentication no
    GSSAPIAuthentication yes
    GSSAPICleanupCredentials no
    UsePAM yes
    X11Forwarding yes
    AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
    AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
    AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
    AcceptEnv XMODIFIERS
    Subsystem sftp  /usr/libexec/openssh/sftp-server
    Match User fuser
    ForceCommand internal-sftp
    PasswordAuthentication no
    ChrootDirectory /var/sftp
    PermitTunnel no
    AllowAgentForwarding no
    AllowTcpForwarding no
    X11Forwarding no
    ```

1. Save the file.

1. Restart the SFTP service for the settings to take effect:

    ```bash
    sudo systemctl restart sshd
    ```

1. Create a group for SFTP users:

    ```bash
    sudo groupadd ftpusers
    ```

1. Create directories to save files to:

    ```bash
    sudo mkdir -p /var/sftp/backups
    ```

    Where:

    * `sftp`: The root directory of the SFTP server.
    * `backups`: The directory to store backups on the SFTP server.

1. Set folder permissions so that all users in the `ftpusers` group can write and read files on the SFTP server:

    ```bash
    sudo chown root:ftpusers /var/sftp/backups
    sudo chmod 770 /var/sftp/backups
    ```

1. Check whether the permissions are correct:

    ```bash
    ls -la /var | grep sftp
    ls -la /var/sftp
    ```

    The result should be as follows:

    ```bash
    drwxr-xr-x.  4 root root   37 Aug  7 11:35 sftp
    drwxrwx---. 2 root ftpusers 80 Aug  7 08:41 backups
    ```

## Create an SFTP user {#create-sftp-user}

1. Create an SFTP user, like `fuser`:

    ```bash
    sudo useradd fuser
    ```

1. Create a password for the SFTP user

    ```bash
    sudo passwd fuser
    ```

1. Create SSH keys for the `fuser` user. The command must be run on behalf of the `fuser` user:

    ```bash
    sudo runuser -l  fuser -c 'ssh-keygen'
    ```

    The key generation process is given below. Leave the `passphrase` field blank.

    ```
    [yc-user@ftp-server ~]$ sudo runuser -l fuser -c 'ssh-keygen'
    Generating public/private rsa key pair.
    Enter file in which to save the key (/home/fuser/.ssh/id_rsa): 
    Created directory '/home/fuser/.ssh'.
    Enter passphrase (empty for no passphrase):
    Enter same passphrase again:
    Your identification has been saved in /home/fuser/.ssh/id_rsa.
    Your public key has been saved in /home/fuser/.ssh/id_rsa.pub.
    The key fingerprint is:
    SHA256:S2jRD3/A6ClHW/RZUOeOrl6BsK3pfWdhusGBGZiHE44 fuser@ftp-server.{{ region-id }}.internal
    The key's randomart image is:
    +---[RSA 2048]----+
    |         .. .oo .|
    |       .o+=. o o |
    |      .E=*=oo   .|
    |       = Bo=+. o |
    |      + S +o+.o .|
    |     . + . +...+ |
    |        . o  o= .|
    |         . . +o o|
    |          ..+o.o |
    +----[SHA256]-----+
    ```

1. Create a file to save the SFTP client's public SSH keys to. Set the necessary permissions.

    ```bash
    sudo touch /home/fuser/.ssh/authorized_keys
    sudo chmod 600 /home/fuser/.ssh/authorized_keys
    sudo chown fuser:fuser /home/fuser/.ssh/authorized_keys
    ```

1. Make sure that the permissions are set correctly:

    ```bash
    ls -la /home/fuser/.ssh/
    ```

    Result:

    ```bash
    -rw-------. 1 fuser fuser  421 Aug  7 08:31 authorized_keys
    -rw-------. 1 fuser fuser 1675 Aug  7 08:29 id_rsa
    -rw-r--r--. 1 fuser fuser  419 Aug  7 08:29 id_rsa.pub
    ```

1. Add the SFTP user to the SFTP group:

    ```bash
    sudo usermod -G ftpusers fuser
    ```

## Create a VM for the SFTP client {#create-vm-sftp-client}

The process for creating a VM for the SFTP client is exactly the same as the one for the SFTP server.

1. Perform steps 1-9 from the section [Create a VM for the SFTP server](#create-vm-sftp-server) (for the VM name, enter a name like `sftp-client`).

1. Create an SSH key pair on the SFTP client. The process is similar to the one described for the `fuser` user in the [previous section](#create-sftp-user):

    ```bash
    ssh-keygen
    ```

1. Output the public key on the SFTP client screen:

    ```bash
    cat ~/.ssh/id_rsa.pub
    ```

1. Log in to the SFTP server and open the `/home/fuser/.ssh/authorized_keys` file:

    ```bash
    sudo vi /home/fuser/.ssh/authorized_keys
    ```

1. Copy the SSH key received on the SFTP client to the end of the file.

1. Save the file.

1. Make sure that the SFTP client VM is accessible from the SFTP server and vice versa:

   1. Log in to the SFTP server via SSH.

   1. Find the public or internal IP address of the SFTP client in the {{ yandex-cloud }} console under VM settings.

      {% note warning %}

      The internal addresses of the SFTP client and server must be located in the same subnet or be linked via routing settings.

      {% endnote %}

   1. Enter the following command in the SFTP server terminal by substituting the appropriate value:

      ```bash
      ping <SFTP client IP address>
      ```

   1. Make sure that packages are sent and received successfully:

      ```bash
      ping 84.201.170.171
      PING 84.201.170.171 (84.201.170.171) 56(84) bytes of data.
      64 bytes from 84.201.170.171: icmp_seq=1 ttl=55 time=8.59 ms
      64 bytes from 84.201.170.171: icmp_seq=2 ttl=55 time=6.32 ms
      64 bytes from 84.201.170.171: icmp_seq=3 ttl=55 time=5.95 ms
      ^C
      --- 84.201.170.171 ping statistics ---
      3 packets transmitted, 3 received, 0% packet loss, time 2003ms
      rtt min/avg/max/mdev = 5.955/6.959/8.595/1.168 ms
      ```

   1. Repeat the check on the SFTP client.

## Make a backup of configuration files on the SFTP server {#backup}

These instructions describe how to back up configuration files (with the `.conf` extension) from the `/etc` folder.

Backup process:

1. Archive all the necessary configuration files.
1. Send the archive to the SFTP server.
1. Delete the archive on the SFTP client.

To set up the backup process:

1. Log in to the SFTP client VM via SSH the same way you did for the SFTP server.

1. Set environment variables for the script to work properly. To do this, open the `~/.bash_profile` file:

    ```bash
    vi ~/.bash_profile
    ```

1. Add the following lines at the end of the file by substituting the appropriate values:

   ```bash
   export SFTP_SERVER=<SFTP client IP address>
   export SFTP_USER='fuser'
   ```

1. Apply the settings:

   ```bash
   source ~/.bash_profile
   ```

1. Check that you have these variables:

   ```bash
   env | grep SFTP
   ```

    The screen should display:

    ```
    SFTP_USER=fuser
    SFTP_SERVER=10.128.0.5
    ```

1. Compress all configuration files into a single archive:

    ```bash
    sudo find /etc -type f -name *.conf -print0 | sudo tar -czf backup.tar.gz --null -T -
    ```

    Where:

    * `sudo find /etc -type f -name *.conf -print0`: Search for all `.conf` files from the `/etc` directory.
    * `sudo tar -czf backup.tar.gz --null -T -`: Move the configuration files to the `backup.tar.gz` archive.

1. Send the resulting archive to the SFTP server:

   ```bash
   url -T backup.tar.gz sftp://$SFTP_SERVER/backups/backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz --insecure --user $SFTP_USER:
   ```
   
   Where:

   * `-T`: Upload the `backup.tar.gz` file to a remote server.
   * `$SFTP_SERVER`: A variable that automatically takes the value of the SFTP server IP address.
   * `backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz`: Add the name of the computer to the archive name and the date and time when the archive was created. This will help you navigate the list of backups on the server.
     For example, the name of the archive on the server might look like this: `backup_ftp-server.{{ region-id }}.internal_20190803_180228.tar.gz`.
   * `--insecure`: Disable SSL certificate verification by the SFTP server. In this case, traffic within the SSH session is still encrypted.
   * `$SFTP_USER`: A variable that automatically takes the SFTP user value.

1. Delete the archive on the SFTP client:

   ```bash
   sudo rm -f backup.tar.gz
   ```

All actions for creating a backup can be performed with a single command:

```bash
sudo find /etc -type f -name *.conf -print0 | sudo tar -czf backup.tar.gz --null -T -&& curl -T backup.tar.gz sftp://$SFTP_SERVER/backups/backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz --insecure --user $SFTP_USER: && sudo rm -f backup.tar.gz
```

## Set up a schedule for backups {#schedule}

To create regular backups of your settings, you can use a built-in program called `crontab`.

1. Open the `crontab` file to edit it:

   ```bash
   crontab -e
   ```

1. Add the following line to run backups daily at 23:00:

   ```
   0 23 * * * sudo find /etc -type f -name *.conf -print0 | sudo tar -czf backup.tar.gz --null -T -&& curl -T backup.tar.gz sftp://$SFTP_SERVER/backups/backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz --insecure --user $SFTP_USER: && sudo rm -f backup.tar.gz
   ```

## Make sure the backup works {#check-backup}

To make sure that a backup is created properly, run the backup and find the copy on the server:

1. Run the backup command on the SFTP client:

   ```bash
   sudo find /etc -type f -name *.conf -print0 | sudo tar -czf backup.tar.gz --null -T -&& curl -T backup.tar.gz sftp://$SFTP_SERVER/backups/backup_$(hostname)_$(date "+%Y%m%d_%H%M%S").tar.gz --insecure --user $SFTP_USER: && sudo rm -f backup.tar.gz
   ```

1. Log in to the SFTP server and make sure that a file that looks like `backup_ftp-server.{{ region-id }}.internal_20190803_180228.tar.gz` appeared in the SFTP user's home directory. To do this, run the following command on the SFTP server:

   ```bash
   sudo ls /var/sftp/backups
   ```

## Restore settings from a backup {#restore}

The settings are restored as follows:

1. Download the backup from the SFTP server to the SFTP client.
1. Unpack the archive.
1. Copy the configuration files from the archive to the system.
1. Delete the archive.

To restore the settings from the backup:

1. On the SFTP server, in the `/var/sftp/backups` directory, select the backup that you want to restore the configuration files from. For example, `backup_ftp-server.{{ region-id }}.internal_20190803_180228.tar.gz`.

1. On the SFTP client, make an environment variable to name a backup file:

    ```bash
    SFTP_BACKUP='backup_ftp-server.{{ region-id }}.internal_20190803_180228.tar.gz'
    ```

1. Download the backup from the SFTP server to the SFTP client:

   ```bash
   sftp $SFTP_USER@$SFTP_SERVER:/backups/$SFTP_BACKUP .
   ```

1. Unpack the archive:

   ```bash
   tar -xzf $SFTP_BACKUP
   ```

1. Copy the configuration files from the archive to the system (`yes`: avoid entering confirmation when overwriting files):

   ```bash
   yes | cp -rfp etc /
   ```

1. Delete the archive and unpacked content:

   ```bash
   rm -f $SFTP_BACKUP
   rm -rfd etc
   ```

All actions for restoring settings from a backup can be performed with a single command:

```bash
sftp $SFTP_USER@$SFTP_SERVER:/backups/$SFTP_BACKUP . && tar -xzf $SFTP_BACKUP && yes | cp -rfp etc / && rm -rfd etc && rm -f $SFTP_BACKUP
```

## Check whether the settings are restored correctly {#check-restore}

To make sure that the configuration files from the archive successfully get into the file system, add a verification block to the command above:

```bash
sftp $SFTP_USER@$SFTP_SERVER:/backups/$SFTP_BACKUP . && tar -xzf $SFTP_BACKUP && echo "## this is from backup" >> etc/yum.conf && yes | cp -rfp etc / && rm -rfd etc && rm -f $SFTP_BACKUP
```

The `echo "## this is from backup" >> etc/yum.conf` command writes the test phrase "## this is from backup" at the end of the`etc/yum.conf` file unpacked from the archive.

After restoring the backup, run the following command:

```bash
cat /etc/yum.conf | grep backup
```

Make sure that the test phrase is displayed on the screen:

```bash
## this is from backup
```

## Delete the created cloud resources {#cleanup}

If you no longer need the SFTP server and client:

* [Delete the VMs](../../compute/operations/vm-control/vm-delete.md) for the SFTP client and server (in the example, they're named `sftp-server` and `sftp-client`).
* [Delete the static IP address](../../vpc/operations/address-delete.md) if you created one.

