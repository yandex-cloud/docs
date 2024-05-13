# Migrating a database from a third-party {{ RD }} cluster to {{ mrd-full-name }}


For data migration, {{ RD }} uses a _logical dump_: this is a file with a sequence of commands to restore the state of databases in the cluster. There are several ways to create a dump. The following example will use [redis-dump-go](https://github.com/yannh/redis-dump-go/).

{% note info %}

A binary RDB dump cannot be used for migration, because {{ mrd-name }} does not permit accessing file systems on cluster hosts.

{% endnote %}

To migrate {{ RD }} databases from the _source cluster_ to the _target cluster_:

1. [Connect to the source cluster and create a logical dump](#create-dump).
1. (Optional) [Upload the dump to the intermediate virtual machine](#load-vm).

   You must transfer data to {{ compute-full-name }} using a virtual machine if:

   * Your {{ mrd-name }} cluster is not accessible from the internet.
   * Your hardware or connection to the cluster in {{ yandex-cloud }} is not very reliable.

1. [Restore the dump on the target cluster](#restore-dump).
1. [Make sure the dump is fully restored](#check-data).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create a {{ mrd-name }} cluster](../../managed-redis/operations/cluster-create.md) with any suitable configuration. To connect to a cluster from a user's local machine rather than a {{ yandex-cloud }} cloud network, enable TLS support and public host access when creating your cluster.

   1. (Optional) [Create an intermediate Linux virtual machine](../../compute/operations/vm-create/create-linux-vm.md) in {{ compute-full-name }} on the same network as the {{ mrd-name }} cluster using the following configuration:

      * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select **{{ ui-key.yacloud.compute.instances.create.image_value_os-products }}** → [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).
      * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

         * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
         * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
         * **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}**: Select the same security group as for the {{ mrd-name }} cluster.

   
   1. If you use {{ vpc-name }} security groups, [configure them](../../managed-redis/operations/connect/index.md#configuring-security-groups).


- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. Download the configuration file for the appropriate cluster type to the same working directory:

         * [redis-cluster-non-sharded.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/redis-migration/redis-cluster-non-sharded.tf): For an unsharded cluster.
         * [redis-cluster-sharded.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/redis-migration/redis-cluster-sharded.tf): For a [sharded](../../managed-redis/concepts/sharding.md) cluster.

         Each file describes:

         * Network.
         * Subnet.
         * Default security group and rules required to connect to the cluster and the virtual machine.
         * {{ mrd-name }} cluster with public internet access.
         * (Optional) Virtual machine with public internet access.

   1. Specify the following in the configuration file:

         * Password to access the {{ mrd-name }} cluster.
         * (Optional) Virtual machine parameters:

            * Public virtual machine [image](../../compute/operations/images-with-pre-installed-software/get-list) ID, e.g., for [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
            * Login and absolute path to the [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) for accessing the virtual machine. By default, the specified username is ignored in the [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) image. A user with the `ubuntu` username is created instead. Use it to connect to the instance.

   1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Install additional software {#install-extra-software}

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
1. Download the archive with the `redis-dump-go` utility from the [project page](https://github.com/yannh/redis-dump-go/releases). The examples below use version `0.5.1`.

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
   export REDISDUMPGO_AUTH="<{{ RD }}_password>"
   ```

1. Start an interactive `screen` session:

   ```bash
   screen
   ```

1. Launch the creation of a logical dump:

   ```bash
   ./redis-dump-go \
       -host <IP_address_or_FQDN_of_{{ RD }}_cluster_master_host> \
       -port <{{ RD }}_port> > <dump_file>
   ```

   {% note tip %}

   As the dump is created, the number of processed keys is shown on the screen. Remember or write down the last output value: you will need it to check whether the dump has been restored completely in the target cluster.

   {% endnote %}

1. When the dump has been created, download it to your computer.

1. End the interactive `screen` session:

   ```bash
   exit
   ```

## (Optional) Upload the dump to the intermediate virtual machine {#load-vm}


1. [Connect to the intermediate virtual machine via SSH](../../compute/operations/vm-connect/ssh.md).


1. Upload the dump from your computer to an intermediate virtual machine however is convenient.

## Restore the dump on the target cluster {#restore-dump}

1. [Connect to the cluster](../../managed-redis/operations/connect/index.md) and run an interactive `screen` session:

   ```bash
   screen
   ```

1. Start the dump recovery process:

   {% list tabs group=connection %}

   - Connecting without TLS {#without-tls}

      {% include [Install requirements](../../_includes/mdb/mrd/connect/bash/install-requirements.md) %}

      **Connecting via Sentinel**

      ```bash
      host=$(redis-cli \
        -h <FQDN_of_any_{{ RD }}_host> \
        -p {{ port-mrd-sentinel }} \
        sentinel \
        get-master-addr-by-name \
        no-shards-no-tls | head -n 1)
      redis-cli \
        -h ${host} \
        -p {{ port-mrd }} \
        -a <target cluster password> \
        --pipe < <dump_file>
      ```

      **Connecting directly to the master host**

      ```bash
      redis-cli \
        -h <FQDN_of_any_host> \
        -p {{ port-mrd }} \
        -a <target_cluster_password> \
        --pipe < <dump file>
      ```

      {% include [use-special-fqdn](../../_includes/mdb/mrd/conn-strings-fqdn.md) %}

      **Connecting to a sharded cluster**

      1. Create a script containing the dump-loading commands:

         `load-dump.sh`

         ```bash
         shards=('<FQDN_of_master_host_in_shard_1>' \
                 ...
                 '<FQDN_of_master_host_in_shard_N>')

         for shard in "${shards[@]}" ; do
           redis-cli -h "${shard}" \
                     -p {{ port-mrd }} \
                     -a "<target_cluster_password>" \
                     --pipe < <dump_file>
         done
         ```

      1. Run the script:

         ```bash
         bash ./load-dump.sh
         ```

         As you run the script, you will see messages about data insertion errors. This is normal behavior for the `redis-cli` command, because in a sharded cluster, each shard stores only a certain part of the data. For more information, see [{#T}](../../managed-redis/concepts/sharding.md).

   - Connecting via TLS {#with-tls}

      {% include [Install requirements SSL](../../_includes/mdb/mrd/connect/bash/install-requirements-ssl.md) %}

      **Connecting via Sentinel**

      ```bash
      host=$(redis-cli \
             -h <FQDN_of_any_{{ RD }}_host> \
             -p {{ port-mrd-sentinel }} \
             sentinel \
             get-master-addr-by-name \
             no-shards-tls | head -n 1)
      redis-cli \
          -h ${host} \
          -p {{ port-mrd-tls }} \
          -a <target_cluster_password> \
          --tls \
          --cacert ~/.redis/{{ crt-local-file }} \
          --pipe < <dump_file>
      ```

      **Connecting directly to the master host**

      ```bash
      redis-cli \
          -h c-<cluster_ID>.rw.{{ dns-zone }} \
          -p {{ port-mrd-tls }} \
          -a <target_cluster_password> \
          --tls \
          --cacert ~/.redis/{{ crt-local-file }} \
          --pipe < <dump_file>
      ```

      {% include [use-special-fqdn](../../_includes/mdb/mrd/conn-strings-fqdn.md) %}

      **Connecting to a sharded cluster**

      1. Create a script containing the dump-loading commands:

         `load-dump.sh`

         ```bash
         shards=('<FQDN_of_master_host_in_shard_1>' \
                 ...
                 '<FQDN_of_master_host_in_shard_N>')

         for shard in "${shards[@]}" ; do
           redis-cli -h "${shard}" \
                     -p {{ port-mrd-tls }} \
                     -a "<target_cluster_password>" \
                     --tls \
                     --cacert ~/.redis/{{ crt-local-file }} \
                     --pipe < <dump_file>
         done
         ```

      1. Run the script:

         ```bash
         bash ./load-dump.sh
         ```

         As you run the script, you will see messages about data insertion errors. This is normal behavior for the `redis-cli` command, because in a sharded cluster, each shard stores only a certain part of the data. For more information, see [{#T}](../../managed-redis/concepts/sharding.md).

      {% endcut %}

   {% endlist %}

1. End the interactive `screen` session:

   ```bash
   exit
   ```

## Make sure that the dump is restored completely {#check-data}

1. In the [management console]({{ link-console-main }}), select the folder containing the cluster to restore.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Click the cluster name and open the [{{ ui-key.yacloud.redis.cluster.switch_monitoring }}](../../managed-redis/operations/monitoring.md) tab.

Pay attention to the **DB Keys** chart showing the number of keys stored in the cluster. If the cluster is [sharded](../../managed-redis/concepts/sharding.md), the chart will show the number of keys in each shard. In this case, the number of keys in the cluster is equal to the total number of keys in the shards.

The total number of keys in the cluster must be equal to the number of keys processed by the `redis-dump-go` utility when creating the dump.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

   * [Delete the {{ mrd-full-name }} cluster](../../managed-redis/operations/cluster-delete.md).
   * If you created an intermediate virtual machine, [delete it](../../compute/operations/vm-control/vm-delete.md).
   * If you reserved public static IP addresses, release and [delete them](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

   To delete the infrastructure [created with {{ TF }}](#deploy-infrastructure):

   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the configuration file (`redis-cluster-non-sharded.tf` or `redis-cluster-sharded.tf`).
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the configuration file will be deleted.

{% endlist %}
