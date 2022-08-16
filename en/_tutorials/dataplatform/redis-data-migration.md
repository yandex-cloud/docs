# Migrating databases to {{ mrd-name }}

For data migration, {{ RD }} uses a _logical dump_: this is a file with a sequence of commands to restore the state of databases in the cluster. There are several ways to create a dump. The following example will use [redis-dump-go](https://github.com/yannh/redis-dump-go/).

{% note info %}

A binary RDB dump can't be used for migration, because {{ mrd-name }} doesn't permit accessing file systems on cluster hosts.

{% endnote %}

To migrate {{ RD }} databases from the _source cluster_ to the _target cluster_:

1. [Connect to the source cluster and create a logical dump](#create-dump).
1. [Configure the intermediate virtual machine](#setup-vm).
1. [Restore the dump on the target cluster](#restore-dump).
1. [Make sure the dump is fully restored](#check-data).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs %}

- Manually

   1. [Create a {{ mrd-name }} cluster](../../managed-redis/operations/cluster-create.md) with any suitable configuration.

   1. {% if audience != "internal" %}[Create an intermediate Linux virtual machine](../../compute/operations/vm-create/create-linux-vm.md){% else %}Create an intermediate Linux virtual machine{% endif %} in {{ compute-full-name }} on the same network as the {{ mrd-name }} cluster using the following configuration:

      * Under **Image/boot disk selection**, select **Operating systems** → `Ubuntu 20.04`.
      * Under **Network settings**:

         * **Public address**: `Auto`.
         * **Private address**: `Auto`.
         * **Security group**: Select the same security group as for the {{ mrd-name }} cluster.

   1. [Configure the {{ vpc-name }} security group](../../managed-redis/operations/connect/index.md#configuring-security-groups).

- Using Terraform

   1. If you don't have {{ TF }}, {% if audience != "internal" %}[install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}install it{% endif %}.
      1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and {% if audience != "internal" %}[specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}specify the parameter values{% endif %}.
      1. Download the configuration file for the appropriate cluster type to the same working directory:

         * [redis-cluster-non-sharded.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/redis-migration/redis-cluster-non-sharded.tf): For an unsharded cluster.
         * [redis-cluster-sharded.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/redis-migration/redis-cluster-sharded.tf): For a [sharded](../../managed-redis/concepts/sharding.md) cluster.

         Each file describes:

         * Network.
         * Subnet.
         * {{ mrd-name }} cluster.
         * Virtual machine.
         * Default security group and rules required to connect to the cluster and the virtual machine from the internet.
            * SSH connection to the VM.
            * Connection to the VM from the {{ mrd-name }} cluster via {{ RD }} ports.


      1. Specify the following in the configuration file:

         * Password to access the {{ mrd-name }} cluster.
         * Public virtual machine {% if audience != "internal" %}[image](../../compute/operations/images-with-pre-installed-software/get-list){% else %}image{% endif %} ID. For example, for [Ubuntu 20.04 LTS]{% if lang == "ru" %}(https://cloud.yandex.ru/marketplace/products/yc/ubuntu-20-04-lts){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en-ru/marketplace/products/yc/ubuntu-20-04-lts){% endif %}.
         * Login and path to the {% if audience != "internal" %}[public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys){% else %}public SSH key{% endif %} to use for accessing the virtual machine.

      1. Run the `terraform init` command in the directory with the configuration files. This command initializes the providers specified in the configuration files and lets you work with the provider resources and data sources.
      1. Make sure the {{ TF }} configuration files are correct using the command:

         ```bash
         terraform validate
         ```

         If there are errors in the configuration files, {{ TF }} will point to them.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Install additional software {#install-extra-software}

1. (Optional) Install utilities on the local machine for downloading and uploading files over SSH, such as:

   * [WinSCP]{% if lang == "ru" %}(https://winscp.net/eng/docs/lang:ru){% endif %}{% if lang == "en" %}(https://winscp.net/eng/index.php){% endif %}
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

1. If connecting to the {{ RD }} cluster requires a password, enter it in the `REDISDUMPGO_AUTH` environment variable:

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

## Configure the intermediate virtual machine {#setup-vm}

{% if audience == "external" %}

1. [Connect to the intermediate virtual machine via SSH](../../compute/operations/vm-connect/ssh.md).

{% else %}

1. Connect to the intermediate virtual machine via SSH.

{% endif %}

1. If your {{ mrd-name }} cluster is deployed with TLS support enabled:

   1. [Get an SSL certificate](../../managed-redis/operations/connect/index.md#get-ssl-cert).

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

1. {% if audience != "internal" %}[Connect to the intermediate VM via SSH](../../compute/operations/vm-connect/ssh.md){% else %}Connect to the intermediate VM via SSH{% endif %} and start an interactive `screen` session:

   ```bash
   screen
   ```

1. Start the dump recovery process:

   {% list tabs %}

   - Connecting without using TLS

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

         As you run the script, you'll see messages about data insertion errors. This is normal behavior for the `redis-cli` command, because in a sharded cluster, each shard stores only a certain part of the data. For more information, see [{#T}](../../managed-redis/concepts/sharding.md).

   - Connecting via TLS

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

         As you run the script, you'll see messages about data insertion errors. This is normal behavior for the `redis-cli` command, because in a sharded cluster, each shard stores only a certain part of the data. For more information, see [{#T}](../../managed-redis/concepts/sharding.md).

      {% endcut %}

   {% endlist %}

1. End the interactive `screen` session:

   ```bash
   exit
   ```

## Make sure that the dump is restored completely {#check-data}

1. In the [management console]({{ link-console-main }}), select the folder containing the cluster to restore.
1. In the list of services, select **{{ mrd-name }}**.
1. Click on the name of the cluster and open the [Monitoring](../../managed-redis/operations/monitoring.md) tab.

Pay attention to the **DB Keys** chart showing the number of keys stored in the cluster. If the cluster is [sharded](../../managed-redis/concepts/sharding.md), the chart will show the number of keys in each shard. In this case, the number of keys in the cluster is equal to the total number of keys in the shards.

The total number of keys in the cluster must be equal to the number of keys processed by the `redis-dump-go` utility when creating the dump.

## Delete the resources you created {#clear-out}

{% list tabs %}

- Manually

   If you no longer need these resources, delete them:

   * [Delete the {{ mrd-full-name }} cluster](../../managed-redis/operations/cluster-delete.md).
   * {% if audience != "internal" %}[Delete the virtual machine](../../compute/operations/vm-control/vm-delete.md){% else %}Delete a virtual machine{% endif %}.
   * If you reserved public static IP addresses, release and {% if audience != "internal" %}[delete them](../../vpc/operations/address-delete.md){% else %}delete them{% endif %}.

- Using Terraform

   To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the configuration file (`redis-cluster-non-sharded.tf` or `redis-cluster-sharded.tf`).
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All resources described in the configuration file will be deleted.

{% endlist %}
