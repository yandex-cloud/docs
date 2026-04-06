---
title: Assigning access rules for queries in {{ mtr-name }}
description: Rules define the actions users can perform with SQL queries.
---

# Assigning access rules for queries in {{ mtr-name }}

Query access rules define the actions users can perform with SQL queries in a {{ mtr-name }} cluster.

For each user-query pair, the rules apply as follows:
* Rules are checked for matches in the order they are specified in the configuration file. The first rule matching the user-query pair applies.
* If none of the rules match the user-query pair, no actions with the query are allowed to the user.
* If no query access rules are set, any user can perform any actions with any query.
* Query access rules apply together with the top-level [rules for catalog objects](./access-control-catalogs.md).

{% note warning %}

If there are no query access rules, users can view and cancel each other's queries.

{% endnote %}

## Setting rules when creating a cluster {#set-at-create}

You can set query access rules when creating a {{ mtr-name }} cluster.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ mtr-name }} cluster.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}** and set the cluster parameters.
  1. Under **{{ ui-key.yacloud.trino.section_rbac }}**, click ![image](../../_assets/console-icons/chevron-down.svg).
  1. In the **{{ ui-key.yacloud.trino.label_rbac-query }}** field, click **{{ ui-key.yacloud.trino.label_rbac-add-rule }}**.
  1. In the window that opens, set the rule settings:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. Optionally, in the **{{ ui-key.yacloud.trino.label_rbac-query-privileges }}** field, select permitted actions with the queries:
        * `VIEW`: View query information.
        * `KILL`: Cancel a query.
        * `EXECUTE`: Run a query.

        If you do not select any actions, the rule prohibits any actions with the queries.

        {% note warning %}

        You cannot create a rule with the `EXECUTE` action permitted if at least one user is selected in the **{{ ui-key.yacloud.trino.ClusterForm.label_query-owners_a81zm }}** field.

        {% endnote %}

     1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.label_query-owners_a81zm }}** field, select the users whose queries the rule applies to:
        1. Click **{{ ui-key.yacloud.trino.ClusterForm.button_add_1EfQa }}**.
        1. Select the users from the list that opens. Use the search bar above the list to find particular users.
        1. To deselect a user selected by mistake, click that user again in the list.

        I no user is selected in the **{{ ui-key.yacloud.trino.ClusterForm.label_query-owners_a81zm }}** field, the rule will apply to queries of all users.

  1. Add other rules in a similar way if required.
  1. To delete a rule added by mistake, click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.
  1. Click **{{ ui-key.yacloud.common.create }}**.

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
  
  1. Add the `yandex_trino_access_control` resource with the `queries` rule list to the configuration file.
 
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

  1. Validate your configuration.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
 
  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mtr-access }}).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        <cluster_parameters>
        ...
        "trino": {
          "accessControl": {
            "queries": [
              {
                "privileges": [
                  "<list_of_privileges>"
                ],
                "queryOwners": [
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

      * `accessControl`: Access rule configuration in the cluster.

      * `queries`: List of rule sections for queries. All the rule parameters are optional: `privileges`, `queryOwners`, `groups`, `users`, and `description`.

      * `privileges`: List of permitted actions with queries:
        * `VIEW`: View query information.
        * `KILL`: Cancel a query.
        * `EXECUTE`: Run a query.

        {% include notitle [queries-privileges-rest](../../_includes/managed-trino/access-control-src.md#queries-privileges-rest) %}

      * `queryOwners`: List of query owner IDs. The rule will apply to queries whose owners are listed in `queryOwners`. If not specified, the rule will apply to queries from all users.

      {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

      For available cluster parameters and their descriptions, see [this guide](cluster-create.md#create-cluster).

  1. Call the [Cluster.Create](../api-ref/Cluster/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters'
          --data '@body.json'
      ```

  1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

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

## Setting rules for an existing cluster {#set-at-update}

You can set or update query access rules in an existing {{ mtr-name }} cluster.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the cluster name.
  1. Go to **{{ ui-key.yacloud.trino.ClusterView.RBACView.label_rbac-settings_o2F64 }}** → **{{ ui-key.yacloud.trino.label_rbac-query }}**.
  1. To add a rule, click **{{ ui-key.yacloud.trino.label_rbac-add-rule }}**. In the window that opens, set the rule settings:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. Optionally, in the **{{ ui-key.yacloud.trino.label_rbac-query-privileges }}** field, select permitted actions with the queries:
        * `VIEW`: View query information.
        * `KILL`: Cancel a query.
        * `EXECUTE`: Run a query.

        If you do not select any actions, the rule prohibits any actions with the queries.

        {% note warning %}

        You cannot create a rule with the `EXECUTE` action permitted if at least one user is selected in the **{{ ui-key.yacloud.trino.ClusterForm.label_query-owners_a81zm }}** field.

        {% endnote %}

     1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.label_query-owners_a81zm }}** field, select the users whose queries the rule applies to:
        1. Click **{{ ui-key.yacloud.trino.ClusterForm.button_add_1EfQa }}**.
        1. Select the users from the list that opens. Use the search bar above the list to find particular users.
        1. To deselect a user selected by mistake, click that user again in the list.

        I no user is selected in the **{{ ui-key.yacloud.trino.ClusterForm.label_query-owners_a81zm }}** field, the rule will apply to queries of all users.

  1. Add other rules in a similar way if required.
  1. To edit a rule:
     1. Click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.
     1. Update the rule settings and click **{{ ui-key.yacloud.common.update }}**.
  1. To delete a rule you no longer need, Click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.
  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set query access rules:

  1. If you have not set any access rules yet, create a file named `access_control.yaml` and paste the following into it:

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
  
      For more on how to create this file, see [Creating a cluster](cluster-create.md).
  
  1. If you have not set any access rules yet, add the `yandex_trino_access_control` resource containing the `queries` rule list.

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

  1. Validate your configuration.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
 
  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mtr-access }}).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. If you have not set any access rules yet, create a file named `body.json` and paste the following code into it:

      ```json
      {
        "updateMask": "trino.accessControl.queries",
        "trino": {
          "accessControl": {
            "queries": [
              {
                "privileges": [
                  "<list_of_privileges>"
                ],
                "queryOwners": [
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

      * `updateMask`: Comma-separated list of parameters to update.

          {% note warning %}

          When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

          {% endnote %}

      * `accessControl`: Access rule configuration in the cluster.

      * `queries`: List of rule sections for queries. All the rule parameters are optional: `privileges`, `queryOwners`, `groups`, `users`, and `description`.

      * `privileges`: List of permitted actions with queries:
        * `VIEW`: View query information.
        * `KILL`: Cancel a query.
        * `EXECUTE`: Run a query.

        {% include notitle [queries-privileges-rest](../../_includes/managed-trino/access-control-src.md#queries-privileges-rest) %}

      * `queryOwners`: List of query owner IDs. The rule will apply to queries whose owners are listed in `queryOwners`. If not specified, the rule will apply to queries from all users.

      {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  1. If you have already set the access rules, open `body.json` with these rules and edit it as needed. You can:

     * Add new rules.
     * Update the existing ones.
     * Delete the rules you no longer need.

  1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>'
        --data '@body.json'
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

  1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

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

  1. If you have already set the access rules, open `body.json` with these rules and edit it as needed. You can:

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

- REST API {#api}

  The `body.json` file for this rule set is as follows:

  ```json
  {
    "updateMask": "trino.accessControl.queries",
    "trino": {
      "accessControl": {
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
            "queryOwners": [
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
