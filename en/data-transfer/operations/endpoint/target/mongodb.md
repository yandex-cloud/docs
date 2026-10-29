---
title: How to set up a {{ MG }} target endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up a {{ MG }} target endpoint in {{ data-transfer-full-name }}.
---
# Transferring data to a {{ MG }}/{{ SD }} (Managed Service for MongoDB) target endpoint


{{ data-transfer-full-name }} enables you to migrate data to a {{ MG }}/{{ SD }} (Managed Service for MongoDB) database and implement various data transfer, processing, and transformation scenarios. To set up a transfer:

1. [Review possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Prepare your {{ MG }}/{{ SD }} (Managed Service for MongoDB) database](#prepare) for the transfer.
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) and [launch](../../transfer.md#activate) the transfer.
1. [Perform the required database tasks](#db-actions) while [monitoring the transfer status](../../monitoring.md).
1. If you run into any problems, [check the available solutions](#troubleshooting) for troubleshooting.

## Scenarios for transferring data to {{ MG }}/{{ SD }} (Managed Service for MongoDB) {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}
    
    * [Migrating a {{ MG }} cluster](../../../tutorials/storedoc.md)
    * [Migrating a {{ SD }} (Managed Service for MongoDB) cluster from 4.4 to 6.0](../../../tutorials/storedoc-versions.md)

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    
    * [Delivering data from {{ KF }} to {{ SD }} (Managed Service for MongoDB)](../../../tutorials/mkf-to-mmg.md)

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ MG }}/{{ SD }}](../source/mongodb.md)
* [{{ AB }}](../../../transfer-matrix.md#airbyte)
* [{{ DS }}](../source/data-streams.md)
* [{{ KF }}](../source/kafka.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

## Preparing the target database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/targets/mongodb-prepare.md) %}

## Configuring a {{ MG }}/{{ SD }} (Managed Service for MongoDB) target endpoint {#endpoint-settings}

{% include [MongodDB Version](../../../../_includes/data-transfer/notes/mongodb-version.md) %}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can configure:

* Connection settings for a [{{ mmg-full-name }} cluster](#managed-service) or a [custom deployment](#on-premise), including those running on {{ compute-full-name }} VMs. These settings are required.
* [Optional settings](#additional-settings).


### {{ mmg-name }} (Managed Service for MongoDB) cluster {#managed-service}


{% note warning %}

To create or edit a managed database endpoint, you will need the [`{{ roles.mmg.viewer }}`](../../../../storedoc/security/index.md#mmg-viewer) role or the primitive [`viewer`](../../../../iam/roles-reference.md#viewer) role for the folder where its cluster resides.

{% endnote %}

Connection to the database with the cluster specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [Managed MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/managed-mongodb.md) %}

- CLI {#cli}

    * Endpoint type: `mongo-target`.

    {% include [Managed MongodDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mongodb.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `mongo_target`.

    {% include [Managed MongodDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mongodb.md) %}

    Configuration file structure example:

    
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
              auth_source    = "<DB_name>"
              user           = "<username>"
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


    For more information, see [this {{ TF }} provider guide]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed MongodDB API](../../../../_includes/data-transfer/necessary-settings/api/managed-mongodb.md) %}

{% endlist %}


### Custom installation {#on-premise}

Connection to the database with explicitly specified network addresses and ports.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [On premise MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mongodb.md) %}

- CLI {#cli}

    * Endpoint type: `mongo-target`.

    {% include [Managed MongoDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mongodb.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `mongo_target`.

    {% include [On premise MongoDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mongodb.md) %}

    Configuration file structure example:

    
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
                    ca_certificate = "<certificate_in_PEM_format>"
                  }
                }
              }
              auth_source = "<DB_name>"
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


    For more information, see [this {{ TF }} provider guide]({{ tf-provider-dt-endpoint }}).

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
1. Select `DISABLED` or `TRUNCATE` for cleanup policy.

Selecting the `DROP` policy will cause the service to delete all the data, including sharded collections, from the target database and replace them with new non-sharded ones when activating a transfer.

{% endnote %}

Once you have configured the source and target, [create and launch the transfer](../../transfer.md#create).

## Operations with the database during transfer {#db-actions}

{% include [work with db](../../../../_includes/data-transfer/endpoints/sources/mongo-work-with-db.md) %}

## Mapping supported data types between DBMS and endpoint {#type-mapping}

#|
|| **{{ MG }} type** | **Endpoint type** ||
|| bson | int64 ||
|| bson | int32 ||
|| bson | int16 ||
|| bson | int8 ||
|| bson | uint64 ||
|| bson | uint32 ||
|| bson | uint16 ||
|| bson | uint8 ||
|| bson | float ||
|| bson | double ||
|| bson | string ||
|| bson | utf8 ||
|| bson | boolean ||
|| bson | date ||
|| bson | datetime ||
|| bson | timestamp ||
|| bson | any ||
|#

## Data transfer troubleshooting {#troubleshooting}

Known issues when using a {{ MG }} endpoint:

* [Collection key size exceeds 5 MB](#string-size).
* [Collection object size exceeds 16 MB](#object-size).
* [No tables found](#no-tables).
* [Error when transferring a sharded cluster](#sharded).
* [Error when transferring timeseries collections](#timeseries).
* [Unable to recognize an external cluster IP address or FQDN](#cluster-config-issue).

For the full list of recommendations, see [Troubleshooting](../../../troubleshooting/index.md).

{% include [string-size](../../../../_includes/data-transfer/troubles/mongodb/string-size.md) %}

{% include [object-size](../../../../_includes/data-transfer/troubles/mongodb/object-size.md) %}

{% include [no-tables](../../../../_includes/data-transfer/troubles/mongodb/no-tables.md) %}

{% include [sharded](../../../../_includes/data-transfer/troubles/mongodb/sharded.md) %}

{% include [timeseries](../../../../_includes/data-transfer/troubles/mongodb/timeseries.md) %}

{% include [cluster configuration](../../../../_includes/data-transfer/troubles/mongodb/cluster-configuration.md) %}

