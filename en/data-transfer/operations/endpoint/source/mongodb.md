---
title: "How to set up a {{ MG }} source endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you will learn how to configure a {{ MG }} source endpoint when creating or modifying it in {{ data-transfer-full-name }}."
---
# Transferring data from a {{ MG }} source endpoint


{{ data-transfer-full-name }} enables you to migrate data from a {{ MG }} database and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the {{ MG }}](#prepare) database for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. [Perform the required operations with the database](#db-actions) and [see how the transfer is going](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](#troubleshooting) to resolve them.

## Scenarios for transferring data from {{ MG }} {#scenarios}

1. {% include [migration](../../../../_includes/data-transfer/scenario-captions/migration.md) %}

    * [Migrating a {{ MG }} cluster](../../../tutorials/managed-mongodb.md).
    * [Migrating a {{ MG }} cluster from 4.4 to 6.0](../../../tutorials/mongodb-versions.md).

1. {% include [storage](../../../../_includes/data-transfer/scenario-captions/storage.md) %}

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing the source database {#prepare}

{% include [prepare db](../../../../_includes/data-transfer/endpoints/sources/mongodb-prepare.md) %}

## Configuring the {{ MG }} source endpoint {#endpoint-settings}

{% include [MongodDB Verstion](../../../../_includes/data-transfer/notes/mongodb-version.md) %}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

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

    * Endpoint type: `mongo-source`.

    {% include [Managed MongoDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mongodb.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `mongo_source`.

    {% include [Managed MongoDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mongodb.md) %}

    Here is an example of the configuration file structure:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        mongo_source {
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


    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [Managed MongoDB API](../../../../_includes/data-transfer/necessary-settings/api/managed-mongodb.md) %}

{% endlist %}


### Custom installation {#on-premise}

The settings are given for the OnPremise use case when all fields are filled in manually.

{% list tabs group=instructions %}

- Management console {#console}

    {% include [On premise MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mongodb.md) %}

- CLI {#cli}

    * Endpoint type: `mongo-source`.

    {% include [On premise MongoDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mongodb.md) %}

- {{ TF }} {#tf}

    * Endpoint type: `mongo_source`.

    {% include [On premise MongoDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mongodb.md) %}

    Here is an example of the configuration file structure:

    
    ```hcl
    resource "yandex_datatransfer_endpoint" "<endpoint_name_in_{{ TF }}>" {
      name = "<endpoint_name>"
      settings {
        mongo_source {
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


    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API {#api}

    {% include [On premise MongoDB API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mongodb.md) %}

{% endlist %}

### Collection filter {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    * {% include [collections](../../../../_includes/data-transfer/fields/mongodb/ui/collections.md) %}

        {% include [Description for Included collections](../../../../_includes/data-transfer/fields/mongodb/description-included-collections.md) %}

    * {% include [excluded-collections](../../../../_includes/data-transfer/fields/mongodb/ui/excluded-collections.md) %}

    Included and excluded collection names must meet the ID naming rules in {{ MG }}. Escaping double quotes is not required.

- CLI {#cli}

    * {% include [include-collection](../../../../_includes/data-transfer/fields/mongodb/cli/include-collection.md) %}

        {% include [Description for Included collections](../../../../_includes/data-transfer/fields/mongodb/description-included-collections.md) %}

    * {% include [exclude-collection](../../../../_includes/data-transfer/fields/mongodb/cli/exclude-collection.md) %}

    * {% include [prefer-secondary](../../../../_includes/data-transfer/fields/mongodb/cli/prefer-secondary.md) %}

- {{ TF }} {#tf}

    * {% include [collections](../../../../_includes/data-transfer/fields/mongodb/terraform/collections.md) %}

        {% include [Description for Included collections](../../../../_includes/data-transfer/fields/mongodb/description-included-collections.md) %}

    * {% include [excluded_collections](../../../../_includes/data-transfer/fields/mongodb/terraform/excluded-collections.md) %}

    * {% include [secondary_preferred_mode](../../../../_includes/data-transfer/fields/mongodb/terraform/secondary-preferred-mode.md) %}

- API {#api}

    * {% include [collections](../../../../_includes/data-transfer/fields/mongodb/api/collections.md) %}

        {% include [Description for Included collections](../../../../_includes/data-transfer/fields/mongodb/description-included-collections.md) %}

    * {% include [excludedCollections](../../../../_includes/data-transfer/fields/mongodb/api/excluded-collections.md) %}

    * {% include [secondaryPreferredMode](../../../../_includes/data-transfer/fields/mongodb/api/secondary-preferred-mode.md) %}

{% endlist %}

If a source workload is high (over 10,000 write transactions per second), we recommend that you select these settings to have no more than ten different databases at each endpoint. This will help avoid database connection errors while the transfer is ongoing.

{% note info %}

* If you use several endpoints, you need to create a separate transfer for each one.
* As transfers of [timeseries collections]({{ mg.docs.comd }}/core/timeseries-collections/) are not supported, you should exclude such collections.

{% endnote %}


## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ objstorage-full-name }}](../target/object-storage.md).
* [{{ MG }}](../target/mongodb.md).

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

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
* [Error at the copying stage](#history-lost)

For more troubleshooting tips, see [Troubleshooting](../../../troubleshooting/index.md).

{% include [string-size](../../../../_includes/data-transfer/troubles/mongodb/string-size.md) %}

{% include [object-size](../../../../_includes/data-transfer/troubles/mongodb/object-size.md) %}

{% include [no-tables](../../../../_includes/data-transfer/troubles/mongodb/no-tables.md) %}

{% include [sharded](../../../../_includes/data-transfer/troubles/mongodb/sharded.md) %}

{% include [timeseries](../../../../_includes/data-transfer/troubles/mongodb/timeseries.md) %}

{% include [cluster configuration](../../../../_includes/data-transfer/troubles/mongodb/cluster-configuration.md) %}

{% include [history lost](../../../../_includes/data-transfer/troubles/mongodb/history-lost.md) %}

{% include [cannot-get-delimiters](../../../../_includes/data-transfer/troubles/mongodb/cannot-get-delimiters.md) %}
