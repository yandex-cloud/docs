---
title: Assigning access rules for catalog objects in {{ mtr-name }}
description: Rules define the top-level user access to catalog objects, such as schemas and tables, within a {{ mtr-name }} cluster.
---

# Assigning access rules for catalog objects in {{ mtr-name }}

Catalog object access rules enable you to restrict user access to all objects in one or more catalogs within a {{ mtr-name }} cluster. To manage access to individual cluster objects, use more granular rules, e.g., access rules for [schemas](./access-control-schemas.md) or [tables](./access-control-tables.md).

For each user-object pair, the access rules apply as follows:
* Rules are checked for matches in the order they are listed in the configuration file. The first rule matching the user-object pair applies.
* If none of the rules match the user-object pair, access is denied.
* If no rules are defined for catalogs, user access to catalog objects is controlled by more granular rules, e.g., table rules.

## Setting rules when creating a cluster {#set-at-create}

You can set access rules for catalog objects when creating a {{ mtr-name }} cluster.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ mtr-name }} cluster.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}** and set the cluster parameters.
  1. Under **{{ ui-key.yacloud.trino.section_rbac }}**, click ![image](../../_assets/console-icons/chevron-down.svg).
  1. In the **{{ ui-key.yacloud.trino.label_rbac-catalog }}** field, click **{{ ui-key.yacloud.trino.label_rbac-add-rule }}**.
  1. In the window that opens, set the rule settings:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. In the **{{ ui-key.yacloud.trino.label_rbac-catalog-permissions }}** field, select the access level for folder objects:
        * `NONE`: All operations on catalog objects are prohibited.
        * `ALL`: All operations are allowed. In which case user access to catalog objects is controlled by more granular rules, e.g., table rules.
        * `READ_ONLY`: Only read operations are allowed, e.g., reading data from a table.

     1. {% include [calatogs-description-console](../../_includes/managed-trino/calatogs-description-console.md) %}

  1. Add other rules in a similar way if required.
  1. To delete a rule added by mistake, click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set access rules for catalog objects:

  1. Create a file named `access_control.yaml` and paste the following code into it:

     ```yaml
     catalogs:
       # Rule 1
       - permission: <access_level>
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

     * `catalogs`: List of catalog rules. Each rule contains the required `permission` parameter as well as optional parameters: `catalog`, `groups`, `users`, and `description`.

     * `permission`: User or group access level to catalogs assigned by the rule:
       * `NONE`: All operations on catalog objects are prohibited.
       * `READ_ONLY`: Only read operations are allowed, e.g., reading data from a table.
       * `ALL`: All operations are allowed. In which case user access to catalog objects is controlled by more granular rules, e.g., table rules.

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
  
  1. Add the `yandex_trino_access_control` resource with the `catalogs` rule list to the configuration file.
 
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
       catalogs = [
         # Rule 1
         {
           permission    = "<access_level>"
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

     * `catalogs`: List of catalog rule sections. Each rule contains the required `permission` parameter as well as optional parameters: `catalog`, `groups`, `users`, and `description`.

     * `permission`: User or group access level to catalogs assigned by the rule:
       * `NONE`: All operations on catalog objects are prohibited.
       * `READ_ONLY`: Only read operations are allowed, e.g., reading data from a table.
       * `ALL`: All operations are allowed. In which case user access to catalog objects is controlled by more granular rules, e.g., table rules.

     * `catalog`: Catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
       * `ids`: List of catalog IDs. These catalogs must be created in the same manifest.
       * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

       You can specify either `ids` or `name_regexp` but not both.

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
          "accessControl": {
            "catalogs": [
              {
                "permission": "<access_level>",
                "catalog": {
                  "names": {
                    "any": [
                      "<catalog_1_name>",
                      "<catalog_2_name>",
                      ...
                      "<catalog_N_name>"
                    ]
                  },
                  "nameRegexp": "<regular_expression>"
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

      * `accessControl`: Access rule configuration in the cluster.

      * `catalogs`: List of catalog rule sections. Each rule contains the required `permission` parameter as well as optional parameters: `catalog`, `groups`, `users`, and `description`.

      * `permission`: User or group access level to catalogs assigned by the rule:
        * `NONE`: All operations on catalog objects are prohibited.
        * `READ_ONLY`: Only read operations are allowed, e.g., reading data from a table.
        * `ALL`: All operations are allowed. In which case user access to catalog objects is controlled by more granular rules, e.g., table rules.

      * `catalog`: Catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
        * `names`: List of catalog names. You must create catalogs within the same [Cluster.Create](../api-ref/Cluster/create.md) call.
        * `nameRegexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

        The `catalog` section must contain either the nested `names` section or the `nameRegexp` parameter.

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
            "catalogs": [
              {
                "permission": "<access_level>",
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

      * `catalogs`: List of catalog rule sections. Each rule contains the required `permission` parameter as well as optional parameters: `catalog`, `groups`, `users`, and `description`.

      * `permission`: User or group access level to catalogs assigned by the rule:
        * `NONE`: All operations on catalog objects are prohibited.
        * `READ_ONLY`: Only read operations are allowed, e.g., reading data from a table.
        * `ALL`: All operations are allowed. In which case user access to catalog objects is controlled by more granular rules, e.g., table rules.

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

## Setting rules for an existing cluster {#set-at-update}

You can set or update access rules for catalog objects in an existing {{ mtr-name }} cluster.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the cluster name.
  1. Go to **{{ ui-key.yacloud.trino.ClusterView.RBACView.label_rbac-settings_o2F64 }}** → **{{ ui-key.yacloud.trino.label_rbac-catalog }}**.
  1. To add a rule, click **{{ ui-key.yacloud.trino.label_rbac-add-rule }}**. In the window that opens, set the rule settings:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. In the **{{ ui-key.yacloud.trino.label_rbac-catalog-permissions }}** field, select the access level for folder objects:
        * `NONE`: All operations on catalog objects are prohibited.
        * `ALL`: All operations are allowed. In which case user access to catalog objects is controlled by more granular rules, e.g., table rules.
        * `READ_ONLY`: Only read operations are allowed, e.g., reading data from a table.

     1. {% include [calatogs-description-ID-console](../../_includes/managed-trino/calatogs-description-ID-console.md) %}

  1. Add other rules in a similar way if required.
  1. To edit a rule:
     1. Click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.
     1. Update the rule settings and click **{{ ui-key.yacloud.common.update }}**.
  1. To delete a rule you no longer need, Click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.
  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set access rules for catalog objects:

  1. If you have not set any access rules yet, create a file named `access_control.yaml` and paste the following into it:

     ```yaml
     catalogs:
       # Rule 1
       - permission: <access_level>
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

     * `catalogs`: List of catalog rules. Each rule contains the required `permission` parameter as well as optional parameters: `catalog`, `groups`, `users`, and `description`.

     * `permission`: User or group access level to catalogs assigned by the rule:
       * `NONE`: All operations on catalog objects are prohibited.
       * `READ_ONLY`: Only read operations are allowed, e.g., reading data from a table.
       * `ALL`: All operations are allowed. In which case user access to catalog objects is controlled by more granular rules, e.g., table rules.

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
  
      For more on how to create this file, see [Creating a cluster](cluster-create.md).
  
  1. If you have not set any access rules yet, add the `yandex_trino_access_control` resource containing the `catalogs` rule list.
 
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
       catalogs = [
         # Rule 1
         {
           permission    = "<access_level>"
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

     * `catalogs`: List of catalog rule sections. Each rule contains the required `permission` parameter as well as optional parameters: `catalog`, `groups`, `users`, and `description`.

     * `permission`: User or group access level to catalogs assigned by the rule:
       * `NONE`: All operations on catalog objects are prohibited.
       * `READ_ONLY`: Only read operations are allowed, e.g., reading data from a table.
       * `ALL`: All operations are allowed. In which case user access to catalog objects is controlled by more granular rules, e.g., table rules.

     * `catalog`: Catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
       * `ids`: List of catalog IDs. These must exist or be created in the same manifest.
       * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

       You can specify either `ids` or `name_regexp` but not both.

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
        "updateMask": "trino.accessControl.catalogs",
        "trino": {
          "accessControl": {
            "catalogs": [
              {
                "permission": "<access_level>",
                "catalog": {
                  "nameRegexp": "<regular_expression>",
                  "ids": {
                    "any": [
                      "<list_of_catalog_IDs>"
                    ]
                  },
                  "names": {
                    "any": [
                      "<list_of_catalog_names>"
                    ]
                  }
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

      * `updateMask`: Comma-separated list of parameters to update.

          {% note warning %}

          When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

          {% endnote %}

      * `accessControl`: Access rule configuration in the cluster.

      * `catalogs`: List of catalog rule sections. Each rule contains the required `permission` parameter as well as optional parameters: `catalog`, `groups`, `users`, and `description`.

      * `permission`: User or group access level to catalogs assigned by the rule:
        * `NONE`: All operations on catalog objects are prohibited.
        * `READ_ONLY`: Only read operations are allowed, e.g., reading data from a table.
        * `ALL`: All operations are allowed. In which case user access to catalog objects is controlled by more granular rules, e.g., table rules.

      * `catalog`: Catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
        * `ids`: List of catalog IDs. These must be the existing catalogs.
        * `names`: List of catalog names. These must be the existing catalogs.
        * `nameRegexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

        The `catalog` section must contain either one of the nested `ids` and `names` sections or the `nameRegexp` parameter.

      {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  1. If you have already set the access rules, open the existing `body.json` rules file and edit it as needed. You can:

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
            "trino.access_control.catalogs"
          ]
        },
        "trino": {
          "access_control": {
            "catalogs": [
              {
                "permission": "<access_level>",
                "catalog": {
                  "name_regexp": "<regular_expression>",
                  "ids": {
                    "any": [
                      "<list_of_catalog_IDs>"
                    ]
                  },
                  "names": {
                    "any": [
                      "<list_of_catalog_names>"
                    ]
                  }
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

      * `catalogs`: List of catalog rule sections. Each rule contains the required `permission` parameter as well as optional parameters: `catalog`, `groups`, `users`, and `description`.

      * `permission`: User or group access level to catalogs assigned by the rule:
        * `NONE`: All operations on catalog objects are prohibited.
        * `READ_ONLY`: Only read operations are allowed, e.g., reading data from a table.
        * `ALL`: All operations are allowed. In which case user access to catalog objects is controlled by more granular rules, e.g., table rules.

      * `catalog`: Catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
        * `ids`: List of catalog IDs. These must be the existing catalogs.
        * `names`: List of catalog names. These must be the existing catalogs.
        * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

        The `catalog` section must contain either one of the nested `ids` and `names` sections or the `name_regexp` parameter.

      {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  1. If you have already set the rules, open the relevant `body.json` file and edit it as needed. You can:

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

## Example of setting access rules for catalog objects {#example}

Let's configure access rules for objects in {{ TR }} cluster catalogs:
1. Deny any actions on objects in all cluster catalogs to users from the group with the `banned_group_id`.
1. Allow all operations with objects in catalogs with the `cat1_id` and `cat2_id` to users with the `user1_id` and `user2_id` if they belong to the group with the `analytics_group_id`.
1. Allow all users to read objects in catalogs with names that match the `.*_prod` regular expression.

{% list tabs group=instructions %}

- CLI {#cli}

  The `access_control.yaml` file for this rule set is as follows:

  ```yaml
  catalogs:
    - permission: NONE
      groups:
        - banned_group_id

    - permission: ALL
      catalog:
        ids:
          any:
            - cat1_id
            - cat2_id
      groups:
        - analytics_group_id
      users:
        - user1_id
        - user2_id

    - permission: READ_ONLY
      catalog:
        name_regexp: ".*_prod"
  ```

- {{ TF }} {#tf}

  The configuration file for this rule set is as follows:

  ```hcl
  resource "yandex_trino_access_control" "trino_access_control" {
    ...
    cluster_id  = <cluster_ID>
    catalogs = [
      {
        permission    = "NONE"
        groups        = ["banned_group_id"]
      },
      {
        permission    = "ALL"
        catalog       = {
          ids         = ["cat1_id", "cat2_id"]
        }
        users         = ["user1_id", "user2_id"]
        groups        = ["analytics_group_id"]
      },
      {
        permission    = "READ_ONLY"
        catalog       = {
          name_regexp = ".*_prod"
        }
      }
    ]
    ...
  }
  ```

- REST API {#api}

  The `body.json` file for this rule set is as follows:

  ```json
  {
    "updateMask": "trino.accessControl.catalogs",
    "trino": {
      "accessControl": {
        "catalogs": [
          {
            "permission": "NONE",
            "groups": [
              "banned_group_id"
            ]
          },
          {
            "permission": "ALL",
            "catalog": {
              "ids": {
                "any": [
                  "cat1_id",
                  "cat2_id"
                ]
              }
            },
            "users": [
              "user1_id",
              "user2_id"
            ],
            "groups": [
              "analytics_group_id"
            ]
          },
          {
            "permission": "READ_ONLY",
            "catalog": {
              "nameRegexp": ".*_prod"
            }
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
        "trino.access_control.catalogs"
      ]
    },
    "trino": {
      "access_control": {
        "catalogs": [
          {
            "permission": "NONE",
            "groups": [
              "banned_group_id"
            ]
          },
          {
            "permission": "ALL",
            "catalog": {
              "ids": {
                "any": [
                  "cat1_id",
                  "cat2_id"
                ]
              }
            },
            "users": [
              "user1_id",
              "user2_id"
            ],
            "groups": [
              "analytics_group_id"
            ]
          },
          {
            "permission": "READ_ONLY",
            "catalog": {
              "name_regexp": ".*_prod"
            }
          }
        ]
      }
    }
  }
  ```

{% endlist %}
