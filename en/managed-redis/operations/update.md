---
title: How to change {{ VLK }} cluster settings in {{ mrd-full-name }}
description: In this tutorial, you will learn how to change {{ VLK }} cluster settings.
---

# Updating {{ VLK }} cluster settings

After creating a cluster, you can:

* [Change the cluster name and description](#change-name-and-description).

* [Configure the use of FQDNs instead of IP addresses](#configure-fqdn-ip-behavior).

* [Change the data persistence mode](#change-persistence-mode).

* [Change the host class](#change-resource-preset).


* [Change the disk type and increase storage size](#change-disk-size).


* [Set up automatic increase of storage size](#disk-size-aut0scale).

* [Configure](#change-redis-config) {{ VLK }} servers as described in the [{{ VLK }}](https://valkey.io/documentation) documentation. For a list of supported settings, see the [{#T}](../concepts/settings-list.md) section and the [API reference](../api-ref/Cluster/update.md).

* [Change additional cluster settings](#change-additional-settings).

* [Enable sharding](#enable-sharding) in a non-sharded cluster.

* [Move the cluster](#move-cluster) to another folder.


* [Edit security groups](#change-sg-set).


Learn more about other cluster updates:

* [{#T}](cluster-version-update.md).

* [Migrating hosts to a different availability zone](host-migration.md)

* [Updating {{ VLK }} user settings](user-update.md)

## Changing the cluster name and description {#change-name-and-description}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Select the cluster in question.
  1. At the top of the page, click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, enter a new name and description for the cluster.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change cluster name and description:

  1. View the description of the CLI command for updating a cluster:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Specify a new name and description in the cluster update command:

     ```bash
     {{ yc-mdb-rd }} cluster update <cluster_name_or_ID> \
       --new-name <new_cluster_name> \
       --description <new_cluster_description>
     ```

- {{ TF }} {#tf}

    {% note alert %}

    Do not change the cluster name using {{ TF }}. This will delete the existing cluster and create a new one.

    {% endnote %}

    To update the cluster description:

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more information about creating this file, see [this guide](./cluster-create.md).

    1. Edit the `description` parameter in the {{ mrd-name }} cluster description:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<cluster_name>" {
          name        = "<cluster_name>"
          description = "<new_cluster_description>"
          ...
        }
        ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see this [{{ TF }} provider guide]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "name,description",
                      "name": "<new_cluster_name>",
                      "description": "<new_cluster_description>"
                    }'
        ```

        Where `updateMask` is the list of parameters to update as a single string, separated by commas.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ "name", "description" ]
                  },
                  "name": "<new_cluster_name>",
                  "description": "<new_cluster_description>" 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Where `update_mask` is the list of parameters to update as an array of `paths[]` strings.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Configuring the use of FQDNs instead of IP addresses {#configure-fqdn-ip-behavior}

If the relevant setting is disabled (by default), {{ VLK }} uses IP addresses as host addresses. If this setting is enabled, it will replace the host's IP address with its FQDN. For more information about this setting and its uses, see [{#T}](../concepts/network.md#fqdn-ip-setting).

{% include [fqdn-option-compatibility-note](../../_includes/mdb/mrd/connect/fqdn-option-compatibility-note.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    To enable or disable the use of FQDNs instead of IP addresses:

    1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Select the cluster in question.
    1. At the top of the page, click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, enable or disable **{{ ui-key.yacloud.redis.field_announce-hostnames }}**.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To enable or disable the use of FQDNs instead of IP addresses:

    1. View the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-rd }} cluster update --help
        ```

    1. Provide the required setting value in the update cluster command:

        ```bash
        {{ yc-mdb-rd }} cluster update <cluster_name_or_ID> \
          --announce-hostnames <using_FQDNs_instead_of_IP_addresses>
        ```

        `--announce-hostnames`: Enables or disables using FQDNs instead of IP addresses: `true` or `false`.

        You can get the cluster name and ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    To enable or disable the use of FQDNs instead of IP addresses:

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more information about creating this file, see [this guide](./cluster-create.md).

    1. Edit the `announce_hostnames` parameter in the {{ mrd-name }} cluster description:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<cluster_name>" {
          name        = "<cluster_name>"
          ...
          announce_hostnames    = <using_FQDNs_instead_of_IP_addresses>
          ...
        }
        ```

        `announce_hostnames`: Enables or disables using FQDNs instead of IP addresses: `true` or `false`.

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see this [{{ TF }} provider guide]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "announceHostnames",
                      "announceHostnames": <using_FQDNs_instead_of_IP_addresses>
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated list of settings you want to update.

            Here, we provide only one setting.

        * `announceHostnames`: [Using FQDNs instead of IP addresses](../concepts/network.md#fqdn-ip-setting), `true` or `false`.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ "announce_hostnames" ]
                  },
                  "announce_hostnames": <using_FQDNs_instead_of_IP_addresses>
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

            Here, we provide only one setting.

        * `announce_hostnames`: [Using FQDNs instead of IP addresses](../concepts/network.md#fqdn-ip-setting), `true` or `false`.

        You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing the data persistence mode {#change-persistence-mode}

For more information about data persistence and its settings, see [Persistence](../concepts/replication.md#persistence).

{% list tabs group=instructions %}

- Management console {#console}

    To change the persistence mode:

    1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Select the cluster in question.
    1. At the top of the page, click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, select the persistence mode.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the persistence mode:

    1. View the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-rd }} cluster update --help
        ```

    1.  Provide the required setting value in the update cluster command:

        ```bash
        {{ yc-mdb-rd }} cluster update <cluster_name_or_ID> \
          --persistence-mode <persistence_mode>
        ```

        {% include [persistence-modes](../../_includes/mdb/mrd/persistence-modes.md) %}

        You can get the cluster name and ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    To change the persistence mode:

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more information about creating this file, see [this guide](./cluster-create.md).

    1. Edit the `persistence_mode` parameter in the {{ mrd-name }} cluster description:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<cluster_name>" {
          name = "<cluster_name>"
          ...
          persistence_mode = "<persistence_mode>"
          ...
        }
        ```

        {% include [persistence-modes](../../_includes/mdb/mrd/persistence-modes.md) %}

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see this [{{ TF }} provider guide]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "persistenceMode",
                      "persistenceMode": "<persistence_mode>"
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated list of settings you want to update.

            Here, we provide only one setting.

        * `persistenceMode`: Persistence mode.

            {% include [persistence-modes](../../_includes/mdb/mrd/persistence-modes.md) %}

        You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ "persistence_mode" ]
                  },
                  "persistence_mode": "<persistence_mode>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

            Here, we provide only one setting.

        * `persistence_mode`: Persistence mode.

           {% include [persistence-modes](../../_includes/mdb/mrd/persistence-modes.md) %}

        You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing the host class {#change-resource-preset}


When changing the host class:

* Your single-host cluster will be unavailable for a few minutes with database connections terminated.
* In a non-sharded multiple-host cluster:
   * The master will change. Its hosts will be stopped and updated one by one. Once stopped, a host will be unavailable for a few minutes.
   * Using a [special FQDN](./connect/non-sharded.md#special-fqdns) does not guarantee a stable database connection: user sessions may be terminated.
* In a sharded cluster:
   * The master will change in each multiple-host shard.
   * Hosts in each shard will be stopped and updated one at a time. The shard's stopped master host will be unavailable for a few minutes.
   * Master host name resolution may not be available. If public access to the host is enabled, you can only connect using the host IP address.

We recommend changing the host class only when your cluster has no active workload.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Select the cluster in question.
  1. At the top of the page, click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_resource }}**:
     
	 * Select a platform in the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** field.
     * Select the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** of the virtual machine the hosts will be deployed on:
        * `high-memory`: Increased RAM per 1 vCPU.
        * `burstable`: Partial guaranteed share of vCPU. VMs with a guaranteed share of less than 100% ensure the specified level of performance with a possible temporary performance increase up to 100%. Clusters with such hosts are good for tasks that do not require guaranteed permanent performance (for example, testing).
     * Modify the host configuration.
	 
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the [host class](../concepts/instance-types.md) for a cluster:

  1. View the description of the CLI command for updating a cluster:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Get the list of available host classes (the `ZONE IDS` column specifies the availability zones where you can select the appropriate class):

     
     ```bash
     {{ yc-mdb-rd }} resource-preset list
     ```

     Result:

     ```text
     +-------------+--------------------------------+----------+
     |     ID      |            ZONE IDS            |  MEMORY  |
     +-------------+--------------------------------+----------+
     | b1.nano     | {{ region-id }}-a, {{ region-id }}-b,  | 2.0 GB   |
     |             | {{ region-id }}-d                  |          |
     | b1.small    | {{ region-id }}-a, {{ region-id }}-b,  | 4.0 GB   |
     |             | {{ region-id }}-d                  |          |
     | hm1.nano    | {{ region-id }}-a, {{ region-id }}-b,  | 8.0 GB   |
     |             | {{ region-id }}-d                  |          |
     | hm1.micro   | {{ region-id }}-a, {{ region-id }}-b,  | 12.0 GB  |
     | ...                                                     |
     +-----------+----------------------------------+----------+
     ```


  1. Specify the class in the update cluster command:

     ```bash
     {{ yc-mdb-rd }} cluster update <cluster_name_or_ID> \
       --resource-preset <host_class_ID>
     ```

     {{ mrd-short-name }} will run the update host class command for the cluster.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more information about creating this file, see [this guide](./cluster-create.md).

    1. In the {{ mrd-name }} cluster description, edit the `resource_preset_id` parameter under `resources`:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<cluster_name>" {
          ...
          resources {
            resource_preset_id = "<host_class>"
            ...
            }
        }
        ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see this [{{ TF }} provider guide]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.resources.resourcePresetId",
                      "configSpec": {
                        "resources": {
                          "resourcePresetId": "<host_class>"
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated list of settings you want to update.

            In this case, only one parameter is provided.

        * `configSpec.resources.resourcePresetId`: New [host class](../concepts/instance-types.md). To retrieve a list of supported values, use the [ResourcePreset.List](../api-ref/ResourcePreset/list.md) method.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ "config_spec.resources.resource_preset_id" ]
                  },
                  "config_spec": {
                    "resources": {
                      "resource_preset_id": "<host_class>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

            Only one parameter is provided in this case.

        * `config_spec.resources.resource_preset_id`: New [host class](../concepts/instance-types.md). To retrieve a list of supported values, use the [ResourcePreset.List](../api-ref/ResourcePreset/list.md) method.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

The {{ mrd-name }} cluster is unavailable for about five to seven minutes after changing the host class.

## Changing the disk type and increasing the storage size {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To change the disk type and increase the storage size for a cluster:

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Select the cluster in question.
  1. At the top of the page, click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.

  
  1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      * Select the [disk type](../concepts/storage.md).
      * Specify the required disk size.


  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To increase storage size of {{ VLK }} hosts:

  1. View the description of the CLI command for updating a cluster:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Specify the required storage size in the update cluster command. The new size must be at least as large as the current `disk_size` in the cluster properties.

     ```bash
     {{ yc-mdb-rd }} cluster update <cluster_name_or_ID> \
       --disk-size <storage_size_in_GB>
     ```

     If all the criteria are met, {{ mrd-short-name }} starts increasing the size of the {{ VLK }} host disks.

- {{ TF }} {#tf}

  To increase your cluster storage size:

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more information about creating this file, see [this guide](./cluster-create.md).

    1. In the {{ mrd-name }} cluster description, edit the `disk_size` parameter under `resources`:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<cluster_name>" {
          ...
          resources {
            disk_size = <storage_size_in_GB>
            ...
            }
        }
        ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see this [{{ TF }} provider guide]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        
        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.resources.diskTypeId,configSpec.resources.diskSize",
                      "configSpec": {
                        "resources": {
                          "diskTypeId": "<disk_type>",
                          "diskSize": "<storage_size_in_bytes>"
                        }
                      }
                    }'
        ```


        Where:

        * `updateMask`: Comma-separated list of settings you want to update.

        
        * `configSpec.resources`: Storage parameters:

            * `diskTypeId`: [Disk type](../concepts/storage.md).
            * `diskSize`: New storage size in bytes.


        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        
        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.resources.disk_type_id",
                      "config_spec.resources.disk_size"
                    ]
                  },
                  "config_spec": {
                    "resources": {
                      "disk_type_id": "<disk_type>",
                      "disk_size": "<storage_size_in_bytes>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```


        Where:

        * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

        
        * `config_spec.resources`: Storage parameters:

            * `disk_type_id`: [Disk type](../concepts/storage.md).
            * `disk_size`: New storage size in bytes.


        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Setting up automatic increase of storage size {#disk-size-autoscale}

For more information about storage and automatic increase, see [Storage in {{ mrd-name }}](../concepts/storage.md).

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.

  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg), then select **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.

  1. Under **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**, configure the automatic increase of disk size:

        {% include [console-autoscaling](../../_includes/mdb/mrd/console-autoscaling.md) %}

  1. Save your changes.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To set up automatic increase of storage size:

  1. View the description of the CLI command for updating a cluster:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Set the maximum storage size and conditions for its increase in the update cluster command.

      ```bash
      {{ yc-mdb-rd }} cluster update <cluster_ID_or_name> \
          --disk-size-autoscaling planned-usage-threshold=<scheduled_increase_percentage>,`
                                  `emergency-usage-threshold=<immediate_increase_percentage>,`
                                  `disk-size-limit=<maximum_storage_size_in_GB> \
      ```

      Where:

      {% include [autoscale-description](../../_includes/mdb/mrd/cli-autoscaling.md) %}

- {{ TF }} {#tf}

  To set up automatic increase of storage size:

  1. Open the current {{ TF }} configuration file describing your infrastructure.

      For more information about creating this file, see [this guide](cluster-create.md).

  1. Add the following section to the cluster description:

      ```hcl
      disk_size_autoscaling {
        planned_usage_threshold   = "<scheduled_increase_percentage>"
        emergency_usage_threshold = "<immediate_increase_percentage>"
        disk_size_limit           = "<maximum_storage_size_in_GiB>"
      }
      ```

      Where:

      {% include [autoscale-description](../../_includes/mdb/mrd/terraform/terraform-autoscaling.md) %}

  1. Validate your configuration.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [terraform-timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.diskSizeAutoscaling",
                      "configSpec": {
                        "diskSizeAutoscaling": {
                          "plannedUsageThreshold": "<scheduled_increase_percentage>",
                          "emergencyUsageThreshold": "<immediate_increase_percentage>",
                          "diskSizeLimit": "<maximum_storage_size_in_bytes>"
                        }
                      }
                    }'
        ```

        Where:

          * `updateMask`: Comma-separated list of settings you want to update.

        {% include [autoscale-description](../../_includes/mdb/mrd/api/autoscaling-rest.md) %}

        You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ "config_spec.disk_size_autoscaling" ]
                  },
                  "config_spec": {
                    "disk_size_autoscaling": {
                      "planned_usage_threshold": "<scheduled_increase_percentage>",
                      "emergency_usage_threshold": "<immediate_increase_percentage>",
                      "disk_size_limit": "<maximum_storage_size_in_bytes>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Where:

          * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

          {% include [autoscale-description](../../_includes/mdb/mrd/api/autoscaling-grpc.md) %}

        You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing {{ VLK }} settings {#change-redis-config}

You can change the DBMS settings for the hosts in your cluster. You can find all the supported settings in [{#T}](../concepts/settings-list.md) and in the [API reference](../api-ref/Cluster/update.md).

{% list tabs group=instructions %}

- Management console {#console}

  To update the [DBMS settings](../concepts/settings-list.md) for the cluster:

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Select the cluster in question.
  1. At the top of the page, click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, click **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
  1. Configure the available parameters according to the [{{ VLK }} documentation](https://valkey.io/documentation).
  1. Click **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.

- {{ TF }} {#tf}

    To update the [DBMS settings](../concepts/settings-list.md) for the cluster:

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more information about creating this file, see [this guide](./cluster-create.md).

    1. In the {{ mrd-name }} cluster description, edit these `config` section parameters:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<cluster_name>" {
          ...
          config {
            password         = "<password>"
            timeout          = <time>
            maxmemory_policy = "<policy>"
            ...
          }
        }
        ```

        Where:

        * `timeout`: Time, in seconds, before disabling inactive clients.
        * `maxmemory_policy`: Memory management policy if low on memory.

        {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see this [{{ TF }} provider guide]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.redisConfig_<{{ VLK }}_version>.<setting_1>,configSpec.redisConfig_<{{ VLK }}_version>.<setting_2>,...,configSpec.redisConfig_<{{ VLK }}_version>.<setting_N>",
                      "configSpec": {
                        "redisConfig_<{{ VLK }}_version>": {
                          "<setting_1>": "<value_1>",
                          "<setting_2>": "<value_2>",
                          ...
                          "<setting_N>": "<value_N>"
                        }
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated list of settings you want to update.

        * `configSpec.redisConfig_<{{ VLK }}_version>`: {{ VLK }} settings. Use a separate line for each setting; separate them by commas.

            See the [method description](../api-ref/Cluster/update.md#yandex.cloud.mdb.redis.v1.UpdateClusterRequest) for the list of {{ VLK }} versions available for the parameter. See [{#T}](../concepts/settings-list.md) for a description and possible values for each setting.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.redis_config_<{{ VLK }}_version>.<setting_1>",
                      "config_spec.redis_config_<{{ VLK }}_version>.<setting_2>",
                      ...
                      "config_spec.redis_config_<{{ VLK }}_version>.<setting_N>"
                    ]
                  },
                  "config_spec": {
                    "redis_config_<{{ VLK }}_version>": {
                      "<setting_1>": "<value_1>",
                      "<setting_2>": "<value_2>",
                      ...
                      "<setting_N>": "<value_N>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

        * `config_spec.redis_config_<{{ VLK }}_version>`: {{ VLK }} settings. Use a separate line for each setting; separate them by commas.

            See the [method description](../api-ref/Cluster/update.md#yandex.cloud.mdb.redis.v1.UpdateClusterRequest) for the list of {{ VLK }} versions available for the parameter. See [{#T}](../concepts/settings-list.md) for a description and possible values for each setting.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Select the cluster in question.
  1. At the top of the page, click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Change additional cluster settings:

     {% include [mrd-extra-settings](../../_includes/mdb/mrd-extra-settings-web-console.md) %}

  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change additional cluster settings:

    1. View the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-rd }} cluster update --help
        ```

    1. Run the following command with the list of settings to update:

        
        ```bash
        {{ yc-mdb-rd }} cluster update <cluster_name_or_ID> \
            --backup-window-start <time> \
            --maintenance-window type=<maintenance_type>,`
                                `day=<day_of_week>,`
                                `hour=<hour> \
            --websql-access=<true_or_false> \
            --deletion-protection
        ```


    You can update the following settings:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--maintenance-window`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters), where `type` is the maintenance type:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}
    
    * `--websql-access`: Enables [SQL queries](web-sql-query.md) against cluster databases from the {{ yandex-cloud }} management console using {{ websql-full-name }}. The default value is `false`.

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

    You can get the cluster name from the [folder’s cluster list](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more information about creating this file, see [this guide](./cluster-create.md).

    1. In the {{ mrd-name }} cluster description, edit the parameters you need:
    
        * To set the backup start time, add the `backup_window_start` section.
        
            ```hcl
            resource "yandex_mdb_redis_cluster" "<cluster_name>" {
                ...
                backup_window_start {
                    hours   = <hours>
                    minutes = <minutes>
                }
            }
            ```

            Where:

            * `hours`: Backup start hour, UTC, in `HH` format: `0` to `23`.
            * `minutes`: Backup start minute, UTC, in `mm` format: `0` to `59`.

        * To set up the [maintenance window](../concepts/maintenance.md) (for disabled clusters as well), add the `maintenance_window` section to the cluster description:

            ```hcl
            resource "yandex_mdb_redis_cluster" "<cluster_name>" {
            ...
                maintenance_window {
                    day  = <day_of_week>
                    hour = <start_hour>
                    type = "ANYTIME"
                }
            }
            ```

            Where `type` is the maintenance type, which can be:

            * `ANYTIME`: Any time.
            * `WEEKLY`: On a schedule. When specifying this value, you also need to set the following parameters:
                * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

        * To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

            ```hcl
            resource "yandex_mdb_redis_cluster" "<cluster_name>" {
            ...
                    deletion_protection = false
            }
            ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see this [{{ TF }} provider guide]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.backupWindowStart,maintenanceWindow,deletionProtection",
                      "configSpec": {
                        "backupWindowStart": {
                          "hours": "<hours>",
                          "minutes": "<minutes>",
                          "seconds": "<seconds>",
                          "nanos": "<nanoseconds>"
                        }
                      },
                      "maintenanceWindow": {
                        "weeklyMaintenanceWindow": {
                          "day": "<day_of_week>",
                          "hour": "<hour>"
                        }
                      },
                      "deletionProtection": <cluster_deletion_protection>
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated list of settings you want to update.

        * `configSpec.backupWindowStart`: [Backup](../concepts/backup.md) window settings.

            In this parameter, specify the backup start time:

            * `hours`: Between `0` and `23` hours.
            * `minutes`: Between `0` and `59` minutes.
            * `seconds`: Between `0` and `59` seconds.
            * `nanos`: Between `0` and `999999999` nanoseconds.

        * `maintenanceWindow`: [Maintenance window](../concepts/maintenance.md) settings, including those for disabled clusters. Provide one of the two parameters:

            * `anytime`: Maintenance takes place at any time.
            * `weeklyMaintenanceWindow`: Maintenance takes place once a week at the specified time:

                * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

        * `deletionProtection`: Cluster protection from accidental deletion, `true` or `false`.

            {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

        You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.backup_window_start",
                       "maintenance_window",
                       "deletion_protection"
                    ]
                  },
                  "config_spec": {
                    "backup_window_start": {
                      "hours": "<hours>",
                      "minutes": "<minutes>",
                      "seconds": "<seconds>",
                      "nanos": "<nanoseconds>"
                    }
                  },
                  "maintenance_window": {
                    "weekly_maintenance_window": {
                      "day": "<day_of_week>",
                      "hour": "<hour>"
                    }
                  },
                  "deletion_protection": <cluster_deletion_protection>
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

        * `config_spec.backup_window_start`: [Backup](../concepts/backup.md) window settings.

            In this parameter, specify the backup start time:

            * `hours`: Between `0` and `23` hours.
            * `minutes`: Between `0` and `59` minutes.
            * `seconds`: Between `0` and `59` seconds.
            * `nanos`: Between `0` and `999999999` nanoseconds.

        * `maintenance_window`: [Maintenance window](../concepts/maintenance.md) settings, including those for disabled clusters. Provide one of the two parameters:

            * `anytime`: Maintenance takes place at any time.
            * `weekly_maintenance_window`: Maintenance takes place once a week at the specified time:

                * `day`: Day of week in `DDD` format: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, or `SUN`.
                * `hour`: Time of day (UTC) in `HH` format, from `1` to `24`.

        * `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

            {% include [deletion-protection-limits-data](../../_includes/mdb/deletion-protection-limits-data.md) %}

        You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Enabling sharding {#enable-sharding}

You can enable [sharding](../concepts/sharding.md) in a non-sharded cluster to make it a sharded one.

{% note warning %}

You cannot disable sharding in a cluster where it is already enabled.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Select the cluster in question.
    1. At the top of the page, click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, enable **{{ ui-key.yacloud.mdb.forms.field_cluster-mode }}**.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

    {% include [enable-sharding-shard-note](../../_includes/mdb/mrd/enable-sharding-shard-note.md) %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To enable sharding:

    1. View the description of the CLI command to enable sharding:

        ```bash
        {{ yc-mdb-rd }} cluster enable-sharding --help
        ```

    1. Run this command:

        ```bash
        {{ yc-mdb-rd }} cluster enable-sharding <cluster_ID>
        ```

        You can get the cluster ID from the [folder’s cluster list](./cluster-list.md#list-clusters).

    {% include [enable-sharding-shard-note](../../_includes/mdb/mrd/enable-sharding-shard-note.md) %}

- {{ TF }} {#tf}

    To enable sharding:

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more information about creating this file, see [this guide](./cluster-create.md).

    1. Add the `sharded` parameter set to `true` to the {{ mrd-name }} cluster description:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<cluster_name>" {
            ...
            sharded = true
        }
        ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    {% include [enable-sharding-shard-note](../../_includes/mdb/mrd/enable-sharding-shard-note.md) %}

    You can also [manage shards](../operations/shards.md).

    For more information, see this [{{ TF }} provider guide]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.EnableSharding](../api-ref/Cluster/enableSharding.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>:enable_sharding'
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        {% include [enable-sharding-shard-note](../../_includes/mdb/mrd/enable-sharding-shard-note.md) %}

    1. Check the [server response](../api-ref/Cluster/enableSharding.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.EnableSharding](../api-ref/grpc/Cluster/enableSharding.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.EnableSharding
        ```

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        {% include [enable-sharding-shard-note](../../_includes/mdb/mrd/enable-sharding-shard-note.md) %}

    1. Check the [server response](../api-ref/grpc/Cluster/enableSharding.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Moving a cluster {#move-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the cluster you want to move.
    1. Select **{{ ui-key.yacloud.mdb.clusters.button_action-move }}**.
    1. Select the folder you want to move your cluster to.
    1. Click **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To move a cluster:

    1. View the description of the CLI move cluster command:

        ```bash
        {{ yc-mdb-rd }} cluster move --help
        ```

    1. Specify the destination folder in that command:

        ```bash
        {{ yc-mdb-rd }} cluster move <cluster_ID> \
           --destination-folder-name=<destination_folder_name>
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more information about creating this file, see [this guide](./cluster-create.md).

    1. In the {{ mrd-name }} cluster description, edit or add the `folder_id` value:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<cluster_name>" {
          ...
          folder_id = "<destination_folder_ID>"
        }
        ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see this [{{ TF }} provider guide]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Move](../api-ref/Cluster/move.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>:move' \
            --data '{
                      "destinationFolderId": "<folder_ID>"
                    }'
        ```

        Where `destinationFolderId` is the ID of the folder to move the cluster to.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).

    1. Check the [server response](../api-ref/Cluster/move.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Move](../api-ref/grpc/Cluster/move.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "destination_folder_id": "<folder_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Move
        ```

        Where `destination_folder_id` is the ID of the folder to move the cluster to.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters) and the folder ID with the [list of folders in the cloud](../../resource-manager/operations/folder/get-id.md).

    1. Check the [server response](../api-ref/grpc/Cluster/move.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


## Changing security groups {#change-sg-set}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Select the cluster in question.
    1. At the top of the page, click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**, select security groups for cluster network traffic.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To edit the list of [security groups](../concepts/network.md#security-groups) for your cluster:

    1. View the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-rd }} cluster update --help
        ```

    1. Specify the security groups in that command:

        ```bash
        {{ yc-mdb-rd }} cluster update <cluster_name_or_ID> \
          --security-group-ids <list_of_security_group_IDs>
        ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For more information about creating this file, see [this guide](./cluster-create.md).

    1. Edit the `security_group_ids` parameter in the {{ mrd-name }} cluster description:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<cluster_name>" {
          ...
          security_group_ids = [<list_of_security_group_IDs>]
        }
        ```

    1. Validate your configuration.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see this [{{ TF }} provider guide]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "securityGroupIds",
                      "securityGroupIds": [
                        "<security_group_1_ID>",
                        "<security_group_2_ID>",
                        ...
                        "<security_group_N_ID>"
                      ]
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated list of settings you want to update.

            Here, we provide only one setting.

        * `securityGroupIds`: [Security group](../concepts/network.md#security-groups) IDs.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [ "security_group_ids" ]
                  },
                  "security_group_ids": [
                    "<security_group_1_ID>",
                    "<security_group_2_ID>",
                    ...
                    "<security_group_N_ID>"
                  ] 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of `paths[]` strings.

            Here, we provide only one setting.

        * `security_group_ids`: [Security group](../concepts/network.md#security-groups) IDs.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note warning %}

You may need to additionally [set up security groups](connect/index.md#configuring-security-groups) to connect to the cluster.

{% endnote %}

