# Migrating data with change of storage from {{ MY }} to {{ ydb-short-name }} using {{ data-transfer-full-name }}


With {{ data-transfer-name }}, you can transfer data from a {{ mmy-name }} source cluster to {{ ydb-name }}.

To transfer data:

1. [Prepare the source cluster](#prepare-source).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare the infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create a {{ mmy-name }} source cluster](../../managed-mysql/operations/cluster-create.md) with any suitable configuration.

   1. [Create a {{ ydb-name }} database](../../ydb/operations/manage-databases.md) in any suitable configuration.


   1. If using security groups, [configure them](../../managed-kafka/operations/connect/index.md#configuring-security-groups) to be able to connect to the cluster from the internet.


- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. Download the [data-transfer-mmy-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-ydb/blob/main/data-transfer-mmy-ydb.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security group](../../vpc/concepts/security-groups.md) and the rule required to connect to a {{ mmy-name }} cluster.
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

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the source cluster {#prepare-source}

1. If you created the infrastructure manually, [prepare the source cluster](../../data-transfer/operations/prepare.md#source-my).

1. [Connect to the {{ mmy-name }} source cluster](../../managed-mysql/operations/connect.md).

1. Add test data to the database. As an example, we will use a simple table with information transmitted by car sensors.

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
       ('iv9a94th6rzt********', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
       ('rhibbh3y08qm********', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
   ```

## Prepare and activate the transfer {#prepare-transfer}

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `YDB`.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.title }}**:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.connection.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}**: Select the {{ ydb-name }} database from the list.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select or create a service account with the `ydb.editor` role.

1. Create a source endpoint and transfer:

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. [Create a source endpoint](../../data-transfer/operations/endpoint/index.md#create):

         * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ MY }}`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.

            Select a source cluster from the list and specify its connection settings.

      1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_** type that will use the created endpoints.
      1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

   - {{ TF }} {#tf}

      1. Uncomment the following in the `data-transfer-mmy-ydb.tf` file:

         * The `target_endpoint_id` variable and set it to the value of the endpoint ID for the target created in the previous step.
         * The `yandex_datatransfer_endpoint` and `yandex_datatransfer_transfer` resources.

      1. Make sure the {{ TF }} configuration files are correct using this command:

         ```bash
         terraform validate
         ```

         If there are any errors in the configuration files, {{ TF }} will point them out.

      1. Create the required infrastructure:

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         Once created, your transfer will be activated automatically.

   {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. Make sure the data from the source {{ mmy-name }} cluster has been moved to the {{ ydb-name }} database:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder with the DB you need.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
      1. Select the database from the list.
      1. Go to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
      1. Check that the {{ ydb-name }} database contains the `<source_cluster_DB_name>_measurements` table with the test data.

   - CLI {#cli}

      1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).
      1. Check that the database contains the `<source_cluster_DB_name>_measurements` table with the test data:

         ```sql
         SELECT *
         FROM <source_cluster_DB_name>_measurements;
         ```

   {% endlist %}

1. [Connect to the {{ mmy-name }} source cluster](../../managed-mysql/operations/connect.md) and add data to the `measurements` table:

   ```sql
   INSERT INTO measurements VALUES
       ('iv7b74th678t********', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
   ```

1. Check that the {{ ydb-name }} database shows information about the added row:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the folder with the DB you need.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
      1. Select the database from the list.
      1. Go to the **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
      1. Check that new data has been added to the `<source_cluster_DB_name>_measurements` table.

   - CLI {#cli}

      1. [Connect to the {{ ydb-name }} database](../../ydb/operations/connection.md).
      1. Check that new data has been added to the `<source_cluster_DB_name>_measurements` table:

         ```sql
         SELECT *
         FROM <source_cluster_DB_name>_measurements;
         ```

   {% endlist %}

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete).
1. [Delete the target endpoint](../../data-transfer/operations/endpoint/index.md#delete).
1. If you created a service account together with the target endpoint, [delete it](../../iam/operations/sa/delete.md).

Delete the other resources depending on how they were created:

{% list tabs group=instructions %}

- Manually {#manual}

   * [Delete the source endpoint](../../data-transfer/operations/endpoint/index.md#delete).
   * [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).
   * [Delete the {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md).

- {{ TF }} {#tf}

   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `data-transfer-mmy-ydb.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `data-transfer-mmy-ydb.tf` configuration file will be deleted.

{% endlist %}
