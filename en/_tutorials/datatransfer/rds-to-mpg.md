To set up data transfers from [Amazon RDS for {{ PG }}](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html) to {{ mpg-name }} databases using {{ data-transfer-name }}:

1. [Prepare the test data](#prepare-data).
1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

Data transfers are supported for {{ PG }} starting with version 9.4. Make sure the {{ PG }} version in {{ mpg-name }} is not older than the {{ PG }} version in Amazon RDS.

{% note info %}

Using Amazon services is not part of the [{{ yandex-cloud }} Terms of Use]({{ link-cloud-terms-of-use }}) and is governed by a separate arrangement between the client and Amazon. Yandex is not responsible for the relationship between Amazon and the client arising in connection with the client's use of Amazon products or services.

{% endnote %}

## Getting started {#before-you-begin}

Prepare the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

   1. If you do not have an AWS account, [create](https://aws.amazon.com) one.
   1. In Amazon RDS, [create a group of parameters](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithDBInstanceParamGroups.html) and set the `rds.logical_replication` parameter to `1` in it. In other parameters, you can leave the defaults.
   1. [Create an instance of Amazon RDS for {{ PG }}](https://aws.amazon.com/ru/getting-started/hands-on/create-connect-postgresql-db/) (source cluster).

      When creating an instance, configure it as required:

      * Enable public access for the instance.
      * In the instance's security group, add a rule that will allow incoming TCP traffic from any IP address to the {{ PG }} instance port (`5432` by default).
      * Assign the instance the parameter group you created earlier.

      {% note info %}

      If you changed the parameter group of the created instance, restart the instance for the changes to take effect. While restarting, the instance will be unavailable.

      {% endnote %}

   1. [Create a {{ mpg-name }} target cluster](../../managed-postgresql/operations/cluster-create.md#create-cluster) in any applicable configuration with publicly available hosts and the following settings:

      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `mpg_db`
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `mpg_user`
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: `<target_password>`

   1. Make sure that the {{ mpg-name }} cluster's security group has been [set up correctly](../../managed-postgresql/operations/connect.md#configuring-security-groups) and allows connecting to the cluster from the internet.
   1. Set up an egress [NAT gateway](../../vpc/operations/create-nat-gateway.md) for the subnet that hosts the target cluster.
   1. [Download an AWS certificate](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html#UsingWithRDS.SSL.RegionCertificates) for the region where the Amazon RDS for {{ PG }} instance resides.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}

   1. Set up the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html). The AWS provider for {{ TF }} uses the AWS CLI configuration to access the service.
   1. [Configure the {{ TF }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). There is no need to create a provider configuration file manually, you can [download](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf) and save it to a separate working directory.
   1. Edit the `provider.tf` file:

      * [Set the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider) for the `yandex` provider. If you did not add the authentication credentials to environment variables, specify them in the configuration file.
      * Add the `aws` provider to the `required_providers` section:

         ```hcl
         required_providers {
           ...
           aws = {
             source  = "hashicorp/aws"
             version = ">= 3.70"
           }
         }
         ```

      * Add a description for the `aws` provider by specifying in the parameters the region where the Amazon RDS for {{ PG }} instance will reside (`eu-north-1` in this example):

         ```hcl
         provider "aws" {
           region = "eu-north-1"
         }
         ```

   1. Download the [rds-pg-mpg.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-postgres-from-aws-rds/blob/main/rds-pg-mpg.tf) configuration file to the same working directory.

      This file describes:

      * Infrastructure required for the Amazon RDS for {{ PG }} instance to run:

         * Subnet group
         * Security group rule
         * Parameter group

         The instance will use the default network, subnets, and security group.

      * Amazon RDS for {{ PG }} instance (source cluster).
      * Infrastructure required for the {{ mpg-name }} target cluster to run:

         * [Network](../../vpc/concepts/network.md#network) and [subnet](../../vpc/concepts/network.md#subnet)
         * Egress [NAT gateway](../../vpc/operations/create-nat-gateway.md) for the cluster
         * [Security group](../../vpc/concepts/security-groups.md)

      * {{ mpg-name }} target cluster.
      * Source and target endpoints.
      * Transfer.

   1. [Download an AWS certificate](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html#UsingWithRDS.SSL.RegionCertificates) for the region where the Amazon RDS for {{ PG }} instance will reside.
   1. Specify the following in the `rds-pg-mpg.tf` file:

      * {{ PG }} versions for Amazon RDS for {{ PG }} and {{ mpg-name }}.
      * Parameter family for the Amazon RDS [parameter group](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithDBInstanceParamGroups.html).
      * Path to the previously downloaded AWS certificate.
      * Amazon RDS for {{ PG }} and {{ mpg-name }} user passwords.

   1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the test data {#prepare-data}

1. Install the `psql` utility:

   ```bash
   sudo apt update && sudo apt install --yes postgresql-client
   ```

1. Connect to the database in the Amazon RDS for {{ PG }} source cluster:

   ```bash
   psql "host=<host_URL> \
   port=<{{ PG }}_port> \
   sslmode=verify-full \
   sslrootcert=<path_to_certificate_file> \
   dbname=<DB_name> \
   user=<username>"
   ```

   The default {{ PG }} port is `5432`.

   {% note info %}

   It may take up to an hour after creating the instance for a connection to the instance over the internet to be available.

   {% endnote %}

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
   ('iv9a94th6rztooxh5ur2', '2022-06-05 17:27:00', 55.70329032, 37.65472196,  427.5,    0, 23.5, 17, NULL),
   ('rhibbh3y08qmz3sdbrbu', '2022-06-06 09:49:54', 55.71294467, 37.66542005, 429.13, 55.5, NULL, 18, 32);
   ```

## Prepare and activate the transfer {#prepare-transfer}

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Create a source endpoint](../../data-transfer/operations/endpoint/source/mysql.md) of the `{{ PG }}` type and specify the cluster connection parameters in it:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.on_premise.title }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.host.title }}**: Host URL.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}**: `5432`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.ca_certificate.title }}**: Select the AWS certificate file.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}**: `postgres`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}**: `postgres`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}**: `<user_password>`.

   1. [Create a target endpoint](../../data-transfer/operations/endpoint/target/postgresql.md) of the `{{ PG }}` type and specify the cluster connection parameters in it:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: `<name_of_target_cluster>` from the drop-down list.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}**: `mpg_db`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}**: `mpg_user`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}**: `<user_password>`.

   1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_** type that will use the created endpoints.
   1. [Activate the transfer](../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

- {{ TF }} {#tf}

   1. In the `rds-pg-mpg.tf` file, set the `transfer_enabled` parameter to `1`.

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   1. The transfer is activated automatically. Wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

{% endlist %}

## Test the transfer {#verify-transfer}

To check if the transfer performs properly, test the copy and replication processes.

### Test the copy process {#verify-copy}

1. [Connect to the {{ mpg-name }} target cluster database](../../managed-postgresql/operations/connect.md).
1. Run the following query:

   ```sql
   SELECT * FROM measurements;
   ```

### Test the replication process {#verify-replication}

1. Connect to the database in the Amazon RDS for {{ PG }} source cluster:

   ```bash
   psql "host=<host_URL> \
   port=<{{ PG }}_port> \
   sslmode=verify-full \
   sslrootcert=<path_to_certificate_file> \
   dbname=<DB_name> \
   user=<username>"
   ```

   The default {{ PG }} port is `5432`.

1. Add data to the `measurements` table:

   ```sql
   INSERT INTO measurements VALUES
   ('iv7b74th678tooxdagrf', '2020-06-08 17:45:00', 53.70987913, 36.62549834, 378.0, 20.5, 5.3, 20, NULL);
   ```

1. Make sure the new row has been added to the target database:

   1. [Connect to the {{ mpg-name }} target cluster database](../../managed-postgresql/operations/connect.md).
   1. Run the following query:

      ```sql
      SELECT * FROM measurements;
      ```

   {% note info %}

   It may take a few minutes to replicate the data.

   {% endnote %}

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the created resources, [deactivate the transfer](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

   * [Transfer](../../data-transfer/operations/transfer.md#delete)
   * [Endpoints](../../data-transfer/operations/endpoint/index.md#delete)
   * [Amazon RDS for {{ PG }} instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html)
   * [{{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md)

- {{ TF }} {#tf}

   If you created your resources using {{ TF }}:

   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `rds-pg-mpg.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `rds-pg-mpg.tf` configuration file will be deleted.

{% endlist %}
