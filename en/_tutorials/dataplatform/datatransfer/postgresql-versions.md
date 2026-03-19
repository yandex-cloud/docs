# Migrating a {{ mpg-name }} cluster to another version using {{ data-transfer-full-name }}


You can migrate a loaded production database deployed in a {{ mpg-name }} cluster to a higher version cluster. This tutorial covers migration from version 13 directly to version 17, without going stepwise through multiple versions (13 → 14 → 15 → 16 → 17).

To transfer data:

1. [Prepare the source cluster](#prepare-source).
1. [Prepare the target cluster](#prepare-target).
1. [Prepare and activate the transfers](#prepare-transfer).
1. [Switch to the new cluster](#move-data).
1. [Check the data transfer](#verify).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ PG }} cluster: Computing resources allocated to hosts along with storage and backup capacity (see [{{ PG }} pricing](../../../managed-postgresql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* Per transfer: Computing resources used and the number of data rows transferred (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).


## Prepare the source cluster {#prepare-source}

1. Prepare the source database for migration as per [this guide](../../../data-transfer/operations/prepare.md#source-pg).

1. Estimate your database workload. If it exceeds 10,000 writes per second, plan several transfers.

    1. Identify the high-workload tables.
    1. Distribute the tables between several transfers.

## Prepare the target cluster {#prepare-target}

1. Create a {{ mpg-name }} target cluster:

    {% list tabs group=instructions %}

    - Manually {#manual}

        [Create a {{ mpg-name }} target cluster](../../../managed-postgresql/operations/cluster-create.md) with the same configuration as the source cluster and with the following settings:

        * Cluster version: `17`.
        * Database name: `db1`.
        * Username: `user1`.

        If you intend to connect to the cluster from the internet, enable public access to the cluster hosts.

    - Using {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. In your current working directory, create a `.tf` file with the following contents:

            ```hcl
            resource "yandex_mdb_postgresql_cluster" "old" { }
            ```

        1. Write the {{ PG }} version 13 cluster ID to an environment variable:

            ```bash
            export POSTGRESQL_CLUSTER_ID=<cluster_ID>
            ```

            You can get the cluster ID with the [list of clusters in the folder](../../../managed-postgresql/operations/cluster-list.md#list-clusters).

        1. Import the {{ PG }} version 13 cluster settings into the {{ TF }} configuration:

            ```bash
            terraform import yandex_mdb_postgresql_cluster.old ${POSTGRESQL_CLUSTER_ID}
            ```

        1. Get the imported configuration:

            ```bash
            terraform show
            ```

        1. Copy it from the terminal and paste it into the `.tf` file.
        1. Place the file in the new `imported-cluster` directory.
        1. Edit the copied configuration so that you can create a new cluster from it:

            * Specify the new cluster name in the `resource` string and in the `name` argument.
            * Under `config`, set `version` to `17`.
            * Delete `created_at`, `health`, `id`, and `status`.
            * In the `host` sections, delete the `fqdn`, `role`, and `priority` arguments.
            * If the `disk_size_autoscaling` section has `disk_size_limit = 0`, delete this section.
            * If the `maintenance_window` section contains `type = "ANYTIME"`, delete the `hour` argument.
            * Optionally, make further changes if you need to customize the configuration.

        1. Add to the file a resource to create a user named `user1`:

            ```hcl
            resource "yandex_mdb_postgresql_user" "user1" {
              cluster_id = yandex_mdb_postgresql_cluster.<cluster_name>.id
              name       = "user1"
              password   = "<user_password>"
            }
            ```

            Where `<cluster_name>` is the new cluster name specified in the `yandex_mdb_postgresql_cluster` resource.

        1. Add to the file a resource to create the database:

            ```hcl
            resource "yandex_mdb_postgresql_database" "db1" {
              cluster_id = yandex_mdb_postgresql_cluster.<cluster_name>.id
              name       = "db1"
              owner      = yandex_mdb_postgresql_user.user1.name
              depends_on = [yandex_mdb_postgresql_user.user1]
            }
            ```

            Where `<cluster_name>` is the new cluster name specified in the `yandex_mdb_postgresql_cluster` resource.

        1. [Get the authentication credentials](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) in the `imported-cluster` directory.

        1. In the same directory, [configure and initialize the provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). [Download](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf) the provider configuration file rather than creating it manually.

        1. Place the configuration file in the `imported-cluster` directory and [specify the parameter values](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). If you have not set the authentication credentials as environment variables, specify them in the configuration file.

        1. Validate your {{ TF }} configuration:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

        {% include [Terraform timeouts](../../../_includes/mdb/mpg/terraform/timeouts.md) %}

    {% endlist %}


1. If using security groups, make sure they are [configured correctly](../../../managed-postgresql/operations/connect/index.md#configuring-security-groups) and allow connections to your cluster.


1. Prepare the target database for migration as per [this guide](../../../data-transfer/operations/prepare.md#target-pg).

## Prepare and activate the transfers {#prepare-transfer}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create) for each scheduled transfer and specify the endpoint parameters:

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `PostgreSQL`.
        * **Connection type**: `Manual setup`.
        * **Installation type**: `Managed Service for PostgreSQL cluster`.
        * **Managed DB cluster**: `<source_cluster_name>` from the drop-down list.
        * **Database**: `<source_cluster_database_name>`.
        * **Username**: `<username>`.
        * **Password**: `<password>`.
        * **List of included tables**: For each endpoint, give a list of included tables as per your allocation plan for each transfer.

        Under **Schema transfer**, make sure you have `After data migration` set for foreign keys and indexes. In which case your foreign keys and indexes will be transferred at the transfer deactivation stage.

    1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create) for each planned transfer and specify endpoint parameters:

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `PostgreSQL`.
        * **Connection type**: `Manual setup`.
        * **Installation type**: `Managed Service for PostgreSQL cluster`.
        * **Managed DB cluster**: `db1` from the drop-down list.
        * **Username**: `user1`.
        * **Password**: `<password>`.

    1. [Create transfers](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_** type that will use the created endpoints.

        To speed up the copying of large tables (over 100 GB), configure [parallel copying](../../../data-transfer/concepts/sharded.md) for the transfer by specifying the required numbers of workers and streams.

        The table will be split into the specified number of parts that will be copied in parallel.

    1. [Activate the transfers](../../../data-transfer/operations/transfer.md#activate).

- Using {{ TF }} {#tf}

    1. In the `imported-cluster` folder, open the {{ TF }} configuration file describing your infrastructure.
    1. Add to the file a resource to create the source endpoint.

        ```hcl
        resource "yandex_datatransfer_endpoint" "<endpoint_name>" {
          name = "<endpoint_name>"
            settings {
              postgres_source {
                connection {
                  mdb_cluster_id = "<source_cluster_ID>"
                }
                database = "<DB_name>"
                user     = "<username>"
                password {
                  raw = "<password>"
                }
                include_tables = ["<schema>.<table_1>", ... , "<schema>.<table_N>"]
                object_transfer_settings {
                  fk_constraint = "AFTER_DATA"
                  index         = "AFTER_DATA"
                }
              }
            }
        }
        ```

        If you have scheduled multiple transfers, add a separate endpoint for each one. For each source endpoint, in the `include_tables` parameter, give a list of included tables as per your allocation plan for each transfer.

        The `object_transfer_settings` section specifies the schema transfer parameters. If set to `AFTER_DATA`, foreign keys and indexes will be migrated after the data is migrated (at the transfer deactivation stage).

    1. Add to the file a resource to create the target endpoint.

        ```hcl
        resource "yandex_datatransfer_endpoint" "<endpoint_name>" {
          name = "<endpoint_name>"
            settings {
              postgres_target {
                connection {
                  mdb_cluster_id = yandex_mdb_postgresql_cluster.<cluster_name>.id
                }
                database = "db1"
                user     = "user1"
                password {
                  raw = "<password>"
                }
              }
            }
        }
        ```

        Where `<cluster_name>` is the cluster name specified in the `yandex_mdb_postgresql_cluster` resource.

        If you have scheduled multiple transfers, add a separate endpoint for each one.

    1. Add to the file a resource to create a transfer that will use your new endpoints.

        ```
        resource "yandex_datatransfer_transfer" "<transfer_name>" {
          name      = "<transfer_name>"
          source_id = yandex_datatransfer_endpoint.<source_endpoint_name>.id
          target_id = yandex_datatransfer_endpoint.<target_endpoint_name>.id
          type      = "SNAPSHOT_AND_INCREMENT"
          runtime {
            yc_runtime {
              upload_shard_params {
                job_count     = <number_of_workers>
                process_count = <number_of_streams>
              }
            }
          }
        }
        ```

        Where:

        * `source_id`: Source endpoint link.
        * `target_id`: Target endpoint link.
        * `type`: Transfer type. `SNAPSHOT_AND_INCREMENT`: **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**.
        * `runtime.yc_runtime.upload_shard_params`: [Parallel copy](../../../data-transfer/concepts/sharded.md) settings. This option speeds up the copying of large tables (over 100 GB).

            * `job_count`: Number of workers.
            * `process_count`: Number of streams.

        If you have distributed your tables between several endpoint pairs, create a separate transfer for each pair.

        Your transfers will be started automatically as soon as they are created.

{% endlist %}

## Switch to the new cluster {#move-data}

1. Wait for the transfer status to change to {{ dt-status-repl }}.
1. Remove the writing load from the source cluster.
1. On the [transfer monitoring](../../../data-transfer/operations/monitoring.md) page, wait for the **Maximum data transfer delay** metric to reach zero for each transfer. This indicates that the target cluster now contains all changes made in the source cluster after the data copy completed.
1. Switch the workload to the target cluster.
1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate) the transfers and wait for their status to change to {{ dt-status-stopped }}.

    During deactivation, foreign keys and indexes are being created. This may take a while. The larger your database, the longer the deactivation time.

## Check the data transfer {#verify}

1. [Connect](../../../managed-postgresql/operations/connect/index.md) to the `db1` database in the {{ mpg-name }} target cluster.

1. Run this query to make sure the tables have appeared in the `db1` database:

    ```sql
    SELECT schemaname AS schema, tablename AS table_name
    FROM pg_tables
    WHERE schemaname NOT IN ('pg_catalog', 'information_schema') 
      AND tablename NOT LIKE 'pg\_%'
    ORDER BY schemaname, tablename;
    ```

    The query will return a list of all non-system tables.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
    1. [Delete the endpoints](../../../data-transfer/operations/endpoint/index.md#delete).
    1. [Delete the {{ mpg-name }} `17` cluster](../../../managed-postgresql/operations/cluster-delete.md).

- Using {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
