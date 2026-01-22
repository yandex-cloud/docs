---
title: Updating a {{ ytsaurus-name }} cluster
description: After creating an {{ ytsaurus-name }} cluster, you can edit its basic and advanced settings.
keywords:
  - Updating an {{ ytsaurus-name }} cluster
  - '{{ ytsaurus-name }} cluster'
  - '{{ ytsaurus-name }}'
---

# Updating a {{ ytsaurus-name }} cluster

After creating a cluster, you can edit its basic and advanced settings.

{% list tabs group=instructions %}

- Management console {#console}

    To change the cluster settings:

    1. Navigate to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Edit the cluster name and description.
        * Delete or add new [labels](../../resource-manager/concepts/labels.md).

    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.filestore-section_title_tYMR7 }}**, change the number of disks.
    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.exec-node-configuration-section_title_mfa54 }}**, change the number of exec nodes.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- {{ TF }} {#tf}

    To change the cluster settings:

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. Edit the cluster settings by changing the value of the relevant field in the configuration file. You can only edit a single setting per cluster resource update operation.

        {% note alert %}

        Do not change the cluster name and ID using {{ TF }}. This will delete the existing cluster and create a new one.

        {% endnote %}

        Here is an example of the configuration file structure:

        ```hcl
        resource "yandex_ytsaurus_cluster" "my_cluster" {
          description         = "<cluster_description>"
          name                = "my-ytsaurus-cluster"
          folder_id           = "b1gmioovukmd********"

          labels = {
            <label_list>
          }
          ...
          spec = {
            ...
            storage = {
              hdd = {
                ...
                "count": "<number_of_HDDs>"
              },
              ssd = {
                ...
                "count": "<number_of_SSDs>",
              }
            }
            compute = [{
              ...
              scale_policy = {
                fixed = {
                  size = <number_of_exec_nodes>
                }
              }
            }]
            ...
            odin = {
              checks_ttl = "<TTL_of_checks_by_Odin>"
            }
          }
        }
        ```

        Where:

        * `description`: Cluster description.
        * `labels`: List of labels. Provide labels in `<key> = "<value>"` format.
        * `spec`: Configuration of {{ ytsaurus-name }} cluster components.

            * `storage`: Storage settings:

               * `hdd.count`: Number of HDDs. You can only increase the number; reducing it is not supported.
               * `ssd.count`: Number of SSDs. You can only increase the number; reducing it is not supported.

            * `compute`: Configuration of exec nodes:

               * `scale_policy.fixed.size`: Number of exec nodes for the fixed scaling policy. Currently, this is the only policy {{ ytsaurus-name }} supports.

            * `odin.checks_ttl`: Frequency of checks by Odin, an internal monitoring tool. Provide with units of measurement: `h` (hours), `m` (minutes), `s` (seconds).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-ytsaurus }}).

- REST API {#api}

    To change the cluster settings:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. You can only edit a single setting per cluster update operation. Create a file named `body.json` with the required setting from the example below. This example only shows settings to update; for the full list of available settings, see [this API guide](../api-ref/Cluster/update.md#yandex.cloud.ytsaurus.v1.UpdateClusterRequest).

        ```json
        {
          "clusterId": "<cluster_ID>",
          "updateMask": "<name_of_setting_to_update>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "spec": {
            "storage": {
              "hdd": {
                "count": "<number_of_HDDs>"
              },
              "ssd": {
                "count": "<number_of_SSDs>"
              }
            },
            "compute": [
              {
                "scalePolicy": {
                  "fixed": {
                    "size": "<number_of_exec_nodes>"
                  }
                }
              }
            ],
            "odin": {
              "checksTtl": "<TTL_of_checks_by_Odin>"
            }
          }
        }
        ```

        Where:

        * `clusterId`: Cluster ID. You can get it with the [list of clusters in the folder](cluster-list.md#list-clusters).
        * `updateMask`: Name of the setting you are updating.
        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels provided in `"<key>": "<value>"` format.
        * `spec`: Configuration of {{ ytsaurus-name }} cluster components.

            * `storage`: Storage settings:

               * `hdd.count`: Number of HDDs. You can only increase the number; reducing it is not supported.
               * `ssd.count`: Number of SSDs. You can only increase the number; reducing it is not supported.

            * `compute`: Configuration of exec nodes.

               * `scalePolicy.fixed.size`: Number of exec nodes for the fixed scaling policy. Currently, this is the only policy {{ ytsaurus-name }} supports.

            * `odin.checksTtl`: TTL of checks by Odin, an internal monitoring tool. Provide the value with measurement units: `s` (seconds).

    1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-ytsaurus }}/ytsaurus/v1/clusters'
            --data '@body.json'
        ```

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    To change the cluster settings:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. You can only edit a single setting per cluster update operation. Create a file named `body.json` with the required setting from the example below. This example only shows settings to update; for the full list of available settings, see [this API guide](../api-ref/Cluster/update.md#yandex.cloud.ytsaurus.v1.UpdateClusterRequest).

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": "<name_of_setting_to_update>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "spec": {
            "storage": {
              "hdd": {
                "count": "<number_of_HDDs>"
              },
              "ssd": {
                "count": "<number_of_SSDs>"
              }
            },
            "compute": [
              {
                "scale_policy": {
                  "fixed": {
                    "size": "<number_of_exec_nodes>"
                  }
                }
              }
            ],
            "odin": {
              "checks_ttl": "<TTL_of_checks_by_Odin>"
            }
          }
        }
        ```

        Where:

        * `cluster_id`: Cluster ID. You can get it with the [list of clusters in the folder](cluster-list.md#list-clusters).
        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

            In this case, the array consists of a single element.

            {% cut "Format for listing settings" %}

            ```yaml
            "update_mask": {
                "paths": [
                    "<name_of_setting_to_update>"
                ]
            }
            ```

            {% endcut %}

        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels provided in `"<key>": "<value>"` format.
        * `spec`: Configuration of {{ ytsaurus-name }} cluster components.

            * `storage`: Storage settings:

               * `hdd.count`: Number of HDDs. You can only increase the number; reducing it is not supported.
               * `ssd.count`: Number of SSDs. You can only increase the number; reducing it is not supported.

            * `compute`: Configuration of exec nodes.

               * `scale_policy.fixed.size`: Number of exec nodes for the fixed scaling policy. Currently, this is the only policy {{ ytsaurus-name }} supports.

            * `odin.checks_ttl`: TTL of checks by Odin, an internal monitoring tool. Provide the value with measurement units: `s` (seconds).

    1. Call the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/ytsaurus/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-ytsaurus }}:{{ port-https }} \
            yandex.cloud.ytsaurus.v1.ClusterService.Update \
            < body.json
        ```

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
