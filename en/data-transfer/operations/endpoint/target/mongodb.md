---
title: "How to configure {{ MG }} target endpoint in {{ data-transfer-full-name }}"
description: "Following this guide you will learn how to configure {{ MG }} target endpoint in {{ data-transfer-full-name }}."
---

# Configuring target endpoints {{ MG }}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* {% if product == "yandex-cloud" %}[{{ mmg-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise){% endif %}{% if product == "cloud-il" %}[{{ MG }} custom installation](#on-premise){% endif %} settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

{% if product == "yandex-cloud" %}

## {{ mmg-name }} cluster {#managed-service}

{% list tabs %}

- Management console

   Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mmg-full-name }}](../../../../managed-mongodb/).

   {% include [Managed MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/managed-mongodb.md) %}

- CLI

   * Endpoint type: `mongo-target`.

   {% include [Managed MongodDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mongodb.md) %}

- Terraform

   * Endpoint type: `mongo_target`.

   {% include [Managed MongodDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mongodb.md) %}

   Example configuration file structure:

   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       mongo_target {
         security_groups = [ "list of security group IDs" ]
         subnet_id       = "<subnet ID>"
         connection {
           connection_options {
             mdb_cluster_id = "<{{ mmg-name }} cluster ID>"
             database       = "<database name>"
             user           = "<username>"
             password {
               raw = "<user password>"
             }
           }
         }
         <advanced endpoint settings>
       }
     }
   }
   ```

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   {% include [Managed MongodDB API](../../../../_includes/data-transfer/necessary-settings/api/managed-mongodb.md) %}

{% endlist %}

{% endif %}

## Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs %}

- Management console

   {% include [On premise MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mongodb.md) %}

- CLI

   * Endpoint type: `mongo-target`.

   {% include [Managed MongoDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mongodb.md) %}

- Terraform

   * Endpoint type: `mongo_target`.

   {% include [On premise MongoDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mongodb.md) %}

   Example configuration file structure:

   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       mongo_target {
         security_groups = [ "list of security group IDs" ]
         subnet_id       = "<subnet ID>"
         connection {
           connection_options {
             on_premise {
               hosts       = [ "list of replica set hosts" ]
               port        = "<connection port>"
               replica_set = "<replica set name>"
               tls_mode {
                 enabled {
                   ca_certificate = "<certificate in PEM format>"
                 }
               }
             }
             auth_source = "<database name>"
             user        = "<username>"
             password {
               raw = "<user password>"
             }
           }
         }
         <advanced endpoint settings>
       }
     }
   }
   ```

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   {% include [On premise MongoDB API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mongodb.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * **Cleanup policy**: Select a way to clean up data in the target database before the transfer:

      * `DISABLED`: Do not clean up.

         Select this option if only replication without copying data is performed.

      * `DROP`: Fully delete collections included in the transfer (default).

         Use this option so that the latest schema version is always transferred to the target database from the source whenever the transfer is activated.

      * `TRUNCATE`: Delete only the data from the collections included in the transfer but leave the schema.

         Use this option if the schema in the target database differs from the one that would have been transferred from the source during the transfer.

- Terraform

   * `database`: Specify the database name if you want to create collections in a database that is different from the source database.

   * `cleanup_policy`: Select a way to clean up data in the target database before the transfer:

      * `DISABLED`: Do not clean up.

         Select this option if only replication without copying data is performed.

      * `DROP`: Fully delete collections included in the transfer (default).

         Use this option so that the latest collection version is always transferred to the target database from the source whenever the transfer is activated.

      * `TRUNCATE`: Delete only the data from the collections included in the transfer but leave the collections.

         Use this option if the structure of collections in the target database differs from the one that would have been transferred from the source during the transfer.

{% endlist %}

{% note warning %}

By default, {{ data-transfer-name }} transfers collections without sharding. If you are transferring data to a sharded target cluster and want your collections to be sharded:

1. [Prepare the target cluster](../../prepare.md#target-mg) to shard the collections.
1. Select `DISABLED` or `TRUNCATE `as your cleanup policy.

Selecting the `DROP `policy will result in the service deleting all the data from the target database, including sharded collections, and replacing them with new unsharded ones when a transfer is activated.

{% endnote %}
