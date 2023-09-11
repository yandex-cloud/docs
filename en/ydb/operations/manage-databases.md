# Managing {{ ydb-short-name }} databases

In {{ ydb-name }}, you can create a database in two modes: [serverless](../concepts/serverless-and-dedicated.md#serverless) and [dedicated](../concepts/serverless-and-dedicated.md#dedicated), i.e., with dedicated servers.

Using the management console or {{ yandex-cloud }} CLI, you can:

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
   1. Enter the **Name** of the DB. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Under **Database type**, select the **Serverless** option.
   1. You will be suggested default values for DB parameters. They are selected for you to get started in the most efficient way. You can change them right away or later, if required. For more information about the DB settings, see [Serverless and dedicated modes](../concepts/serverless-and-dedicated.md).
   1. Click **Create database**.

   Wait for the database status to change to `Running`.

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the {{ yandex-cloud }} CLI command to create a database:

      ```bash
      yc ydb database create --help
      ```

   1. Run this command:

      ```bash
      yc ydb database create <DB_name> --serverless
      ```

      Result:

      ```text
      id: etne027gi9aa********
      folder_id: b1gmit33ngp3********
      created_at: "2022-12-13T09:17:06Z"
      name: svlbd
      status: PROVISIONING
      endpoint: {{ ydb.ep-serverless }}/?database=/{{ region-id }}/b1gia87mbaom********/etne027gi9aa********
      serverless_database:
      storage_size_limit: "53687091200"
      location_id: {{ region-id }}
      backup_config:
      backup_settings:
        - name: daily
          backup_schedule:
            daily_backup_schedule:
              execute_time:
                hours: 17
          backup_time_to_live: 604800s
          type: SYSTEM
      document_api_endpoint: {{ ydb.document-api-endpoint }}/{{ region-id }}/b1gia87mbaom********/etne027gi9aa********
      monitoring_config: {}
      ```

   You can [update](#update-db-serverles) any parameter later by running the `update` {{ yandex-cloud }} CLI command or using the management console. For more information, see [{#T}](../concepts/serverless-and-dedicated.md#serverless-options).

   Every serverless database is created with geographic redundancy in three [availability zones](../../overview/concepts/geo-scope.md).

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   For more information about {{ TF }}, [see our documentation](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the {{ TF }} configuration file, describe the parameters of the serverless DB to create:

      ```hcl
      resource "yandex_ydb_database_serverless" "database1" {
        name                = "<DB_name>"
        deletion_protection = "<deletion_protection:_true_or_false>"

        serverless_database {
          enable_throttling_rcu_limit = <true_or_false>
          provisioned_rcu_limit       = <throughput>
          storage_size_limit          = <data_size>
          throttling_rcu_limit        = <provisioned_throughput_capacity>
        }
      }
      ```

      Where:

      * `name`: DB name. This is a required parameter.
      * `deletion_protection`: DB deletion protection. You cannot delete a DB with this option enabled. If deletion protection is activated, this does not protect the DB contents. The default value is `false`.
      * `enable_throttling_rcu_limit`: Enable the throttling limit. This is an optional parameter. The default value is `false`.
      * `provisioned_rcu_limit`: Limit on Request Unit usage per second. This is an optional parameter. The default value is 0.
      * `storage_size_limit`: Amount of data, in GB. This is an optional parameter. The default value is 50 GB.
      * `throttling_rcu_limit`: Shows the request unit usage per second charged on an hourly basis according to the service plan. If set to 0, hourly billing is disabled. This is an optional parameter. The default value is 0.

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   {{ TF }} will create all the required resources. You can verify the changes using the [management console]({{ link-console-main }}) or the [{{ yandex-cloud }} CLI](../../cli/quickstart.md) command below:

   ```bash
   yc ydb database get <DB_name>
   ```

   **Example**

   Creating a serverless DB protected against deletion, with the 10 RU/s throughput limit and 50 GB of data:

   > ```hcl
   > resource "yandex_ydb_database_serverless" "database1" {
   >   name                = "test-ydb-serverless"
   >   deletion_protection = "true"
   >
   >   serverless_database {
   >     enable_throttling_rcu_limit = false
   >     provisioned_rcu_limit       = 10
   >     storage_size_limit          = 50
   >     throttling_rcu_limit        = 0
   >   }
   > }
   > ```

{% endlist %}

### Updating serverless database parameters {#update-db-serverless}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update the database settings.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the line with the DB you need and select **Edit**.
   1. Configure the DB settings:
      1. Change the DB name, if required.
      1. Under **Limits**, specify the [throughput](../pricing/serverless.md#prices-ru) and [max size](../pricing/serverless.md#rules-storage).
      1. Under **Pricing**, set the [provisioned capacity](../pricing/serverless.md#prices-ru).
   1. Click **Update database**.

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   View a description of the {{ yandex-cloud }} CLI command to update a database:

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

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and edit the fragment with the serverless DB description:

      ```hcl
      resource "yandex_ydb_database_serverless" "database1" {
        name                = "<DB_name>"
        deletion_protection = "<deletion_protection:_true_or_false>"

        serverless_database {
          enable_throttling_rcu_limit = <true_or_false>
          provisioned_rcu_limit       = <throughput>
          storage_size_limit          = <data_size>
          throttling_rcu_limit        = <provisioned_throughput_capacity>
        }
      }
      ```

      Where:

      * `name`: DB name. This is a required parameter.
      * `deletion_protection`: DB deletion protection. You cannot delete a DB with this option enabled. If deletion protection is activated, this does not protect the DB contents. The default value is `false`.
      * `enable_throttling_rcu_limit`: Enable the throttling limit. This is an optional parameter. The default value is `false`.
      * `provisioned_rcu_limit`: Limit on Request Unit usage per second. This is an optional parameter. The default value is 0.
      * `storage_size_limit`: Amount of data, in GB. This is an optional parameter. The default value is 50 GB.
      * `throttling_rcu_limit`: Shows the request unit usage per second charged on an hourly basis according to the service plan. If set to 0, hourly billing is disabled. This is an optional parameter. The default value is 0.

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   {{ TF }} will apply the required changes to the resources. You can verify the changes using the [management console]({{ link-console-main }}) or the [{{ yandex-cloud }} CLI](../../cli/quickstart.md) command below:

   ```bash
   yc ydb database get <DB_name>
   ```

   **Example**

   Changing the provisioned throughput capacity and amount of data for the `test-ydb-serverless` database:

   > ```hcl
   > resource "yandex_ydb_database_serverless" "database1" {
   >   name                = "test-ydb-serverless"
   >   deletion_protection = "true"
   >
   >   serverless_database {
   >     enable_throttling_rcu_limit = false
   >     provisioned_rcu_limit       = 10
   >     storage_size_limit          = 80
   >     throttling_rcu_limit        = 100
   >   }
   > }
   > ```

{% endlist %}

## Creating and updating parameters of a dedicated database {#dedicated}

### Creating a dedicated database {#create-db-dedicated}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your DB in.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click **Create database**.
   1. Enter the database **Name**. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Under **Database type**, select the **Dedicated** option.
   1. Under **Computing resources**, select the type and amount of [computing resources](../concepts/resources.md#resource-presets).
   1. Under **Storage groups**, select the disk type and number of [storage groups](../concepts/resources.md#storage-groups) that determines the total amount of storage.
   1. Under **Network**, configure network settings:
      1. (Optional) In the **Public IP addresses** field, select **Assign** if you plan to query the database from the {{ yandex-cloud }} network and the internet.

         {% include [traffic_metering](../_includes/traffic_metering.md) %}

      1. Select an existing network from the **Cloud network** list or create a new one:
         * Click **Create new**.
         * In the window that opens, enter a **Name** for the new network.
         * (Optional) Select the **Create subnets** option. Subnets in each availability zone will be created automatically.
         * Click **Create**.
      1. Under **Subnets**, select a subnet or create a new one for each availability zone:
         * Click **Create new**.
         * In the window that opens, enter a **Name** for the new subnet.
         * (Optional) Enter a **Description** of the subnet.
         * Select the availability zone you need from the **Availability zone** list.
         * Specify the subnet address in [**CIDR**](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) format.
         * Click **Create**.
   1. Click **Create database**.

   Wait for the database status to change to `Running`.

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the {{ yandex-cloud }} CLI command to create a database:

      ```bash
      yc ydb database create --help
      ```

   1. Run this command:

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
      * `--storage`: Media type and [storage group](../concepts/resources.md#storage-groups) count in `type=<type>,groups=<groups>` format. For the `ssd` type, a single storage group can store up to 100 GB of data.
      * `--resource-preset`: Configuration of the node computing resources. You can find the possible values in the **Configuration name** column of the table in [{#T}](../concepts/resources.md#resource-presets).

   Important additional parameters:

   * `--public-ip`: Flag indicating that public IP addresses are assigned. Without it, you cannot connect to the DB you created, from the internet.
   * `--fixed-size INT`: Number of cluster nodes, with the default value of 1. Nodes are allocated in different availability zones, so a configuration of three nodes will be geographically distributed across three availability zones.
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

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the {{ TF }} configuration file, describe the parameters of the Dedicated DB to create:

      ```hcl
       resource "yandex_ydb_database_dedicated" "database1" {
         name                = "<DB_name>"

         network_id          = "<network_ID>"
         subnet_ids          = ["<ID_of_subnet1>", "<ID_of_subnet2>", "<ID_of_subnet3>"]

         resource_preset_id  = "<computing_resource_configuration>"
         deletion_protection = "<deletion_protection:_true_or_false>"

         scale_policy {
           fixed_scale {
             size = <number_of_DB_instances>
           }
         }

         storage_config {
           group_count     = <number_of_storage_groups>
           storage_type_id = "<storage_media_type>"
         } 
       }
      ```

      Where:

      * `name`: DB name.
      * `network_id`: ID of the network the DB is connected to.
      * `subnet_ids`: List of subnet IDs, separated by commas.
      * `resource_preset_id`: Configuration of the node computing resources. You can find the possible values in the **Configuration name** column of the table in [{#T}](../concepts/resources.md#resource-presets).
      * `deletion_protection`: DB deletion protection. You cannot delete a DB with this option enabled. If deletion protection is activated, this does not protect the DB contents. The default value is `false`.
      * `scale_policy`: Scaling policy, where `size` indicates the number of DB instances.
      * `storage_config`: Storage configuration, where:
         * `group_count`: Number of [storage groups](../concepts/resources.md#storage-groups).
         * `storage_type_id`: Type of storage media. For the `ssd` type, a single storage group can store up to 100 GB of data.

   1. Create a database:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   {{ TF }} will create all the required resources. You can verify the changes using the [management console]({{ link-console-main }}) or the [{{ yandex-cloud }} CLI](../../cli/quickstart.md) command below:

   ```bash
   yc ydb database list
   ```

   **Example**

   Creating a single-node dedicated {{ ydb-name }} database with the minimum configuration, named `test-bd` and accessible from the internet:

   > ```hcl
   > resource "yandex_ydb_database_dedicated" "database2" {
   >    name                = "test-ydb-dedicated"
   >    network_id          = yandex_vpc_network.my-net.id
   >    subnet_ids          = [yandex_vpc_subnet.my-subnet-a.id, yandex_vpc_subnet.my-subnet-b.id, yandex_vpc_subnet.my-subnet-c.id]
   >    resource_preset_id  = "medium"
   >    deletion_protection = "true"
   >    scale_policy {
   >      fixed_scale {
   >        size = 1
   >      }
   >    }
   >   storage_config {
   >     group_count     = 1
   >     storage_type_id = "ssd"
   >   }
   > }
   > ```

{% endlist %}

### Updating dedicated database parameters {#update-db-dedicated}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update the database settings.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the line with the DB you need and select **Edit**.
   1. Configure the DB settings:
      1. Change the DB name, if required.
      1. Under **Computing resources**, select the type and amount of [computing resources](../concepts/resources.md#resource-presets).
      1. Under **Storage groups**, select the disk type and number of [storage groups](../concepts/resources.md#storage-groups) that determines the total amount of storage.
   1. Click **Update database**.

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   View a description of the {{ yandex-cloud }} CLI command to update a database:

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

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and edit the fragment with the DB description:

      > ```hcl
      > resource "yandex_ydb_database_dedicated" "database2" {
      >   name                = "my-first-ydb-dedicated"
      >   network_id          = yandex_vpc_network.my-net.id
      >   subnet_ids          = [yandex_vpc_subnet.my-subnet-a.id, yandex_vpc_subnet.my-subnet-b.id, yandex_vpc_subnet.my-subnet-c.id]
      >   resource_preset_id  = "medium"
      >   deletion_protection = "true"
      >   scale_policy {
      >     fixed_scale {
      >       size = 2
      >     }
      >   }
      >   storage_config {
      >     group_count     = 1
      >     storage_type_id = "ssd"
      >   }
      > }
      > ```

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   You can verify the changes using the [management console]({{ link-console-main }}) or the [{{ yandex-cloud }} CLI](../../cli/quickstart.md) command below:

   ```bash
   yc ydb database get <DB_name>
   ```

{% endlist %}

## Viewing the list of databases {#list-db}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to get a list of databases for.
   1. In the list of services, select **{{ ydb-name }}**.

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Run the following command:

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

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Run the following command:

   ```bash
   yc ydb database delete <DB_name>
   ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Open the {{ TF }} configuration file and delete the fragment with the DB description.

      Sample DB description in the {{ TF }} configuration:

      ```hcl
      resource "yandex_ydb_database_dedicated" "database2" {
        name               = "test-ydb-dedicated"

        network_id         = yandex_vpc_network.my-net.id
        subnet_ids         = [yandex_vpc_subnet.my-subnet-a.id, yandex_vpc_subnet.my-subnet-b.id, yandex_vpc_subnet.my-subnet-c.id]

        resource_preset_id = "medium"
        scale_policy {
          fixed_scale {
            size = 1
          }
        }

        storage_config {
          group_count     = 1
          storage_type_id = "ssd"
        }
      }
      ```

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   {{ TF }} will delete all the appropriate resources. You can verify the changes using the [management console]({{ link-console-main }}) or the [{{ yandex-cloud }} CLI](../../cli/quickstart.md) command below:

   ```bash
   yc ydb database list
   ```

{% endlist %}
