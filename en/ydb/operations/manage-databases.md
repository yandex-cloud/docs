# Managing {{ ydb-short-name }} databases

In {{ ydb-name }}, you can create a database in two modes: [serverless](../concepts/serverless-and-dedicated.md#serverless) and [dedicated](../concepts/serverless-and-dedicated.md#dedicated), i.e., with dedicated servers.

You can use the management console or {{ yandex-cloud }} CLI to:

* [Create and update parameters of a serverless database](#serverless).
* [Create and update parameters of a dedicated database](#dedicated).
* [View a list of databases](#list-db).
* [Delete a database](#delete-db).

## Creating and updating parameters of a serverless database {#serverless}

### Creating a serverless database {#create-db-serverless}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create your DB in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Click **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. Enter the **{{ ui-key.yacloud.ydb.forms.label_field_name }}** of the DB. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Under **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}**, select `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
  1. You will be suggested default values for DB parameters. They are selected for you to get started in the most efficient way. You can change them right away or later, if required. For more information about the DB settings, see [Serverless and dedicated modes](../concepts/serverless-and-dedicated.md).
  1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

   Wait for the DB status to change to `Running`.

- {{ yandex-cloud }} CLI {#cli}

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

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the {{ TF }} configuration file, describe the parameters of the serverless DB to create:

      ```hcl
      resource "yandex_ydb_database_serverless" "database1" {
        name                = "<DB_name>"
        deletion_protection = "<deletion_protection>"

        serverless_database {
          enable_throttling_rcu_limit = <throughput_limit>
          provisioned_rcu_limit       = <throughput>
          storage_size_limit          = <data_size>
          throttling_rcu_limit        = <allocated_throughput>
        }
      }
      ```

     Where:

     * `name`: DB name. This is a required parameter.
     * `deletion_protection`: DB deletion protection, `true` or `false`. You cannot delete a DB with this option enabled. If deletion protection is activated, this does not protect the DB contents. The default value is `false`.
     * `enable_throttling_rcu_limit`: Enable throughput limit, `true` or `false`. This is an optional parameter. The default value is `false`.
     * `provisioned_rcu_limit`: Limit on request units consumed per second. This is an optional parameter. The default value is `0`.
     * `storage_size_limit`: Data size limit in bytes. This is an optional parameter. The default value is `50` GB.
     * `throttling_rcu_limit`: Shows the request unit usage per second charged on an hourly basis according to the service plan. If set to 0, hourly billing is off. This is an optional parameter. The default value is `0`.
     
  1. Apply the changes:
  
      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
    {{ TF }} will create all the required resources. You can check the update using the [management console]({{ link-console-main }}) or this [{{ yandex-cloud }}CLI](../../cli/quickstart.md) command:

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

- API {#api}

  To create a serverless database, use the [create](../api-ref/Database/create.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/Create](../api-ref/grpc/Database/create.md) gRPC API call and provide the following in the request:

  * ID of the folder to host the database in the `folderId` parameter.
  * DB name in the `name` parameter.
  * DB throughput in the `serverlessDatabase.throttlingRcuLimit` parameter.
  * DB size (in bytes) in the `serverlessDatabase.storageSizeLimit` parameter.

{% endlist %}

### Updating serverless database parameters {#update-db-serverless}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to update DB settings.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the row with the DB and select **{{ ui-key.yacloud.ydb.overview.button_action-edit }}**.
  1. Configure the DB settings:
      1. Change the DB name, if required.
      1. Under **{{ ui-key.yacloud.ydb.overview.label_serverless-limits }}**, specify [throughput](../pricing/serverless.md#prices-ru) and [data size](../pricing/serverless.md#rules-storage).
      1. Under **{{ ui-key.yacloud.ydb.overview.label_serverless-billing }}**, set the [provisioned throughput capacity](../pricing/serverless.md#prices-ru).
  1. Click **{{ ui-key.yacloud.ydb.forms.button_update-database }}**.

- {{ yandex-cloud }} CLI {#cli}

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

  1. Setting a consumption limit of 100 request units per second for a serverless DB named `db5`:

      > ```bash
      > yc ydb database update db5 \
      >   --sls-throttling-rcu 100
      > ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the fragment with the serverless DB description:

      ```hcl
      resource "yandex_ydb_database_serverless" "database1" {
        name                = "<DB_name>"
        deletion_protection = "<deletion_protection>"

        serverless_database {
          enable_throttling_rcu_limit = <throughput_limit>
          provisioned_rcu_limit       = <throughput>
          storage_size_limit          = <data_size>
          throttling_rcu_limit        = <allocated_throughput>
        }
      }
      ```

     Where:

     * `name`: DB name. This is a required parameter.
     * `deletion_protection`: DB deletion protection, `true` or `false`. You cannot delete a DB with this option enabled. If deletion protection is activated, this does not protect the DB contents. The default value is `false`.
     * `enable_throttling_rcu_limit`: Enable throughput limit, `true` or `false`. This is an optional parameter. The default value is `false`.
     * `provisioned_rcu_limit`: Limit on request units consumed per second. This is an optional parameter. The default value is `0`.
     * `storage_size_limit`: Amount of data, GB. This is an optional parameter. The default value is `50`.
     * `throttling_rcu_limit`: Shows the request unit usage per second charged on an hourly basis according to the service plan. If set to 0, hourly billing is off. This is an optional parameter. The default value is `0`.

  1. Apply the changes:
  
      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

    {{ TF }} will apply the required changes to the resources. You can check the update using the [management console]({{ link-console-main }}) or this [{{ yandex-cloud }} CLI](../../cli/quickstart.md) command:

    ```bash
    yc ydb database get <DB_name>
    ```
  
  **Example**

  Changing the provisioned throughput capacity and amount of data for the `test-ydb-serverless` DB:

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

- API {#api}

  To change the serverless database parameters, use the [update](../api-ref/Database/update.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/Update](../api-ref/grpc/Database/update.md) gRPC API call and specify the database ID in the `databaseId` request parameter.

  {% include [get-db-id](../../_includes/ydb/get-db-id.md) %}

   Provide the following in the request:

  * ID of the folder to host the database in the `folderId` parameter.
  * DB name in the `name` parameter.
  * DB throughput in the `serverlessDatabase.throttlingRcuLimit` parameter.
  * DB size (in bytes) in the `serverlessDatabase.storageSizeLimit` parameter.
  * Computing resource ID in the `resourcePresetId` parameter.
  * Network ID in the `networkId` parameter.
  * Media type in the `storageConfig.storageOptions.storageTypeId` parameter.
  * Number of storage groups in the `storageConfig.storageOptions.groupCount` parameter.
  * Number of database instances in the `scalePolicy.fixedScale.size` parameter.

{% endlist %}

## Creating and updating parameters of a dedicated database {#dedicated}

### Creating a dedicated database {#create-db-dedicated}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create your DB in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Click **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. Enter the database **{{ ui-key.yacloud.ydb.forms.label_field_name }}**. The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Under **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}**, select `{{ ui-key.yacloud.ydb.forms.label_dedicated-type }}`.
  1. Under **{{ ui-key.yacloud.ydb.forms.label_section-compute }}**, select the type and amount of [computing resources](../concepts/resources.md#resource-presets).

      {% note warning %}

      For reliable and stable performance, a database needs multiple slots. A database run in the production environment must have at least three slots.

      {% endnote %}

  1. Under **{{ ui-key.yacloud.ydb.forms.label_section-storage }}**, select the disk type and number of [storage groups](../concepts/resources.md#storage-groups) that determines the total amount of storage.
  1. Under **{{ ui-key.yacloud.ydb.forms.label_section-network }}**, configure network settings:
      1. (Optional) In the **{{ ui-key.yacloud.ydb.forms.field_public-ips }}** field, select **{{ ui-key.yacloud.ydb.forms.label_text-public-ips }}** if you plan to query the database from the {{ yandex-cloud }} network and the internet.

          {% include [traffic_metering](../_includes/traffic_metering.md) %}

      1. Select an existing network from the **{{ ui-key.yacloud.ydb.forms.field_network }}** list or create a new one:
          * Click **{{ ui-key.yacloud.common.create }}**.
          * In the window that opens, enter a **{{ ui-key.yacloud.vpc.networks.create.field_name }}** for the new network.
          * Optionally, select **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**. Subnets in each availability zone will be created automatically.
          * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.
      1. Under **{{ ui-key.yacloud.ydb.forms.field_subnetworks }}**, select a subnet or create a new one for each availability zone:
          * Click **{{ ui-key.yacloud.common.create }}**.
          * In the window that opens, enter a **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** for the new subnet.
          * (Optional) Enter a **{{ ui-key.yacloud.vpc.subnetworks.create.field_description }}** of the subnet.
          * Select the availability zone you need from the **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** list.
          * Set the subnet address in [**{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}**](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) format.
          * Click **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.
  1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

    Wait for the DB status to change to `Running`.

- {{ yandex-cloud }} CLI {#cli}

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
        --storage <media_type>,<number_of_storage_groups> \
        --resource-preset <computing_resource_configuration> \
      ```

      Where:

        * `--dedicated`: Configuration of the DB with dedicated servers.
        * `--network-name`: Name of the cloud network to create the DB in. You can specify the `default` network.
        * `--storage`: Media type and number of [storage groups](../concepts/resources.md#storage-groups) in `type=<media_type>,groups=<number_of_storage_groups>` format. For the `ssd` type, a single storage group can store up to 100 GB of data.
        * `--resource-preset`: Configuration of the node computing resources. You can find the possible values in the **Configuration name** column of the table in [{#T}](../concepts/resources.md#resource-presets).

  Important additional parameters:

  * `--public-ip`: Public IP address assignment flag. Without it, you cannot connect to the DB you created from the internet.
  * `--fixed-size INT`: Number of cluster nodes, `1` by default. Nodes are allocated in different availability zones, so a configuration of three nodes will be geographically distributed across three availability zones.
  * `--async`: Asynchronous DB creation flag. Creating a dedicated DB may take a long time, up to a few minutes. You can set this flag to recover control as soon as the command to create DB is accepted by the cloud.

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

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the {{ TF }} configuration file, describe the parameters of the Dedicated DB to create:

     ```hcl
      resource "yandex_ydb_database_dedicated" "database1" {
        name                = "<DB_name>"

        network_id          = "<network_ID>"
        subnet_ids          = ["<subnet_1_ID>", "<subnet_2_ID>", "<subnet_3_ID>"]

        resource_preset_id  = "<computing_resource_configuration>"
        deletion_protection = "<deletion_protection>"

        scale_policy {
          fixed_scale {
            size = <number_of_DB_instances>
          }
        }

        storage_config {
          group_count     = <number_of_storage_groups>
          storage_type_id = "<media_type>"
        }
      }
     ```

     Where:
    
     * `name`: DB name.
     * `network_id`: ID of the network the DB is connected to.
     * `subnet_ids`: Subnet IDs list. Separated by commas.
     * `resource_preset_id`: Configuration of the node computing resources. You can find the possible values in the **Configuration name** column of the table in [{#T}](../concepts/resources.md#resource-presets).
     * `deletion_protection`: DB deletion protection, `true` or `false`. You cannot delete a DB with this option enabled. If deletion protection is activated, this does not protect the DB contents. The default value is `false`.
     * `scale_policy`: Scaling policy, where `size` indicates the number of DB instances.
     * `storage_config`: Storage configuration, where:
        * `group_count`: Number of [storage groups](../concepts/resources.md#storage-groups).
        * `storage_type_id`: Media type. For the `ssd` type, a single storage group can store up to 100 GB of data.

  1. Create a database:
  
      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

    {{ TF }} will create all the required resources. You can check the update using the [management console]({{ link-console-main }}) or this [{{ yandex-cloud }} CLI](../../cli/quickstart.md) command:

    ```bash
    yc ydb database list
    ```

  **Example**

  Creating a single-node dedicated {{ ydb-name }} database named `test-bd` with the minimum configuration and accessible from the internet:

    > ```hcl
    > resource "yandex_ydb_database_dedicated" "database2" {
    >    name                = "test-ydb-dedicated"
    >    network_id          = yandex_vpc_network.my-net.id
    >    subnet_ids          = [yandex_vpc_subnet.my-subnet-a.id, yandex_vpc_subnet.my-subnet-b.id, yandex_vpc_subnet.my-subnet-d.id]
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

- API {#api}

  To create a dedicated database, use the [create](../api-ref/Database/create.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/Create](../api-ref/grpc/Database/create.md) gRPC API call and provide the following in the request:

  * ID of the folder to host the database in the `folderId` parameter.
  * DB name in the `name` parameter.
  * Permission to assign public IP addresses to DB nodes in the `dedicatedDatabase.assignPublicIps` parameter.
  * Computing resource ID in the `resourcePresetId` parameter.
  * Network ID in the `networkId` parameter.
  * Media type in the `storageConfig.storageOptions.storageTypeId` parameter.
  * Number of storage groups in the `storageConfig.storageOptions.groupCount` parameter.
  * Number of database instances in the `scalePolicy.fixedScale.size` parameter.

{% endlist %}

### Updating dedicated database parameters {#update-db-dedicated}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to update DB settings.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the row with the DB and select **{{ ui-key.yacloud.ydb.overview.button_action-edit }}**.
  1. Configure the DB settings:
      1. Change the DB name, if required.
      1. Under **{{ ui-key.yacloud.ydb.forms.label_section-compute }}**, select the type and amount of [computing resources](../concepts/resources.md#resource-presets).
      1. Under **{{ ui-key.yacloud.ydb.forms.label_section-storage }}**, select the disk type and number of [storage groups](../concepts/resources.md#storage-groups) that determines the total amount of storage.
  1. Click **{{ ui-key.yacloud.ydb.forms.button_update-database }}**.

- {{ yandex-cloud }} CLI {#cli}

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

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the fragment with the DB description:

      > ```hcl
      > resource "yandex_ydb_database_dedicated" "database2" {
      >   name                = "my-first-ydb-dedicated"
      >   network_id          = yandex_vpc_network.my-net.id
      >   subnet_ids          = [yandex_vpc_subnet.my-subnet-a.id, yandex_vpc_subnet.my-subnet-b.id, yandex_vpc_subnet.my-subnet-d.id]
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

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the update using the [management console]({{ link-console-main }}) or this [{{ yandex-cloud }}CLI](../../cli/quickstart.md) command:

  ```bash
  yc ydb database get <DB_name>
  ```

- API {#api}

  To change the dedicated database parameters, use the [update](../api-ref/Database/update.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/Update](../api-ref/grpc/Database/update.md) gRPC API call and specify the database ID in the `databaseId` request parameter.

  {% include [get-db-id](../../_includes/ydb/get-db-id.md) %}

  In the request, provide a set of parameters used to [create the dedicated database](#create-db-dedicated) with your updated values.

{% endlist %}

To move a database to a different availability zone, follow [this guide](migration-to-an-availability-zone.md).

## Viewing the list of databases {#list-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to get a list of databases for.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run this command:

  ```bash
  yc ydb database list
  ```

- API {#api}

  To get a list of databases in the folder, use the [list](../api-ref/Database/list.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/List](../api-ref/grpc/Database/list.md) gRPC API call and provide the folder ID in the `folderId` request parameter.

{% endlist %}

## Assigning a role for a database {#add-access-binding}

You can grant access to a {{ ydb-name }} database to a user, service account, or user group. To do this, assign a [role](../../iam/concepts/access-control/roles.md) for the database. To choose the one you need, [learn](../security/index.md#roles-list) about the service's roles.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the DB resides in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Click the name of the database.
  1. Go to ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. Select the group, user, or service account you want to grant access to the database.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required roles.
  1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To assign a role for a database:

  1. See the description of the CLI role assignment command:

     ```bash
     yc ydb database add-access-binding --help
     ```

  1. Get a list of databases with their IDs:

     ```bash
     yc ydb database list
     ```

  1. Get the [ID of the user](../../iam/operations/users/get.md), [service account](../../iam/operations/sa/get-id.md), or user group you are assigning a role to.
  1. Use one of these commands to assign a role:

     * To a user:

        ```bash
        yc ydb database add-access-binding \
           --id <DB_ID> \
           --role <role> \
           --user-account-id <user_ID>
        ```

     * To a federated user:

        ```bash
        yc ydb database add-access-binding \
           --id <DB_ID> \
           --role <role> \
           --user-account-id <user_ID>
        ```

     * To a service account:

        ```bash
        yc ydb database add-access-binding \
           --id <DB_ID> \
           --role <role> \
           --service-account-id <service_account_ID>
        ```

     * To a user group:

        ```bash
        yc ydb database add-access-binding \
           --id <DB_ID> \
           --role <role> \
           --subject group:<group_ID>
        ```

- API {#api}

  Use the [DatabaseService/UpdateAccessBindings](../api-ref/grpc/Database/updateAccessBindings.md) gRPC API call and provide the following in the request:

  * `ADD` value in the `access_binding_deltas[].action` parameter to add a role.
  * Role in the `access_binding_deltas[].access_binding.role_id` parameter.
  * ID of the subject you are assigning the role to in the `access_binding_deltas[].access_binding.subject.id` parameter.
  * Type of the subject you are assigning the role to in the `access_binding_deltas[].access_binding.subject.type` parameter.

{% endlist %}

## Assigning multiple roles for a database {#set-access-bindings}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the DB resides in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Click the name of the database.
  1. Go to ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. Select the group, user, or service account you want to grant access to the database.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the required roles.
  1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

  {% include [set-access-bindings-cli](../../_includes/iam/set-access-bindings-cli.md) %}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To assign multiple roles for a database:

  1. Make sure the database has no roles assigned that you would not want to lose:

     ```bash
     yc ydb database list-access-bindings \
        --id <DB_ID>
     ```

  1. See the description of the CLI role assignment command:

     ```bash
     yc ydb database set-access-bindings --help
     ```

  1. Get a list of databases with their IDs:

     ```bash
     yc ydb database list
     ```

  1. Get the [ID of the user](../../iam/operations/users/get.md), [service account](../../iam/operations/sa/get-id.md), or user group you are assigning roles to.
  1. Use one of the commands below to assign roles:

     * To a Yandex account user:

        ```bash
        yc ydb database set-access-bindings \
           --id <DB_ID> \
           --access-binding role=<role>,user-account-id=<user_ID>
        ```

     * To a federated user:

        ```bash
        yc ydb database set-access-bindings \
           --id <DB_ID> \
           --access-binding role=<role>,subject=federatedUser:<user_ID>
        ```

     * To a service account:

        ```bash
        yc ydb database set-access-bindings \
           --id <DB_ID> \
           --access-binding role=<role>,service-account-id=<service_account_ID>
        ```

     * To a user group:

        ```bash
        yc ydb database set-access-bindings \
           --id <DB_ID> \
           --access-binding role=<role>,subject=group:<group_ID>
        ```

     Provide a separate `--access-binding` parameter for each role. For example:

     ```bash
     yc ydb database set-access-bindings \
        --id <DB_ID> \
        --access-binding role=<role1>,service-account-id=<service_account_ID> \
        --access-binding role=<role2>,service-account-id=<service_account_ID> \
        --access-binding role=<role3>,service-account-id=<service_account_ID>
     ```

- API {#api}

  {% include [set-access-bindings-api](../../_includes/iam/set-access-bindings-api.md) %}

  Use the [DatabaseService/SetAccessBindings](../api-ref/grpc/Database/setAccessBindings.md) gRPC API call. In your request, provide an array of objects, each one corresponding to a particular role and containing the following data:

  * Role in the `access_bindings[].role_id` parameter.
  * ID of the subject getting the roles in the `access_bindings[].subject.id` parameter.
  * Type of the subject getting the roles in the `access_bindings[].subject.type` parameter.

{% endlist %}

## Deleting a database {#delete-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to delete the DB from.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) in the row with the DB and select **{{ ui-key.yacloud.ydb.overview.button_action-delete }}**.
  1. Confirm the deletion.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run this command:

    ```bash
    yc ydb database delete <DB_name>
    ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and delete the fragment with the DB description.

     Sample DB description in the {{ TF }} configuration:

     ```hcl
     resource "yandex_ydb_database_dedicated" "database2" {
       name               = "test-ydb-dedicated"

       network_id         = yandex_vpc_network.my-net.id
       subnet_ids         = [yandex_vpc_subnet.my-subnet-a.id, yandex_vpc_subnet.my-subnet-b.id, yandex_vpc_subnet.my-subnet-d.id]

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

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

    {{ TF }} will delete all the resources as appropriate. You can check the update using the [management console]({{ link-console-main }}) or this [{{ yandex-cloud }} CLI](../../cli/quickstart.md) command:

    ```bash
    yc ydb database list
    ```

- API {#api}

  To delete the database, use the [delete](../api-ref/Database/delete.md) REST API method for the [Database](../api-ref/Database/index.md) resource or the [DatabaseService/Delete](../api-ref/grpc/Database/delete.md) gRPC API call and specify the ID of the DB to delete in the `databaseId` request parameter.

  {% include [get-db-id](../../_includes/ydb/get-db-id.md) %}

{% endlist %}
