---
title: Assigning access rules for schemas in {{ mtr-name }}
description: These rules decide which users own which schemas.
---

# Assigning access rules for schemas in {{ mtr-name }}

Schema access rules decide which users own which schemas in a {{ mtr-name }} cluster.

{% note info %}

The schema owner can create, update, or delete the schema. To do this, the owner needs the `ALL` access level for the catalog that contains the schema.

{% endnote %}

For each user-schema pair, the rules apply as follows:
* Rules are checked for matches in the order they are specified in the configuration file. The first rule matching the user-schema pair applies.
* If none of the rules match the user-schema pair, the user is not the schema owner.
* If no schema access rules are set, each user owns all schemas in all catalogs.

## Setting rules when creating a cluster {#set-at-create}

You can set schema access rules when creating a {{ mtr-name }} cluster.

{% note warning %}
  
Schema names specified in the rules are not validated. If a schema name contains an error, the rule will not apply correctly.
  
{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set schema access rules:

  1. Create a file named `access_control.yaml` and paste the following code into it:

     ```yaml
     schemas:
       # Rule 1
       - owner: <whether_or_not_user_owns_schema>
         schema:
           names:
             any: [<list_of_schema_names>]
           name_regexp: <regular_expression>
         catalog:
           name_regexp: <regular_expression>
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

     * `schemas`: List of schema rules. Each rule contains the required `owner` parameter, as well as the optional `schema`, `catalog`, `groups`, `users`, and `description` parameters.

     * `owner`: Whether or not the user owns the schema:
       * `YES`: This user owns the schema.
       * `NO`: This user does not own the schema.

     * `schema`: Schemas the rule applies to. If you do not specify `schema`, the rule applies to all schemas.
       * `names`: List of schema names.
       * `name_regexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.

       You can specify either `names` or `name_regexp` but not both.

     * `catalog`: Cluster catalogs the rule applies to. If you do not specify `catalog`, the rule applies to all cluster catalogs.
       * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

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
  
  1. Add to the configuration file the `yandex_trino_access_control` resource containing the `schemas` rule list.
 
     ```hcl
     resource "yandex_trino_cluster" "<cluster_name>" {
       ...
     }

     resource "yandex_trino_catalog" "<catalog_1_name>" {
       ...
     }

     resource "yandex_trino_catalog" "<catalog_2_name>" {
       ...
     }

     ...

     resource "yandex_trino_catalog" "<catalog_N_name>" {
       ...
     }

     resource "yandex_trino_access_control" "trino_access_control" {
       ...
       cluster_id  = yandex_trino_cluster.<cluster_name>.id
       schemas = [
         # Rule 1
         {
           owner         = "<whether_or_not_user_owns_schema>"
           schema        = {
             names       = ["<list_of_schema_names>"]
             name_regexp = "<regular_expression>"
           }
           catalog       = {
             ids         = [
               yandex_trino_catalog.<catalog_1_name>.id,
               yandex_trino_catalog.<catalog_2_name>.id,
               ... 
               yandex_trino_catalog.<catalog_N_name>.id
             ]
             name_regexp = "<regular_expression>"
           }
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

     * `schemas`: List of schema rule sections. Each rule contains the required `owner` parameter, as well as the optional `schema`, `catalog`, `groups`, `users`, and `description` parameters.

     * `owner`: Whether or not the user owns the schema:
       * `YES`: This user owns the schema.
       * `NO`: This user does not own the schema.

     * `schema`: Schemas the rule applies to. If the `schema` section is not specified, the rule applies to all schemas.
       * `names`: List of schema names.
       * `name_regexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.

       You can specify either `names` or `name_regexp` but not both.

     * `catalog`: Catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
       * `ids`: List of catalog IDs. These catalogs must be created in the same manifest.
       * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

       You can specify either `ids` or `name_regexp` but not both.

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
          "catalogs": [
            {
              "name": "catalog_1_name",
              ...
            },
            {
              "name": "catalog_2_name",
              ...
            },
            ...
            {
              "name": "catalog_N_name",
              ...
            }
          ]
          ...
          "access_control": {
            "schemas": [
              {
                "owner": "<whether_or_not_user_owns_schema>",
                "schema": {
                  "names": {
                    "any": [
                      "<list_of_schema_names>"
                    ]
                  },
                  "name_regexp": "<regular_expression>"
                },
                "catalog": {
                  "names": {
                    "any": [
                      "<catalog_1_name>",
                      "<catalog_2_name>",
                      ...
                      "<catalog_N_name>"
                    ]
                  },
                  "name_regexp": "<regular_expression>"
                },
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

      * `schemas`: List of schema rule sections. Each rule contains the required `owner` parameter, as well as the optional `schema`, `catalog`, `groups`, `users`, and `description` parameters.

      * `owner`: Whether or not the user owns the schema:
        * `YES`: This user owns the schema.
        * `NO`: This user does not own the schema.

      * `schema`: Schemas the rule applies to. If the `schema` section is not specified, the rule applies to all schemas.
        * `names`: List of schema names.
        * `name_regexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.

        The `schema` section must contain either the nested `names` section or the `name_regexp` parameter.

      * `catalog`: Catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
        * `names`: List of catalog names. You must create catalogs within the same [ClusterService/Create](../api-ref/grpc/Cluster/create.md) call.
        * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

        The `catalog` section must contain either the nested `names` section or the `name_regexp` parameter.

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

You can set or update schema access rules for an existing {{ mtr-name }} cluster.

{% note warning %}
  
Schema names specified in the rules are not validated. If a schema name contains an error, the rule will not apply correctly.
  
{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set schema access rules:

  1. If you have not set any access rules yet, create a file named `access_control.yaml` and paste the following code into it:

     ```yaml
     schemas:
       # Rule 1
       - owner: <whether_or_not_user_owns_schema>
         schema:
           names:
             any: [<list_of_schema_names>]
           name_regexp: <regular_expression>
         catalog:
           ids:
             any: [<list_of_catalog_IDs>]
           names:
             any: [<list_of_catalog_names>]
           name_regexp: <regular_expression>
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

     * `schemas`: List of schema rules. Each rule contains the required `owner` parameter, as well as the optional `schema`, `catalog`, `groups`, `users`, and `description` parameters.

     * `owner`: Whether or not the user owns the schema:
       * `YES`: This user owns the schema.
       * `NO`: This user does not own the schema.

     * `schema`: Schemas the rule applies to. If you do not specify `schema`, the rule applies to all schemas.
       * `names`: List of schema names.
       * `name_regexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.
 
       You can specify either `names` or `name_regexp` but not both.

     * `catalog`: Catalogs the rule applies to. If you do not specify `catalog`, the rule applies to all cluster catalogs.
       * `ids`: List of catalog IDs. These must be the existing catalogs.
       * `names`: List of catalog names. These must be the existing catalogs.
       * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

       You can specify only one of the following: `ids`, `names`, or `name_regexp`.

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
  
  1. If you have not set any access rules yet, add the `yandex_trino_access_control` resource containing the `schemas` rule list.
 
     ```hcl
     resource "yandex_trino_cluster" "<cluster_name>" {
       ...
     }

     resource "yandex_trino_catalog" "<catalog_1_name>" {
       ...
     }

     resource "yandex_trino_catalog" "<catalog_2_name>" {
       ...
     }

     ...

     resource "yandex_trino_catalog" "<catalog_N_name>" {
       ...
     }

     resource "yandex_trino_access_control" "trino_access_control" {
       ...
       cluster_id  = yandex_trino_cluster.<cluster_name>.id
       schemas = [
         # Rule 1
         {
           owner         = "<whether_or_not_user_owns_schema>"
           schema        = {
             names       = ["<list_of_schema_names>"]
             name_regexp = "<regular_expression>"
           }
           catalog       = {
             ids         = [
               yandex_trino_catalog.<catalog_1_name>.id,
               yandex_trino_catalog.<catalog_2_name>.id,
               ... 
               yandex_trino_catalog.<catalog_N_name>.id
             ]
             name_regexp = "<regular_expression>"
           }
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

     * `schemas`: List of schema rule sections. Each rule contains the required `owner` parameter, as well as the optional `schema`, `catalog`, `groups`, `users`, and `description` parameters.

     * `owner`: Whether or not the user owns the schema:
       * `YES`: This user owns the schema.
       * `NO`: This user does not own the schema.

     * `schema`: Schemas the rule applies to. If the `schema` section is not specified, the rule applies to all schemas.
       * `names`: List of schema names.
       * `name_regexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.

       You can specify either `names` or `name_regexp` but not both.

     * `catalog`: Catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
       * `ids`: List of catalog IDs. These must exist or be created in the same manifest.
       * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

       You can specify either `ids` or `name_regexp` but not both.

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
            "trino.access_control.schemas"
          ]
        },
        "trino": {
          "access_control": {
            "schemas": [
              {
                "owner": "<whether_or_not_user_owns_schema>",
                "schema": {
                  "names": {
                    "any": [
                      "<list_of_schema_names>"
                    ]
                  },
                  "name_regexp": "<regular_expression>"
                },
                "catalog": {
                  "ids": {
                    "any": [
                      "<list_of_catalog_IDs>"
                    ]
                  },
                  "names": {
                    "any": [
                      "<list_of_catalog_names>"
                    ]
                  },
                  "name_regexp": "<regular_expression>"
                },
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

      * `schemas`: List of schema rule sections. Each rule contains the required `owner` parameter, as well as the optional `schema`, `catalog`, `groups`, `users`, and `description` parameters.

      * `owner`: Whether or not the user owns the schema:
        * `YES`: This user owns the schema.
        * `NO`: This user does not own the schema.

      * `schema`: Schemas the rule applies to. If the `schema` section is not specified, the rule applies to all cluster schemas.
        * `names`: List of schema names.
        * `name_regexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.

        The `schema` section must contain either the nested `names` section or the `name_regexp` parameter.

      * `catalog`: Catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
        * `ids`: List of catalog IDs. These must be the existing catalogs.
        * `names`: List of catalog names. These must be the existing catalogs.
        * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

        The `catalog` section must contain either one of the nested `ids` or `names` sections, or the `name_regexp` parameter.

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

## Example of setting schema access rules {#example}

Let's assume you need to specify schema owners in a {{ TR }} cluster as shown below:
1. The user with the `banned_user_id` ID does not own any schemas.
1. Users belonging to the groups whose IDs are `data_engineering_group_id` or `admins_group_id` own the `b2b` and `b2c` schemas in catalogs with the naming pattern of `dwh_.*`.
1. All other users do not own any schemas.

{% list tabs group=instructions %}

- CLI {#cli}

  The `access_control.yaml` file for this rule set is as follows:

  ```yaml
  schemas:
    - users:
        - banned_user_id
      owner: NO

    - groups:
        - data_engineering_group_id
        - admins_group_id
      schema:
        names:
          any:
            - b2b
            - b2c
      catalog:
        name_regexp: "dwh_.*"
      owner: YES
  ```

- {{ TF }} {#tf}

  The configuration file for this rule set is as follows:

  ```hcl
  resource "yandex_trino_access_control" "trino_access_control" {
    ...
    cluster_id  = <cluster_ID>
    schemas = [
      {
        users         = ["banned_user_id"]
        owner         = "NO"
      },
      {
        groups        = ["data_engineering_group_id", "admins_group_id"]
        schema        = {
          names       = ["b2b", "b2c"]
        }        
        catalog       = {
          name_regexp = "dwh_.*"
        }
        owner         = "YES"
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
        "trino.access_control.schemas"
      ]
    },
    "trino": {
      "access_control": {
        "schemas": [
          {
            "users": [
              "banned_user_id"
            ],
            "owner": "NO"
          },
          {
            "groups": [
              "data_engineering_group_id",
              "admins_group_id"
            ],
            "schema": {
              "names": {
                "any": [
                  "b2b",
                  "b2c"
                ]
              }
            },
            "catalog": {
              "name_regexp": "dwh_.*"
            },
            "owner": "YES"
          }
        ]
      }
    }
  }
  ```

{% endlist %}
