---
title: Updating a {{ TR }} cluster
description: After creating an {{ TR }} cluster, you can edit its basic and advanced settings.
keywords:
  - Updating an {{ TR }} cluster
  - '{{ TR }} cluster'
  - '{{ TR }}'
---

# Updating a {{ TR }} cluster

After you create a cluster, you can update its settings:

* [Cluster name and description](#change-basic-settings)
* [Service account](#change-sa)
* [Version](#change-version)
* [Security groups](#change-sg)
* [Fault-tolerant query execution parameters](#change-retry-policy)
* [Coordinator and worker configuration](#change-configuration)
* [Additional cluster settings](#change-additional-settings)

## Changing cluster name and description {#change-basic-settings}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, change the cluster's name and description.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the cluster name and description:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    1. To change cluster name and description, run this command:

        ```bash
        {{ yc-mdb-tr }} cluster update <cluster_name_or_ID> \
          --new-name <cluster_name> \
          --description <cluster_description> 
        ```

        Where:

        * `--new-name`: Cluster name, unique within the cloud.
        * `--description`: Cluster description.

        You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.   

- {{ TF }} {#tf}

    {% note alert %}

    Do not change the cluster name using {{ TF }}. This will delete the existing cluster and create a new one.

    {% endnote %}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).
        
    1. Edit the `description` parameter in the cluster's description:
      
        ```hcl
        resource "yandex_trino_cluster" "<cluster_name>" {
          ...
          description = "<cluster_description>"
          ...
        }
        ```

        Where `description` is the cluster's description.

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
          "updateMask": "<list_of_parameters_to_update>",
          "name": "<cluster_name>",
          "description": "<cluster_description>"
        }
        ```

        Where:

        * `updateMask`: Comma-separated list of parameters to update.

            {% note warning %}

            When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

            {% endnote %}

        * `name`: Cluster name, unique within the cloud.
        * `description`: Cluster description.

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

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": {
            "paths": [
              <list_of_settings_to_update>
            ]
          },
          "name": "<cluster_name>",
          "description": "<cluster_description>"
        }
        ```

        Where:

        * `cluster_id`: Cluster ID.
            
            You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

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

        * `name`: Cluster name, unique within the cloud.
        * `description`: Cluster description.

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

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing a service account {#change-sa}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, select a service account or [create a new one](../../iam/operations/sa/create.md#create-sa) with the `managed-trino.integrationProvider` and `storage.editor` roles. The cluster will thus get the permissions it needs to work with user resources. For more information, see [Impersonation](../concepts/impersonation.md).

        To change your service account in a {{ mtr-name }} cluster, [make sure](../../iam/operations/roles/get-assigned-roles.md) your {{ yandex-cloud }} account has the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher.

        {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To update a service account:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    1. Update your service account using this command:

        ```bash
        {{ yc-mdb-tr }} cluster update <cluster_name_or_ID> \
          --service-account-id <service_account_ID>
        ```

        Where `--service-account-id` is the service account ID.

        You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.   

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

    1. Edit the `service_account_id` parameter in the cluster's description:
      
        ```hcl
        resource "yandex_trino_cluster" "<cluster_name>" {
          ...
          service_account_id  = "<service_account_ID>"
          ...
        }
        ```

        Where `service_account_id` is the service account ID.

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
          "updateMask": "serviceAccountId",
          "serviceAccountId": "<service_account_ID>"
        }
        ```

        Where:

        * `updateMask`: Comma-separated list of parameters to update.

            {% note warning %}

            When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

            {% endnote %}

        * `serviceAccountId`: Service account ID.

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

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": {
            "paths": [
              "service_account_id"
            ]
          },
          "service_account_id": "<service_account_ID>"
        }
        ```

        Where:

        * `cluster_id`: Cluster ID.
            
            You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

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

        * `service_account_id`: Service account ID.

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

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Switching versions {#change-version}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, select {{ TR }}. You can either upgrade or downgrade the version.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the {{ TR }} version:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    1. Change the version by running this command:

        ```bash
        {{ yc-mdb-tr }} cluster update <cluster_name_or_ID> \
          --version <version>
        ```

        Where `--version` is the {{ TR }} version. You can either upgrade or downgrade the version.

        You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.   

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).
        
    1. Edit the `version` parameter in the cluster's description:
      
        ```hcl
        resource "yandex_trino_cluster" "<cluster_name>" {
          ...
          version = "<version>"
          ...
        }
        ```

        Where `version` is the {{ TR }} version. You can either upgrade or downgrade the version.

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
          "updateMask": "trino.version",
          "trino": {
            "version": "<version>"
          }
        }
        ```

        Where:

        * `updateMask`: Comma-separated list of parameters to update.

            {% note warning %}

            When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

            {% endnote %}

        * `version`: {{ TR }} version. You can either upgrade or downgrade the version.

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

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": {
            "paths": [
              "trino.version"
            ]
          },
          "trino": {
            "version": "<version>"
          }
        }
        ```

        Where:

        * `cluster_id`: Cluster ID.
            
            You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

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

        * `version`: {{ TR }} version. You can either upgrade or downgrade the version.

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

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Updating security groups {#change-sg}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select security groups for the cluster.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To update security groups:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    1. Update security groups using this command:

        ```bash
        {{ yc-mdb-tr }} cluster update <cluster_name_or_ID> \
          --security-group-ids <list_of_security_group_IDs>
        ```

        Where `--security-group-ids` is the list of security group IDs.

        You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.   

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

    1. Edit the `security_group_ids` parameter in the cluster's description:
      
        ```hcl
        resource "yandex_trino_cluster" "<cluster_name>" {
          ...
          security_group_ids  = [<list_of_security_group_IDs>]
          ...
        }
        ```

        Where `security_group_ids` is the list of security group IDs.

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
          "updateMask": "networkSpec.securityGroupIds",
          "networkSpec": {
            "securityGroupIds": [
              <list_of_security_group_IDs>
            ]
          }
        }
        ```

        Where:

        * `updateMask`: Comma-separated list of parameters to update.

            {% note warning %}

            When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

            {% endnote %}

        * `networkSpec`: Network settings:
          
            * `securityGroupIds`: List of security group IDs.

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

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": {
            "paths": [
              "network_spec.security_group_ids"
            ]
          },
          "network_spec": {
            "security_group_ids": [ <list_of_security_group_IDs> ]
          }
        }
        ```

        Where:

        * `cluster_id`: Cluster ID.
            
            You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

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

        * `network_spec`: Network settings:

            * `security_group_ids`: List of security group IDs.

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

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing fault-tolerant query execution parameters {#change-retry-policy}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **Retry policy**, update the [fault-tolerant query execution](../concepts/retry-policy.md) parameters:
        
        * Change the **Retry object type**.
        
        * Add or delete additional parameters in `key:value` format in the **Retry parameters** field. For more information about parameters, see [this {{ TR }} guide](https://trino.io/docs/current/admin/fault-tolerant-execution.html#advanced-configuration).
        
        * Add or delete additional Exchange Manager storage parameters in `key: value` format in the **Storage parameters** field. For more information about parameters, see [this {{ TR }} guide](https://trino.io/docs/current/admin/fault-tolerant-execution.html#id1).

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To update [fault-tolerant query execution](../concepts/retry-policy.md) parameters:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    1. Update the [fault-tolerant query execution](../concepts/retry-policy.md) parameters using this command:

        ```bash
        {{ yc-mdb-tr }} cluster update <cluster_name_or_ID> \
          --retry-policy-enabled \ 
          --retry-policy <object_type_for_retry> \
          --retry-policy-additional-properties <list_of_additional_parameters> \
          --retry-policy-exchange-manager-service-s3 \
          --retry-policy-exchange-manager-additional-properties <list_of_additional_parameters>
        ```

        Where:

        * `--retry-policy-enabled`: Enables the retry policy.
          
        * `--retry-policy`: Query retry method. The possible values are:

            * `query`: Retries all [stages of the query](../concepts/index.md#query-execution) in which the worker failed.
            * `task`: Retries the intermediate task within the query that caused worker failure.

        * `--retry-policy-additional-properties`: Additional query retry parameters in `<key>=<value>` format. [Learn more about parameters in the {{ TR }} documentation]({{ tr.docs }}/admin/fault-tolerant-execution.html#advanced-configuration).
          
        * `--retry-policy-exchange-manager-service-s3`: Activates the use of a service {{ objstorage-short-name }} bucket as an Exchange Manager storage for intermediate data.
          
        * `--retry-policy-exchange-manager-additional-properties`: Additional Exchange Manager storage parameters in `<key>=<value>` format. [Learn more about parameters in the {{ TR }} documentation]({{ tr.docs }}/admin/fault-tolerant-execution.html#id1).

        You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.   

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

    1. To enable a [fault-tolerant query execution](../concepts/retry-policy.md) policy, add a `retry_policy` section to the cluster description:
      
        {% include [Terraform retry policy parameters description](../../_includes/managed-trino/terraform/retry-policy-parameters.md) %}

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
          "updateMask": "<list_of_settings_to_update>",
          "trino": {
            "retryPolicy": {
              "policy": "<object_type_for_retry>",
              "exchangeManager": {
                "storage": {
                  "serviceS3": {}
                },
                "additionalProperties": {<additional_storage_parameters>}
              },
              "additionalProperties": {<additional_retry_parameters>}
            }
          }
        }
        ```

        Where:

        * `updateMask`: Comma-separated list of parameters to update.

            {% note warning %}

            When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

            {% endnote %}

        * `trino.retryPolicy`: [Fault-tolerant query execution](../concepts/retry-policy.md) parameters.

            * `policy`: Query retry method. The possible values are:

                * `TASK`: Retries the intermediate task within the query that caused worker failure.
                * `QUERY`: Retries all [stages of the query](../concepts/index.md#query-execution) where worker failure occurred.

            * `exchangeManager.additionalProperties`: Additional Exchange Manager storage parameters in `key: value` format. For more information about parameters, see [this {{ TR }} guide](https://trino.io/docs/current/admin/fault-tolerant-execution.html#id1).

            * `additionalProperties`: Additional parameters in `key: value` format. For more information about parameters, see [this {{ TR }} guide](https://trino.io/docs/current/admin/fault-tolerant-execution.html#advanced-configuration).

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
            "retry_policy": {
              "policy": "<object_type_for_retry>",
              "exchange_manager": {
                "storage": {
                  "service_s3": ""
                },
                "additional_properties": {<additional_storage_parameters>}
              },
              "additional_properties": {<additional_retry_parameters>}
            }
          }
        }
        ```

        Where:

        * `cluster_id`: Cluster ID.
            
            You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

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

        * `trino.retry_policy`: [Fault-tolerant query execution](../concepts/retry-policy.md) parameters.

            * `policy`: Query retry method. The possible values are:

                * `TASK`: Retries the intermediate task within the query that caused worker failure.
                * `QUERY`: Retries all [stages of the query](../concepts/index.md#query-execution) where worker failure occurred.

            * `exchange_manager.additional_properties`: Additional Exchange Manager storage parameters in `key: value` format. For more information about parameters, see [this {{ TR }} guide](https://trino.io/docs/current/admin/fault-tolerant-execution.html#id1).

            * `additional_properties`: Additional parameters in `key: value` format. For more information about parameters, see [this {{ TR }} guide](https://trino.io/docs/current/admin/fault-tolerant-execution.html#advanced-configuration).

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

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing the configuration of the coordinator and workers {#change-configuration}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Change the configuration of the [coordinator](../concepts/index.md#coordinator) and [workers](../concepts/index.md#workers).
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the configuration of the [coordinator](../concepts/index.md#coordinator) and [workers](../concepts/index.md#workers):

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    1. Run this command to change the configuration of the [coordinator](../concepts/index.md#coordinator) and [workers](../concepts/index.md#workers):

        ```bash
        {{ yc-mdb-tr }} cluster update <cluster_name_or_ID> \
          --coordinator resource-preset-id=<host_class> \
          --worker count=<number_of_instances>,`
                  `min-count=<minimum_number_of_instances>,`
                  `max-count=<maximum_number_of_instances>,`
                  `resource-preset-id=<host_class>
        ```

        Where:

        * `--coordinator`: [Coordinator](../concepts/index.md#coordinator) configuration.
            
            * `resource-preset-id`: [Class](../concepts/instance-types.md) of coordinator hosts.
        
        * `--worker`: [Worker](../concepts/index.md#workers) configuration:

            * `resource-preset-id`: [Class](../concepts/instance-types.md) of worker hosts.
            * `count`: Number of workers.
            * `min-count`: Minimum number of workers.
            * `max-count`: Maximum number of workers.
                
            For worker count to automatically vary based on load, use `min-count` and `max-count`. If you need to set a fixed number of workers, use `count`.

        You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.   

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

    1. Edit the [coordinator](../concepts/index.md#coordinator) and [worker](../concepts/index.md#workers) configuration under `coordinator` and `worker`, respectively:
      
        ```hcl
        resource "yandex_trino_cluster" "<cluster_name>" {
          ...
          coordinator = {
            resource_preset_id = "<class_of_computing_resources>"
          }
          
          worker = {
            fixed_scale = {
              count = <number_of_instances>
            }
            auto_scale = {
              max_count=<minimum_number_of_instances>
              min_count=<maximum_number_of_instances>
            }
            resource_preset_id = "<class_of_computing_resources>"
          }
          ...
        }
        ```
        
        Where:
        
        * `coordinator`: [Coordinator](../concepts/index.md#coordinator) configuration.
            
            * `resource_preset_id`: [Class](../concepts/instance-types.md) of coordinator hosts.

        * `worker`: [Worker](../concepts/index.md#workers) configuration:
        
            * `resource_preset_id`: [Class](../concepts/instance-types.md) of worker hosts.
            
            * `fixed_scale`: Fixed number of workers.
                
                * `count`: Number of workers

            * `auto_scale`: Worker number autoscaling.
                
                * `min_count`: Minimum number of workers.
                * `max_count`: Maximum number of workers.
            
            For worker count to automatically vary based on load, use the `auto_scale` section and set the minimum and maximum values. For a fixed number of workers, use the `fixed_scale` section and specify the required value.

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
          "updateMask": "<list_of_settings_to_update>",
          "trino": {
            "coordinatorConfig": {
              "resources": {
                "resourcePresetId": "<host_class>"
              }
            },
            "workerConfig": {
              "resources": {
                "resourcePresetId": "<host_class>"
              },
              "scalePolicy": {
                "fixedScale": {
                  "count": "<number_of_instances>"
                },
                "autoScale": {
                  "minCount": "<minimum_number_of_instances>",
                  "maxCount": "<maximum_number_of_instances>"
                }
              }
            }
          }
        }
        ```

        Where:

        * `updateMask`: Comma-separated list of parameters to update.

            {% note warning %}

            When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

            {% endnote %}

        * `trino.coordinatorConfig`: [Coordinator](../concepts/index.md#coordinator) configuration.

            * `resources.resourcePresetId`: [Class](../concepts/instance-types.md) of coordinator hosts.
              
        * `trino.workerConfig`: [Worker](../concepts/index.md#workers) configuration:

            * `resources.resourcePresetId`: [Class](../concepts/instance-types.md) of worker hosts.

            * `scalePolicy.fixedScale`: Fixed number of workers.
                
                * `count`: Number of workers.

            * `scalePolicy.autoScale`: Worker number autoscaling.

                * `minCount`: Minimum number of workers.
                * `maxCount`: Maximum number of workers.

            For worker count to automatically vary based on load, use the `scalePolicy.autoScale` setting to set the minimum and maximum values. For a fixed number of workers, use the `scalePolicy.fixedScale` setting to set the required value.

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
            "coordinator_config": {
              "resources": {
                "resource_preset_id": "<host_class>"
              }
            },
            "worker_config": {
              "resources": {
                "resource_preset_id": "<host_class>"
              },
              "scale_policy": {
                "fixed_scale": {
                  "count": "<number_of_instances>"
                },
                "auto_scale": {
                  "min_count": "<minimum_number_of_instances>",
                  "max_count": "<maximum_number_of_instances>"
                }
              }
            }
          }
        }
        ```

        Where:

        * `cluster_id`: Cluster ID.
            
            You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

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

        * `trino.coordinator_config"`: [Coordinator](../concepts/index.md#coordinator) configuration.

            * `resources.resource_preset_id`: [Class](../concepts/instance-types.md) of coordinator hosts.
              
        * `trino.worker_config`: [Worker](../concepts/index.md#workers) configuration:

            * `resources.resource_preset_id`: [Class](../concepts/instance-types.md) of worker hosts.

            * `scale_policy.fixed_scale`: Fixed number of workers.
                
                * `count`: Number of workers.

            * `scale_policy.auto_scale`: Worker number autoscaling.

                * `minCount`: Minimum number of workers.
                * `maxCount`: Maximum number of workers.

            For worker count to automatically vary based on load, use the `scale_policy.auto_scale` setting to set the minimum and maximum values. For a fixed number of workers, use the `scale_policy.fixed_scale` setting to set the required value.

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

    1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    1. Go to the [folder page]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Change additional cluster settings:
        
        * **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}**: Cluster protection from accidental deletion by a user.

            Even with deletion protection enabled, one can still connect to the cluster manually and delete the data.
        
        * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../concepts/maintenance.md) settings.

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        * **{{ ui-key.yacloud.logging.field_logging }}**: Enables logging. 
        
          * Select the log destination:
            * **{{ ui-key.yacloud.common.folder }}**: Select a folder from the list. Logs will be written to the selected folder's default log group.
                
            * **{{ ui-key.yacloud.logging.label_group }}**: Select a [log group](../../logging/concepts/log-group.md) from the list or create a new one.
            
          * Select **{{ ui-key.yacloud.logging.label_minlevel }}** from the list.

          {% include [logging-roles](../../_includes/managed-trino/logging-roles.md) %}

    1. Change the TLS settings. You can update, add, or delete certificates.

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change additional cluster settings:

    1. See the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    1. Update additional cluster settings using this command:

        ```bash
        {{ yc-mdb-tr }} cluster update <cluster_name_or_ID> \
          --deletion-protection \
          --maintenance-window type=<maintenance_type>,`
                              `day=<day_of_week>,`
                              `hour=<hour> \
          --log-enabled \
          --log-folder-id <folder_ID> \
          --log-group-id <log_group_ID> \
          --log-min-level <logging_level> \
          --trusted-certs-from-files <list_of_paths_to_certificate_files>
        ```

        Where:

        * `--deletion-protection`: Enables cluster protection against accidental deletion.
          
            Even with deletion protection enabled, one can still connect to the cluster manually and delete the data.
        
        * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters), where `type` is the maintenance type:

            {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

        * Logging parameters:

          * `--log-enabled`: Enables logging. Logs generated by {{ TR }} components will be sent to {{ cloud-logging-full-name }}.
          * `--log-folder-id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
          * `--log-group-id`: Custom [log group](../../logging/concepts/log-group.md) ID.

            You can specify only one of the parameters: `--log-folder-id` or `--log-group-id`.

          * `--log-min-level`: Minimum logging level. Possible values: `TRACE`, `DEBUG`, `INFO` (default), `WARN`, `ERROR`, and `FATAL`.
        
          {% include [logging-roles](../../_includes/managed-trino/logging-roles.md) %}
        
        * `--trusted-certs-from-files`: List of paths to files with trusted certificates. 
        
          If you want to delete all certificates, provide `--remove-trusted-certs`.

        You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.   

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

    1. To enable cluster protection against accidental deletion, add the `deletion_protection = true` parameter:
        
        ```hcl
        resource "yandex_trino_cluster" "<cluster_name>" {
          ...
          deletion_protection = true
          ...
        }
        ```

        Where `deletion_protection` is the cluster protection from accidental deletion: `true` or `false`.

        Even with deletion protection enabled, one can still connect to the cluster manually and delete the data.

    1. To change maintenance time (including for disabled clusters), add the `maintenance_window` section to the cluster description:

        {% include [Terraform maintenance window parameters description](../../_includes/managed-trino/terraform/maintenance-window-parameters.md) %}

    1. To enable sending {{ TR }} logs to [{{ cloud-logging-full-name }}](../../logging/), add the `logging` section to the cluster description:

        {% include [Terraform logging parameters description](../../_includes/managed-trino/terraform/logging-parameters.md) %}

        {% include [logging-roles](../../_includes/managed-trino/logging-roles.md) %}

    1. To change the TLS settings:

       {% include [tls description](../../_includes/managed-trino/terraform/tls.md) %}

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
          "updateMask": "<list_of_settings_to_update>",
          "deletionProtection": "<deletion_protection>",
          "logging": {
            "enabled": "<use_of_logging>",
            "folderId": "<folder_ID>",
            "logGroupId": "<log_group_ID>",
            "minLevel": "<logging_level>"
          },
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "tls": {
            "trustedCertificates": [ <list_of_certificates> ]
          }
        }
        ```

        Where:

        * `updateMask`: Comma-separated list of parameters to update.

            {% note warning %}

            When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

            {% endnote %}

        * `deletionProtection`: Cluster protection against accidental deletion, `true` or `false`.

            Even if it is enabled, one can still connect to the cluster manually and delete it.

        * `logging`: Logging parameters:

            * `enabled`: Enables logging. Logs generated by {{ TR }} components will be sent to {{ cloud-logging-full-name }}. The possible values are `true` or `false`.
            * `folderId`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
            * `logGroupId`: Custom [log group](../../logging/concepts/log-group.md) ID.

                You can specify only one of the parameters: `folderId` or `logGroupId`.

            * `minLevel`: Minimum logging level. Possible values: `TRACE`, `DEBUG`, `INFO` (default), `WARN`, `ERROR`, and `FATAL`.

            {% include [logging-roles](../../_includes/managed-trino/logging-roles.md) %}

        * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). Provide one of these two parameters:

            * `anytime`: Maintenance takes place at any time.
            * `weeklyMaintenanceWindow`: Maintenance takes place once a week at the specified time:
            
              * `day`: Day of week for the `WEEKLY` type, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
              * `hour`: Time of day (UTC) for the `WEEKLY` type, from `1` to `24`.
        * `tls`: TLS parameters.

           {% include notitle [tls](../../_includes/managed-trino/cluster-settings.md#tls) %}

           * `trustedCertificates`: Comma-separated list of certificates.

              {% include notitle [tls](../../_includes/managed-trino/cluster-settings.md#cert-list) %}
               
           {% include notitle [tls-pg-ch](../../_includes/managed-trino/cluster-settings.md#tls-pg-ch) %}

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

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": {
            "paths": [
              <list_of_settings_to_update>
            ]
          },
          "deletion_protection": "<deletion_protection>",
          "logging": {
            "enabled": "<use_of_logging>",
            "folder_id": "<folder_ID>",
            "log_group_id": "<log_group_ID>",
            "min_level": "<logging_level>"
          },
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<day_of_week>",
              "hour": "<hour>"
            }
          },
          "tls": {
            "trusted_certificates": [ <list_of_certificates> ]
          }
        }
        ```

        Where:

        * `cluster_id`: Cluster ID.
            
            You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

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

        * `deletion_protection`: Cluster protection against accidental deletion, `true` or `false`.

            Even with deletion protection enabled, one can still connect to the cluster manually and delete the data.

        * `logging`: Logging parameters:

            * `enabled`: Enables logging. Logs generated by {{ TR }} components will be sent to {{ cloud-logging-full-name }}. The possible values are `true` or `false`.
            * `folder_id`: Folder ID. Logs will be written to the default [log group](../../logging/concepts/log-group.md) for this folder.
            * `log_group_id`: Custom [log group](../../logging/concepts/log-group.md) ID.

                You can specify only one of the parameters: `folderId` or `logGroupId`.

            * `min_level`: Minimum logging level. Possible values: `TRACE`, `DEBUG`, `INFO` (default), `WARN`, `ERROR`, and `FATAL`.

            {% include [logging-roles](../../_includes/managed-trino/logging-roles.md) %}

        * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters). Provide one of these two parameters:

            * `anytime`: Maintenance takes place at any time.
            * `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:
            
              * `day`: Day of week for the `WEEKLY` type, i.e., `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
              * `hour`: Time of day (UTC) for the `WEEKLY` type, from `1` to `24`.
        
        * `tls`: TLS parameters.

          {% include notitle [tls](../../_includes/managed-trino/cluster-settings.md#tls) %}

          * `trusted_certificates`: Comma-separated list of certificates.

            {% include notitle [tls](../../_includes/managed-trino/cluster-settings.md#cert-list) %}
               
          {% include notitle [tls-pg-ch](../../_includes/managed-trino/cluster-settings.md#tls-pg-ch) %}

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