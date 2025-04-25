# Migrating data from a third-party {{ GP }} or {{ PG }} cluster to {{ mgp-full-name }} using {{ data-transfer-full-name }}

You can migrate your database from a third-party {{ GP }} or {{ PG }} cluster to {{ mgp-name }} using {{ data-transfer-full-name }}. This method allows you to:

* Migrate the database without interrupting user service.
* Migrate from older {{ GP }} versions to newer versions.
* Go without creating an intermediate VM or granting online access to your {{ mpg-name }} target cluster.

To learn more, see [{#T}](../../../data-transfer/concepts/use-cases.md).

{% note info %}

{{ data-transfer-name }} enables you to transfer the state of the source database to the {{ mgp-name }} target without keeping it up-to-date (the [_{{ dt-type-copy }}_](../../../data-transfer/concepts/transfer-lifecycle.md#copy) transfer type). Changes occurring on the source after the transfer is completed will not be transferred.

{% endnote %}

To migrate your database, you need to directly transfer the data, acquire a write lock for the old database, and switch over the load to the database cluster in {{ yandex-cloud }}.


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mgp-name }} cluster fee: Using computing resources allocated to hosts and disk space (see [{{ mgp-name }} pricing](../../../managed-greenplum/pricing/index.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* Per-transfer fee: Using computing resources and the number of transferred data rows (see [{{ data-transfer-name }} pricing](../../../data-transfer/pricing.md)).


## Getting started {#before-you-begin}

[Create a {{ mgp-name }} target cluster](../../../managed-greenplum/operations/cluster-create.md) with the computing capacity and storage size appropriate for the environment where the migrated database is deployed.

The database name in the target cluster must be the same as the source database name.

## Transferring data {#data-transfer}

1. Prepare the source cluster:
    * [{{ GP }}](../../../data-transfer/operations/prepare.md#source-gp)
    * [{{ PG }}](../../../data-transfer/operations/prepare.md#source-pg)
1. [Prepare the target cluster](../../../data-transfer/operations/prepare.md#target-gp).
1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create) with the following parameters:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Greenplum` or `PostgreSQL`
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumSource.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.on_premise.title }}`

        Specify the parameters for connecting to the source cluster.

1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create) with the following parameters:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Greenplum`
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTarget.connection.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`

        Specify the ID of the target cluster.

1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the _{{ dt-type-copy }}_ type that will use the created endpoints.
1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate).
1. Wait for the transfer status to change to {{ dt-status-finished }}.

    For more information about transfer statuses, see [Transfer lifecycle](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. Switch the source cluster to <q>read-only</q> mode and transfer the load to the target cluster.
1. [Delete the completed transfer](../../../data-transfer/operations/transfer.md#delete).
1. [Delete the endpoints](../../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.
