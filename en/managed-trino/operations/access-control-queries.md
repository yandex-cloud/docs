---
title: Assigning access rules for queries in {{ mtr-name }}
description: Rules define the actions users can perform with SQL queries.
---

# Assigning access rules for queries in {{ mtr-name }}

Query access rules define the actions users can perform with SQL queries in a {{ mtr-name }} cluster.

For each user-query pair, the rules apply as follows:
* Rules are checked for matches in the order they are listed in the configuration file. The first rule matching the user-query pair applies.
* If none of the rules match the user-query pair, no actions with the query are allowed to the user.
* If no query access rules are set, any user can perform any actions with any query.
* Query access rules apply together with the top-level [rules for catalog objects](./access-control-catalogs.md).

{% note warning %}

If there are no query access rules, users can view and cancel each other's queries.

{% endnote %}

## Setting rules when creating a cluster {#set-at-create}

You can set query access rules when creating a {{ mtr-name }} cluster.

{% list tabs group=instructions %}

- CLI {#cli}
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set query access rules:

  1. Create a file named `access_control.yaml` and paste the following code into it:

     ```yaml
     queries:
       # Rule 1
       - privileges: [<list_of_privileges>]
         query_owners: [<list_of_query_owners>]
         groups: [<list_of_group_IDs>]
         users: [<list_of_user_IDs>]
         description: <rule_description>
       # Rule 2
       - <Rule_2_parameters>
       ...
       # Rule N
       - <Rule_N_parameters>
     ```

     Where:

     * `queries`: List of query rules. All the rule parameters are optional: `privileges`, `query_owners`, `groups`, `users`, and `description`.

     * `privileges`: List of permitted actions with queries:
       * `VIEW`: View query information.
       * `KILL`: Cancel a query.
       * `EXECUTE`: Run a query.
        
       {% include notitle [queries-privileges](../../_includes/managed-trino/access-control-src.md#queries-privileges) %}

     * `query_owners`: List of query owner IDs. The rule will apply to queries whose owners are listed in `query_owners`. If not specified, the rule will apply to queries from all users.

     {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  1. View the description of the CLI command for creating a cluster:

     ```bash
     {{ yc-mdb-tr }} cluster create --help
     ```

  1. Run this command:

     ```bash
     {{ yc-mdb-tr }} cluster create \
       ...
       --access-control-from-file access_control.yaml
     ```

     For available cluster parameters and their descriptions, see [this guide](cluster-create.md#create-cluster).

- {{ TF }} {#tf}

  1. Create a {{ TF }} configuration file describing your [infrastructure](cluster-create.md).
  
  1. Add to the configuration file the `yandex_trino_access_control` resource containing the `queries` rule list.
 
     ```hcl
     resource "yandex_trino_cluster" "<cluster_name>" {
       ...
     }

     resource "yandex_trino_access_control" "trino_access_control" {
       ...
       cluster_id  = yandex_trino_cluster.<cluster_name>.id
       queries = [
         # Rule 1
         {
           privileges    = ["<list_of_privileges>"]
           query_owners  = ["<list_of_query_owners>"]
           users         = ["<list_of_user_IDs>"]
           groups        = ["<list_of_group_IDs>"]
           description   = "<rule_description>"
         },
         # Rule 2
         {
           ... 
         },
         ...
         # Rule N
         {
           ... 
         }
       ]
       ...
     }
     ```

     Where:

     * `queries`: List of rule sections for queries. All the rule parameters are optional: `privileges`, `query_owners`, `groups`, `users`, and `description`.

     * `privileges`: List of permitted actions with queries:
       * `VIEW`: View query information.
       * `KILL`: Cancel a query.
       * `EXECUTE`: Run a query.
        
       {% include notitle [queries-privileges](../../_includes/managed-trino/access-control-src.md#queries-privileges) %}

     * `query_owners`: List of query owner IDs. The rule will apply to queries whose owners are listed in `query_owners`. If not specified, the rule will apply to queries from all users.

     {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
 
  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mtr-access }}).

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        <cluster_parameters>
        ...
        "trino": {
          "access_control": {
            "queries": [
              {
                "privileges": [
                  "<list_of_privileges>"
                ],
                "query_owners": [
                  "<list_of_query_owners>"
                ],
                "users": [
                  "<list_of_user_IDs>"
                ],
                "groups": [
                  "<list_of_group_IDs>"
                ],
                "description": "<rule_description>"
              },
              {
                <Rule_2_section>
              },
              ...
              {
                <Rule_N_section>
              }
            ]
          }
        }
      }
      ```

      Where:

      * `access_control`: Access rule configuration in the cluster.

      * `queries`: List of rule sections for queries. All the rule parameters are optional: `privileges`, `query_owners`, `groups`, `users`, and `description`.

      * `privileges`: List of permitted actions with queries:
        * `VIEW`: View query information.
        * `KILL`: Cancel a query.
        * `EXECUTE`: Run a query.
        
        {% include notitle [queries-privileges](../../_includes/managed-trino/access-control-src.md#queries-privileges) %}

      * `query_owners`: List of query owner IDs. The rule will apply to queries whose owners are listed in `query_owners`. If not specified, the rule will apply to queries from all users.

      {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

      For available cluster parameters and their descriptions, see [this guide](cluster-create.md#create-cluster).

  1. Call the [ClusterService/Create](../api-ref/grpc/Cluster/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-trino }}:{{ port-https }} \
          yandex.cloud.trino.v1.ClusterService.Create \
          < body.json
      ```

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Setting rules for an existing cluster {#set-at-create}

You can set or update query access rules in an existing {{ mtr-name }} cluster.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set query access rules:

  1. If you have not set any access rules yet, create a file named `access_control.yaml` and paste the following code into it:

     ```yaml
     queries:
       # Rule 1
       - privileges: [<list_of_privileges>]
         query_owners: [<list_of_query_owners>]
         groups: [<list_of_group_IDs>]
         users: [<list_of_user_IDs>]
         description: <rule_description>
       # Rule 2
       - <Rule_2_parameters>
       ...
       # Rule N
       - <Rule_N_parameters>
     ```

     Where:

     * `queries`: List of query rules. All the rule parameters are optional: `privileges`, `query_owners`, `groups`, `users`, and `description`.

     * `privileges`: List of permitted actions with queries:
       * `VIEW`: View query information.
       * `KILL`: Cancel a query.
       * `EXECUTE`: Run a query.
        
       {% include notitle [queries-privileges](../../_includes/managed-trino/access-control-src.md#queries-privileges) %}

     * `query_owners`: List of query owner IDs. The rule will apply to queries whose owners are listed in `query_owners`. If not specified, the rule will apply to queries from all users.

     {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  1. If you have already set the access rules, open `access_control.yaml` and edit it as needed. You can:

     * Add new rules.
     * Update the existing ones.
     * Delete the rules you no longer need.

  1. Run this command:

     ```bash
     {{ yc-mdb-tr }} cluster set-access-control <cluster_name_or_ID> \
       --from-file access_control.yaml
     ```

     You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.
  
      To learn how to create this file, see [Creating a cluster](cluster-create.md).
  
  1. If you have not set the access rules yet, add the `yandex_trino_access_control` resource containing the `queries` rule list.

     ```hcl
     resource "yandex_trino_cluster" "<cluster_name>" {
       ...
     }

     resource "yandex_trino_access_control" "trino_access_control" {
       ...
       cluster_id  = yandex_trino_cluster.<cluster_name>.id
       queries = [
         # Rule 1
         {
           privileges    = ["<list_of_privileges>"]
           query_owners  = ["<list_of_query_owners>"]
           users         = ["<list_of_user_IDs>"]
           groups        = ["<list_of_group_IDs>"]
           description   = "<rule_description>"
         },
         # Rule 2
         {
           ... 
         },
         ...
         # Rule N
         {
           ... 
         }
       ]
       ...
     }
     ```

     Where:

     * `queries`: List of rule sections for queries. All the rule parameters are optional: `privileges`, `query_owners`, `groups`, `users`, and `description`.

     * `privileges`: List of permitted actions with queries:
       * `VIEW`: View query information.
       * `KILL`: Cancel a query.
       * `EXECUTE`: Run a query.
        
       {% include notitle [queries-privileges](../../_includes/managed-trino/access-control-src.md#queries-privileges) %}

     * `query_owners`: List of query owner IDs. The rule will apply to queries whose owners are listed in `query_owners`. If not specified, the rule will apply to queries from all users.

     {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  1. If you have already set the access rules, edit the `yandex_trino_access_control` resource description. You can:

     * Add new rules.
     * Update the existing ones.
     * Delete the rules you no longer need.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
 
  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mtr-access }}).

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. If you have not set any access rules yet, create a file named `body.json` and paste the following code into it:

      ```json
      {
        "cluster_id": "<cluster_ID>",
        "update_mask": {
          "paths": [
            "trino.access_control.queries"
          ]
        },
        "trino": {
          "access_control": {
            "queries": [
              {
                "privileges": [
                  "<list_of_privileges>"
                ],
                "query_owners": [
                  "<list_of_query_owners>"
                ],
                "users": [
                  "<list_of_user_IDs>"
                ],
                "groups": [
                  "<list_of_group_IDs>"
                ],
                "description": "<rule_description>"
              },
              {
                <Rule_2_section>
              },
              ...
              {
                <Rule_N_section>
              }
            ]
          }
        }
      }
      ```

      Where:

      * `cluster_id`: Cluster ID.
          
          You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

      * `update_mask`: List of parameters to update as an array of strings (`paths[]`).

          {% cut "Format for listing settings" %}

          ```yaml
          "update_mask": {
            "paths": [
              "<setting_1>",
              "<setting_2>",
              ...
              "<setting_N>"
            ]
          }
          ```

          {% endcut %}

          {% note warning %}

          When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

          {% endnote %}

      * `access_control`: Access rule configuration in the cluster.

      * `queries`: List of rule sections for queries. All the rule parameters are optional: `privileges`, `query_owners`, `groups`, `users`, and `description`.

      * `privileges`: List of permitted actions with queries:
        * `VIEW`: View query information.
        * `KILL`: Cancel a query.
        * `EXECUTE`: Run a query.
        
        {% include notitle [queries-privileges](../../_includes/managed-trino/access-control-src.md#queries-privileges) %}

      * `query_owners`: List of query owner IDs. The rule will apply to queries whose owners are listed in `query_owners`. If not specified, the rule will apply to queries from all users.

      {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  1. If you have already set the access rules, open the existing `body.json` rules file and edit it as needed. You can:

     * Add new rules.
     * Update the existing ones.
     * Delete the rules you no longer need.

  1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d @ \
        {{ api-host-trino }}:{{ port-https }} \
        yandex.cloud.trino.v1.ClusterService.Update \
        < body.json
      ```

  1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Example of setting query access rules {#example}

Let's configure query access rules as follows:
1. Allow any actions on queries to the user group with the `admins_group_id`.
1. Allow the user group with the `security_group_id` to view and delete queries owned by user with the `suspicious_user_id`.
1. Allow all other users to only run queries.

{% list tabs group=instructions %}

- CLI {#cli}

  The `access_control.yaml` file for this rule set is as follows:

  ```yaml
  queries:
    - groups:
        - admins_group_id
      privileges:
        - VIEW
        - KILL
        - EXECUTE

    - groups: 
        - security_group_id
      query_owners:
        - suspicious_user_id
      privileges:
        - VIEW
        - KILL

    - privileges:
        - EXECUTE
  ```

- {{ TF }} {#tf}

  The configuration file for this rule set is as follows:

  ```hcl
  resource "yandex_trino_access_control" "trino_access_control" {
    ...
    cluster_id  = <cluster_ID>
    queries = [
      {
        privileges    = ["VIEW", "KILL", "EXECUTE"]
        groups        = ["admins_group_id"]
      },
      {
        privileges    = ["VIEW", "KILL"]
        groups        = ["security_group_id"]
        query_owners  = ["suspicious_user_id"]
      },
      {
        privileges    = ["EXECUTE"]
      }
    ]
    ...
  }
  ```

- gRPC API {#grpc-api}

  The `body.json` file for this rule set is as follows:

  ```json
  {
    "cluster_id": "<cluster_ID>",
    "update_mask": {
      "paths": [
        "trino.access_control.queries"
      ]
    },
    "trino": {
      "access_control": {
        "queries": [
          {
            "privileges": [
              "VIEW",
              "KILL",
              "EXECUTE"              
            ],
            "groups": [
              "admins_group_id"
            ]
          },
          {
            "privileges": [
              "VIEW",
              "KILL"
            ],
            "query_owners": [
              "suspicious_user_id"
            ],
            "groups": [
              "security_group_id"
            ]
          },
          {
            "privileges": [
              "EXECUTE"
            ]
          }
        ]
      }
    }
  }
  ```

{% endlist %}
