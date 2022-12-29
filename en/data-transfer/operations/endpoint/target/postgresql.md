---
title: "How to configure {{ PG }} target endpoint in {{ data-transfer-full-name }}"
description: "Following this guide you will learn how to configure {{ PG }} target endpoint in {{ data-transfer-full-name }}."
---

# Configuring a {{ PG }} target endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mpg-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ mpg-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mpg-full-name }}](../../../../managed-postgresql/).

{% list tabs %}

- Management console

   {% include [Managed Postgresql](../../../../_includes/data-transfer/necessary-settings/ui/managed-postgresql.md) %}

- CLI

   * Endpoint type: `postgres-target`.

   {% include [Managed PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-postgresql.md) %}

- {{ TF }}

   * Endpoint type: `postgres_target`.

   {% include [Managed PostgreSQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-postgresql.md) %}

   Example configuration file structure:

   {% if audience != "internal" %}

   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       postgres_target {
         security_groups = [ "list of security group IDs" ]
         connection {
           mdb_cluster_id = "<{{ mpg-name }} cluster ID>"
         }
         database = "<name of database being transferred>"
         user     = "<username for connection>"
         password {
           raw = "<user password>"
         }
       }
     }
   }
   ```

   {% else %}

   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       postgres_target {
         connection {
           mdb_cluster_id = "<{{ mpg-name }} cluster ID>"
         }
         database = "<name of database to transfer>"
         user     = "<username to connect>"
         password {
           raw = "<user password>"
         }
       }
     }
   }
   ```

   {% endif %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   {% include [Managed PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-postgresql.md) %}

{% endlist %}

## Custom installation {#on-premise}

For OnPremise, all fields are filled in manually.

{% list tabs %}

- Management console

   {% include [On premise Postgresql](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-postgresql.md) %}

- CLI

   * Endpoint type: `postgres-target`.

   {% include [On premise PostgreSQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-postgresql.md) %}

- {{ TF }}

   * Endpoint type: `postgres_target`.

   {% include [On premise PostgreSQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-postgresql.md) %}

   Example configuration file structure:

   {% if audience != "internal" %}

   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       postgres_target {
         security_groups = [ "list of security group IDs" ]
         connection {
           on_premise {
             hosts = ["<host list>"]
             port  = <connection port>
           }
         }
         database = "<name of database being transferred>"
         user     = "<username for connection>"
         password {
           raw = "<user password>"
         }
       }
     }
   }
   ```

   {% else %}

   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       postgres_target {
         connection {
           on_premise {
             hosts = ["<host list>"]
             port  = <connection port>
           }
         }
         database = "<name of database to transfer>"
         user     = "<username to connect>"
         password {
           raw = "<user password>"
         }
       }
     }
   }
   ```

{% endif %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   {% include [On premise PostgreSQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-postgresql.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * {% include [Field Cleanup Policy Disabled/Drop/Truncate](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-disabled-drop-truncate.md) %}

   * **Save transaction boundaries**: Enable so that the service writes data to the target database only after fully reading the transaction data from the source database.

      {% if audience != "internal" %}

      {% note warning %}

      This feature is in the [Preview stage](../../../../overview/concepts/launch-stages.md).

      {% endnote %}

      {% endif %}

{% endlist %}
