# Configuring {{ mch-name }} for Graphite

You can use {{ mch-full-name }} to store [Graphite](https://graphite.readthedocs.io/en/latest/index.html) data.

The [GraphiteMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree/) table engine is designed for thinning and aggregating/averaging Graphite data. The engine reduces storage volume and improves the efficiency of queries from Graphite.

{% note info %}

If thinning, aggregation, or averaging, are not required, you can use any {{ CH }} [table engine]({{ ch.docs }}/engines/table-engines/) for storing Graphite data.

{% endnote %}

To configure a database to work with Graphite:
1. [Set up your environment](#start).
1. [Create a cluster](#cluster-create).
1. [Register the rollup configuration in the cluster](#rollup-config).
1. [Create and configure a virtual machine](#VM-setup).
1. [Connect your virtual machine to the database](#cluster-connect).
1. [Create a GraphiteMergeTree table](#table-create).
1. [Configure Graphite](#graphite-setup).

If you no longer need the resources you created, [delete them](#clear-out).

## Set up your environment {#start}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of maintaining your {{ CH }} database for Graphite includes:
* Fee for the cluster computing resources, storage, and backups (see [{{ mch-full-name }} pricing](../../managed-clickhouse/pricing.md)).
* Fee for a running VM managing the database (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).


## Create a cluster {#cluster-create}

1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with your preferred configuration with the `db1` database and public access to all of its hosts. Save the database name, username, and password.
1. In the [management console]({{ link-console-main }}), select {{ mch-name }} and navigate to your new cluster. Save the cluster ID from the **{{ ui-key.yacloud.common.overview }}** tab. 
1. In the top-right corner, click **{{ ui-key.yacloud.mdb.clusters.button_action-connect }}**. In the **Shell** tab, save the `--host` value from the **Sample connection string** field, e.g., `rc1a-2sqal8f0********.{{ dns-zone }}`. This is the cluster host’s FQDN you will need later on.

## Register the rollup configuration in the cluster {#rollup-config}

Register the `rollup` configuration in your cluster for thinning, then aggregating or averaging Graphite data:

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Prepare the `graphite-rollup.yaml` file describing `rollup` parameters, e.g.:
  
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

      For more information about the `managed-clickhouse cluster add-graphite-rollup` command, see the [CLI reference](../../cli/cli-ref/managed-clickhouse/cli-ref/cluster/add-graphite-rollup.md).

- API {#api}
  
  Use the REST API [update](../../managed-clickhouse/api-ref/Cluster/update.md) method, providing the required `rollup` parameters in the request body:

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

## Create and configure a virtual machine {#VM-setup}

1. [Create](../../compute/operations/vm-create/create-linux-vm.md) a Linux VM in your cluster’s [cloud network](../../vpc/concepts/network.md).
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH. 
1. Add the {{ CH }} [DEB repository]({{ ch.docs }}/getting-started/install/#install-from-deb-packages):

    ```bash
    sudo apt update && sudo apt install -y apt-transport-https ca-certificates dirmngr && \
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
    echo "deb https://packages.{{ ch-domain }}/deb stable main" | sudo tee \
    /etc/apt/sources.list.d/clickhouse.list
    ```

1. Install the dependencies and the `clickhouse-client` application:

    ```bash
    sudo apt update && sudo apt install -y clickhouse-client
    ```

1. Download the `clickhouse-client` configuration file:

    {% include [ClickHouse client config](../../_includes/mdb/mch/client-config.md) %}

1. Get an SSL certificate:

    ```bash
    sudo mkdir --parents {{ crt-local-dir }} && \
    sudo wget "{{ crt-web-path-root }}" \
         --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
    sudo chmod 655 {{ crt-local-dir }}{{ crt-local-file-root }} && \
    sudo update-ca-certificates
    ```

## Connect your virtual machine to the database {#cluster-connect}

1. If using security groups for your cloud network, [configure them](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups) to allow all required traffic between your cluster and VM.

1. [Connect](../../compute/operations/vm-connect/ssh.md). 
1. Run the {{ CH }} CLI, replacing the following placeholders with your saved values: `<host_FQDN>`, `<DB_name>`, `<DB_user_name>`, and `<DB_user_password>`.

    ```bash
    clickhouse-client --host <host_FQDN> \
                      --secure \
                      --user <DB_user_name> \
                      --database <DB_name> \
                      --password <DB_user_password> \
                      --port 9440
    ```

## Create a table using the GraphiteMergeTree engine {#table-create}

{% list tabs group=instructions %}

- {{ CH }} CLI {#cli}

  To create a [GraphiteMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree/) table, run the following query in the {{ CH }} CLI interface, providing the name of the previously described `rollup` section as a parameter:

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

Configure Graphite to store metrics in your {{ CH }} cluster. The {{ CH }} server will automatically handle data thinning based on your configured retention rules.

1. Install `carbon-clickhouse` utility on your Graphite server:

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

1. Install `graphite-clickhouse`:

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

    For more information on configuring Graphite, see [these guides](https://graphite.readthedocs.io/en/latest/index.html). 

## How to delete the resources you created {#clear-out}

To remove the `rollup` configuration from your cluster:

1. Delete all the tables that use this configuration.
1. Run the `yc managed-clickhouse cluster remove-graphite-rollup` command.

For more information about this command, see the [CLI reference](../../cli/cli-ref/managed-clickhouse/cli-ref/cluster/remove-graphite-rollup.md).

{% note alert %}

Removing the `rollup` configuration without first deleting its dependent tables may result in cluster failure.

{% endnote %}

Delete the resources you no longer need to avoid paying for them:

* [Delete the {{ CH }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
* [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
