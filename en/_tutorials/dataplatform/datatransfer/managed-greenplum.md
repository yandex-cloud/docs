# Migrating data from a third-party {{ GP }} or {{ PG }} cluster to {{ mgp-full-name }} with {{ data-transfer-full-name }}

{{ data-transfer-full-name }} enables you to migrate your database from a third-party {{ GP }} or {{ PG }} cluster to {{ mgp-name }}. Using this approach, you can do the following:

* Migrate your database with zero downtime.
* Migrate from older to newer versions of {{ GP }}.
* Eliminate the need for an intermediate VM or for exposing your {{ mpg-name }} target cluster to the internet.

For more details, see [{#T}](../../../data-transfer/concepts/use-cases.md).

{% note info %}

{{ data-transfer-name }} enables you to transfer a snapshot of the source database to the {{ mgp-name }} target without maintaining it in sync (the [_{{ dt-type-copy }}_](../../../data-transfer/concepts/transfer-lifecycle.md#copy) transfer type). Any changes made on the source after the transfer is completed will not be transferred.

{% endnote %}

To migrate your database, first you need to transfer the data, then put the old database in read-only mode, and finally switch the workload over to the {{ yandex-cloud }} database cluster.

Transferring a database using {{ data-transfer-full-name }}:

1. [Set up your infrastructure](#prepare-infrastructure).
1. [Set up and activate the transfer](#data-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

* {{ mgp-name }} cluster: use of computing resources allocated to hosts, storage and backup size (see [{{ mgp-name }} pricing](../../../managed-greenplum/pricing/index.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).


## Set up your infrastructure {#prepare-infrastructure}

1. Prepare the source cluster: [{{ GP }}](../../../data-transfer/operations/prepare.md#source-gp) or [{{ PG }}](../../../data-transfer/operations/prepare.md#source-pg).
1. [Create](../../../managed-greenplum/operations/cluster-create.md) a {{ mgp-name }} target cluster.

    Its computing capacity and storage size must be adequate for the environment the migrated database is deployed in.

    The names of the source and target databases must be the same.

1. [Prepare the target cluster](../../../data-transfer/operations/prepare.md#target-gp).


## Set up and activate the transfer {#data-transfer}

1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create):

    {% list tabs group=data_sources %}

    - {{ PG }} {#postgresql}

      * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}**: `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
      * Name the endpoint.
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `PostgreSQL`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.title }}**:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.connection.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.on_premise.title }}`.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.host.title }}**: Specify the IP or FQDN of the source cluster's master host.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}**: Specify the port number for connection to the source cluster.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Specify the database name.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: Specify the database user name.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: Enter the user password.

    - Greenplum/Yandex MPP Analytics {#greenplum}

      * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}**: `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
      * Name the endpoint.
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Greenplum/Yandex MPP Analytics`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumSource.title }}**:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumSource.connection.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.on_premise.title }}`.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.primary_host.title }}**: Specify the IP or FQDN of the source cluster's primary master host.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.primary_port.title }}**: Specify the port number for connection to the primary master host.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: Specify the database name.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: Specify the database user name.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: Enter the user password.

    {% endlist %}

1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}**: `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
    * Name the endpoint.
    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Greenplum/Yandex MPP Analytics`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTarget.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}**: Select the target cluster from the list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: Specify the name database of interest.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: Specify the database user name.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: Enter the user password.

1. [Create](../../../data-transfer/operations/transfer.md#create) a _{{ dt-type-copy }}_-type transfer and configure it to use the previously created endpoints.
1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate).
1. Wait for the transfer status to change to {{ dt-status-finished }}.

    To learn more about transfer statuses, see [Transfer lifecycle](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. Switch the source cluster to <q>read-only</q> mode and transfer the workload to the target cluster.


## Delete the resources you created {#clear-out}


Some resources are not free of charge. Delete the resources you no longer need, so you will not be charged for them:


1. [Deactivate](../../../data-transfer/operations/transfer.md#deactivate) and [delete](../../../data-transfer/operations/transfer.md#delete) the transfer.
1. [Delete the endpoints](../../../data-transfer/operations/endpoint/index.md#delete).
1. Delete the clusters:

    * [{{ mpg-name }}](../../../managed-postgresql/operations/cluster-delete.md).
    * [{{ mgp-name }}](../../../managed-greenplum/operations/cluster-delete.md).


1. If static public IP addresses were used for accessing the cluster hosts, release and [delete](../../../vpc/operations/address-delete.md) them.

