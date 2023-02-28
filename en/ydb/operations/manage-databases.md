# Managing {{ ydb-short-name }} databases

In {{ ydb-name }}, you can create a database in two modes: [serverless](../concepts/serverless-and-dedicated.md#serverless) and [dedicated](../concepts/serverless-and-dedicated.md#dedicated), i.e., with dedicated servers.

Using the management console or YC CLI, you can:

* [Create and update parameters of a serverless database](#serverless).
* [Create and update parameters of a dedicated database](#dedicated).
* [View a list of databases](#list-db).
* [Delete a database](#delete-db).

## Creating and updating parameters of a serverless database {#serverless}

### Creating a serverless database {#create-db-serverless}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your DB in.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click **Create database**.
   1. Enter the **Name** of the DB. For naming requirements, see below:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Under **Database type**, select the **Serverless** option.
   1. You will be suggested default values for DB parameters. They are selected for you to get started in the most efficient way. You can change them right away or later, if required. For more information about the DB settings, see [Serverless and dedicated modes](../concepts/serverless-and-dedicated.md).
   1. Click **Create database**.

   Wait for the database status to change to `Running`.

- YC CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the YC CLI command to create a database:

      ```bash
      yc ydb database create --help
      ```

   1. Run the command:

      ```bash
      yc ydb database create <DB_name> --serverless
      ```

      Result:

      ```text
      id: etne027gi9aap7ldau3f
      folder_id: b1gmit33ngp3kr4mhjmo
      created_at: "2022-12-13T09:17:06Z"
      name: svlbd
      status: PROVISIONING
      endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1gia87mbaomkfvsleds/etne027gi9aap7ldau3f
      serverless_database:
      storage_size_limit: "53687091200"
      location_id: ru-central1
      backup_config:
      backup_settings:
        - name: daily
          backup_schedule:
            daily_backup_schedule:
              execute_time:
                hours: 17
          backup_time_to_live: 604800s
          type: SYSTEM
      document_api_endpoint: https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaomkfvsleds/etne027gi9aap7ldau3f
      monitoring_config: {}
      ```

   You can [update](#update-db-serverles) any parameter later by running the YC CLI `update` command or using the management console. For more information, see [{#T}](../concepts/serverless-and-dedicated.md#serverless-options).

   Every serverless database is created with geographic redundancy in three [availability zones](../../overview/concepts/geo-scope.md).

{% endlist %}

### Updating serverless database parameters {#update-db-serverless}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update the database settings.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the line with the DB you need and select **Edit**.
   1. Configure the DB settings:
      1. Change the DB name if required.
      1. Under **Limits**, specify the {% if product == "yandex-cloud" %}[throughput](../pricing/serverless.md#prices-ru) and [max size](../pricing/serverless.md#rules-storage){% else %}throughput and max size.{% endif %}
      1. Under **Pricing**, set the {% if product == "yandex-cloud" %}[provisioned capacity](../pricing/serverless.md#prices-ru){% else %}provisioned capacity.{% endif %}
   1. Click **Update database**.

- YC CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   View a description of the YC CLI command to update a database:

   ```bash
   yc ydb database update --help
   ```

   Serverless DB parameter names start with `sls-`. Other parameters are only applicable to dedicated DBs.

   **Examples**

   1. Renaming the `dbtest` database to `mydb`:

      > ```bash
      > yc ydb database update dbtest \
      >   --new-name mydb
      > ```

   1. Setting a consumption limit of 100 request units per second for a serverless DB named db5:

      > ```bash
      > yc ydb database update db5 \
      >   --sls-throttling-rcu 100
      > ```

{% endlist %}

## Creating and updating parameters of a dedicated database {#dedicated}

### Creating a dedicated database {#create-db-dedicated}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your DB in.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click **Create database**.
   1. Enter the database **Name**. For naming requirements, see below:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Under **Database type**, select the **Dedicated** option.
   1. Under **Computing resources**, select the type and amount of [computing resources](../concepts/resources.md#resource-presets).
   1. Under **Storage groups**, select the disk type and number of [storage groups](../concepts/resources.md#storage-groups) that determines the total amount of storage.
   1. Under **Network**, configure network settings:
      1. (optional) In the **Public IP addresses** field, select **Assign** if you plan to query the database from the {{ yandex-cloud }} network and the internet.

         {% include [traffic_metering](../_includes/traffic_metering.md) %}

      1. Select an existing network from the **Cloud network** list or create a new one:
         * Click **Create new**.
         * In the window that opens, enter a **Name** for the new network.
         * (optional) Select the **Create subnets** option. Subnets in each availability zone will be created automatically.
         * Click **Create**.
      1. Under **Subnets**, select a subnet or create a new one for each availability zone:
         * Click **Create new**.
         * In the window that opens, enter a **Name** for the new subnet.
         * (optional) Enter a **Description** of the subnet.
         * Select the desired availability zone from the **Availability zone** list.
         * Specify the subnet address in [**CIDR**]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Бесклассовая_адресация){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing){% endif %} format.
         * Click **Create**.
   1. Click **Create database**.

   Wait for the database status to change to `Running`.

- YC CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the YC CLI command to create a database:

      ```bash
      yc ydb database create --help
      ```

   1. Run the command:

      ```bash
      yc ydb database create <DB_name> \
        --dedicated \
        --network-name <network_name> \
        --storage <storage_media_type>,<number_of_storage_groups> \
        --resource-preset <computing_resource_configuration> \
      ```

      Where:

      * `--dedicated`: Configuration of the DB with dedicated servers.
      * `--network-name`: Name of the cloud network to create the DB in. You can specify the network as `default`.
      * `--storage`: Media type and storage group count in `type=<type>,groups=<groups>` format. For the `ssd` type, a single storage group can store up to 100 GB of data.
      * `--resource-preset`: Configuration of the node computing resources. You can [view](../concepts/resources.md#resource-presets) possible values in the table, namely, in the **Configuration name** column.

   Important additional parameters:

   * `--public-ip`: Flag indicating that public IP addresses are assigned. Without it, you cannot connect to the DB you created, from the internet.
   * `--fixed-size INT`: Number of cluster nodes, with the default number of 1. Nodes are allocated in different availability zones, so a configuration of three nodes will be geographically distributed across three availability zones.
   * `--async`: Asynchronous DB creation flag. Creating a dedicated DB may take a long time, up to a few minutes. You can set this flag to return control as soon as the `create DB` command is accepted by the cloud.

   **Examples**

   1. Creating a single-node dedicated YDB database with the minimum configuration, named `dedb` and accessible from the internet:

      > ```bash
      > yc ydb database create dedb \
      >   --dedicated \
      >   --network-name default \
      >   --storage type=ssd,groups=1 \
      >   --resource-preset medium \
      >   --public-ip
      > ```

   1. Asynchronously creating a three-node dedicated YDB database with geographic redundancy, 300 GB of storage, and computing nodes with 64 GB RAM each, named `dedb3` and accessible from the internet:

      > ```bash
      > yc ydb database create dedb3 \
      >   --dedicated
      >   --network-name default \
      >   --storage type=ssd,groups=3 \
      >   --resource-preset medium-m64 \
      >   --public-ip \
      >   --fixed-size 3 \
      >   --async
      > ```

{% endlist %}

### Updating dedicated database parameters {#update-db-dedicated}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update the database settings.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the line with the DB you need and select **Edit**.
   1. Configure the DB settings:
      1. Change the DB name if required.
      1. Under **Computing resources**, select the type and amount of [computing resources](../concepts/index.md#resource-presets).
      1. Under **Storage groups**, select the disk type and number of [storage groups](../concepts/index.md#storage-groups) that determines the total amount of storage.
   1. Click **Update database**.

- YC CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   View a description of the YC CLI command to update a database:

   ```bash
   yc ydb database update --help
   ```

   Dedicated DB parameters have no `sls-` prefix.

   **Example**

   Changing the number of storage groups for a DB with the SSD storage type and a single storage group:

   > ```bash
   > yc ydb database update test-db \
   >   --storage type=ssd,group=2
   > ```

   You cannot decrease the number of storage groups.

{% endlist %}

## Viewing the list of databases {#list-db}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to get a list of databases for.
   1. In the list of services, select **{{ ydb-name }}**.

- YC CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Run the command:

   ```bash
   yc ydb database list
   ```

{% endlist %}

## Deleting a database {#delete-db}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to delete the DB from.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the line with the DB you need and select **Delete**.
   1. Confirm the deletion.

- YC CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Run the command:

   ```bash
   yc ydb database delete <DB_name>
   ```

{% endlist %}
