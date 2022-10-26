# Getting started with {{ ydb-full-name }}

In this tutorial, you'll create a [{{ ydb-short-name }}]{% if lang == "en" %}(https://ydb.tech/en){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru){% endif %} database in {{ yandex-cloud }} and run a simple query to it using the {{ yandex-cloud }} [management console]({{ link-console-main }}) or command-line tools.

You can also work with the {{ ydb-full-name }} database through:

* [{{ ydb-short-name }} SDK]{% if lang == "en" %}(https://ydb.tech/en/docs/reference/ydb-sdk/){% endif %}{% if lang == "ru" %}(https://ydb.tech/en/docs/reference/ydb-sdk/){% endif %}.
* [{{ ydb-short-name }} CLI]{% if lang == "en" %}(https://ydb.tech/en/docs/reference/ydb-cli/){% endif %}{% if lang == "ru" %}(https://ydb.tech/en/docs/reference/ydb-cli/){% endif %}.
* [AWS SDK](docapi/tools/aws-sdk/index.md).
* [AWS CLI](docapi/tools/aws-cli/index.md).

## Before you begin {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.
1. If you don't have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

## Create a database {#create-db}

You can create a database in a Serverless configuration or with dedicated servers. For more information about differences in configurations, see [Serverless and Dedicated modes](concepts/serverless-and-dedicated.md). You can't change the database type after you create it.

{% note info %}

For the Amazon DynamoDB-compatible mode, use a serverless database configuration.

{% endnote %}

### Create a serverless database {#serverless}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder to create your database in.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click **Create database**.
   1. Enter the database **Name**. Naming requirements:

      {% include [name-format](../_includes/name-format.md) %}

   1. Under **Database type**, select the **Serverless** option.

      You can leave the default parameters for the database being created and [change](operations/manage-database.md#change-db-params) them later. For more information about DB parameters, see [{#T}](operations/manage-database.md#create-db).
   1. Click **Create database**.

   Wait until the database starts. When a database is being created, it has the `Provisioning` status. When it is ready for use, the status changes to `Running`.

- YC CLI

   1. {% include [cli-install](../_includes/cli-install.md) %}
   1. Create a database:

      ```bash
      yc ydb database create <name> --serverless
      ```

      Where `name` is the name of your database.

      Result:

      ```text
      done (6s)
      id: etn95g8jk8g0qk84hk20
      folder_id: b1g7gvsi89m34qmcm3ke
      created_at: "2022-05-30T07:26:44Z"
      name: test
      status: PROVISIONING
      endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/{{ region-id }}/b1gia87mbaomkfvsleds/etn95g8jk8g0qk84hk20
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
      document_api_endpoint: https://docapi.serverless.yandexcloud.net/{{ region-id }}/b1gia87mbaomkfvsleds/etn95g8jk8g0qk84hk20
      monitoring_config: {}
      ```

      A database with default parameters is created. You can [change](operations/manage-database.md#change-db-params) its parameters later. For more information about DB parameters, see [{#T}](operations/manage-database.md#create-db).
   1. Check the status of the created database:

      ```bash
      yc ydb database get <name>
      ```

      Where `name` is the name of the created database.

      When a database is being created, it has the `PROVISIONING` status. When it is ready for use, the status changes to `RUNNING`.

{% endlist %}

### Create a database on dedicated servers {#dedicated}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder to create your database in.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Click **Create database**.
   1. Enter the database **Name**. Naming requirements:

      {% include [name-format](../_includes/name-format.md) %}

   1. Under **Database type**, select the **Dedicated** option.
   1. Under **Computing resources**, select the type and amount of [computing resources](concepts/index.md#resource-presets).
   1. Under **Storage groups**, select the disk type and number of [storage groups](concepts/index.md#storage-groups) that determines the total amount of storage.
   1. Under **Network**, configure network settings:
      1. (optional) In the **Public IP addresses** field, select **Assign** if you plan to query the database from the {{ yandex-cloud }} network and the internet.

         {% include [traffic_metering](_includes/traffic_metering.md) %}

      1. Select an existing network from the **Cloud network** list or create a new one:
         1. Click **Create new**.
         1. In the window that opens, enter a **Name** for the new network.
         1. (optional) Select the **Create subnets** option. Subnets in each availability zone will be created automatically.
         1. Click **Create**.
      1. Under **Subnets**, select a network or create a new one for each [availability zone](../overview/concepts/geo-scope.md):
         1. Click **Create new**.
         1. In the window that opens, enter a **Name** for the new subnet.
         1. (optional) Enter a **Description** of the subnet.
         1. Select the desired availability zone from the **Availability zone** list.
         1. Specify the subnet address in [**CIDR**]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Бесклассовая_адресация){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing){% endif %} format.
         1. Click **Create**.

      You can't change the settings of the **Network** section after the database is created.
   1. Click **Create database**.

      Wait until the database starts. When a database is being created, it has the `Provisioning` status. When it is ready for use, the status changes to `Running`.

- YC CLI

   1. {% include [cli-install](../_includes/cli-install.md) %}
   1. If necessary, create a cloud [network](../vpc/operations/network-create.md) and [subnets](../vpc/operations/subnet-create.md) for each [availability zone](../overview/concepts/geo-scope.md).
   1. Create a database:

      ```bash
      yc ydb database create <name> \
        --dedicated \
        --resource-preset <preset> \
        --storage type=<type>,groups=<groups> \
        --public-ip \
        --network-name default\
        --async
      ```

      Where:

      * `--resource-preset STR`: The configuration of node computing resources. Possible values are listed in the "Configuration name" column of the [Computing resources](concepts/index.md#resource-presets) table on the page with information about databases.
      * `--storage STR`: The media type and number of storage groups in `type=<type>,groups=<groups>` format. For the `ssd` type, a single storage group can store up to 100 GB of data.
      * `--public-ip`: A flag indicating that public IP addresses are assigned. Without it, you can't connect to the database you create from the internet.
      * `--network-name STR`: The name of the cloud network to create the database in. You can specify the `default` network.
      * `--async`: The asynchronous DB creation flag.

      For more information about DB parameters, see [{#T}](operations/manage-database.md#create-db).

      Result:

      ```text
      done (7m18s)
      id: etnk1u65e4shtgj207sc
      folder_id: b1g7gvsi89m34qmcm3ke
      created_at: "2022-05-31T10:10:12Z"
      name: test-ded
      status: PROVISIONING
      endpoint: grpcs://lb.etnk1u65e4shtgj207sc.ydb.mdb.yandexcloud.net:2135/?database=/{{ region-id }}/b1gia87mbaomkfvsleds/etnk1u65e4shtgj207sc
      resource_preset_id: medium
      storage_config:
        storage_options:
        - storage_type_id: ssd
          group_count: "1"
        storage_size_limit: "107374182400"
      scale_policy:
        fixed_scale:
          size: "1"
      network_id: enpqkm0od2bueqbuo9qa
      subnet_ids:
      - b0cmespgm8o3pr0ssprq
      - e2lif378n1pg90pp96bl
      - e9b72lv142k40bul5qgv
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
        network_id: enpqkm0od2bueqbuo9qa
        subnet_ids:
        - b0cmespgm8o3pr0ssprq
        - e2lif378n1pg90pp96bl
        - e9b72lv142k40bul5qgv
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
      yc ydb database get <name>
      ```

      Where `name` is the name of the created database.

      When a database is being created, it has the `PROVISIONING` status. When it is ready for use, the status changes to `RUNNING`.

{% endlist %}

## Make a query to the database {#query}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with the desired DB.
   1. In the list of services, select **{{ ydb-name }}**.
   1. Select the database you created earlier.
   1. Go to the **Navigation** tab.
   1. Click **SQL query** and enter the query text:

      ```yql
      SELECT 1;
      ```

   1. Click **Run**.

      See the query result below:

      ```text
      # column0
      0 1
      ```

- YDB CLI

   1. {% include [cli-install](../_includes/cli-install.md) %}
   1. To manage your databases from the command line, [install]{% if lang == "en" %}(https://ydb.tech/en/docs/reference/ydb-cli/install){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/reference/ydb-cli/install){% endif %} the YDB CLI.
   1. To authenticate the YDB CLI in {{ yandex-cloud }}, get an [IAM token](../iam/concepts/authorization/iam-token.md) and export it to the following environment variable:

      ```bash
      export IAM_TOKEN=`yc iam create-token`
      ```

   1. Get the database endpoint and path:

      ```bash
      yc ydb database get ydb-prod
      ```

      Result:

      ```text
      ...
      endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/{{ region-id }}/b1gia87mbaomkfvsleds/etnudu2n9ri35luqs9o2
      ...
      ```

      Here, part of the `grpcs://ydb.serverless.yandexcloud.net:2135` string contains the endpoint and `/{{ region-id }}/b1gia87mbaomkfvsleds/etnudu2n9ri35luqs9o2` specifies the DB path.

   1. Make a query to the previously created database using the obtained endpoint value and DB path:

      ```bash
      ydb \
        --endpoint grpcs://ydb.serverless.yandexcloud.net:2135 \
        --database /{{ region-id }}/b1gia87mbaomkfvsleds/etnudu2n9ri35luqs9o2 \
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

* Learn more about [working with databases](operations/index.md).
* Read about [service concepts](concepts/index.md).
* Learn more about the [YQL]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/){% endif %} query language.
