---
title: How to update a {{ metadata-hub-name }} connection. Step-by-step guides
description: Step-by-step guides on using {{ connection-manager-name }} in {{ yandex-cloud }}. In this tutorial, you will learn how to modify connections.
---

# Editing a connection


To change connection settings:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. In the list of connections, click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the connection you want to edit.
  1. Select **{{ ui-key.yacloud.common.edit }}**.
  1. Change the required connection parameters, such as description, labels, database server settings, or user authentication information.
  1. Click **{{ ui-key.yacloud.common.apply }}** to save the changes.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  You can update settings of a connection to a cluster with a managed database or to a custom database installation.

  1. To update settings of a connection to a cluster with a managed database:

      1. View the description of the CLI command for updating a connection:

          ```bash
          yc metadata-hub connection-manager connection update <database_type> --help
          ```

          The supported database types are `postgresql`, `mysql`, `clickhouse`, `mongodb`, `opensearch`, `valkey`, `greenplum`, and `kafka`.

      1. Update your connection by running this command:
      
          ```bash
          yc metadata-hub connection-manager connection update <database_type> <connection_ID> \
            --name <connection_name> \
            --user <username> \
            --password <password> \
            --managed-cluster-id <cluster_ID>
          ```

          Where:

          * `--name`: Connection name.

          * `--user`: Username to connect to the cluster.

          * `--password`: Password.
      
          * `--managed-cluster-id`: Cluster ID. You can get the cluster ID with the list of clusters in the folder.

          You can get the connection ID with the [list of connections](view-connection.md#connection-list) in the folder.

      1. You can update the list of databases for all connections, except {{ mos-name }} and {{ mkf-name }} connections, by running this command:

          ```bash
          yc metadata-hub connection-manager connection update <database_type> <connection_ID> \
            --databases <database_list>
          ```

          Where `--databases` is a comma-separated list of databases.
          
          Make sure the user has the required access permissions.
  
  1. To update settings of a connection to a custom database installation:
      
      1. View the description of the CLI command for updating a connection:

          ```bash
          yc metadata-hub connection-manager connection update <database_type> --help
          ```

          The supported database types are `postgresql`, `mysql`, `clickhouse`, `mongodb`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, and `kafka`.

      1. Update your connection by running this command:
      
          ```bash
          yc metadata-hub connection-manager connection update <database_type> <connection_ID> \
            --name <connection_name> \
            --user <username> \
            --password <password> \
            --ca-certificate <path_to_certificate>
          ```

          Where:

          * `--name`: Connection name.
          
          * `--description`: Connection description.
          
          * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.
          
          * `--user`: Username to connect to the cluster.
          
          * `--password`: Password.
          
          * `--ca-certificate`: Path to your TLS CA certificate file.
          
            TLS is enabled by default; to disable it, use the `--tls-disabled` flag.

      1. You can also update the following:

          * List of hosts for all connections, except {{ TR }} connections, by running this command:

            ```bash
            yc metadata-hub connection-manager connection update <database_type> <connection_ID> \
              --hosts <list_of_hosts>
            ```

            Where `--hosts` is a comma-separated list of hosts.

            {% note warning %}

            Host notation format depends on the database type. For more information, see the [CLI reference](../../cli/cli-ref/metadata-hub/cli-ref/connection-manager/connection/update/index.md).

            {% endnote %}

          * Coordinator parameters for connecting to {{ TR }}, by running this command:

            ```bash
            yc metadata-hub connection-manager connection update trino <connection_ID> \
              --coordinator <coordinator_parameters>
            ```

            Where `--coordinator` stands for coordinator parameters in `<host>:<port>` format.

          * List of databases for all connections, except {{ TR }}, {{ OS }}, and {{ KF }} connections, by running this command:

            ```bash
            yc metadata-hub connection-manager connection update <database_type> <connection_ID> \
              --databases <database_list>
            ```

            Where `--databases` is a comma-separated list of databases.
          
            Make sure the user has the required access permissions.


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% note alert %}

  Do not change the connection name using {{ TF }}. This will delete the existing connection and create a new one.

  {% endnote %}

  You can update settings of a connection to a cluster with a managed database or to a custom database installation.

  1. To update settings of a connection to a cluster with a managed database:

     1. Open the current {{ TF }} configuration file describing your infrastructure.

      1. To update the description and labels for a connection, update the values of the relevant fields in the resource description:

          ```hcl
          resource "yandex_connectionmanager_connection" "<local_connection_name>" {
            ...
            description = "<connection_description>"
        
            labels = {
              "<key_1>" = "<value_1>"
              "<key_2>" = "<value_2>"
              ...
              "<key_N>" = "<value_N>"
            }
            ...
          }
          ```

          Where:

          * `description`: Connection description.

          * `--labels`: Labels in `"<key>" = "<value>"` format.

      1. To update the cluster ID, update the `managed_cluster_id` field value under `params.<database_type>`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<local_connection_name>" {
            ...
            params = {
              <database_type> = {
                managed_cluster_id = "<cluster_ID>"
                ...
              }
            }
          }
          ```

      1. To update the list of databases for all connections, except {{ mos-name }} and {{ mkf-name }} connections, update the `databases` field value under `params.<database_type>`:
     
          ```hcl
          resource "yandex_connectionmanager_connection" "<local_connection_name>" {
            ...
            params = {
              <database_type> = {
                ...
                databases = [
                  "<database_1>",
                  "<database_2>",
                  ...
                  "<database_N>"
                ]
                ...
              }
            }
          }
          ```

          Where `databases` is the list of databases. Make sure the user has the required access permissions.

      1. To update authentication parameters for all connections, except {{ mkf-name }} connections, update the values in the `user` and `password.raw` fields under `params.<database_type>.auth.user_password`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<local_connection_name>" {
            ...
            params = {
              <database_type> = {
                ...
                auth = {
                  user_password = {
                    user     = "<username>"
                    password = {
                      raw = "<password>"
                    }
                  }
                }
              }
            }
          }
          ```
      
      1. To update authentication parameters for {{ mkf-name }} connections, update the values of the fields under `params.kafka.auth.sasl`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<local_connection_name>" {
            ...
            params = {
              kafka = {
                ...
                auth = {
                  sasl = {
                    user     = "<username>"
                    password = { 
                      raw = "<password>"
                    }
                    supported_mechanisms = [
                      <list_of_authentication_mechanisms>
                    ]
                  }
                }
              }
            }
          }
          ```

          Where `params.kafka.auth` stands for authentication parameters. Select one of the sections:

          * `sasl`: SASL authentication parameters.
            
            * `user`: Username to connect to the cluster.
            * `password.raw`: Password.
            * `supported_mechanisms`: List of authentication mechanisms. The possible values are:
              
              * `PLAIN`: Authentication with login and password provided as plain unencrypted text.
              * `SCRAM_SHA256`: Authentication with SHA-256 hashing.
              * `SCRAM_SHA512`: Authentication with SHA-512 hashing.

          
          * `disabled`: Disables authentication.
  
      1. Make sure the settings are correct.
  
          {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
      1. Confirm updating the resources.
  
          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  1. To update settings of a connection to a custom database installation:

      1. Open the current {{ TF }} configuration file describing your infrastructure.

      1. To update the description and labels for a connection, update the values of the relevant fields in the resource description:

          ```hcl
          resource "yandex_connectionmanager_connection" "<local_connection_name>" {
            ...
            description = "<connection_description>"
        
            labels = {
              "<key_1>" = "<value_1>"
              "<key_2>" = "<value_2>"
              ...
              "<key_N>" = "<value_N>"
            }
            ...
          }
          ```

          Where:

          * `description`: Connection description.

          * `--labels`: Labels in `"<key>" = "<value>"` format.

      1. To update the list of hosts for all connections, except {{ TR }} connections, update the `hosts` field value under `params.<database_type>.cluster`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<local_connection_name>" {
            ...
            params = {
              <database_type> = {
                cluster = {
                  hosts = [
                    {
                      <host_1_parameters>
                    },
                    {
                      <host_2_parameters>
                    },
                    ...
                    {
                      <host_N_parameters>
                    }
                  ]
                  ...
                }
                ...
              }
            }
          }
          ```

          {% note warning %}

          Host parameters depend on the database type. For more information, see this [{{ TF }} provider guide](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).

          {% endnote %}

      1. To update coordinator parameters for {{ TR }} connections, update the values of the `host` and `port` fields under `params.trino.cluster.coordinator`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<local_connection_name>" {
            ...
            params = {
              <database_type> = {
                cluster = {
                  coordinator = {
                    host = "<host>"
                    port = <port>
                  }
                  ...
                }
                ...
              }
            }
          }
          ```

      1. To update TLS parameters, update the values of the fields under `params.<database_type>.cluster.tls_params`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<local_connection_name>" {
            ...
            params = {
              <database_type> = {
                cluster = {
                  ...
                  tls_params = {
                    tls {
                      ca_certificate = "<path_to_certificate>"
                    }
                  }
                }
                ...
              }
            }
          }
          ```

          Where `params.<database_type>.cluster.tls_params` represents TLS parameters. Select one of the sections:
        
          * `tls.ca_certificate`: Path to your TLS CA certificate file.
          * `disabled`: Disables TLS. TLS is enabled by default.

      1. To update the list of databases for all connections, except {{ TR }}, {{ OS }}, and {{ KF }} connections, update the `databases` field value under `params.<database_type>`:
     
          ```hcl
          resource "yandex_connectionmanager_connection" "<local_connection_name>" {
            ...
            params = {
              <database_type> = {
                ...
                databases = [
                  "<database_1>",
                  "<database_2>",
                  ...
                  "<database_N>"
                ]
                ...
              }
            }
          }
          ```

          Where `databases` is the list of databases. Make sure the user has the required access permissions.
  
      1. To update authentication parameters for all connections, except {{ KF }} connections, update the values in the `user` and `password.raw` fields under `params.<database_type>.auth.user_password`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<local_connection_name>" {
            ...
            params = {
              <database_type> = {
                ...
                auth = {
                  user_password = {
                    user     = "<username>"
                    password = {
                      raw = "<password>"
                    }
                  }
                }
              }
            }
          }
          ```
      
      1. To update authentication parameters for {{ KF }} connections, update the values of the fields under `params.kafka.auth.sasl`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<local_connection_name>" {
            ...
            params = {
              kafka = {
                ...
                auth = {
                  sasl = {
                    user     = "<username>"
                    password = { 
                      raw = "<password>"
                    }
                    supported_mechanisms = [
                      <list_of_authentication_mechanisms>
                    ]
                  }
                }
              }
            }
          }
          ```

          Where `params.kafka.auth` stands for authentication parameters. Select one of the sections:

          * `sasl`: SASL authentication parameters.
            
            * `user`: Username to connect to the cluster.
            * `password.raw`: Password.
            * `supported_mechanisms`: List of authentication mechanisms. The possible values are:
              
              * `PLAIN`: Authentication with login and password provided as plain unencrypted text.
              * `SCRAM_SHA256`: Authentication with SHA-256 hashing.
              * `SCRAM_SHA512`: Authentication with SHA-512 hashing.

          
          * `disabled`: Disables authentication.

      1. Make sure the settings are correct.
  
          {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
      1. Confirm updating the resources.
  
          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
      
- API {#api}

  Use the [Connection.Update](../connection-manager/api-ref/Connection/update.md) REST API method or the [ConnectionService.Update](../connection-manager/api-ref/grpc/Connection/update.md) gRPC API call and provide the connection ID in the request.

  You can get the connection ID with the [list of connections](view-connection.md#connection-list) in the folder.

{% endlist %}


