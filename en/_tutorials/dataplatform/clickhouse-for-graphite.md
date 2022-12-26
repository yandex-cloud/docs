# Configuring {{ mch-name }} for Graphite

{{ mch-full-name }} can be used as data storage for [Graphite](https://graphite.readthedocs.io/en/latest/index.html).

The table engine [GraphiteMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree/) enables you to trim and aggregate or average the contents of a database specifically for Graphite. The engine reduces the data storage volume and improves the efficiency of queries from Graphite.

{% note info %}

If trimming and aggregation or averaging are not required, any {{ CH }} [table engine]({{ ch.docs }}/engines/table-engines/) can be used to store Graphite data.

{% endnote %}

To configure a database to work with Graphite:
1. [Prepare the environment](#start).
1. [Create a cluster](#cluster-create).
1. [Register the rollup configuration in a cluster](#rollup-config).
1. [Create and set up a virtual machine](#VM-setup).
1. [Connect the virtual machine to a database](#cluster-connect).
1. [Create a GraphiteMergeTree table](#table-create).
1. [Configure Graphite](#graphite-setup).

If you no longer need these resources, [delete them](#clear-out).

## Prepare the environment {#start}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if audience != "internal" %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of maintaining your {{ CH }} database for Graphite includes:
* A payment for the cluster's computing resources, the amount of storage and backups (see [{{ mch-full-name }} pricing](../../managed-clickhouse/pricing.md)).
* A payment for a running VM to manage a database (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

{% endif %}

{% endif %}

## Create a cluster {#cluster-create}

1. [Create a {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) in any suitable configuration with the `db1` database and public access to all of its hosts. Save the database name, username, and password.
1. In the [management console]({{ link-console-main }}), select {{ mch-name }} and go to the created cluster. Save the cluster ID on the **Overview** tab.
1. In the upper-right corner, click **Connect**, on the **Shell** tab from the **Sample connection string** field, save the `--host` parameter, for example, `rc1a-2sqal8f01znegjkj.{{ dns-zone }}`. This is the FQDN of the cluster host, you will need it later.

## Register the rollup configuration in a cluster {#rollup-config}

Register the `rollup` configuration in a cluster to trim and aggregate or average the contents of a database for Graphite:

{% list tabs %}

- CLI

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Prepare the yaml file `graphite-rollup.yaml` with the description of the `rollup` parameters, for example:

      ```bash
                name: test_rollup
      patterns:    
          - regexp: click_cost
          function: max
          retention:
            - age: 86400
              precision: 60
      ```

   1. Specify the cluster ID in place of `<CLUSTER_ID>` and the path to `graphite-rollup.yaml` in place of `<path to yaml file>` and run the command:

      ```bash
      yc managed-clickhouse cluster add-graphite-rollup <CLUSTER_ID> --rollup-file-name <path to yaml file>
      ```

      Where:

      * `<CLUSTER_ID>`: Cluster ID.
      * `<path to yaml file>`: Path to `graphite-rollup.yaml`.

      For more information about the `managed-clickhouse cluster add-graphite-rollup` command, see the [CLI reference](../../cli/cli-ref/managed-services/managed-clickhouse/cluster/add-graphite-rollup.md).

      {% note info %}

      To delete the `rollup` configuration, use the `managed-clickhouse cluster remove-graphite-rollup` command. For more information about the command, see the [CLI reference](../../cli/cli-ref/managed-services/managed-clickhouse/cluster/remove-graphite-rollup.md).

      {% endnote %}

- API

   Use the REST API [update](../../managed-clickhouse/api-ref/Cluster/update.md) method by passing the required `rollup` parameters in the query body:

   ```
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

1. {% if audience != "internal" %}In the same [cloud network](../../vpc/concepts/network.md) where the cluster is located, [create](../../compute/operations/vm-create/create-linux-vm.md) a VM on Linux. {% else %}In the same cloud network where the cluster is located, create a VM on Linux. {% endif %}
1. {% if audience != "internal" %}[Connect](../../compute/operations/vm-connect/ssh.md){% else %}Connect{% endif %} to the VM via SSH.
1. Connect the [DEB repository]({{ ch.docs }}/getting-started/install/#install-from-deb-packages) {{ CH }}:

   ```bash
   sudo apt update && sudo apt install -y apt-transport-https ca-certificates dirmngr && \
   sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
   echo "deb https://repo.{{ ch-domain }}/deb/stable/ main/" | sudo tee \
   /etc/apt/sources.list.d/clickhouse.list
   ```

1. Install the dependencies and the `clickhouse-client` client application:

   ```bash
   sudo apt update && sudo apt install -y clickhouse-client
   ```

1. Download the configuration file for `clickhouse-client`:

   ```bash
   mkdir -p ~/.clickhouse-client && wget "https://{{ s3-storage-host }}/mdb/clickhouse-client.conf.example" -O ~/.clickhouse-client/config.xml
   ```

1. Get an SSL certificate:

   {% if audience != "internal" %}

   ```bash
   mkdir --parents /usr/local/share/ca-certificates/Yandex/ && \
   wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
       --output-document /usr/local/share/ca-certificates/Yandex/YandexCA.crt && \
   chmod 655 /usr/local/share/ca-certificates/Yandex/YandexCA.crt
   ```

   {% else %}

   ```bash
   wget "{{ pem-path }}" \
       --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
   chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
   ```

   {% endif %}

## Connect the virtual machine to a database {#cluster-connect}

1. [Configure security groups](../../managed-clickhouse/operations/connect.md#configuring-security-groups) for the cloud network to permit all the required traffic between the cluster and the VM.
1. {% if audience != "internal" %}[Connect](../../compute/operations/vm-connect/ssh.md){% else %}Connect{% endif %}.
1. Run the ClickHouse CLI with the following parameters: specify the earlier saved parameters in place of `<host FQDN>`, `<database name>`, `<database username>`, and `<database user password>`.

   ```bash
   clickhouse-client --host <host FQDN> \
                     --secure \
                     --user <database username> \
                     --database <database name> \
                     --password <database user password> \
                     --port 9440
   ```

## Create a GraphiteMergeTree table {#table-create}

{% list tabs %}

- ClickHouse CLI

   In the ClickHouse CLI interface, run a query to create a [GraphiteMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/graphitemergetree/) table. Pass the name of the `rollup` section described earlier:

   ```bash
   CREATE TABLE GraphiteTable
   (        
       metric String,
       time DateTime,
       value Int64,
       version UInt64
   )
   ENGINE = GraphiteMergeTree('test_rollup')
   PARTITION BY time
   ORDER BY cityHash64(version, metric)
   ```

{% endlist %}

## Configure Graphite {#graphite-setup}

Configure Graphite to save metrics in the {{ CH }} cluster. In this case, data is trimmed automatically by the {{ CH }} server according to the parameters you specified.

1. Install the `carbon-clickhouse` utility in the system with Graphite:

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

   For more information about configuring Graphite, see the [documentation](https://graphite.readthedocs.io/en/latest/index.html).

## How to delete created resources {#clear-out}

To stop paying for the resources created:
* [Delete the {{ CH }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
* {% if audience != "internal" %}[Delete the VM](../../compute/operations/vm-control/vm-delete.md){% else %}Delete the VM{% endif %}.
