---
title: Managing resource groups in {{ mtr-name }}
description: You can get information about a resource group configuration, set up or delete a configuration.
---

# Managing resource groups in {{ mtr-name }}

In {{ mtr-name }}, you can manage [resource group](../concepts/resource-groups.md) configurations, i.e.:
* [Get information about the current configuration](#get).
* [Set up a configuration when creating a cluster](#set-at-create).
* [Set up or update a configuration for an existing cluster](#set-at-update).
* [Delete a configuration](#delete).

## Getting information about a resource group configuration {#get}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the cluster name.
  1. Go to the **{{ ui-key.yacloud.trino.section_resource-management }}** section.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get the description of resource groups and selector rules in the {{ mtr-name }} cluster, run this command:

  ```bash
  {{ yc-mdb-tr }} cluster get-resource-groups <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Get](../api-ref/Cluster/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<cluster_ID>'
        ```

        You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. The description of resource groups and selector rules in the {{ mtr-name }} cluster is in the `resourceGroups` field of the [server response](../api-ref/Cluster/get.md#yandex.cloud.trino.v1.Cluster).

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.Get](../api-ref/grpc/Cluster/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.ClusterService.Get
        ```

        You can request the cluster ID with the [list of clusters in the folder](#list-clusters).

    1. The description of resource groups and selector rules in the {{ mtr-name }} cluster is in the `resource_groups` field of the [server response](../api-ref/grpc/Cluster/get.md#yandex.cloud.trino.v1.Cluster).

{% endlist %}

## Setting up a resource group configuration when creating a cluster {#set-at-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ mtr-name }} cluster.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}** and set the cluster parameters.
  1. Go to the **{{ ui-key.yacloud.trino.section_resource-management }}** section.
  1. In the **{{ ui-key.yacloud.trino.ClusterView.label_cpu-quota-period_tD5vD }}** field, set the CPU quota calculation period for resource groups.
  1. Click **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupsTable.button_add-group_m99qN }}** and set up the resource group:

     {% include [resources-rg-params-console](../../_includes/managed-trino/resources-rg-params-console.md) %}

  1. Optionally, add other resource groups in the same way.
  1. Click **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.button_add-rule_3Gide }}** and set up the rule:

     {% include [resources-sel-params-console](../../_includes/managed-trino/resources-sel-params-console.md) %}

  1. Optionally, add other selector rules in the same way.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To specify a resource group configuration:

  1. Create a file with a description of resource groups and selector rules in JSON or YAML format. Below is an example of the `resource-groups.yaml` file.

     {% include [resources-syntax-cli](../../_includes/managed-trino/resources-syntax-cli.md) %}

     Where:

     {% include [resources-params-cli-tf-rest](../../_includes/managed-trino/resources-params-cli-tf-rest.md) %}

  1. View the description of the CLI command for creating a cluster:

     ```bash
     {{ yc-mdb-tr }} cluster create --help
     ```

  1. Run this command:

     ```bash
     {{ yc-mdb-tr }} cluster create \
       ...
       --resource-groups-from-file resource-groups.yaml
     ```

     For available cluster parameters and their descriptions, see [this guide](cluster-create.md#create-cluster).

- {{ TF }} {#tf}

  1. Create a {{ TF }} configuration file describing your [infrastructure](cluster-create.md).

  1. Add the `resource_groups` section to the cluster description:

     {% include [resources-syntax-tf](../../_includes/managed-trino/resources-syntax-tf.md) %}

     Where:

     {% include [resources-params-cli-tf-rest](../../_includes/managed-trino/resources-params-cli-tf-rest.md) %}

     {% note info %}

     You can also create a separate JSON file describing resource groups and selector rules and provide it in the `resource_groups` parameter as follows:

     ```hcl
     resource_groups = file("resource-groups.json")
     ```

     {% endnote %}

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
         ...
         "resourceManagement": {
           "resourceGroups": {
             "rootGroups": [
               {
                 "name" : "<resource_group_name>",
                 "softMemoryLimit" : "<memory_usage_limit>",
                 "softConcurrencyLimit" : "<soft_limit_on_the_number_of_running_queries>",
                 "hardConcurrencyLimit" : "<hard_limit_on_the_number_of_running_queries>",
                 "softCpuLimit" : "<soft_CPU_time_limit>",
                 "hardCpuLimit" : "<hard_CPU_time_limit>",
                 "maxQueued" : "<limit_on_the_number_of_queued_requests>",
                 "schedulingPolicy" : "<query_scheduling_policy>",
                 "schedulingWeight" : "<group_weight>",
                 "subGroups": [
                   {
                     <resource_sub-group_1>
                     ...
                     "subGroups" : [<list_of_next-level_sub-groups>]
                   },
                   {
                     <resource_sub-group_2>
                     ...
                     "subGroups" : [<list_of_next-level_sub-groups>]
                   },
                   ...
                   {
                     <resource_sub-group_N>
                     ...
                     "subGroups" : [<list_of_next-level_sub-groups>]
                   }
                 ]
               },
               {
                 <root_resource_group_2>
               },
               ...
               {
                 <root_resource_group_N>
               }
             ],
             "selectors": [
               {
                 "user": "<regular_expression_for_usernames>",
                 "userGroup": "<regular_expression_for_user_groups>",
                 "queryType": "<request_type>",
                 "source": "<regular_expression_for_query_sources>",
                 "clientTags": ["<list_of_tags>"],
                 "group": "<resource_group_name>"
               },
               {
                 <selector_rule_2> 
               },
               ...
               {
                 <selector_rule_N>
               }
             ],
             "cpuQuotaPeriod": "<CPU_quota_calculation_period>"
           }
           ...
         },
       }
     }
     ```

     Where:

     {% include [resources-params-cli-tf-rest](../../_includes/managed-trino/resources-params-cli-tf-rest.md) %}

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
  
  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Create a file named `body.json` and paste the following code into it:

     ```json
     {
       <cluster_parameters>
       ...
       "trino": {
         ...
         "resource_management": {
           "resource_groups": {
             "root_groups": [
               {
                 "name" : "<resource_group_name>",
                 "soft_memory_limit" : "<memory_usage_limit>",
                 "soft_concurrency_limit" : "<soft_limit_on_the_number_of_running_queries>",
                 "hard_concurrency_limit" : "<hard_limit_on_the_number_of_running_queries>",
                 "soft_cpu_limit" : "<soft_CPU_time_limit>",
                 "hard_cpu_limit" : "<hard_CPU_time_limit>",
                 "max_queued" : "<limit_on_the_number_of_queued_requests>",
                 "scheduling_policy" : "<query_scheduling_policy>",
                 "scheduling_weight" : "<group_weight>",
                 "sub_groups": [
                   {
                     <resource_sub-group_1>
                     ...
                     "sub_groups" : [<list_of_next-level_sub-groups>]
                   },
                   {
                     <resource_sub-group_2>
                     ...
                     "sub_groups" : [<list_of_next-level_sub-groups>]
                   },
                   ...
                   {
                     <resource_sub-group_N>
                     ...
                     "sub_groups" : [<list_of_next-level_sub-groups>]
                   }
                 ]
               },
               {
                 <root_resource_group_2>
               },
               ...
               {
                 <root_resource_group_N>
               }
             ],
             "selectors": [
               {
                 "user": "<regular_expression_for_usernames>",
                 "user_group": "<regular_expression_for_user_groups>",
                 "query_type": "<request_type>",
                 "source": "<regular_expression_for_query_sources>",
                 "client_tags": ["<list_of_tags>"],
                 "group": "<resource_group_name>"
               },
               {
                 <selector_rule_2> 
               },
               ...
               {
                 <selector_rule_N>
               }
             ],
             "cpu_quota_period": "<CPU_quota_calculation_period>"
           }
           ...
         },
       }
     }
     ```

     Where:

     {% include [resources-params-grpc](../../_includes/managed-trino/resources-params-grpc.md) %}

     For available cluster parameters and their descriptions, see [this guide](cluster-create.md#create-cluster).

  1. Call the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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

## Setting up or updating a resource group configuration in a cluster {#set-at-update}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the cluster name.
  1. Go to the **{{ ui-key.yacloud.trino.section_resource-management }}** section.
  1. In the **{{ ui-key.yacloud.trino.ClusterView.label_cpu-quota-period_tD5vD }}** field, set the new CPU quota calculation period for resource groups.
  1. To add a new resource group, click **{{ ui-key.yacloud.trino.ClusterForm.ResourceGroupsTable.button_add-group_m99qN }}** and set up the group:

     {% include [resources-rg-params-console](../../_includes/managed-trino/resources-rg-params-console.md) %}

  1. Optionally, add other resource groups in the same way.
  1. To edit a resource group:
     1. Click ![trash-bin](../../_assets/console-icons/pencil.svg) next to the group.
     1. Update the group parameters and click **{{ ui-key.yacloud.common.edit }}**.
  1. To add a new selector rule, click **{{ ui-key.yacloud.trino.ClusterForm.SelectorRulesTable.button_add-rule_3Gide }}** and set up the rule:

     {% include [resources-sel-params-console](../../_includes/managed-trino/resources-sel-params-console.md) %}

  1. Optionally, add other selector rules in the same way.
  1. To edit a selector rule:
     1. Click ![pencil](../../_assets/console-icons/pencil.svg) in the line with this rule.
     1. Edit the rule parameters.
  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To specify a resource group configuration:

  1. If no description of resource groups and selector rules in the {{ mtr-name }} cluster has been given yet, create a description file in JSON or YAML format. Below is an example of the `resource-groups.yaml` file.

     {% include [resources-syntax-cli](../../_includes/managed-trino/resources-syntax-cli.md) %}

     Where:

     {% include [resources-params-cli-tf-rest](../../_includes/managed-trino/resources-params-cli-tf-rest.md) %}

  1. If a description of resource groups and selector rules has already been given, open `resource-groups.yaml` and edit it as needed. You can:

     * Add new resource groups and selector rules.
     * Update the parameters of existing groups and rules.
     * Delete the groups and rules you no longer need.

  1. Run this command:

  ```bash
  {{ yc-mdb-tr }} cluster set-resource-groups <cluster_name_or_ID> \
     --from-file resource-groups.yaml
  ```

  You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.   

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.
  
     For more on how to create this file, see [Creating a cluster](cluster-create.md).
  
  1. If no description of resource groups and selector rules in the {{ mtr-name }} cluster has been given yet, add the `resource_groups` section to the cluster description:

     {% include [resources-syntax-tf](../../_includes/managed-trino/resources-syntax-tf.md) %}

     Where:

     {% include [resources-params-cli-tf-rest](../../_includes/managed-trino/resources-params-cli-tf-rest.md) %}

     {% note info %}

     You can also create a separate JSON file describing resource groups and selector rules and provide it in the `resource_groups` parameter as follows:

     ```hcl
     resource_groups = file("resource-groups.json")
     ```

     {% endnote %}

  1. If a description of resource groups and selector rules has already been given, edit the `resource_groups` section or JSON file as needed. You can:

     * Add new resource groups and selector rules.
     * Update the parameters of existing groups and rules.
     * Delete the groups and rules you no longer need.

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
       "updateMask": "<list_of_settings_to_update>",
       "trino": {
         "resourceManagement": {
           "resourceGroups": {
             "rootGroups": [
               {
                 "name" : "<resource_group_name>",
                 "softMemoryLimit" : "<memory_usage_limit>",
                 "softConcurrencyLimit" : "<soft_limit_on_the_number_of_running_queries>",
                 "hardConcurrencyLimit" : "<hard_limit_on_the_number_of_running_queries>",
                 "softCpuLimit" : "<soft_CPU_time_limit>",
                 "hardCpuLimit" : "<hard_CPU_time_limit>",
                 "maxQueued" : "<limit_on_the_number_of_queued_requests>",
                 "schedulingPolicy" : "<query_scheduling_policy>",
                 "schedulingWeight" : "<group_weight>",
                 "subGroups": [
                   {
                     <resource_sub-group_1>
                     ...
                     "subGroups" : [<list_of_next-level_sub-groups>]
                   },
                   {
                     <resource_sub-group_2>
                     ...
                     "subGroups" : [<list_of_next-level_sub-groups>]
                   },
                   ...
                   {
                     <resource_sub-group_N>
                     ...
                     "subGroups" : [<list_of_next-level_sub-groups>]
                   }
                 ]
               },
               {
                 <root_resource_group_2>
               },
               ...
               {
                 <root_resource_group_N>
               }
             ],
             "selectors": [
               {
                 "user": "<regular_expression_for_usernames>",
                 "userGroup": "<regular_expression_for_user_groups>",
                 "queryType": "<request_type>",
                 "source": "<regular_expression_for_query_sources>",
                 "clientTags": ["<list_of_tags>"],
                 "group": "<resource_group_name>"
               },
               {
                 <selector_rule_2> 
               },
               ...
               {
                 <selector_rule_N>
               }
             ],
             "cpuQuotaPeriod": "<CPU_quota_calculation_period>"
           }
           ...
         },
       }
     }
     ```

     Where:

     * `updateMask`: Comma-separated list of parameters to update.

       {% note warning %}

       When you update a cluster, all parameters of the object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

       {% endnote %}

     {% include [resources-params-cli-tf-rest](../../_includes/managed-trino/resources-params-cli-tf-rest.md) %}

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Create a file named `body.json` and paste the following code into it:

     ```json
     {
       "cluster_id": "<cluster_ID>",
         "update_mask": {
           "paths": [
             <list_of_settings_to_update>
           ]
         },
       "trino": {
         "resource_management": {
           "resource_groups": {
             "root_groups": [
               {
                 "name" : "<resource_group_name>",
                 "soft_memory_limit" : "<memory_usage_limit>",
                 "soft_concurrency_limit" : "<soft_limit_on_the_number_of_running_queries>",
                 "hard_concurrency_limit" : "<hard_limit_on_the_number_of_running_queries>",
                 "soft_cpu_limit" : "<soft_CPU_time_limit>",
                 "hard_cpu_limit" : "<hard_CPU_time_limit>",
                 "max_queued" : "<limit_on_the_number_of_queued_requests>",
                 "scheduling_policy" : "<query_scheduling_policy>",
                 "scheduling_weight" : "<group_weight>",
                 "sub_groups": [
                   {
                     <resource_sub-group_1>
                     ...
                     "sub_groups" : [<list_of_next-level_sub-groups>]
                   },
                   {
                     <resource_sub-group_2>
                     ...
                     "sub_groups" : [<list_of_next-level_sub-groups>]
                   },
                   ...
                   {
                     <resource_sub-group_N>
                     ...
                     "sub_groups" : [<list_of_next-level_sub-groups>]
                   }
                 ]
               },
               {
                 <root_resource_group_2>
               },
               ...
               {
                 <root_resource_group_N>
               }
             ],
             "selectors": [
               {
                 "user": "<regular_expression_for_usernames>",
                 "user_group": "<regular_expression_for_user_groups>",
                 "query_type": "<request_type>",
                 "source": "<regular_expression_for_query_sources>",
                 "client_tags": ["<list_of_tags>"],
                 "group": "<resource_group_name>"
               },
               {
                 <selector_rule_2> 
               },
               ...
               {
                 <selector_rule_N>
               }
             ],
             "cpu_quota_period": "<CPU_quota_calculation_period>"
           }
           ...
         },
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

         When you update a cluster, all parameters of the object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

         {% endnote %}

     {% include [resources-params-grpc](../../_includes/managed-trino/resources-params-grpc.md) %}

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

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Deleting a resource group configuration {#delete}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Click the cluster name.
  1. Go to the **{{ ui-key.yacloud.trino.section_resource-management }}** section.
  1. To delete resource groups you no longer need:
     1. Click ![trash-bin](../../_assets/console-icons/trash-bin.svg) next to the resource group you want to delete.
     1. Optionally, delete other resource groups in the same way.
  1. To delete selector rules you no longer need:
     1. Click ![trash-bin](../../_assets/console-icons/trash-bin.svg) next to the rule you want to delete.
     1. Optionally, delete other selector rules in the same way.
  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete all resource groups and selector rules, run this command:

  ```bash
  {{ yc-mdb-tr }} cluster remove-resource-groups <cluster_name_or_ID>
  ```

  You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.
  
      For more on how to create this file, see [Creating a cluster](cluster-create.md).
  
  1. To delete all resource groups and selector rules, delete the `resource_groups` parameter from the cluster description.

  1. Make sure the settings are correct.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Confirm updating the resources.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "updateMask": "trino.resourceManagement.resourceGroups",
          "trino": {
            "resourceManagement": {
              "resourceGroups": {}
            }
          }
        }
        ```

        Where:

        * `updateMask`: Comma-separated list of parameters to update.

            {% note warning %}

            When you update a cluster, all parameters of the object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

            {% endnote %}

        * `resourceGroups`: Description of resource groups and selector rules.

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Create a file named `body.json` and paste the following code into it:

      ```json
      {
        "cluster_id": "<cluster_ID>",
        "update_mask": {
          "paths": [
            "trino.resource_management.resource_groups"
          ]
        },
        "trino": {
          "resource_management": {
            "resource_groups": {}
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

          When you update a cluster, all parameters of the object you are modifying will be reset to their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `update_mask` parameter.

          {% endnote %}

      * `resource_groups`: Description of resource groups and selector rules.

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

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Example of a resource group configuration in a {{ mtr-name }} cluster {#example}

This example uses the following resource groups:

* `global`: Root group that sets the general `hardConcurrencyLimit` and `maxQueued` limits. The `global` group contains sub-groups `adm`, `bi`, `etl`, and `adhoc`.

* `adm`: Group for administrator queries and `DATA_DEFINITION` queries. High `schedulingWeight` values make it less probable that such queries will be blocked by user load.

* `bi`: Group for queries to business analytics systems. This group uses the `softMemoryLimit` limit for queries not to take up too much memory and not to force other query types out. Within this group, for each tool, a sub-group instance is created with a dynamically generated name. Within each tool's group, sub-group instances are created for each user. This sets a separate limit for each tool and user. This limits the mutual impact between queries originating from different users and tools.

* `etl`: Group for data retrieval, transformation, and upload queries. This group uses the `softCpuLimit` and `hardCpuLimit` limits for CPU time consumed by queries.

* `adhoc`: Group for interactive user queries. Within this group, for each user, a sub-group instance is created with a dynamically generated name. This sets a separate limit for each user thus limiting the mutual impact between queries originating from different users.

Queries are distributed between the `adm`, `bi`, `etl`, and `adhoc` groups as per the `weighted_fair` scheduling policy. The `schedulingWeight` parameter is not specified for the `adhoc` group; therefore, `1` (default) is used. No scheduling policy is specified for the `bi` and `adhoc` groups; therefore, queries are distributed between their sub-groups as per the default policy named `fair`.

The following selector rules are used to send queries to the groups:

1. Queries of users from the `admins` group are sent to the `global.adm` resource group.

1. Queries with the `etl_job` tag are sent to the `global.etl` group.

1. The `DATA_DEFINITION` type queries are sent to the `global.adm` resource group. This ensures that queries used to call the `system.runtime.kill_query()` procedure will not wait for other user queries to complete.

1. The `SELECT` type queries from a source with a name formatted as `jdbc#(?<toolname>[^#]+)` go to the `global.bi.${toolname}.${USER}` template group. For example, a query by the user `bob` from the source `jdbc#grafana` will go to a group instance named `global.bi.grafana.bob`.

1. All other queries are sent to the `global.adhoc.${USER}` template group. For example, a query by the user `bob` will be sent to the group instance named `global.adhoc.bob`.

{% list tabs group=instructions %}

- CLI {#cli}

  `resource-groups.json` for this example:

  {% include [resources-example](../../_includes/managed-trino/resources-example.md) %}

- {{ TF }} {#tf}

  `resource-groups.json` for this example:

  {% include [resources-example](../../_includes/managed-trino/resources-example.md) %}

- REST API {#api}

  `body.json` for this example:

  ```json
  {
    "updateMask": "trino.resourceManagement.resourceGroups",
    "trino": {
      "resourceManagement": {
        "resourceGroups": {
          "rootGroups": [
            {
              "name": "global",
              "hardConcurrencyLimit": "20",
              "maxQueued": "200",
              "schedulingPolicy": "weighted_fair",
              "subGroups": [
                {
                  "name": "adm",
                  "hardConcurrencyLimit": "5",
                  "maxQueued": "50",
                  "schedulingWeight": "5"
                },
                {
                  "name": "bi",
                  "hardConcurrencyLimit": "10",
                  "softMemoryLimit": "20%",
                  "maxQueued": "100",
                  "schedulingWeight": "3",
                  "subGroups": [
                    {
                      "name": "${toolname}",
                      "hardConcurrencyLimit": "5",
                      "maxQueued": "50",
                      "subGroups": [
                        {
                          "name": "${USER}",
                          "hardConcurrencyLimit": "2",
                          "maxQueued": "20"
                        }
                      ]
                    }
                  ]
                },
                {
                  "name": "etl",
                  "hardConcurrencyLimit": "5",
                  "softCpuLimit": "20s",
                  "hardCpuLimit": "40s",
                  "maxQueued": "50",
                  "schedulingWeight": "1"
                },
                {
                  "name": "adhoc",
                  "hardConcurrencyLimit": "5",
                  "maxQueued": "100",
                  "subGroups": [
                    {
                      "name": "${USER}",
                      "hardConcurrencyLimit": "2",
                      "maxQueued": "20"
                    }
                  ]
                }
              ]
            }
          ],
          "selectors": [
            {
              "userGroup": "admins",
              "group": "global.adm"
            },
            {
              "clientTags": ["etl_job"],
              "group": "global.etl"
            },
            {
              "queryType": "DATA_DEFINITION",
              "group": "global.adm"
            },
            {
              "source": "jdbc#(?<toolname>[^#]+)",
              "queryType": "SELECT",
              "group": "global.bi.${toolname}.${USER}"
            },
            {
              "group": "global.adhoc.${USER}"
            }
          ],
          "cpuQuotaPeriod": "1m"
        }
      }
    }
  }
  ```

- gRPC API {#grpc-api}

  `body.json` for this example:

  ```json
  {
    "cluster_id": "<cluster_ID>",
    "update_mask": {
      "paths": [
        "trino.resource_management.resource_groups"
      ]
    },
    "trino": {
      "resource_management": {
        "resource_groups": {
          "root_groups": [
            {
              "name": "global",
              "hard_concurrency_limit": "20",
              "max_queued": "200",
              "scheduling_policy": "weighted_fair",
              "sub_groups": [
                {
                  "name": "adm",
                  "hard_concurrency_limit": "5",
                  "max_queued": "50",
                  "scheduling_weight": "5"
                },
                {
                  "name": "bi",
                  "hard_concurrency_limit": "10",
                  "soft_memory_limit": "20%",
                  "max_queued": "100",
                  "scheduling_weight": "3",
                  "sub_groups": [
                    {
                      "name": "${toolname}",
                      "hard_concurrency_limit": "5",
                      "max_queued": "50",
                      "sub_groups": [
                        {
                          "name": "${USER}",
                          "hard_concurrency_limit": "2",
                          "max_queued": "20"
                        }
                      ]
                    }
                  ]
                },
                {
                  "name": "etl",
                  "hard_concurrency_limit": "5",
                  "soft_cpu_limit": "20s",
                  "hard_cpu_limit": "40s",
                  "max_queued": "50",
                  "scheduling_weight": "1"
                },
                {
                  "name": "adhoc",
                  "hard_concurrency_limit": "5",
                  "max_queued": "100",
                  "sub_groups": [
                    {
                      "name": "${USER}",
                      "hard_concurrency_limit": "2",
                      "max_queued": "20"
                    }
                  ]
                }
              ]
            }
          ],
          "selectors": [
            {
              "user_group": "admins",
              "group": "global.adm"
            },
            {
              "client_tags": ["etl_job"],
              "group": "global.etl"
            },
            {
              "query_type": "DATA_DEFINITION",
              "group": "global.adm"
            },
            {
              "source": "jdbc#(?<toolname>[^#]+)",
              "query_type": "SELECT",
              "group": "global.bi.${toolname}.${USER}"
            },
            {
              "group": "global.adhoc.${USER}"
            }
          ],
          "cpu_quota_period": "1m"
        }
      }
    }
  }
  ```

{% endlist %}
