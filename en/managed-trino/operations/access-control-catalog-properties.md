---
title: Assigning access rules for catalog session properties in {{ mtr-name }}
description: Rules define whether users can set certain catalog session properties.
---

# Assigning access rules for catalog session properties in {{ mtr-name }}

Access rules for catalog session propertires define whether users can set certain catalog session properties in a {{ mtr-name }} cluster.

{% note warning %}

Set rules for catalog session properties to limit user consumption of system resources.

{% endnote %}

For each user-property pair, the rules apply as follows:
* Rules are checked for matches in the order they are specified in the configuration file. The first rule matching the user-property pair applies.
* If none of the rules match the user-property pair, the user is not allowed to set that property.
* If no rules are specified for session properties, any user can set any session properties for all catalogs.
* Property access rules apply together with the top-level [rules for objects in catalogs](./access-control-catalogs.md).

## Setting rules when creating a cluster {#set-at-create}

You can set access rules for catalog session properties when creating a {{ mtr-name }} cluster.

{% note warning %}
  
Property names specified in the rules are not validated. If a property name contains an error, the rule will not apply correctly.
  
{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ mtr-name }} cluster.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}** and set the cluster parameters.
  1. Under **{{ ui-key.yacloud.trino.section_rbac }}**, click ![image](../../_assets/console-icons/chevron-down.svg).
  1. In the **{{ ui-key.yacloud.trino.ClusterForm.label_catalog-session-property_9XoJs }}** field, click **{{ ui-key.yacloud.trino.label_rbac-add-rule }}**.
  1. In the window that opens, set the rule settings:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. In the **{{ ui-key.yacloud.trino.ClusterForm.label_allow_4botu }}** field, specify whether the user is allowed to set the property:
        * `No`: Not allowed.
        * `Yes`: Allowed.

     1. {% include [calatogs-description-console](../../_includes/managed-trino/calatogs-description-console.md) %}

     1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.label_session-property_cyTHR }}** field, specify the properties the rule applies to:
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name }}**: Select property names.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name-regexp }}**: Enter a regular expression. The rule applies to the properties whose names match the regular expression.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-empty }}**: The rule applies to all properties.

  1. Add other rules in a similar way if required.
  1. To delete a rule added by mistake, click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set access rules:

  1. Create a file named `access_control.yaml` and paste the following code into it:

     ```yaml
     catalog_session_properties:
       # Rule 1
       - allow: <permission_to_set_property>
         property:
           names:
             any: [<list_of_property_names>]
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

     * `catalog_session_properties`: List of rules for catalog session properties. Each rule contains the required `allow` parameter, as well as the optional `property`, `catalog`, `groups`, `users`, and `description` parameters.

     * `allow`: Permission to set a property:
       * `YES`: User is allowed to set the property.
       * `NO`: User is not allowed to set the property.

     * `property`: Properties the rule applies to. If you do not specify `property`, the rule applies to all properties.
       * `names`: List of property names.
       * `name_regexp`: Regular expression. The rule applies to the properties whose names match the regular expression.

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
  
  1. Add the `yandex_trino_access_control` resource with the `catalog_session_properties` rule list to the configuration file.
 
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
       catalog_session_properties = [
         # Rule 1
         {
           allow         = "<permission_to_set_property>"
           property      = {
             names       = ["<list_of_property_names>"]
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

     * `catalog_session_properties`: List of rule sections for catalog session properties. Each rule contains the required `allow` parameter, as well as the optional `property`, `catalog`, `groups`, `users`, and `description` parameters.

     * `allow`: Permission to set a property:
       * `YES`: User is allowed to set the property.
       * `NO`: User is not allowed to set the property.

     * `property`: Properties the rule applies to. If the `property` section is not specified, the rule applies to all properties.
       * `names`: List of property names.
       * `name_regexp`: Regular expression. The rule applies to the properties whose names match the regular expression.

       You can specify either `names` or `name_regexp` but not both.

     * `catalog`: Cluster catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
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
            "catalogSessionProperties": [
              {
                "allow": "<permission_to_set_property>",
                "property": {
                  "names": {
                    "any": [
                      "<list_of_property_names>"
                    ]
                  },
                  "nameRegexp": "<regular_expression>"
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

      * `catalogSessionProperties`: List of rule sections for catalog session properties. Each rule contains the required `allow` parameter, as well as the optional `property`, `catalog`, `groups`, `users`, and `description` parameters.

      * `allow`: Permission to set a property:
        * `YES`: User is allowed to set the property.
        * `NO`: User is not allowed to set the property.

      * `property`: Properties the rule applies to. If the `property` section is not specified, the rule applies to all properties.
        * `names`: List of property names.
        * `nameRegexp`: Regular expression. The rule applies to the properties whose names match the regular expression.

        The `property` section must contain either the nested `names` section or the `nameRegexp` parameter.

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
            "catalog_session_properties": [
              {
                "allow": "<permission_to_set_property>",
                "property": {
                  "names": {
                    "any": [
                      "<list_of_property_names>"
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

      * `catalog_session_properties`: List of rule sections for catalog session properties. Each rule contains the required `allow` parameter, as well as the optional `property`, `catalog`, `groups`, `users`, and `description` parameters.

      * `allow`: Permission to set a property:
        * `YES`: User is allowed to set the property.
        * `NO`: User is not allowed to set the property.

      * `property`: Properties the rule applies to. If the `property` section is not specified, the rule applies to all properties.
        * `names`: List of property names.
        * `name_regexp`: Regular expression. The rule applies to the properties whose names match the regular expression.

        The `property` section must contain either the nested `names` section or the `name_regexp` parameter.

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

You can set or update access rules for catalog session properties in an existing {{ mtr-name }} cluster.

{% note warning %}
  
Property names specified in the rules are not validated. If a property name contains an error, the rule will not apply correctly.
  
{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the cluster name.
  1. Go to **{{ ui-key.yacloud.trino.ClusterView.RBACView.label_rbac-settings_o2F64 }}** → **{{ ui-key.yacloud.trino.ClusterForm.label_catalog-session-property_9XoJs }}**.
  1. To add a rule, click **{{ ui-key.yacloud.trino.label_rbac-add-rule }}**. In the window that opens, set the rule settings:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. In the **{{ ui-key.yacloud.trino.ClusterForm.label_allow_4botu }}** field, specify whether the user is allowed to set the property:
        * `No`: Not allowed.
        * `Yes`: Allowed.

     1. {% include [calatogs-description-ID-console](../../_includes/managed-trino/calatogs-description-ID-console.md) %}

     1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.label_session-property_cyTHR }}** field, specify the properties the rule applies to:
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name }}**: Select property names.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name-regexp }}**: Enter a regular expression. The rule applies to the properties whose names match the regular expression.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-empty }}**: The rule applies to all properties.

  1. Add other rules in a similar way if required.
  1. To edit a rule:
     1. Click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.
     1. Update the rule settings and click **{{ ui-key.yacloud.common.update }}**.
  1. To delete a rule you no longer need, Click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.
  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set access rules:

  1. If you have not set any access rules yet, create a file named `access_control.yaml` and paste the following into it:

     ```yaml
     catalog_session_properties:
       # Rule 1
       - allow: <permission_to_set_property>
         property:
           names:
             any: [<list_of_property_names>]
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

     * `system_session_properties`: List of rules for catalog session properties. Each rule contains the required `allow` parameter, as well as the optional `property`, `catalog`, `groups`, `users`, and `description` parameters.

     * `allow`: Permission to set a property:
       * `YES`: User is allowed to set the property.
       * `NO`: User is not allowed to set the property.

     * `property`: Properties the rule applies to. If you do not specify `property`, the rule applies to all properties.
       * `names`: List of property names.
       * `name_regexp`: Regular expression. The rule applies to the properties whose names match the regular expression.

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
  
      For more on how to create this file, see [Creating a cluster](cluster-create.md).
  
  1. If you have not set any access rules yet, add the `yandex_trino_access_control` resource containing the `system_session_properties` rule list.

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
       catalog_session_properties = [
         # Rule 1
         {
           allow         = "<permission_to_set_property>"
           property      = {
             names       = ["<list_of_property_names>"]
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

     * `catalog_session_properties`: List of rule sections for catalog session properties. Each rule contains the required `allow` parameter, as well as the optional `property`, `catalog`, `groups`, `users`, and `description` parameters.

     * `allow`: Permission to set a property:
       * `YES`: User is allowed to set the property.
       * `NO`: User is not allowed to set the property.

     * `property`: Properties the rule applies to. If the `property` section is not specified, the rule applies to all properties.
       * `names`: List of property names.
       * `name_regexp`: Regular expression. The rule applies to the properties whose names match the regular expression.

       You can specify either `names` or `name_regexp` but not both.

     * `catalog`: Cluster catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
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
        "updateMask": "trino.accessControl.systemSessionProperties",
        "trino": {
          "accessControl": {
            "systemSessionProperties": [
              {
                "allow": "<permission_to_set_property>",
                "property": {
                  "names": {
                    "any": [
                      "<list_of_property_names>"
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

      * `updateMask`: Comma-separated list of parameters to update.

          {% note warning %}

          When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

          {% endnote %}

      * `accessControl`: Access rule configuration in the cluster.

      * `systemSessionProperties`: List of rule sections for session system properties. Each rule contains the required `allow` parameter, as well as the optional `property`, `groups`, `users`, and `description` parameters.

      * `allow`: Permission to set a property:
        * `YES`: User is allowed to set the property.
        * `NO`: User is not allowed to set the property.

      * `property`: Properties the rule applies to. If the `property` section is not specified, the rule applies to all properties.
        * `names`: List of property names.
        * `nameRegexp`: Regular expression. The rule applies to the properties whose names match the regular expression.

        The `property` section must contain either the nested `names` section or the `nameRegexp` parameter.

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
            "trino.access_control.catalog_session_properties"
          ]
        },
        "trino": {
          "access_control": {
            "catalog_session_properties": [
              {
                "allow": "<permission_to_set_property>",
                "property": {
                  "names": {
                    "any": [
                      "<list_of_property_names>"
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

      * `system_session_properties`: List of rule sections for catalog session properties. Each rule contains the required `allow` parameter, as well as the optional `property`, `catalog`, `groups`, `users`, and `description` parameters.

      * `allow`: Permission to set a property:
        * `YES`: User is allowed to set the property.
        * `NO`: User is not allowed to set the property.

      * `property`: Properties the rule applies to. If the `property` section is not specified, the rule applies to all properties.
        * `names`: List of property names.
        * `name_regexp`: Regular expression. The rule applies to the properties whose names match the regular expression.

        The `property` section must contain either the nested `names` section or the `name_regexp` parameter.

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

## Example of setting access rules for catalog session properties {#example}

Let's configure access rules for catalog session properties:
1. Allow users in the group with the `admins_group_id` to set any properties.
1. Allow users in the group with the `analytics_group_id` to set properties with names such as `parquet_.*` in the catalog with the `hive_cat_id`.
1. Prohibit all other users from setting properties.

{% list tabs group=instructions %}

- CLI {#cli}

  The `access_control.yaml` file for this rule set is as follows:

  ```yaml
  catalog_session_properties:
    - groups: 
        - admins_group_id
      allow: YES

    - groups: 
        - data_engineers_group_id
      property:
        name_regexp: "parquet.*"
      catalog:
        ids:
          any:
            - hive_cat_id
      allow: YES
  ```

- {{ TF }} {#tf}

  The configuration file for this rule set is as follows:

  ```hcl
  resource "yandex_trino_access_control" "trino_access_control" {
    ...
    cluster_id  = <cluster_ID>
    catalog_session_properties = [
      {
        groups        = ["admins_group_id"]
        allow         = "YES"
      },
      {
        groups        = ["data_engineers_group_id"]
        property      = {
          name_regexp = "parquet.*"
        }
        catalog       = {
          ids         = ["hive_cat_id"]
        }
        allow         = "YES"
      }
    ]
    ...
  }
  ```

- REST API {#api}

  The `body.json` file for this rule set is as follows:

  ```json
  {
    "updateMask": "trino.accessControl.systemSessionProperties",
    "trino": {
      "accessControl": {
        "systemSessionProperties": [
          {
            "groups": [
              "admins_group_id"
            ],
            "allow": "YES"
          },
          {
            "groups": [
              "data_engineers_group_id"
            ],
            "catalog": {
              "ids": {
                "any": ["hive_cat_id"]
              }
            },
            "property": {
              "nameRegexp": "parquet.*"
            },
            "allow": "YES"
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
        "trino.access_control.catalog_session_properties"
      ]
    },
    "trino": {
      "access_control": {
        "catalog_session_properties": [
          {
            "groups": [
              "admins_group_id"
            ],
            "allow": "YES"
          },
          {
            "groups": [
              "data_engineers_group_id"
            ],
            "catalog": {
              "ids": {
                "any": ["hive_cat_id"]
              }
            },
            "property": {
              "name_regexp": "parquet.*"
            },
            "allow": "YES"
          }
        ]
      }
    }
  }
  ```

{% endlist %}
