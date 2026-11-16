---
title: Working with hybrid storage
description: Follow this guide to enable hybrid storage for a {{ mch-name }} cluster, as well as to set the hybrid storage settings and data storage policies.
---

# Working with hybrid storage

[Hybrid storage](../concepts/storage.md#hybrid-storage-features) enables you to store frequently used data in cluster storage (on the {{ mch-name }} cluster's network drives) while keeping rarely used data in [{{ objstorage-full-name }}](../../storage/).


## Enabling hybrid storage for a cluster {#enable-hybrid-storage}

{% include [hybrid-storage-cannot-be-switched-off](../../_includes/mdb/mch/hybrid-storage-cannot-be-switched-off.md) %}


### Enabling hybrid storage when creating a cluster {#cluster-create}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ CH }} cluster.
    1. [Navigate]({{ link-console-main }}/link/managed-clickhouse) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}** and set the cluster parameters. To learn more about parameters, see the [guide on creating a cluster](cluster-create.md).
    1. Enable **{{ ui-key.yacloud.mdb.forms.additional-field-cloud-storage }}** under **{{ ui-key.yacloud.mdb.forms.section_settings }}** and, optionally, set the hybrid storage settings:

        {% include [hybrid-storage-settings-console](../../_includes/mdb/mch/hybrid-storage-settings-console.md) %}

    1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a cluster with hybrid storage enabled and, optionally, configure its settings:

    1. View the description of the CLI command for creating a cluster:

        ```bash
        {{ yc-mdb-ch }} cluster create --help
        ```

    1. Run this command, specifying hybrid storage settings:

        ```bash
        {{ yc-mdb-ch }} cluster create \
           ...
           --cloud-storage=true \
           --cloud-storage-data-cache=<cache_data> \
           --cloud-storage-data-cache-max-size=<maximum_memory_in_bytes> \
           --cloud-storage-move-factor=<share_of_free_space> \
           --cloud-storage-prefer-not-to-merge=<disable_merging_data_parts>
          ...
        ```

        Where:

        * `--cloud-storage`: Enables hybrid storage.

        {% include [hybrid-storage-settings-cli](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

        To learn more about the `{{ yc-mdb-ch }} cluster create` command's other parameters, see the [guide on creating a cluster](cluster-create.md).

- {{ TF }} {#tf}

    1. Create a {{ TF }} configuration file describing your [infrastructure](cluster-create.md).
    1. Add the `cloud_storage` section to the configuration file:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<cluster_name>" {
          ...
          cloud_storage = {
            enabled             = true
            move_factor         = <share_of_free_space>
            data_cache_enabled  = <cache_data>
            data_cache_max_size = <maximum_memory_in_bytes>
            prefer_not_to_merge = <disable_merging_data_parts>
          }
        }
        ```

        Where:

        * `enabled`: Enables hybrid storage.

        {% include [tf-hybrid-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

    1. Make sure the {{ TF }} configuration file is correct:

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Create a cluster:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Create](../api-ref/Cluster/create.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        1. Create a file named `body.json` and paste the following code into it:

            ```json
            {
              <cluster_parameters>
              ...
              "configSpec": {
                "cloudStorage": {
                  "enabled": true,
                  "moveFactor": "<share_of_free_space>",
                  "dataCacheEnabled": <cache_data>,
                  "dataCacheMaxSize": "<maximum_memory_in_bytes>",
                  "preferNotToMerge": <disable_merging_data_parts>
                },
                ...
              }
            }
            ```

            Where:

            * `enabled`: Enables hybrid storage.

            {% include [rest-cloud-storage-settings](../../_includes/mdb/mch/api/rest-cloud-storage-settings.md) %}

            To learn more about other parameters, see the [guide on creating a cluster](cluster-create.md).

        1. Run this request:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters' \
              --data '@body.json'
            ```

    1. View the [server response](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.Create](../api-ref/grpc/Cluster/create.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        1. Create a file named `body.json` and paste the following code into it:

            ```json
            {
              <cluster_parameters>
              ...
              "config_spec": {
                "cloud_storage": {
                  "enabled": true,
                  "move_factor": "<share_of_free_space>",
                  "data_cache_enabled": <cache_data>,
                  "data_cache_max_size": "<maximum_memory_in_bytes>",
                  "prefer_not_to_merge": <disable_merging_data_parts>
                },
                ...
              }
            }
            ```

            Where:

            * `enabled`: Enables hybrid storage.

            {% include [grpc-cloud-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

            To learn more about other parameters, see the [guide on creating a cluster](cluster-create.md).

        1. Run this request:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.Create \
              < body.json
            ```

    1. Check the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


### Enabling hybrid storage for an existing cluster {#cluster-update}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the cluster.
    1. [Navigate]({{ link-console-main }}/link/managed-clickhouse) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Enable **{{ ui-key.yacloud.mdb.forms.additional-field-cloud-storage }}** under **{{ ui-key.yacloud.mdb.forms.section_settings }}** and, optionally, set the hybrid storage settings:

        {% include [hybrid-storage-settings-console](../../_includes/mdb/mch/hybrid-storage-settings-console.md) %}

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To enable hybrid storage in a cluster and, optionally, configure its settings, run this command:

    ```bash
    {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
       --cloud-storage=true \
       --cloud-storage-data-cache=<cache_data> \
       --cloud-storage-data-cache-max-size=<maximum_memory_in_bytes> \
       --cloud-storage-move-factor=<share_of_free_space> \
       --cloud-storage-prefer-not-to-merge=<disable_merging_data_parts>
    ```

    Where:

    * `<cluster_name_or_ID>`: Cluster name or ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.
    * `--cloud-storage`: Enables hybrid storage.

    {% include [hybrid-storage-settings-cli](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

- {{ TF }} {#tf}

    To enable hybrid storage in a cluster and, optionally, configure its settings:

    1. Open the current {{ TF }} configuration file with the infrastructure plan.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

        For the complete list of configurable {{ mch-name }} cluster fields, see [this {{ TF }} provider guide]({{ tf-provider-mch }}).

    1. Add the `cloud_storage` section to the {{ mch-name }} cluster description:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<cluster_name>" {
          ...
          cloud_storage = {
            enabled             = true
            move_factor         = <share_of_free_space>
            data_cache_enabled  = <cache_data>
            data_cache_max_size = <maximum_memory_in_bytes>
            prefer_not_to_merge = <disable_merging_data_parts>
          }
        }
        ```

        Where:

        * `enabled`: Enables hybrid storage.

        {% include [tf-hybrid-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

    1. Make sure the {{ TF }} configuration file is correct:

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "<list_of_settings_to_update>",
                      "configSpec": {
                        "cloudStorage": {
                          "enabled": true,
                          "moveFactor": "<share_of_free_space>",
                          "dataCacheEnabled": <cache_data>,
                          "dataCacheMaxSize": "<maximum_memory_in_bytes>",
                          "preferNotToMerge": <disable_merging_data_parts>
                        }
                      }
                    }'
        ```

        Where:

        * `<cluster_ID>`: Cluster ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.
        * `updateMask`: Comma-separated string of settings to update.
        * `configSpec.cloudStorage`: Hybrid storage settings:

            * `enabled`: Enables hybrid storage.

            {% include [rest-cloud-storage-settings](../../_includes/mdb/mch/api/rest-cloud-storage-settings.md) %}

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      <list_of_settings_to_update>
                    ]
                  },
                  "config_spec": {
                    "cloud_storage": {
                      "enabled": true,
                      "move_factor": "<share_of_free_space>",
                      "data_cache_enabled": <cache_data>,
                      "data_cache_max_size": "<maximum_memory_in_bytes>",
                      "prefer_not_to_merge": <disable_merging_data_parts>
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Where:

        * `<cluster_ID>`: Cluster ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.
        * `update_mask`: List of settings to update as an array of strings (`paths[]`).
        * `config_spec.cloud_storage`: Hybrid storage settings:

            * `enabled`: Enables hybrid storage.

            {% include [grpc-cloud-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

        You can get the cluster ID with the [list of clusters](./cluster-list.md#list-clusters) in the folder.

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


## Changing the hybrid storage settings {#change-hybrid-storage}

If a {{ mch-name }} cluster has hybrid storage enabled, you can change its settings.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder containing the cluster.
    1. [Navigate]({{ link-console-main }}/link/managed-clickhouse) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, edit the hybrid storage settings:

        {% include [hybrid-storage-settings-console](../../_includes/mdb/mch/hybrid-storage-settings-console.md) %}

    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To edit hybrid storage settings, run this command:

    ```bash
    {{ yc-mdb-ch }} cluster update <cluster_name_or_ID> \
        --cloud-storage-data-cache=<cache_data> \
        --cloud-storage-data-cache-max-size=<maximum_memory_in_bytes> \
        --cloud-storage-move-factor=<share_of_free_space> \
        --cloud-storage-prefer-not-to-merge=<disable_merging_data_parts>
    ```

    Where:

    * `<cluster_name_or_ID>`: Cluster name or ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.

    {% include [hybrid-storage-settings-cli](../../_includes/mdb/mch/hybrid-storage-settings-cli.md) %}

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with the infrastructure plan.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

        For the complete list of configurable {{ mch-name }} cluster fields, see [this {{ TF }} provider guide]({{ tf-provider-mch }}).

    1. In the {{ mch-name }} cluster description, edit the `cloud_storage` section attributes:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<cluster_name>" {
          ...
          cloud_storage = {
            ...
            move_factor         = <share_of_free_space>
            data_cache_enabled  = <cache_data>
            data_cache_max_size = <maximum_memory_in_bytes>
            prefer_not_to_merge = <disable_merging_data_parts>
          }
        }
        ```

        Where:

        {% include [tf-hybrid-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

    1. Make sure the {{ TF }} configuration file is correct:

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "<list_of_settings_to_update>",
                      "configSpec": {
                        "cloudStorage": {
                          "moveFactor": "<share_of_free_space>",
                          "dataCacheEnabled": <cache_data>,
                          "dataCacheMaxSize": "<maximum_memory_in_bytes>",
                          "preferNotToMerge": <disable_merging_data_parts>
                        }
                      }
                    }'
        ```

        Where:

        * `<cluster_ID>`: Cluster ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.
        * `updateMask`: Comma-separated string of settings to update.
        * `configSpec.cloudStorage`: Hybrid storage settings:

            {% include [rest-cloud-storage-settings](../../_includes/mdb/mch/api/rest-cloud-storage-settings.md) %}

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      <list_of_settings_to_update>
                    ]
                  },
                  "config_spec": {
                    "cloud_storage": {
                      "move_factor": "<share_of_free_space>",
                      "data_cache_enabled": <cache_data>,
                      "data_cache_max_size": "<maximum_memory_in_bytes>",
                      "prefer_not_to_merge": <disable_merging_data_parts>
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Where:

        * `<cluster_ID>`: Cluster ID which you can get with the [list of clusters](cluster-list.md#list-clusters) in the folder.
        * `update_mask`: List of settings to update as an array of strings (`paths[]`).
        * `config_spec.cloud_storage`: Hybrid storage settings:

            {% include [grpc-cloud-storage-settings](../../_includes/mdb/mch/api/grpc-cloud-storage-settings.md) %}

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Setting data storage policies {#policies-create}

In a {{ mch-name }} cluster with hybrid storage enabled, three [storage policies](../concepts/storage.md#storage-policies) are available: `default`, `local`, and `object_storage`. For DB tables, you can specify one of them. You cannot create new storage policies or update the existing ones.

### Getting information about policies {#get-info}

To view policy settings, run this query:

{% list tabs group=instructions %}

- SQL {#sql}

    ```sql
    SELECT *
    FROM system.storage_policies;
    ```

{% endlist %}


### Setting a policy when creating a table {#table-create}

To set a policy when creating a table, run this query:

{% list tabs group=instructions %}

- SQL {#sql}

    ```sql
    CREATE TABLE <table_name> (
        <table_schema>
    ) ENGINE = MergeTree
    ...
    SETTINGS storage_policy = '<storage_policy>';
    ```

{% endlist %}

### Setting a policy for an existing a table {#table-update}

To set or edit a policy for an existing a table, run this query:

{% list tabs group=instructions %}

- SQL {#sql}

    ```sql
    ALTER TABLE <table_name>
    MODIFY SETTING storage_policy = '<storage_policy>';
    ```

{% endlist %}


## Monitoring space taken up by data in {{ objstorage-name }} {#metrics}

{% include [hybrid-storage-monitoring](../../_includes/mdb/mch/hybrid-storage-monitoring.md) %}


## Use cases {#examples}

* [{#T}](../tutorials/hybrid-storage.md)
