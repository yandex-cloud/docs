# Configuring {{ mch-name }} for Graphite

{{ mch-full-name }} can be used as data storage for [Graphite](https://graphite.readthedocs.io/en/latest/index.html).

The [GraphiteMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree/) table engine enables you to decimate and aggregate or average out the contents of a database specifically for Graphite. The engine reduces the data storage volume and improves the efficiency of queries from Graphite.

{% note info %}

If you do not need decimation and aggregation or averaging, you can use any {{ CH }} [table engine]({{ ch.docs }}/engines/table-engines/) to store Graphite data.

{% endnote %}

To configure a database to work with Graphite:
1. [Prepare the environment](#start).
1. [Create a cluster](#cluster-create).
1. [Register the rollup configuration in a cluster](#rollup-config).
1. [Create and set up a virtual machine](#VM-setup).
1. [Connect the virtual machine to a database](#cluster-connect).
1. [Create a GraphiteMergeTree table](#table-create).
1. [Configure Graphite](#graphite-setup).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare the environment {#start}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}



### Required paid resources {#paid-resources}

The cost of maintaining your {{ CH }} database for Graphite includes:
* Fee for the cluster computing resources, storage, and backups (see [{{ mch-full-name }} pricing](../../managed-clickhouse/pricing.md)).
* Fee for a running VM to manage a database (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).



## Create a cluster {#cluster-create}

1. [Create a {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) cluster in any suitable configuration with the `db1` database and public access to all of its hosts. Save the database name, username, and password.
1. In the [management console]({{ link-console-main }}), select {{ mch-name }} and go to the new cluster. Save the cluster ID in the **{{ ui-key.yacloud.common.overview }}** tab. 
1. In the top-right corner, click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**. In the **Shell** tab, save the `--host` parameter from the **Sample connection string** field, e.g., `rc1a-2sqal8f0********.{{ dns-zone }}`. This is the cluster host FQDN you will need later on.

## Register the rollup configuration in a cluster {#rollup-config}

Register the `rollup` configuration in your cluster to decimate and aggregate or average out the database contents for Graphite:

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Prepare a YAML file named `graphite-rollup.yaml` with a description of `rollup` parameters, e.g.:
  
      ```yaml
      name: test_rollup
      patterns:
        - regexp: click_cost
          function: max
          retention:
            - age: 86400
              precision: 60
      ```

  1. Run this command:

      ```bash
      yc managed-clickhouse cluster add-graphite-rollup <cluster_ID> --rollup-file-name <yaml_file_path>
      ```

      Where:

      * `<cluster_ID>`: Cluster ID.
      * `--rollup-file-name`: Path to `graphite-rollup.yaml`.

      For more information about the `managed-clickhouse cluster add-graphite-rollup` command, see the [CLI reference](../../cli/cli-ref/managed-services/managed-clickhouse/cluster/add-graphite-rollup.md).

- API {#api}
  
  Use the REST API [update](../../managed-clickhouse/api-ref/Cluster/update.md) method by providing the required `rollup` parameters in the request body:

    ```json
    "graphiteRollup": [
              {
                "name": "test_rollup",
                "patterns": [
                  {
                    "regexp": "click_cost",
                    "function": "max",
                    "retention": [
                      {
                        "age": "86400",
                        "precision": "60"
                      }
                    ]
                  }
                ]
              }
            ]
    ```

{% endlist %}

## Create and set up a virtual machine {#VM-setup}

1. In the same [cloud network](../../vpc/concepts/network.md) where the cluster is located, [create](../../compute/operations/vm-create/create-linux-vm.md) a VM on Linux. 
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH. 
1. Connect the {{ CH }} [DEB repository]({{ ch.docs }}/getting-started/install/#install-from-deb-packages):

    ```bash
    sudo apt update && sudo apt install -y apt-transport-https ca-certificates dirmngr && \
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
    echo "deb https://packages./deb stable main" | sudo tee \
    /etc/apt/sources.list.d/clickhouse.list
    ```

1. Install the dependencies and the `clickhouse-client` client application:

    ```bash
    sudo apt update && sudo apt install -y clickhouse-client
    ```

1. Download the configuration file for `clickhouse-client`:

    {% include [ClickHouse client config](../../_includes/mdb/mch/client-config.md) %}

1. Get an SSL certificate:

    ```bash
    sudo mkdir --parents  && \
    sudo wget "" \
         --output-document  && \
    sudo chmod 655  && \
    sudo update-ca-certificates
    ```

## Connect the virtual machine to a database {#cluster-connect}

1. If you are using security groups for a cloud network, [configure them](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) to allow all required traffic between the cluster and the VM.

1. [Connect](../../compute/operations/vm-connect/ssh.md). 
1. Run the {{ CH }} CLI with the following parameters: instead of `<host_FQDN>`, `<db_name>`, `<db_username>` and `<DB_user_password>`, specify the previously saved parameters.

    ```bash
    clickhouse-client --host <host_FQDN> \
                      --secure \
                      --user <db_username> \
                      --database <db_name> \
                      --password <db_user_password> \
                      --port 9440
    ```

## Create a GraphiteMergeTree table {#table-create}

{% list tabs group=instructions %}

- {{ CH }} CLI {#cli}

  In the {{ CH }} CLI interface, run a query to create a [GraphiteMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree/) table. For the parameter, provide the name of the `rollup` section described earlier:

    ```sql
    CREATE TABLE GraphiteTable
    (        
        Path String, 
        Time DateTime, 
        Value Int64, 
        Version UInt64
    )
    ENGINE = GraphiteMergeTree('test_rollup')
    PARTITION BY Time
    ORDER BY cityHash64(Version, Path)
    ```

{% endlist %}

## Configure Graphite {#graphite-setup}

Configure Graphite to save metrics in the {{ CH }} cluster. In this case, data is decimated automatically by the {{ CH }} server according to the parameters you specified.

1. Install the `carbon-clickhouse` utility in the system running Graphite:

    ```bash
    wget https://github.com/go-graphite/carbon-clickhouse/releases/download/v0.11.2/carbon-clickhouse_0.11.2_amd64.deb && \
    sudo apt-get install $(pwd)/carbon-clickhouse_0.11.2_amd64.deb
    ```

1. [Configure](https://github.com/go-graphite/carbon-clickhouse) `carbon-clickhouse`.
1. Run `carbon-clickhouse`:

    ```bash
    sudo systemctl enable carbon-clickhouse && \
    sudo systemctl start carbon-clickhouse
    ```

1. Install the `graphite-clickhouse` utility:

    ```bash
    wget https://github.com/go-graphite/graphite-clickhouse/releases/download/v0.13.2/graphite-clickhouse_0.13.2_amd64.deb && \
    sudo apt-get install $(pwd)/graphite-clickhouse_0.13.2_amd64.deb
    ```

1. [Configure](https://github.com/go-graphite/graphite-clickhouse) `graphite-clickhouse`.
1. Run `graphite-clickhouse`:

    ```bash
    sudo systemctl enable graphite-clickhouse && \
    sudo systemctl start graphite-clickhouse
    ```

    For more information about configuring Graphite, see the [relevant documentation](https://graphite.readthedocs.io/en/latest/index.html). 

## How to delete the resources you created {#clear-out}

To remove the `rollup` configuration from a cluster:

1. Delete all the tables that use this configuration.
1. Run the `yc managed-clickhouse cluster remove-graphite-rollup` command.

For more information about the command, see the [CLI reference](../../cli/cli-ref/managed-services/managed-clickhouse/cluster/remove-graphite-rollup.md).

{% note alert %}

Removal of the `rollup` configuration without first deleting the tables that use it may result in cluster failure.

{% endnote %}

Delete the resources you no longer need to avoid paying for them:

* [Delete the {{ CH }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
* [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
