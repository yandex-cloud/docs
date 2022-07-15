# Migrating databases to {{ mrd-name }}

For data migration, {{ RD }} uses a _logical dump_: this is a file with a sequence of commands to restore the state of databases in the cluster. There are several ways to create a dump. The following example will use [redis-dump-go](https://github.com/yannh/redis-dump-go/).

{% note info %}

A binary RDB dump can't be used for migration, because {{ mrd-name }} doesn't permit accessing file systems on cluster hosts.

{% endnote %}

To migrate {{ RD }} databases from the _source cluster_ to the _target cluster_:

1. [{#T}](#create-dump).
1. [{#T}](#create-vm).
1. [{#T}](#restore-dump).
1. [{#T}](#check-data).


## Before you begin {#before-you-begin}

1. [Create a {{ mrd-name }} cluster](../operations/cluster-create.md) with any suitable configuration.
1. [Set up security groups](../operations/connect/index.md#configuring-security-groups) for the cluster and the intermediate VM. {#configure-security-groups}
1. (Optional) Install utilities on the local machine for downloading and uploading files over SSH, such as:

   * [WinSCP](https://winscp.net/eng/index.php)
   * [Putty SCP](https://www.putty.org/)

1. Make sure that [GNU Screen](https://www.gnu.org/software/screen/) is installed on the source cluster.

    It might take a long time to create and restore a dump. To keep these processes alive when your SSH session times out, start them using this utility. If your SSH connection breaks while creating or restoring the dump, reconnect and restore the session state using the command:

   ```bash
   screen -R
   ```

## Connect to the source cluster and create a logical dump {#create-dump}

1. Connect to the source cluster's master host via SSH.
1. Download the archive with the `redis-dump-go` utility from the [project page](https://github.com/yannh/redis-dump-go/releases). In the following examples, we'll use version `0.5.1`.

   ```bash
   wget https://github.com/yannh/redis-dump-go/releases/download/v0.5.1/redis-dump-go_0.5.1_linux_amd64.tar.gz
   ```

1. Unpack the archive to the current directory:

   ```bash
   tar xf redis-dump-go_0.5.1_linux_amd64.tar.gz
   ```

1. Get familiar with the utility launch parameters:

   ```bash
   ./redis-dump-go -h
   ```

1. If connecting to the {{ RD }} cluster requires a password,  enter it in the `REDISDUMPGO_AUTH` environment variable:

   ```bash
   export REDISDUMPGO_AUTH="<{{ RD }} password>"
   ```

1. Start an interactive `screen` session:

   ```bash
   screen
   ```

1. Launch the creation of a logical dump:

   ```bash
   ./redis-dump-go \
       -host <master host IP or FQDN in a {{ RD }} cluster> \
       -port <port {{ RD }}> > <dump file>
   ```

   {% note tip %}

   As the dump is created, the number of processed keys is shown on the screen. Remember or write down the last output value: you'll need it to check that the dump has been recovered completely in the target cluster.

   {% endnote %}

1. When the dump has been created, download it to your computer.

1. End the interactive `screen` session:

   ```bash
   exit
   ```

## Create and set up an intermediate VM {#create-vm}


1. [Create a Linux virtual machine](../../compute/operations/vm-create/create-linux-vm.md) with the following configuration:

* Under **Image/boot disk selection**: Select **Operating systems** → `Ubuntu 20.04`.
* Under **Network settings**:
* **Subnet**: Select a subnet that includes at least one of the {{ mrd-name }} cluster's master hosts.
* **Public address**: `Auto`.
* **Internal address**: `Auto`.
* **Security groups**: Select the [previously configured](#configure-security-groups) security groups.

1. [Connect to the intermediate virtual machine via SSH](../../compute/operations/vm-connect/ssh.md).


1. If your {{ mrd-name }} cluster is deployed with TLS support enabled:

   1. [Get an SSL certificate](../operations/connect/index.md#get-ssl-cert).

   1. Add the official {{ RD }} repository to your list of repositories:

      ```bash
      sudo apt-add-repository ppa:redislabs/redis
      ```

      {% note info %}

      The packages in this repository are built with the `BUILD_TLS=yes` flag, so you don't need to manually rebuild them from the source.

      {% endnote %}

1. Update the list of available packages and install the necessary utilities:

   ```bash
   sudo apt update && sudo apt install redis-tools screen --yes
   ```


## Restore the dump on the target cluster {#restore-dump}

1. Upload the dump from your computer to an intermediate virtual machine however is convenient.

1. Start an interactive `screen` session:

   ```bash
   screen
   ```

1. Start the dump recovery process:

   {% list tabs %}

   * Connecting without using TLS

      **Connecting via Sentinel**

      ```bash
      host=$(redis-cli \
        -h <FQDN of any host {{ RD }}> \
        -p {{ port-mrd-sentinel }} \
        sentinel \
        get-master-addr-by-name \
        no-shards-no-tls | head -n 1)
      redis-cli \
        -h ${host} \
        -p {{ port-mrd }} \
        -a <target cluster password> \
        --pipe < <dump file>
      ```

      **Connecting directly to the master host**

      ```bash
      redis-cli \
        -h <FQDN of any host> \
        -p {{ port-mrd }} \
        -a <target cluster password> \
        --pipe < <dump file>
      ```

      {% include [use-special-fqdn](../../_includes/mdb/mrd/conn-strings-fqdn.md) %}

      **Connecting to a sharded cluster**

      1. Create a script containing the dump-loading commands:

         `load-dump.sh`

         ```bash
         shards=('<FQDN of the master host in shard 1>' \
                 ...
                 '<FQDN of master host in shard N>')

         for shard in "${shards[@]}" ; do
           redis-cli -h "${shard}" \
                     -p {{ port-mrd }} \
                     -a "<target cluster password>" \
                     --pipe < <dump file>
         done
         ```

      1. Run the script:

         ```bash
         bash ./load-dump.sh
         ```

         As you run the script, you'll see messages about data insertion errors. This is normal behavior for the `redis-cli` command, because in a sharded cluster, each shard stores only a certain part of the data. For more information, see [{#T}](../concepts/sharding.md).

   * Connecting via TLS

      **Connecting via Sentinel**

      ```bash
      host=$(redis-cli \
             -h <FQDN of any {{ RD }} host> \
             -p {{ port-mrd-sentinel }} \
             sentinel \
             get-master-addr-by-name \
             no-shards-tls | head -n 1)
      redis-cli \
          -h ${host} \
          -p {{ port-mrd-tls }} \
          -a <target cluster password> \
          --tls \
          --cacert ~/.redis/{{ crt-local-file }} \
          --pipe < <dump file>
      ```

      **Connecting directly to the master host**

      ```bash
      redis-cli \
          -h c-<cluster ID>.rw.{{ dns-zone }} \
          -p {{ port-mrd-tls }} \
          -a <target cluster password> \
          --tls \
          --cacert ~/.redis/{{ crt-local-file }} \
          --pipe < <dump file>
      ```

      {% include [use-special-fqdn](../../_includes/mdb/mrd/conn-strings-fqdn.md) %}

      **Connecting to a sharded cluster**

      1. Create a script containing the dump-loading commands:

         `load-dump.sh`

         ```bash
         shards=('<FQDN of the master host in shard 1>' \
                 ...
                 '<FQDN of master host in shard N>')

         for shard in "${shards[@]}" ; do
           redis-cli -h "${shard}" \
                     -p {{ port-mrd-tls }} \
                     -a "<target cluster password>" \
                     --tls \
                     --cacert ~/.redis/{{ crt-local-file }} \
                     --pipe < <dump file>
         done
         ```

      1. Run the script:

         ```bash
         bash ./load-dump.sh
         ```

         As you run the script, you'll see messages about data insertion errors. This is normal behavior for the `redis-cli` command, because in a sharded cluster, each shard stores only a certain part of the data. For more information, see [{#T}](../concepts/sharding.md).

      {% endcut %}

   {% endlist %}

1. End the interactive `screen` session:

   ```bash
   exit
   ```


## Make sure that the dump is restored completely {#check-data}

1. In the [management console]({{ link-console-main }}), select the folder containing the cluster to restore.
1. In the list of services, select **{{ mrd-name }}**.
1. Click on the name of the cluster and open the [Monitoring](../operations/monitoring.md) tab.

Pay attention to the **DB Keys** chart showing the number of keys stored in the cluster. If the cluster is [sharded](../concepts/sharding.md), the chart will show the number of keys in each shard. In this case, the number of keys in the cluster is equal to the total number of keys in the shards.

The total number of keys in the cluster must be equal to the number of keys processed by the `redis-dump-go` utility when creating the dump.
