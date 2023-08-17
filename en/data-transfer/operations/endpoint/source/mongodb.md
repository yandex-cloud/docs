---
title: "How to configure a {{ MG }} source endpoint in {{ data-transfer-full-name }}"
description: "In this tutorial, you'll learn how to set up a {{ MG }} source endpoint in {{ data-transfer-full-name }}."
---

# Configuring a {{ MG }} source endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mmg-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).


## {{ mmg-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mmg-full-name }}](../../../../managed-mongodb/).

{% list tabs %}

- Management console

   {% include [Managed MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/managed-mongodb.md) %}

- CLI

   * Endpoint type: `mongo-source`.

   {% include [Managed MongoDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mongodb.md) %}

- {{ TF }}

   * Endpoint type: `mongo_source`.

   {% include [Managed MongoDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mongodb.md) %}

   Example of the configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       mongo_source {
         security_groups = [ "list of security group IDs" ]
         subnet_id       = "<subnet ID>"
         connection {
           connection_options {
             mdb_cluster_id = "<{{ mmg-name }} cluster ID>"
             auth_source    = "<database name>"
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

   {% include [Managed MongoDB API](../../../../_includes/data-transfer/necessary-settings/api/managed-mongodb.md) %}

{% endlist %}


## Custom installation {#on-premise}

The settings are given for the OnPremise use case when all fields are filled in manually.

{% list tabs %}

- Management console

   {% include [On premise MongoDB](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mongodb.md) %}

- CLI

   * Endpoint type: `mongo-source`.

   {% include [On premise MongoDB CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mongodb.md) %}

- {{ TF }}

   * Endpoint type: `mongo_source`.

   {% include [On premise MongoDB Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mongodb.md) %}

   Example of the configuration file structure:

   
   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       mongo_source {
         security_groups = [ "list of security group IDs" ]
         subnet_id       = "<subnet ID>"
         connection {
           connection_options {
             on_premise {
               hosts       = [ "replica collection host list" ]
               port        = "<connection port>"
               replica_set = "<replica collection name>"
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

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoCollectionFilter.collections.title }}**: Data is only transferred from listed collections. All collections are transferred by default.

      {% include [Description for Included collections](../../../../_includes/data-transfer/fields/mongodb/description-included-collections.md) %}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoCollectionFilter.excluded_collections.title }}**: Data is transferred from all collections except the specified ones.

- {{ TF }}

   * `secondary_preferred_mode`: If there are replicas in the cluster, they will be used for data reads instead of the master host.

   * `collections`: Data is only transferred from listed collections. All collections are transferred by default.

      {% include [Description for Included collections](../../../../_includes/data-transfer/fields/mongodb/description-included-collections.md) %}

   * `excluded_collections`: Data is transferred from all collections except the specified ones.

{% endlist %}

If a source is experiencing high workload (over 10000 write transactions per second), we recommend that you select these settings to have no more than ten different databases at each endpoint. This will help avoid database connection errors while the transfer is ongoing.

{% note info %}

1. If you use several endpoints, you need to create a separate transfer for each one.
1. As transfers of [timeseries collections]({{ mg.docs.comd }}/core/timeseries-collections/) are not supported, you should exclude these collections.

{% endnote %}
