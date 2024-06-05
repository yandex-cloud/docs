---
title: "How to configure a {{ MG }} target endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to set up a {{ MG }} target endpoint in {{ data-transfer-full-name }}."
---
# Transferring data to a {{ MG }} target endpoint


{{ data-transfer-full-name }} enables you to migrate data to a {{ MG }} database and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Prepare the {{ MG }}](#prepare) database for the transfer.
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. [Perform required operations with the database](../../../../_includes/data-transfer/endpoints/sources/pg-work-with-db.md) and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data to {{ MG }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

   * [Migrating the {{ MG }} cluster](../../../tutorials/managed-mongodb.md).
   * [Migrating {{ MG }} cluster from 4.4 to 6.0](../../../tutorials/mongodb-versions.md).

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}

   * [Delivering data from {{ KF }} to {{ MG }}](../../../tutorials/mkf-to-mmg.md).

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ MG }}](../source/mongodb.md)​
* [Airbyte](../../../transfer-matrix.md#airbyte)
* [{{ DS }}](../source/data-streams.md)
* [{{ KF }}](../source/kafka.md)​

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

## Preparing the target database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/mongodb-prepare.md) %}

## Configuring the {{ MG }} target endpoint {#endpoint-settings}

{% include [MongodDB Verstion](../../../../_includes/data-transfer/notes/mongodb-version.md) %}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mmg-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).


### {{ mmg-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you need to have the [`{{ roles.mmg.viewer }}` role](../../../../managed-mongodb/security/index.md#mmg-viewer) or the [`viewer` primitive role](../../../../iam/roles-reference.md#viewer) assigned for the folder where this managed database cluster resides.

{% endnote %}


Connecting to the database with the cluster ID specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [Managed MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/managed-mongodb.md) %}

- CLI {#cli}

   * Endpoint type: `mongo-target`.

   {% include [Managed MongodDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mongodb.md) %}

- {{ TF }} {#tf}

   * Endpoint type: `mongo_target`.

   {% include [Managed MongodDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mongodb.md) %}

   Here is an example of the configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
     name = "<endpoint_name>"
     settings {
       mongo_target {
         security_groups = ["<list_of_security_group_IDs>"]
         subnet_id       = "<subnet_ID>"
         connection {
           connection_options {
             mdb_cluster_id = "<cluster_ID>"
             auth_source    = "<database_name>"
             user           = "<user_name>"
             password {
               raw = "<user_password>"
             }
           }
         }
         <additional_endpoint_settings>
       }
     }
   }
   ```


   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

   {% include [Managed MongodDB API](../../../../_includes/data-transfer/necessary-settings/api/managed-mongodb.md) %}

{% endlist %}


### Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

   {% include [On premise MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mongodb.md) %}

- CLI {#cli}

   * Endpoint type: `mongo-target`.

   {% include [Managed MongoDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mongodb.md) %}

- {{ TF }} {#tf}

   * Endpoint type: `mongo_target`.

   {% include [On premise MongoDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mongodb.md) %}

   Here is an example of the configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
     name = "<endpoint_name>"
     settings {
       mongo_target {
         security_groups = ["<list_of_security_group_IDs>"]
         subnet_id       = "<subnet_ID>"
         connection {
           connection_options {
             on_premise {
               hosts       = [ "list of replica set hosts" ]
               port        = "<port_for_connection>"
               replica_set = "<replica_set_name>"
               tls_mode {
                 enabled {
                   ca_certificate = "<PEM_certificate>"
                 }
               }
             }
             auth_source = "<database_name>"
             user        = "<username>"
             password {
               raw = "<user_password>"
             }
           }
         }
         <additional_endpoint_settings>
       }
     }
   }
   ```


   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

   {% include [On premise MongoDB API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mongodb.md) %}

{% endlist %}

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

   * {% include [database](../../../../_includes/data-transfer/fields/mongodb/ui/database.md) %}

   * {% include [cleanup_policy](../../../../_includes/data-transfer/fields/mongodb/ui/cleanup-policy.md) %}

- CLI {#cli}

   {% include [target-database](../../../../_includes/data-transfer/fields/mongodb/cli/target-database.md) %}

- {{ TF }} {#tf}

   * {% include [database](../../../../_includes/data-transfer/fields/mongodb/terraform/database.md) %}

   * {% include [cleanup_policy](../../../../_includes/data-transfer/fields/mongodb/terraform/cleanup-policy.md) %}

- API {#api}

   * {% include [database](../../../../_includes/data-transfer/fields/mongodb/api/database.md) %}

   * {% include [cleanupPolicy](../../../../_includes/data-transfer/fields/mongodb/api/cleanup-policy.md) %}

{% endlist %}

{% note warning %}

By default, {{ data-transfer-name }} transfers collections without sharding. If you are transferring data to a sharded target cluster and want your collections to be sharded:

1. [Prepare the target cluster](../../prepare.md#target-mg) to shard the collections.
1. Select `DISABLED` or `TRUNCATE `as your cleanup policy.

Selecting the `DROP `policy will result in the service deleting all the data from the target database, including sharded collections, and replacing them with new unsharded ones when a transfer is activated.

{% endnote %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Operations with the database during transfer {#db-actions}

{% include [work with db](../../../../_includes/data-transfer/endpoints/sources/mongo-work-with-db.md) %}

## Troubleshooting data transfer issues {#troubleshooting}

Known issues when using a {{ MG }} endpoint:

* [Collection key size exceeds 5 MB](#string-size).
* [Collection object size exceeds 16 MB](#object-size).
* [No tables found](#no-tables).
* [Error when transferring a sharded cluster](#sharded).
* [Error when transferring timeseries collections](#timeseries).
* [Unable to recognize an external cluster IP address or FQDN](#cluster-config-issue).

See a full list of recommendations in the [Troubleshooting](../../../troubleshooting/index.md) section.

{% include [string-size](../../../../_includes/data-transfer/troubles/mongodb/string-size.md) %}

{% include [object-size](../../../../_includes/data-transfer/troubles/mongodb/object-size.md) %}

{% include [no-tables](../../../../_includes/data-transfer/troubles/mongodb/no-tables.md) %}

{% include [sharded](../../../../_includes/data-transfer/troubles/mongodb/sharded.md) %}

{% include [timeseries](../../../../_includes/data-transfer/troubles/mongodb/timeseries.md) %}

{% include [cluster configuration](../../../../_includes/data-transfer/troubles/mongodb/cluster-configuration.md) %}

