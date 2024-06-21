# Getting started with {{ ydb-name }}


In this tutorial, you will create a [{{ ydb-short-name }}](https://ydb.tech/en) database in {{ yandex-cloud }} and run a simple query to it using the {{ yandex-cloud }} [management console]({{ link-console-main }}) or command line tools.

You can also work with a {{ ydb-full-name }} DB through:
* [{{ ydb-short-name }} SDK](https://ydb.tech/en/docs/reference/ydb-sdk/).
* [{{ ydb-short-name }} CLI](https://ydb.tech/en/docs/reference/ydb-cli/).
* [AWS SDK](docapi/tools/aws-sdk/index.md).
* [AWS CLI](docapi/tools/aws-cli/index.md).

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if you are not signed up yet.
1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

## Create a database {#create-db}

You can create a DB in the Serverless configuration or with dedicated servers. For more information about differences between configurations, see [Serverless and dedicated modes](concepts/serverless-and-dedicated.md). You cannot change the DB type once you have created it.

{% note info %}

For the Amazon DynamoDB-compatible mode, use a serverless database configuration.

{% endnote %}

### Create a serverless database {#serverless}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create your DB in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Click **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. Enter the **{{ ui-key.yacloud.ydb.forms.label_field_name }}** of the DB. The naming requirements are as follows:

     {% include [name-format](../_includes/name-format.md) %}

  1. Under **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}**, select `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.

      You can leave the default parameters for the DB being created and [change](operations/manage-databases.md#update-db-serverless) them later. For more information about DB parameters, see [{#T}](operations/manage-databases.md#create-db-serverless).
  1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

  Wait for the DB to start. When a database is being created, it has the `Provisioning` status. When it is ready for use, the status changes to `Running`.

- {{ yandex-cloud }} CLI {#cli}

  1. {% include [cli-install](../_includes/cli-install.md) %}
  1. Create a database:

      ```bash
      yc ydb database create <DB_name> --serverless
      ```

      Where `DB_name` is the name of your database.

      Result:

      ```text
      done (6s)
      id: etn95g8jk8g0********
      folder_id: b1g7gvsi89m3********
      created_at: "2022-05-30T07:26:44Z"
      name: test
      status: PROVISIONING
      endpoint: {{ ydb.ep-serverless }}/?database=/{{ region-id }}/b1gia87mbaom********/etn95g8jk8g0********
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
          backup_time_to_live: 172800s
          type: SYSTEM
      document_api_endpoint: {{ ydb.document-api-endpoint }}/{{ region-id }}/b1gia87mbaom********/etn95g8jk8g0********
      monitoring_config: {}
      ```

      A database with default parameters is created. You can [change](operations/manage-databases.md#update-db-serverless) its parameters later. For more information about DB parameters, see [{#T}](operations/manage-databases.md#create-db-serverless).
  1. Check the status of the created database:

     ```bash
     yc ydb database get <DB_name>
     ```

     Where `DB_name` is the name of the new DB.

     When a database is being created, it has the `Provisioning` status. When it is ready for use, the status changes to `Running`.

{% endlist %}

### Create a database on dedicated servers {#dedicated}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create your DB in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Click **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. Enter the **{{ ui-key.yacloud.ydb.forms.label_field_name }}** of the DB. The naming requirements are as follows:

     {% include [name-format](../_includes/name-format.md) %}

  1. Under **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}**, select `{{ ui-key.yacloud.ydb.forms.label_dedicated-type }}`.
  1. Under **{{ ui-key.yacloud.ydb.forms.label_section-compute }}**, select the type and amount of [computing resources](concepts/resources.md#resource-presets).
  1. Under **{{ ui-key.yacloud.ydb.forms.label_section-storage }}**, select the disk type and number of [storage groups](concepts/resources.md#storage-groups) that determines the total amount of storage.
  1. Under **{{ ui-key.yacloud.ydb.forms.label_section-network }}**, configure network settings:
     1. (Optional) In the **{{ ui-key.yacloud.ydb.forms.field_public-ips }}** field, select **{{ ui-key.yacloud.ydb.forms.label_text-public-ips }}** if you plan to run queries against the DB both from the {{ yandex-cloud }} network and the internet.

        {% include [traffic_metering](_includes/traffic_metering.md) %}

     1. Select an existing network from the **{{ ui-key.yacloud.ydb.forms.field_network }}** list or create a new one:
        1. Click **{{ ui-key.yacloud.ydb.forms.button_create-network-new }}**.
        1. In the window that opens, enter a **{{ ui-key.yacloud.vpc.networks.create.field_name }}** for the new network.
        1. (Optional) Select the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option. Subnets in each availability zone will be created automatically.
        1. Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.
     1. Under **{{ ui-key.yacloud.ydb.forms.field_subnetworks }}**, select a subnet or create a new one for each [availability zone](../overview/concepts/geo-scope.md):
        1. Click **{{ ui-key.yacloud.ydb.forms.button_create-subnetwork-new }}**.
        1. In the window that opens, enter a **{{ ui-key.yacloud.component.vpc.create-subnetwork-dialog.field_name }}** for the new subnet.
        1. (Optional) Enter a **{{ ui-key.yacloud.component.vpc.create-subnetwork-dialog.field_description }}** of the subnet.
        1. Select the availability zone you need from the **{{ ui-key.yacloud.component.vpc.create-subnetwork-dialog.field_zone }}** list.
        1. Specify the subnet address in [**{{ ui-key.yacloud.component.vpc.create-subnetwork-dialog.field_cidr }}**](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) format.
        1. Click **{{ ui-key.yacloud.component.vpc.create-subnetwork-dialog.button_create }}**.

     You cannot change the settings of the **{{ ui-key.yacloud.ydb.forms.label_section-network }}** section after the database is created.
  1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

     Wait for the DB to start. When a database is being created, it has the `Provisioning` status. When it is ready for use, the status changes to `Running`.

- {{ yandex-cloud }} CLI {#cli}

  1. {% include [cli-install](../_includes/cli-install.md) %}

  1. Create a cloud [network](../vpc/operations/network-create.md) and [subnets](../vpc/operations/subnet-create.md) for each [availability zone](../overview/concepts/geo-scope.md), if required.
  1. Create a database:

      ```bash
      yc ydb database create <DB_name> \
        --dedicated \
        --resource-preset <configuration> \
        --storage type=<storage_media_type>,groups=<number_of_storage_groups> \
        --public-ip \
        --network-name default\
        --async
      ```

      Where:

      * `--resource-preset STR`: Configuration of the node computing resources. You can find the possible values in the **Configuration name** column of the table in [{#T}](concepts/resources.md#resource-presets).
      * `--storage STR`: Media type and number of [storage groups](concepts/resources.md#storage-groups), in the `type=<storage_media_type>,groups=<number_of_storage_groups>` format. For the `ssd` type, a single storage group can store up to 100 GB of data.
      * `--public-ip`: Flag indicating that public IP addresses are assigned. Without it, you cannot connect to the database you created from the internet.
      * `--network-name STR`: Name of the cloud network to create the database in. You can specify the network as `default`.
      * `--async`: Asynchronous DB creation flag.

      For more information about DB parameters, see [{#T}](operations/manage-databases.md#create-db-serverless).

      Result:

      ```text
      done (7m18s)
      id: etnk1u65e4sh********
      folder_id: b1g7gvsi89m3********
      created_at: "2022-05-31T10:10:12Z"
      name: test-ded
      status: PROVISIONING
      endpoint: {{ ydb.ep-dedicated }}/?database=/{{ region-id }}/b1gia87mbaom********/etnk1u65e4sh********
      resource_preset_id: medium
      storage_config:
        storage_options:
        - storage_type_id: ssd
          group_count: "1"
        storage_size_limit: "107374182400"
      scale_policy:
        fixed_scale:
          size: "1"
      network_id: enpqkm0od2bu********
      subnet_ids:
      - b0cmespgm8o3********
      - e2lif378n1pg********
      - e9b72lv142k4********
      dedicated_database:
        resource_preset_id: medium
        storage_config:
          storage_options:
          - storage_type_id: ssd
            group_count: "1"
          storage_size_limit: "107374182400"
        scale_policy:
          fixed_scale:
            size: "1"
        network_id: enpqkm0od2bu********
        subnet_ids:
        - b0cmespgm8o3********
        - e2lif378n1pg********
        - e9b72lv142k4********
        assign_public_ips: true
      assign_public_ips: true
      location_id: {{ region-id }}
      backup_config:
        backup_settings:
        - name: daily
          backup_schedule:
            daily_backup_schedule:
              execute_time:
                hours: 17
          backup_time_to_live: 172800s
          type: SYSTEM
      monitoring_config: {}
      ```

  1. Check the status of the created database:

     ```bash
     yc ydb database get <DB_name>
     ```

     Where `DB_name` is the name of the new DB.

     When a database is being created, it has the `Provisioning` status. When it is ready for use, the status changes to `Running`.

{% endlist %}

## Run a query to the database {#query}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the desired bucket is located.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Select the previously created database.
  1. Go to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
  1. Click **{{ ui-key.yacloud.ydb.browse.button_sql-query }}** and enter the query text.

     ```yql
     SELECT 1;
     ```

  1. Click **{{ ui-key.yacloud.ydb.sql.button_run }}**.

     See the query result below:

     ```text
     # column0
     0 1
     ```

- {{ ydb-short-name }} CLI {#cli}

  1. {% include [cli-install](../_includes/cli-install.md) %}

  1. To manage your DBs from the command line, [install](https://ydb.tech/en/docs/reference/ydb-cli/install) the {{ ydb-short-name }} CLI.
  1. To authenticate the {{ ydb-short-name }} CLI in {{ yandex-cloud }}, get an [IAM token](../iam/concepts/authorization/iam-token.md) and export it to the following environment variable:

     ```bash
     export IAM_TOKEN=`yc iam create-token`
     ```

  1. Get the DB endpoint and path:

     ```bash
     yc ydb database get ydb-prod
     ```

     Result:

     ```text
     ...
     endpoint: {{ ydb.ep-serverless }}/?database=/{{ region-id }}/b1gia87mbaom********/etnudu2n9ri3********
     ...
     ```

     Here, part of the `{{ ydb.ep-serverless }}` string contains the endpoint, while `/{{ region-id }}/b1gia87mbaom********/etnudu2n9ri3********` specifies the DB path.

  1. Run a query to the previously created DB using the resulting endpoint value and DB path:

     ```bash
     ydb \
       --endpoint {{ ydb.ep-serverless }} \
       --database /{{ region-id }}/b1gia87mbaom********/etnudu2n9ri3******** \
       yql -s "SELECT 1;"
     ```

     Result:

     ```text
     ┌─────────┐
     | column0 |
     ├─────────┤
     | 1       |
     └─────────┘
     ```

{% endlist %}

## What's next {#whats-next}

* Learn more about [working with DBs](operations/index.md).
* Read about [service concepts](concepts/index.md).
* Read about the [YQL](https://ydb.tech/en/docs/yql/reference/) query language.
