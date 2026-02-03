# Migrating a database from a third-party {{ VLK }} cluster to {{ mrd-full-name }}


For data migration, {{ VLK }} uses a _logical dump_. A _logical dump_ is a file with a sequence of commands that restore the database state. There are several ways to create a dump. The following example will use [redis-dump-go](https://github.com/yannh/redis-dump-go/).

{% note info %}

You cannot use a binary RDB dump for migration, as {{ mrd-name }} does not provide access to the file system on cluster hosts.

{% endnote %}

To migrate {{ VLK }} databases from the _source cluster_ to the _target cluster_:

1. [Connect to the source cluster and create a logical dump](#create-dump).
1. Optionally, [upload the dump to the intermediate VM](#load-vm).

    You need to use a VM in {{ compute-full-name }} to transfer data if:

    * Your {{ mrd-name }} cluster is not accessible from the internet.
    * Your local hardware or {{ yandex-cloud }} cluster connection is not reliable enough.

1. [Restore the dump in the target cluster](#restore-dump).
1. [Make sure the dump is fully restored](#check-data).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ mrd-name }} target cluster fee, which covers the use of computing resources allocated to hosts, and disk space (see [{{ VLK }} pricing](../../managed-valkey/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* When creating a VM for dump upload: fee for the use of computing resources, storage, operating system (for certain OS types), and optionally public IP address (see [{{ compute-name }} pricing](../../compute/pricing.md)).


## Getting started {#before-you-begin}

### Set up your infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create](../../managed-valkey/operations/cluster-create.md) a {{ mrd-name }} cluster with any suitable configuration. To connect to the cluster from your local machine outside {{ yandex-cloud }}, enable TLS and public access for cluster hosts when creating the cluster.

    1. Optionally, [create an intermediate Linux VM](../../compute/operations/vm-create/create-linux-vm.md) in {{ compute-full-name }} in the same network as the {{ mrd-name }} cluster using the following configuration:

        * Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts).
        * Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

            * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
            * **{{ ui-key.yacloud.component.compute.network-select.field_internal-ipv4 }}**: `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.
            * **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}**: Same as for the {{ mrd-name }} cluster.

    
    1. If using {{ vpc-name }} security groups, [configure them](../../managed-valkey/operations/connect/index.md#configuring-security-groups).


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the configuration file matching your cluster type to the same working directory:

        * [redis-cluster-non-sharded.tf](https://github.com/yandex-cloud-examples/yc-redis-data-migration-from-on-premise/blob/main/redis-cluster-non-sharded.tf): For a non-sharded cluster.
        * [redis-cluster-sharded.tf](https://github.com/yandex-cloud-examples/yc-redis-data-migration-from-on-premise/blob/main/redis-cluster-sharded.tf): For a [sharded](../../managed-valkey/concepts/sharding.md) cluster.

        Each file describes the following:

        * Network.
        * Subnet.
        * Default security group and rules for connecting to your cluster and VM.
        * {{ mrd-name }} cluster with public internet access.
        * VM with public internet access, if required.

    1. Specify the following in the configuration file:

        * Password to access the {{ mrd-name }} cluster.
        * Optionally, VM settings:

            * VM public [image](../../compute/operations/images-with-pre-installed-software/get-list) ID, e.g., for [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
            * Username and absolute path to the [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) for accessing the virtual machine. By default, [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) ignores the specified username and automatically creates a user named `ubuntu`. Use it to connect to the VM.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Install additional software {#install-extra-software}

1. Optionally, install SSH file transfer tools on your local machine, such as the following:

    * [WinSCP](https://winscp.net/eng/index.php)
    * [Putty SCP](https://www.putty.org/)

1. Make sure [GNU Screen](https://www.gnu.org/software/screen/) is installed on the source cluster.

    Creating and restoring a dump may take a long time. To keep these processes running when your SSH session times out, start them with this tool. If your SSH connection drops during these operations, reconnect and resume the session using this command:

    ```bash
    screen -R
    ```

## Connect to the source cluster and create a logical dump {#create-dump}

1. Connect to the source cluster master host over SSH.
1. Download the archive with `redis-dump-go` from the [project page](https://github.com/yannh/redis-dump-go/releases). The examples below use version `0.5.1`.

    ```bash
    wget https://github.com/yannh/redis-dump-go/releases/download/v0.5.1/redis-dump-go_0.5.1_linux_amd64.tar.gz
    ```

1. Unpack the archive to the current directory:

    ```bash
    tar xf redis-dump-go_0.5.1_linux_amd64.tar.gz
    ```

1. Review the tool’s command-line options:

    ```bash
    ./redis-dump-go -h
    ```

1. If connecting to the {{ VLK }} cluster requires a password, enter it in the `REDISDUMPGO_AUTH` environment variable:

    ```bash
    export REDISDUMPGO_AUTH="<{{ VLK }}_password>"
    ```

1. Start an interactive `screen` session:

    ```bash
    screen
    ```

1. Start creating a logical dump:

    ```bash
    ./redis-dump-go \
        -host <master_host_IP_address_or_FQDN_in_{{ VLK }}_cluster> \
        -port <{{ VLK }}_port> > <dump_file>
    ```

    {% note tip %}

    While the dump is being created, the number of processed keys will appear on the screen. Remember or write down the last output value, as you will need it to check whether the dump has been fully restored in the target cluster.

    {% endnote %}

1. Once the dump is created, download it to your computer.

1. Terminate the interactive `screen` session:

    ```bash
    exit
    ```

## Optionally, upload the dump to the intermediate VM {#load-vm}


1. [Connect to the intermediate VM over SSH](../../compute/operations/vm-connect/ssh.md).


1. Upload the dump from your computer to the intermediate VM in any way you like.

## Restore the dump in the target cluster {#restore-dump}

1. [Connect to the cluster](../../managed-valkey/operations/connect/index.md) and run an interactive `screen` session:

    ```bash
    screen
    ```

1. Start the dump recovery:

    {% list tabs group=connection %}

    - Connecting without TLS {#without-tls}

        {% include [Install requirements](../../_includes/mdb/mvk/connect/bash/install-requirements.md) %}

        **Connecting via Sentinel**

        ```bash
        host=$(redis-cli \
          -h <FQDN_of_any_{{ VLK }}_host> \
          -p {{ port-mrd-sentinel }} \
          sentinel \
          get-master-addr-by-name \
          no-shards-no-tls | head -n 1)
        redis-cli \
          -h ${host} \
          -p {{ port-mrd }} \
          -a <target_cluster_password> \
          --pipe < <dump_file>
        ```

        **Connecting directly to the master host**

        ```bash
        redis-cli \
          -h <master_host_FQDN> \
          -p {{ port-mrd }} \
          -a <target_cluster_password> \
          --pipe < <dump_file>
        ```

        {% include [use-special-fqdn](../../_includes/mdb/mvk/conn-strings-fqdn.md) %}

        **Connecting to a sharded cluster**

        1. Create a script with commands to load the dump:

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

            While the script runs, you may see data insertion error messages. This is normal behavior for the `redis-cli` command, as each shard in a sharded cluster stores only a portion of the data. For more information, see [{#T}](../../managed-valkey/concepts/sharding.md).

    - Connecting with TLS {#with-tls}

        {% include [Install requirements SSL](../../_includes/mdb/mvk/connect/bash/install-requirements-ssl.md) %}

        **Connecting via Sentinel**

        ```bash
        host=$(redis-cli \
               -h <FQDN_of_any_{{ VLK }}_host> \
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

        {% include [use-special-fqdn](../../_includes/mdb/mvk/conn-strings-fqdn.md) %}

        **Connecting to a sharded cluster**

        1. Create a script with commands to load the dump:

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

            While the script runs, you may see data insertion error messages. This is normal behavior for the `redis-cli` command, as each shard in a sharded cluster stores only a portion of the data. For more information, see [{#T}](../../managed-valkey/concepts/sharding.md).

        {% endcut %}

    {% endlist %}

1. Terminate the interactive `screen` session:

    ```bash
    exit
    ```

## Make sure the dump is fully restored {#check-data}

1. In the [management console]({{ link-console-main }}), navigate to the folder where you want to restore the cluster.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Click the cluster name and open the [{{ ui-key.yacloud.redis.cluster.switch_monitoring }}](../../managed-valkey/operations/monitoring.md) tab.

Pay attention to the **DB Keys** chart showing the number of keys stored in the cluster. If the cluster is [sharded](../../managed-valkey/concepts/sharding.md), the chart will show the number of keys in each shard. In this case, the number of keys in the cluster is equal to the total number of keys across all shards.

The total number of keys in the cluster must match the number of keys processed by `redis-dump-go` when creating the dump.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    * [Delete the {{ mrd-full-name }} cluster](../../managed-valkey/operations/cluster-delete.md).
    * If you created a staging virtual machine, [delete it](../../compute/operations/vm-control/vm-delete.md).
    * If you reserved public static IP addresses, release and [delete them](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
