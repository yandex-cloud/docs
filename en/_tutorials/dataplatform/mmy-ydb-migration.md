# Asynchronously replicating data from {{ mmy-full-name }} to {{ ydb-full-name }} using {{ data-transfer-full-name }}

With {{ data-transfer-name }}, you can transfer data from a {{ mmy-name }} source cluster to {{ ydb-name }}.

To transfer data:

1. [Prepare the source cluster](#prepare-source).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare the infrastructure {#deploy-infrastructure}

{% list tabs %}

* Manually

   1. [Create a {{ mmy-name }} source cluster](../../managed-mysql/operations/cluster-create.md) with any suitable configuration.

   1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) in any suitable configuration.

   
   1. If you are using security groups, [configure them](../../managed-kafka/operations/connect.md#configuring-security-groups) so that you can connect to the cluster from the internet.

      {% include [preview-pp.md](../../_includes/preview-pp.md) %}


* Using {{ TF }}

   1. If you do not have {{ TF }} yet, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the configuration file [data-transfer-mmy-ydb.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/data-transfer-mmy-ydb.tf) to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security groups](../../vpc/concepts/security-groups.md) and the rule required to connect to a {{ mmy-name }} cluster.
      * {{ mmy-name }} source cluster.
      * {{ ydb-name }} database.
      * Source endpoint.
      * Transfer.

   1. Specify in the `data-transfer-mmy-ydb.tf` file:

      * The {{ mmy-name }} source cluster parameters that will also be used as the [source endpoint parameters](../../data-transfer/operations/endpoint/target/mysql.md#managed-service):

         * `source_mysql_version`: {{ MY }} version.
         * `source_db_name`: Database name.
         * `source_user` and `source_password`: Database owner username and password.

      * `target_db_name`: {{ ydb-name }} database name.

   1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the source cluster {#prepare-source}

1. If you created the infrastructure manually, [prepare the source cluster](../../data-transfer/operations/prepare.md#source-my).

1. [Connect to the {{ mmy-name }} source cluster](../../managed-mysql/operations/connect.md).

1. Add test data to the database. As an example, we'll use a simple table with information transmitted by car sensors.

   Create a table:

   ```sql
   CREATE TABLE measurements (
       device_id varchar(200) NOT NULL,
       datetime timestamp NOT NULL,
       latitude real NOT NULL,
       longitude real NOT NULL,
       altitude real NOT NULL,
       speed real NOT NULL,
       battery_voltage real,
       cabin_temperature real NOT NULL,
       fuel_level real,
       PRIMARY KEY (device_id)
   );
   ```

   Populate the table with data:

   ```sql
   INSERT INTO measurements VALUES
       ('iv9a94th6rztooxh5ur2', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
       ('rhibbh3y08qmz3sdbrbu', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
   ```

## Prepare and activate the transfer {#prepare-transfer}

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `YDB`.
   * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}**:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.connection.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}**: Select the {{ ydb-name }} database from the list.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select or create a service account with the `ydb.editor` role.

1. Create a source endpoint and transfer:

   {% list tabs %}

   * Manually

      1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

         * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ MY }}`.
         * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.

            Select a source cluster from the list and specify the cluster connection settings.

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) with a **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_** type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

   * Using {{ TF }}

      1. Uncomment the following in the `data-transfer-mmy-ydb.tf` file:

         * The `target_endpoint_id` variable and set it to the value of the endpoint ID for the target created in the previous step.
         * The `yandex_datatransfer_endpoint` and `yandex_datatransfer_transfer` resources.

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point to them.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         Once created, your transfer will be activated automatically.

   {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. Make sure the data from the source {{ mmy-name }} cluster has been moved to the {{ ydb-name }} database:

   {% list tabs %}

   * Management console

      1. In the [management console]({{ link-console-main }}), select the folder with the desired DB.
      1. In the list of services, select **{{ ydb-name }}**.
      1. Select the database from the list.
      1. Click the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
      1. Make sure the {{ ydb-name }} database contains the `<source cluster DB name>_measurements` table with the test data.

   * CLI

      1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).
      1. Make sure the database contains the `<source cluster DB name>_measurements` table with the test data:

         ```sql
         SELECT *
         FROM <source cluster DB name>_measurements;
         ```

   {% endlist %}

1. [Connect to the {{ mmy-name }} source cluster](../../managed-mysql/operations/connect.md) and add data to the `measurements` table:

   ```sql
   INSERT INTO measurements VALUES
       ('iv7b74th678tooxh5ur2', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
   ```

1. Check that the {{ ydb-name }} database shows information about the row added:

   {% list tabs %}

   * Management console

      1. In the [management console]({{ link-console-main }}), select the folder with the desired DB.
      1. In the list of services, select **{{ ydb-name }}**.
      1. Select the database from the list.
      1. Click the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
      1. Make sure that the new data has been added to the `<source cluster DB name>_measurements` table.

   * CLI

      1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).
      1. Make sure that the new data has been added to the `<source cluster DB name>_measurements` table:

         ```sql
         SELECT *
         FROM <source cluster DB name>_measurements;
         ```

   {% endlist %}

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [disable the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
1. If you created the service account along with the target endpoint, [delete it](../../iam/operations/sa/delete.md).

Delete the other resources, depending on the method used to create them:

{% list tabs %}

* Manually

   * [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
   * [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).
   * [Delete the {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md).

* Using {{ TF }}

   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the `data-transfer-mmy-ydb.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `data-transfer-mmy-ydb.tf` configuration file will be deleted.

{% endlist %}
