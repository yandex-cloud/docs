---
title: Assigning access rules for tables in {{ mtr-name }}
description: Rules define the actions users can perform with tables.
---

# Assigning access rules for tables in {{ mtr-name }}

Rules define the actions users can perform with tables in a {{ mtr-name }} cluster.

For each user-table pair, rules apply as follows:
* Rules are checked for matches in the order they are specified in the configuration file. The first rule matching the user-table pair applies.
* If none of the rules match the user-table pair, no actions with the table are allowed to the user.
* If no table access rules are set, any user can perform any actions with any table.
* Table access rules apply together with the top-level [rules for objects in catalogs](./access-control-catalogs.md).

## Setting rules when creating a cluster {#set-at-create}

You can set table access rules when creating a {{ mtr-name }} cluster.

{% note warning %}
  
Names of tables and schemas specified in rules are not validated. If a table name or a schema name contains an error, the rule will not apply correctly.
  
{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ mtr-name }} cluster.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}** and set the cluster parameters.
  1. Under **{{ ui-key.yacloud.trino.section_rbac }}**, click ![image](../../_assets/console-icons/chevron-down.svg).
  1. In the **{{ ui-key.yacloud.trino.label_rbac-table }}** field, click **{{ ui-key.yacloud.trino.label_rbac-add-rule }}**.
  1. In the window that opens, set the rule settings:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.label_table-privileges_2ikK4 }}** field, select permitted actions with tables:
        * `SELECT`: Read data.
        * `INSERT`: Insert data.
        * `DELETE`: Delete data.
        * `UPDATE`: Update data.
        * `OWNERSHIP`: Create and delete a table, change columns, and add comments to a table.
        * `GRANT_SELECT`: Create `VIEW` and read table data.

        If you do not select any actions, the rule will prohibit all actions with tables.

        {% note info %}

        To use the `OWNERSHIP` privilege for the table, you need the `ALL` access level for the catalog containing that table.

        {% endnote %}

     1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.label_filter_ewYvF }}** field, specify a boolean SQL expression for user access to table rows.

        The user will only have access to the row if the expression returns `TRUE`. The SQL expression is calculated on behalf of the user who runs the query. If the `filter` parameter is not specified or contains an empty string, users will have access to all table rows.

     1. {% include [calatogs-description-console](../../_includes/managed-trino/calatogs-description-console.md) %}

     1. {% include [schemas-description-console](../../_includes/managed-trino/schemas-description-console.md) %}

     1. Optionally, in the **{{ ui-key.yacloud.trino.label_rbac-table-access }}** field, specify the tables the rule applies to:
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name }}**: Select table names.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name-regexp }}**: Enter a regular expression. The rule applies to the tables whose names match the regular expression.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-empty }}**: Rule applies to all tables.

     1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.label_table-columns_68mj2 }}** field, add a list of rules restricting user access to table columns:
        1. Click **{{ ui-key.yacloud.trino.ClusterForm.label_table-column-add_241Co }}**.
        1. Specify a column name.
        1. Set up access to the column: `None` to deny access or `All` to allow.
        1. Specify a mask.

           {% note info %}

           A mask is an SQL expression to mask the column. When reading, user will get the expression result instead of this column's value. The SQL expression type must match the type of the masked column. If you specify no mask, the column will not be masked.

           {% endnote %}

        1. Add other rules in a similar way if required.
        1. To delete a rule added by mistake, click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.

        If no rule is defined for the column, users will have unrestricted access.

  1. Add other rules in a similar way if required.
  1. To delete a rule added by mistake, click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set table access rules:

  1. Create a file named `access_control.yaml` and paste the following code into it:

     ```yaml
     tables:
       # Rule 1
       - privileges: [<list_of_privileges>]
         table:
           names:
             any: [<list_of_table_names>]
           name_regexp: <regular_expression>
         schema:
           names:
             any: [<list_of_schema_names>]
           name_regexp: <regular_expression>
         catalog:
           name_regexp: <regular_expression>
         columns:
           # Access rule for column 1
           - name: <column_name>
             access: <column_access>
             mask: <SQL_expression>
           # Access rule for column 2
           - <Access_settings_for_column_2>
           ...
           # Access rule for column N
           - <Access_settings_for_column_N>
         filter: <SQL_expression>           
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

     * `tables`: List of table rules. All the rule parameters are optional: `privileges`, `table`, `schema`, `catalog`, `columns`, `filter`, `groups`, `users`, and `description`.

     * `privileges`: List of permitted actions with tables:
       * `SELECT`: Read data.
       * `INSERT`: Insert data.
       * `DELETE`: Delete data.
       * `UPDATE`: Update data.
       * `OWNERSHIP`: Create and delete a table, change columns, and add comments to a table.
       * `GRANT_SELECT`: Create a `VIEW` with table data reads.

       {% include notitle [table-ownership](../../_includes/managed-trino/access-control-src.md#table-ownership) %}

     * `table`: Tables the rule applies to. If you do not specify `table`, the rule applies to all tables.
       * `names`: List of table names.
       * `name_regexp`: Regular expression. The rule applies to the tables whose names match the regular expression.

       You can specify either `names` or `name_regexp` but not both.

     * `schema`: Schemas the rule applies to. If you do not specify `schema`, the rule applies to all schemas.
       * `names`: List of schema names.
       * `name_regexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.

       You can specify either `names` or `name_regexp` but not both.

     * `catalog`: Cluster catalogs the rule applies to. If you do not specify `catalog`, the rule applies to all cluster catalogs.
       * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

     * `columns`: List of rules restricting user access to table columns. Each rule contains the required `Queuing Duration` and `Function Init Duration` parameters, and the optional `mask` parameter.
       * `name`: Column name.
       * `access`: Access to the column:
         * `ALL`: Access allowed.
         * `NONE`: Access not allowed.
       * `mask`: SQL expression to mask the column. When reading, user will get the expression result instead of this column's value. The SQL expression type must match the type of the masked column. If the `mask` parameter is not set or contains an empty string, the column will not be masked.

       If no rule is defined for the column, users will have unrestricted access.

     * `filter`: Boolean SQL expression for user access to table rows. The user will only have access to the row if the expression returns `TRUE`. The SQL expression is calculated on behalf of the user who runs the query. If the `filter` parameter is not specified or contains an empty string, users will have access to all table rows.

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
  
  1. Add the `yandex_trino_access_control` resource with the `tables` rule list to the configuration file.
 
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
       tables = [
         # Rule 1
         {
           privileges    = ["<list_of_privileges>"]
           table     = {
             names       = ["<list_of_table_names>"]
             name_regexp = "<regular_expression>"
           }
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
           columns       = [
             # Access rule for column 1
             {
               name      = "<column_name>"
               access    = "<column_access>"
               mask      = "<SQL_expression>"
             },
             # Access rule for column 2
             {
               ...
             },
             ...
             # Access rule for column N
             {
               ...
             }                       
           ]
           filter       = "<SQL_expression>"
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

     * `tables`: List of table rule sections. All the rule parameters are optional: `privileges`, `table`, `schema`, `catalog`, `columns`, `filter`, `groups`, `users`, and `description`.

     * `privileges`: List of permitted actions with tables:
       * `SELECT`: Read data.
       * `INSERT`: Insert data.
       * `DELETE`: Delete data.
       * `UPDATE`: Update data.
       * `OWNERSHIP`: Create and delete a table, change columns, and add comments to a table.
       * `GRANT_SELECT`: Create a `VIEW` with table data reads.

       {% include notitle [table-ownership](../../_includes/managed-trino/access-control-src.md#table-ownership) %}

     * `table`: Tables the rule applies to. If you do not specify `table`, the rule applies to all tables.
       * `names`: List of table names.
       * `name_regexp`: Regular expression. The rule applies to the tables whose names match the regular expression.

       You can specify either `names` or `name_regexp` but not both.

     * `schema`: Schemas the rule applies to. If you do not specify `schema`, the rule applies to all schemas.
       * `names`: List of schema names.
       * `name_regexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.

       You can specify either `names` or `name_regexp` but not both.

     * `catalog`: Cluster catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
       * `ids`: List of catalog IDs. These catalogs must be created in the same manifest.
       * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

       You can specify either `ids` or `name_regexp` but not both.

     * `columns`: List of rule sections restricting user access to table columns. Each rule contains the required `Queuing Duration` and `Function Init Duration` parameters, and the optional `mask` parameter.
       * `name`: Column name.
       * `access`: Access to the column:
         * `ALL`: Access allowed.
         * `NONE`: Access not allowed.
       * `mask`: SQL expression to mask the column. When reading, user will get the expression result instead of this column's value. The SQL expression type must match the type of the masked column. If the `mask` parameter is not set or contains an empty string, the column will not be masked.

       If no rule is defined for the column, users will have unrestricted access.

     * `filter`: Boolean SQL expression for user access to table rows. The user will only have access to the row if the expression returns `TRUE`. The SQL expression is calculated on behalf of the user who runs the query. If the `filter` parameter is not specified or contains an empty string, users will have access to all table rows.

     {% include [groups-users-description](../../_includes/managed-trino/groups-users-description.md) %}

  1. Make sure the settings are correct.
  
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
            "tables": [
              {
                "privileges": [
                  "<list_of_privileges>"
                ],
                "table": {
                  "names": {
                    "any": [
                      "<list_of_table_names>"
                    ]
                  },
                  "nameRegexp": "<regular_expression>"
                },
                "schema": {
                  "names": {
                    "any": [
                      "<list_of_schema_names>"
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
                "columns": [
                  {
                    "name": "<column_name>",
                    "access": "<column_access>",
                    "mask": "<SQL_expression>"
                  },
                  {
                    <Access_rule_for_column_2>
                  },
                  ...
                  {
                    <Access_rule_for_column_N>
                  }
                ],
                "filter": "<SQL_expression>",
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

      * `tables`: List of table rule sections. All the rule parameters are optional: `privileges`, `table`, `schema`, `catalog`, `columns`, `filter`, `groups`, `users`, and `description`.

      * `privileges`: List of permitted actions with tables:
        * `SELECT`: Read data.
        * `INSERT`: Insert data.
        * `DELETE`: Delete data.
        * `UPDATE`: Update data.
        * `OWNERSHIP`: Create and delete a table, change columns, and add comments to a table.
        * `GRANT_SELECT`: Create `VIEW` and read table data.

        {% include notitle [table-ownership](../../_includes/managed-trino/access-control-src.md#table-ownership) %}

      * `table`: Tables the rule applies to. If the `table` section is not specified, the rule applies to all tables.
        * `names`: List of table names.
        * `nameRegexp`: Regular expression. The rule applies to the tables whose names match the regular expression.

        The `table` section must contain either the nested `names` section or the `nameRegexp` parameter.

      * `schema`: Schemas the rule applies to. If the `schema` section is not specified, the rule applies to all schemas.
        * `names`: List of schema names.
        * `nameRegexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.

        The `schema` section must contain either the nested `names` section or the `nameRegexp` parameter.

      * `catalog`: Catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
        * `names`: List of catalog names. You must create catalogs within the same [Cluster.Create](../api-ref/Cluster/create.md) call.
        * `nameRegexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

        The `catalog` section must contain either the nested `names` section or the `nameRegexp` parameter.

      * `columns`: List of rule sections restricting user access to table columns. Each rule contains the required `Queuing Duration` and `Function Init Duration` parameters, and the optional `mask` parameter.
        * `name`: Column name.
        * `access`: Access to the column:
          * `ALL`: Access allowed.
          * `NONE`: Access not allowed.
        * `mask`: SQL expression to mask the column. When reading, user will get the expression result instead of this column's value. The SQL expression type must match the type of the masked column. If the `mask` parameter is not set or contains an empty string, the column will not be masked.

        If no rule is defined for the column, users will have unrestricted access.

      * `filter`: Boolean SQL expression for user access to table rows. The user will only have access to the row if the expression returns `TRUE`. The SQL expression is calculated on behalf of the user who runs the query. If the `filter` parameter is not specified or contains an empty string, users will have access to all table rows.

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
            "tables": [
              {
                "privileges": [
                  "<list_of_privileges>"
                ],
                "table": {
                  "names": {
                    "any": [
                      "<list_of_table_names>"
                    ]
                  },
                  "name_regexp": "<regular_expression>"
                },
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
                "columns": [
                  {
                    "name": "<column_name>",
                    "access": "<column_access>",
                    "mask": "<SQL_expression>"
                  },
                  {
                    <Access_rule_for_column_2>
                  },
                  ...
                  {
                    <Access_rule_for_column_N>
                  }
                ],
                "filter": "<SQL_expression>",
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

      * `tables`: List of table rule sections. All the rule parameters are optional: `privileges`, `table`, `schema`, `catalog`, `columns`, `filter`, `groups`, `users`, and `description`.

      * `privileges`: List of permitted actions with tables:
        * `SELECT`: Read data.
        * `INSERT`: Insert data.
        * `DELETE`: Delete data.
        * `UPDATE`: Update data.
        * `OWNERSHIP`: Create and delete a table, change columns, and add comments to a table.
        * `GRANT_SELECT`: Create a `VIEW` with table data reads.

        {% include notitle [table-ownership](../../_includes/managed-trino/access-control-src.md#table-ownership) %}

      * `table`: Tables the rule applies to. If the `table` section is not specified, the rule applies to all tables.
        * `names`: List of table names.
        * `name_regexp`: Regular expression. The rule applies to the tables whose names match the regular expression.

        The `table` section must contain either the nested `names` section or the `name_regexp` parameter.

      * `schema`: Schemas the rule applies to. If the `schema` section is not specified, the rule applies to all schemas.
        * `names`: List of schema names.
        * `name_regexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.

        The `schema` section must contain either the nested `names` section or the `name_regexp` parameter.

      * `catalog`: Catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
        * `names`: List of catalog names. You must create catalogs within the same [ClusterService/Create](../api-ref/grpc/Cluster/create.md) call.
        * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

        The `catalog` section must contain either the nested `names` section or the `name_regexp` parameter.

      * `columns`: List of rule sections restricting user access to table columns. Each rule contains the required `Queuing Duration` and `Function Init Duration` parameters, and the optional `mask` parameter.
        * `name`: Column name.
        * `access`: Access to the column:
          * `ALL`: Access allowed.
          * `NONE`: Access not allowed.
        * `mask`: SQL expression to mask the column. When reading, user will get the expression result instead of this column's value. The SQL expression type must match the type of the masked column. If the `mask` parameter is not set or contains an empty string, the column will not be masked.

        If no rule is defined for the column, users will have unrestricted access.

      * `filter`: Boolean SQL expression for user access to table rows. The user will only have access to the row if the expression returns `TRUE`. The SQL expression is calculated on behalf of the user who runs the query. If the `filter` parameter is not specified or contains an empty string, users will have access to all table rows.

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

You can set or update table access rules for an existing {{ mtr-name }} cluster.

{% note warning %}
  
Names of tables and schemas specified in rules are not validated. If a table name or a schema name contains an error, the rule will not apply correctly.
  
{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the cluster name.
  1. Go to **{{ ui-key.yacloud.trino.ClusterView.RBACView.label_rbac-settings_o2F64 }}** → **{{ ui-key.yacloud.trino.label_rbac-table }}**.
  1. To add a rule, click **{{ ui-key.yacloud.trino.label_rbac-add-rule }}**. In the window that opens, set the rule settings:

     1. {% include [description-console](../../_includes/managed-trino/description-console.md) %}

     1. {% include [users-console](../../_includes/managed-trino/users-console.md) %}

     1. {% include [groups-console](../../_includes/managed-trino/groups-console.md) %}

     1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.label_table-privileges_2ikK4 }}** field, select permitted actions with tables:
        * `SELECT`: Read data.
        * `INSERT`: Insert data.
        * `DELETE`: Delete data.
        * `UPDATE`: Update data.
        * `OWNERSHIP`: Create and delete a table, change columns, and add comments to a table.
        * `GRANT_SELECT`: Create `VIEW` and read table data.

        If you do not select any actions, the rule will prohibit all actions with tables.

        {% note info %}

        To use the `OWNERSHIP` privilege for the table, you need the `ALL` access level for the catalog containing that table.

        {% endnote %}

     1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.label_filter_ewYvF }}** field, specify a boolean SQL expression for user access to table rows.

        The user will only have access to the row if the expression returns `TRUE`. The SQL expression is calculated on behalf of the user who runs the query. If the `filter` parameter is not specified or contains an empty string, users will have access to all table rows.

     1. {% include [calatogs-description-ID-console](../../_includes/managed-trino/calatogs-description-ID-console.md) %}

     1. {% include [schemas-description-console](../../_includes/managed-trino/schemas-description-console.md) %}

     1. Optionally, in the **{{ ui-key.yacloud.trino.label_rbac-table-access }}** field, specify the tables the rule applies to:
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name }}**: Select table names.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-name-regexp }}**: Enter a regular expression. The rule applies to the tables whose names match the regular expression.
        * **{{ ui-key.yacloud.trino.rbac-catalog-match-by-empty }}**: Rule applies to all tables.

     1. Optionally, in the **{{ ui-key.yacloud.trino.ClusterForm.label_table-columns_68mj2 }}** field, add a list of rules restricting user access to table columns:
        1. Click **{{ ui-key.yacloud.trino.ClusterForm.label_table-column-add_241Co }}**.
        1. Specify a column name.
        1. Set up access to the column: `None` to deny access or `All` to allow.
        1. Specify a mask.

           {% note info %}

           A mask is an SQL expression to mask the column. When reading, user will get the expression result instead of this column's value. The SQL expression type must match the type of the masked column. If you specify no mask, the column will not be masked.

           {% endnote %}

        1. Add other rules in a similar way if required.
        1. To delete a rule added by mistake, click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.

        If no rule is defined for the column, users will have unrestricted access.

  1. Add other rules in a similar way if required.
  1. To edit a rule:
     1. Click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.
     1. Update the rule settings and click **{{ ui-key.yacloud.common.update }}**.
  1. To delete a rule you no longer need, click ![trash-bin](../../_assets/console-icons/trash-bin.svg) in the line with this rule.
  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set table access rules:

  1. If you have not set any access rules yet, create a file named `access_control.yaml` and paste the following code into it:

     ```yaml
     tables:
       # Rule 1
       - privileges: [<list_of_privileges>]
         table:
           names:
             any: [<list_of_table_names>]
           name_regexp: <regular_expression>
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
         columns:
           # Access rule for column 1
           - name: <column_name>
             access: <column_access>
             mask: <SQL_expression>
           # Access rule for column 2
           - <Access_settings_for_column_2>
           ...
           # Access rule for column N
           - <Access_settings_for_column_N>
         filter: <SQL_expression>           
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

     * `tables`: List of table rules. All the rule parameters are optional: `privileges`, `table`, `schema`, `catalog`, `columns`, `filter`, `groups`, `users`, and `description`.

     * `privileges`: List of permitted actions with tables:
       * `SELECT`: Read data.
       * `INSERT`: Insert data.
       * `DELETE`: Delete data.
       * `UPDATE`: Update data.
       * `OWNERSHIP`: Create and delete a table, change columns, and add comments to a table.
       * `GRANT_SELECT`: Create a `VIEW` with table data reads.

       {% include notitle [table-ownership](../../_includes/managed-trino/access-control-src.md#table-ownership) %}

     * `table`: Tables the rule applies to. If you do not specify `table`, the rule applies to all tables.
       * `names`: List of table names.
       * `name_regexp`: Regular expression. The rule applies to the tables whose names match the regular expression.

       You can specify either `names` or `name_regexp` but not both.

     * `schema`: Schemas the rule applies to. If you do not specify `schema`, the rule applies to all schemas.
       * `names`: List of schema names.
       * `name_regexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.

       You can specify either `names` or `name_regexp` but not both.

     * `catalog`: Catalogs the rule applies to. If you do not specify `catalog`, the rule applies to all cluster catalogs.
       * `ids`: List of catalog IDs. These must be the existing catalogs.
       * `names`: List of catalog names. These must be the existing catalogs.
       * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

       You can specify only one of the following: `ids`, `names`, or `name_regexp`.

     * `columns`: List of rules restricting user access to table columns. Each rule contains the required `Queuing Duration` and `Function Init Duration` parameters, and the optional `mask` parameter.
       * `name`: Column name.
       * `access`: Access to the column:
         * `ALL`: Access allowed.
         * `NONE`: Access not allowed.
       * `mask`: SQL expression to mask the column. When reading, user will get the expression result instead of this column's value. The SQL expression type must match the type of the masked column. If the `mask` parameter is not set or contains an empty string, the column will not be masked.

       If no rule is defined for the column, users will have unrestricted access.

     * `filter`: Boolean SQL expression for user access to table rows. The user will only have access to the row if the expression returns `TRUE`. The SQL expression is calculated on behalf of the user who runs the query. If the `filter` parameter is not specified or contains an empty string, users will have access to all table rows.

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
  
  1. If you have not set any access rules yet, add the `yandex_trino_access_control` resource containing the `tables` rule list.

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
       tables = [
         # Rule 1
         {
           privileges    = ["<list_of_privileges>"]
           table     = {
             names       = ["<list_of_table_names>"]
             name_regexp = "<regular_expression>"
           }
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
           columns       = [
             # Access rule for column 1
             {
               name      = "<column_name>"
               access    = "<column_access>"
               mask      = "<SQL_expression>"
             },
             # Access rule for column 2
             {
               ...
             },
             ...
             # Access rule for column N
             {
               ...
             }                       
           ]
           filter       = "<SQL_expression>"
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

     * `tables`: List of table rule sections. All the rule parameters are optional: `privileges`, `table`, `schema`, `catalog`, `columns`, `filter`, `groups`, `users`, and `description`.

     * `privileges`: List of permitted actions with tables:
       * `SELECT`: Read data.
       * `INSERT`: Insert data.
       * `DELETE`: Delete data.
       * `UPDATE`: Update data.
       * `OWNERSHIP`: Create and delete a table, change columns, and add comments to a table.
       * `GRANT_SELECT`: Create a `VIEW` with table data reads.

       {% include notitle [table-ownership](../../_includes/managed-trino/access-control-src.md#table-ownership) %}

     * `table`: Tables the rule applies to. If you do not specify `table`, the rule applies to all tables.
       * `names`: List of table names.
       * `name_regexp`: Regular expression. The rule applies to the tables whose names match the regular expression.

       You can specify either `names` or `name_regexp` but not both.

     * `schema`: Schemas the rule applies to. If you do not specify `schema`, the rule applies to all schemas.
       * `names`: List of schema names.
       * `name_regexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.

       You can specify either `names` or `name_regexp` but not both.

     * `catalog`: Cluster catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
       * `ids`: List of catalog IDs. These must exist or be created in the same manifest.
       * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

       You can specify either `ids` or `name_regexp` but not both.

     * `columns`: List of rule sections restricting user access to table columns. Each rule contains the required `Queuing Duration` and `Function Init Duration` parameters, and the optional `mask` parameter.
       * `name`: Column name.
       * `access`: Access to the column:
         * `ALL`: Access allowed.
         * `NONE`: Access not allowed.
       * `mask`: SQL expression to mask the column. When reading, user will get the expression result instead of this column's value. The SQL expression type must match the type of the masked column. If the `mask` parameter is not set or contains an empty string, the column will not be masked.

       If no rule is defined for the column, users will have unrestricted access.

     * `filter`: Boolean SQL expression for user access to table rows. The user will only have access to the row if the expression returns `TRUE`. The SQL expression is calculated on behalf of the user who runs the query. If the `filter` parameter is not specified or contains an empty string, users will have access to all table rows.

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
        "updateMask": "trino.accessControl.tables",
        "trino": {
          "accessControl": {
            "tables": [
              {
                "privileges": [
                  "<list_of_privileges>"
                ],
                "table": {
                  "names": {
                    "any": [
                      "<list_of_table_names>"
                    ]
                  },
                  "nameRegexp": "<regular_expression>"
                },
                "schema": {
                  "names": {
                    "any": [
                      "<list_of_schema_names>"
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
                "columns": [
                  {
                    "name": "<column_name>",
                    "access": "<column_access>",
                    "mask": "<SQL_expression>"
                  },
                  {
                    <Access_rule_for_column_2>
                  },
                  ...
                  {
                    <Access_rule_for_column_N>
                  }
                ],
                "filter": "<SQL_expression>",
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

      * `tables`: List of table rule sections. All the rule parameters are optional: `privileges`, `table`, `schema`, `catalog`, `columns`, `filter`, `groups`, `users`, and `description`.

      * `privileges`: List of permitted actions with tables:
        * `SELECT`: Read data.
        * `INSERT`: Insert data.
        * `DELETE`: Delete data.
        * `UPDATE`: Update data.
        * `OWNERSHIP`: Create and delete a table, change columns, and add comments to a table.
        * `GRANT_SELECT`: Create `VIEW` and read table data.

        {% include notitle [table-ownership](../../_includes/managed-trino/access-control-src.md#table-ownership) %}

      * `table`: Tables the rule applies to. If the `table` section is not specified, the rule applies to all tables.
        * `names`: List of table names.
        * `nameRegexp`: Regular expression. The rule applies to the tables whose names match the regular expression.

        The `table` section must contain either the nested `names` section or the `nameRegexp` parameter.

      * `schema`: Schemas the rule applies to. If the `schema` section is not specified, the rule applies to all schemas.
        * `names`: List of schema names.
        * `nameRegexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.

        The `schema` section must contain either the nested `names` section or the `nameRegexp` parameter.

      * `catalog`: Catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
        * `ids`: List of catalog IDs. These must be the existing catalogs.
        * `names`: List of catalog names. These must be the existing catalogs.
        * `nameRegexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

        The `catalog` section must contain either one of the nested `ids` or `names` sections, or the `nameRegexp` parameter.

      * `columns`: List of rule sections restricting user access to table columns. Each rule contains the required `Queuing Duration` and `Function Init Duration` parameters, and the optional `mask` parameter.
        * `name`: Column name.
        * `access`: Access to the column:
          * `ALL`: Access allowed.
          * `NONE`: Access not allowed.
        * `mask`: SQL expression to mask the column. When reading, user will get the expression result instead of this column's value. The SQL expression type must match the type of the masked column. If the `mask` parameter is not set or contains an empty string, the column will not be masked.

        If no rule is defined for the column, users will have unrestricted access.

      * `filter`: Boolean SQL expression for user access to table rows. The user will only have access to the row if the expression returns `TRUE`. The SQL expression is calculated on behalf of the user who runs the query. If the `filter` parameter is not specified or contains an empty string, users will have access to all table rows.

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
            "trino.access_control.tables"
          ]
        },
        "trino": {
          "access_control": {
            "tables": [
              {
                "privileges": [
                  "<list_of_privileges>"
                ],
                "table": {
                  "names": {
                    "any": [
                      "<list_of_table_names>"
                    ]
                  },
                  "name_regexp": "<regular_expression>"
                },
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
                "columns": [
                  {
                    "name": "<column_name>",
                    "access": "<column_access>",
                    "mask": "<SQL_expression>"
                  },
                  {
                    <Access_rule_for_column_2>
                  },
                  ...
                  {
                    <Access_rule_for_column_N>
                  }
                ],
                "filter": "<SQL_expression>",
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

      * `tables`: List of table rule sections. All the rule parameters are optional: `privileges`, `table`, `schema`, `catalog`, `columns`, `filter`, `groups`, `users`, and `description`.

      * `privileges`: List of permitted actions with tables:
        * `SELECT`: Read data.
        * `INSERT`: Insert data.
        * `DELETE`: Delete data.
        * `UPDATE`: Update data.
        * `OWNERSHIP`: Create and delete a table, change columns, and add comments to a table.
        * `GRANT_SELECT`: Create a `VIEW` with table data reads.

        {% include notitle [table-ownership](../../_includes/managed-trino/access-control-src.md#table-ownership) %}

      * `table`: Tables the rule applies to. If the `table` section is not specified, the rule applies to all tables.
        * `names`: List of table names.
        * `name_regexp`: Regular expression. The rule applies to the tables whose names match the regular expression.

        The `table` section must contain either the nested `names` section or the `name_regexp` parameter.

      * `schema`: Schemas the rule applies to. If the `schema` section is not specified, the rule applies to all schemas.
        * `names`: List of schema names.
        * `name_regexp`: Regular expression. The rule applies to the schemas whose names match the regular expression.

        The `schema` section must contain either the nested `names` section or the `name_regexp` parameter.

      * `catalog`: Catalogs the rule applies to. If the `catalog` section is not specified, the rule applies to all cluster catalogs.
        * `ids`: List of catalog IDs. These must be the existing catalogs.
        * `names`: List of catalog names. These must be the existing catalogs.
        * `name_regexp`: Regular expression. The rule applies to the catalogs whose names match the regular expression.

        The `catalog` section must contain either one of the nested `ids` or `names` sections, or the `name_regexp` parameter.

      * `columns`: List of rule sections restricting user access to table columns. Each rule contains the required `Queuing Duration` and `Function Init Duration` parameters, and the optional `mask` parameter.
        * `name`: Column name.
        * `access`: Access to the column:
          * `ALL`: Access allowed.
          * `NONE`: Access not allowed.
        * `mask`: SQL expression to mask the column. When reading, user will get the expression result instead of this column's value. The SQL expression type must match the type of the masked column. If the `mask` parameter is not set or contains an empty string, the column will not be masked.

        If no rule is defined for the column, users will have unrestricted access.

      * `filter`: Boolean SQL expression for user access to table rows. The user will only have access to the row if the expression returns `TRUE`. The SQL expression is calculated on behalf of the user who runs the query. If the `filter` parameter is not specified or contains an empty string, users will have access to all table rows.

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

## Example of setting table access rules {#example}

Let’s configure access rules for tables in a {{ TR }} cluster:
1. Prohibit any actions with tables to the user with the `banned_user_id` ID.
1. Allow any actions with tables to the user group with the `admins_group_id` ID.
1. Allow reading data from the `sales` and `orders` tables to all users, in which case:
   * A user can only access a table row if the `manager_id` column value matches the current user ID.
   * The `client_phone` column value will be masked with `***`, except for the last four digits.
1. Prohibit any actions with tables to all other users.

{% list tabs group=instructions %}

- CLI {#cli}

  The `access_control.yaml` file for this rule set is as follows:

  ```yaml
  tables:
    - users:
        - banned_user_id

    - groups:
        - admins_group_id
      privileges:
        - SELECT
        - INSERT
        - DELETE
        - UPDATE
        - OWNERSHIP
        - GRANT_SELECT

    - table:
        names:
          any:
            - sales
            - orders
      columns:
        - name: client_phone
          access: ALL
          mask: "'***' || substring(client_phone, -4)"
      filter: "manager_id = current_user"
      privileges:
        - SELECT
  ```

- {{ TF }} {#tf}

  The configuration file for this rule set is as follows:

  ```hcl
  resource "yandex_trino_access_control" "trino_access_control" {
    ...
    cluster_id  = <cluster_ID>
    tables = [
      {
        users         = ["banned_user_id"]
      },
      {
        groups        = ["admins_group_id"]
        privileges    = ["SELECT", "INSERT", "DELETE", "UPDATE", "OWNERSHIP", "GRANT_SELECT"]
      },
      {
        table         = {
          names       = ["sales", "orders"]
        }
        columns       = [
          {
            name      = "client_phone"
            access    = "ALL"
            mask      = "'***' || substring(client_phone, -4)"
          }
        ]
        filter        = "manager_id = current_user"
        privileges    = ["SELECT"]
      }
    ]
    ...
  }
  ```

- REST API {#api}

  The `body.json` file for this rule set is as follows:

  ```json
  {
    "updateMask": "trino.accessControl.tables",
    "trino": {
      "accessControl": {
        "tables": [
          {
            "users": [
              "banned_user_id"
            ]
          },
          {
            "groups": [
              "admins_group_id"
            ],
            "privileges": [
              "SELECT",
              "INSERT",
              "DELETE",
              "UPDATE",
              "OWNERSHIP",
              "GRANT_SELECT"
            ]
          },
          {
            "table": {
              "names": {
                "any": [
                  "orders",
                  "sales"
                ]
              }
            },
            "columns": [
              {
                "name": "client_phone",
                "access": "ALL",
                "mask": "'***' || substring(client_phone, -4)"
              }
            ],            
            "filter": "manager_id = current_user",
            "privileges": [
              "SELECT"
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
        "trino.access_control.tables"
      ]
    },
    "trino": {
      "access_control": {
        "tables": [
          {
            "users": [
              "banned_user_id"
            ]
          },
          {
            "groups": [
              "admins_group_id"
            ],
            "privileges": [
              "SELECT",
              "INSERT",
              "DELETE",
              "UPDATE",
              "OWNERSHIP",
              "GRANT_SELECT"
            ]
          },
          {
            "table": {
              "names": {
                "any": [
                  "orders",
                  "sales"
                ]
              }
            },
            "columns": [
              {
                "name": "client_phone",
                "access": "ALL",
                "mask": "'***' || substring(client_phone, -4)"
              }
            ],            
            "filter": "manager_id = current_user",
            "privileges": [
              "SELECT"
            ]
          }
        ]
      }
    }
  }
  ```

{% endlist %}
