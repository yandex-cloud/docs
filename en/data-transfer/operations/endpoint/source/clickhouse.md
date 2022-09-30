# Configuring source endpoints {{ CH }}

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mch-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ mch-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mch-name }}](../../../../managed-clickhouse/).

{% list tabs %}

- Management console

   {% include [Managed ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-clickhouse.md) %}

- Terraform

   * Endpoint type: `clickhouse_source`.

   {% include [Managed ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-clickhouse.md) %}

   Example configuration file structure:

   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       clickhouse_source {
         security_groups = [ "list of security group IDs" ]
         subnet_id       = "<subnet ID>"
         connection {
           connection_options {
             mdb_cluster_id = "<{{ mch-name }} cluster ID>"
             database       = "<name of database to transfer>"
             user           = "<username to connect>"
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

{% endlist %}

## Custom installation {#on-premise}

Connecting to the database with explicitly specified network addresses and ports.

{% list tabs %}

- Management console

   {% include [On premise ClickHouse UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-clickhouse.md) %}

- Terraform

   * Endpoint type: `clickhouse_source`.

   {% include [On premise ClickHouse Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-clickhouse.md) %}

   Example configuration file structure:

   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       clickhouse_source {
         connection {
           connection_options {
             on_premise {
               http_port   = "<HTTP connection port>"
               native_port = "<native interface connection port>"
               shards {
                 name  = "<shard name>"
                 hosts = [ "list of shard host IPs or FQDNs" ]
               }
               tls_mode {
                 enabled {
                   ca_certificate = "<certificate in PEM format>"
                 }
               }
             }
             database = "<name of database to transfer>"
             user     = "<username to connect>"
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

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * **Included tables**: Data is only transferred from listed tables. It is set using regular expressions.
   * **Excluded tables**: Data from the listed tables is not transferred. It is set using regular expressions.

   Both lists support expressions in the following format:

   * `<schema name>.<table name>`: Fully qualified table name.
   * `<schema name>.*`: All tables in the specified schema.
   * `<table name>`: Table in the default schema.

- Terraform

   * `include_tables`: List of included tables. Data is only transferred from listed tables. It is set using regular expressions.

   * `exclude_tables`: List of excluded tables. Data from tables on this list will not be transmitted. It is set using regular expressions.

   Both lists support expressions in the following format:

   * `<schema name>.<table name>`: Fully qualified table name.
   * `<schema name>.*`: All tables in the specified schema.
   * `<table name>`: Table in the default schema.

{% endlist %}

## Known limitations {#known-limitations}

For now, transfer cannot move columns of the following types from {{ CH }}:

| Type              | Error sample                                                    |
|-------------------|-----------------------------------------------------------------|
| Int128            | unhandled type Int128                                           |
| Int256            | unhandled type Int256                                           |
| UInt128           | unhandled type UInt128                                          |
| UInt256           | unhandled type UInt256                                          |
| Bool              | unhandled type Bool                                             |
| Date32            | unhandled type Date32                                           |
| JSON              | unhandled type '<field name> <type name>'                       |
| Array(Date)       | Can't transfer type 'Array(Date)', column '<column name>'       |
| Array(DateTime)   | Can't transfer type 'Array(DateTime)', column '<column name>'   |
| Array(DateTime64) | Can't transfer type 'Array(DateTime64)', column '<column name>' |
| Map(,)            | unhandled type Map(<type name>, <type name>)                    |

If the source tables contain columns of these types, the transfer will fail. Examples of errors are shown in the table above.