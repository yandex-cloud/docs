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

    1. In the [management console]({{ link-console-main }}), select a folder.
    1. [Navigate]({{ link-console-main }}/link/managed-ytsaurus) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
    1. Select your cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Edit the cluster name and description.
        * Delete or add new [labels](../../resource-manager/concepts/labels.md).

    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.net-settings-section_title_wo42X }}**, change the list of allowed IPv4 address ranges, in CIDR format, e.g., `203.0.113.0/24`, in the **{{ ui-key.yacloud.managed-ytsaurus.clusters.NetworkSettingsForm.field_cidr-blocks-whitelist_label_hL9Hc }}** field. To remove internet access restrictions, clear all values from the field.

        {% include [cidr-blocks-whitelist-description](../../_includes/managed-ytsaurus/cidr-blocks-whitelist-description.md) %}

    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.filestore-section_title_tYMR7 }}**, change the number of disks.
    1. Under **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.exec-node-configuration-section_title_mfa54 }}**, change the number of exec nodes.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- {{ TF }} {#tf}

    To change the cluster settings:

    1. Open the current {{ TF }} configuration file with the infrastructure plan.

        Learn how to create this file in [Creating a cluster](cluster-create.md).

    1. To change the cluster settings, specify a new value for the relevant field in the configuration file. You can only edit a single setting per cluster resource update operation.

        {% note alert %}

        Do not change the cluster name and ID using {{ TF }}. This will delete the existing cluster and create a new one.

        {% endnote %}

        Configuration file structure example:

        ```hcl
        resource "yandex_ytsaurus_cluster" "my_cluster" {
          description         = "<cluster_description>"
          name                = "my-ytsaurus-cluster"
          folder_id           = "b1gmioovukmd********"

          cidr_blocks_whitelist = {
            v4_cidr_blocks = ["<allowed_range>"]
          }

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
        * `cidr_blocks_whitelist.v4_cidr_blocks`: List of allowed IPv4 address ranges, in CIDR format, for accessing the cluster from the internet, e.g., `203.0.113.0/24`. To remove the restrictions, provide an empty list (`[]`).

            {% include [cidr-blocks-whitelist-description](../../_includes/managed-ytsaurus/cidr-blocks-whitelist-description.md) %}

        * `spec`: Configuration of {{ ytsaurus-name }} cluster components:

            * `storage`: Storage settings:

               * `hdd.count`: Number of HDDs. You can only increase this number.
               * `ssd.count`: Number of SSDs. You can only increase this number.

            * `compute`: Configuration of exec nodes:

               * `scale_policy.fixed.size`: Number of exec nodes for the fixed scaling policy. {{ myt-name }} only supports this policy.

            * `odin.checks_ttl`: Frequency of checks by Odin, an internal monitoring tool. Provide with units of measurement: `h` (hours), `m` (minutes), `s` (seconds).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-ytsaurus }}).

- REST API {#api}

    To change the cluster settings:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. You can only edit a single setting per cluster update operation. Create a file named `body.json` with the required setting from the example below. This example only shows the settings to update. For the full list of available settings, see [this API guide](../api-ref/Cluster/update.md#yandex.cloud.ytsaurus.v1.UpdateClusterRequest).

        ```json
        {
          "clusterId": "<cluster_ID>",
          "updateMask": "<name_of_setting_to_update>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "cidrBlocksWhitelist": {
            "v4CidrBlocks": ["<allowed_range>"]
          },
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

        * `clusterId`: Cluster ID. You can get it from the [list of clusters in the folder](cluster-list.md#list-clusters).
        * `updateMask`: Name of the setting you are updating. To update the list of allowed IP address ranges, specify `cidrBlocksWhitelist`.
        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels provided in `"<key>": "<value>"` format.
        * `cidrBlocksWhitelist.v4CidrBlocks`: List of allowed IPv4 address ranges, in CIDR format, for accessing the cluster from the internet, e.g., `203.0.113.0/24`. To remove the restrictions, provide an empty list (`[]`).

            {% include [cidr-blocks-whitelist-description](../../_includes/managed-ytsaurus/cidr-blocks-whitelist-description.md) %}

        * `spec`: Configuration of {{ ytsaurus-name }} cluster components:

            * `storage`: Storage settings:

               * `hdd.count`: Number of HDDs. You can only increase this number.
               * `ssd.count`: Number of SSDs. You can only increase this number.

            * `compute`: Configuration of exec nodes:

               * `scalePolicy.fixed.size`: Number of exec nodes for the fixed scaling policy. {{ myt-name }} only supports this policy.

            * `odin.checksTtl`: Frequency of checks by Odin, an internal monitoring tool. Specify it in seconds (`s`).

    1. Call the [update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-ytsaurus }}/ytsaurus/v1/clusters' \
            --data '@body.json'
        ```

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    To change the cluster settings:

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. You can only edit a single setting per cluster update operation. Create a file named `body.json` with the required setting from the example below. This example only shows the settings to update. For the full list of available settings, see [this API guide](../api-ref/grpc/Cluster/update.md#yandex.cloud.ytsaurus.v1.UpdateClusterRequest).

        ```json
        {
          "cluster_id": "<cluster_ID>",
          "update_mask": "<name_of_setting_to_update>",
          "name": "<cluster_name>",
          "description": "<cluster_description>",
          "labels": { <label_list> },
          "cidr_blocks_whitelist": {
            "v4_cidr_blocks": ["<allowed_range>"]
          },
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

        * `cluster_id`: Cluster ID. You can get it from the [list of clusters in the folder](cluster-list.md#list-clusters).
        * `update_mask`: Name of the setting you are updating. In JSON, provide it as a string in `lowerCamelCase` notation. To update the list of allowed IP address ranges, specify `cidrBlocksWhitelist`.
        * `name`: Cluster name.
        * `description`: Cluster description.
        * `labels`: List of labels provided in `"<key>": "<value>"` format.
        * `cidr_blocks_whitelist.v4_cidr_blocks`: List of allowed IPv4 address ranges, in CIDR format, for accessing the cluster from the internet, e.g., `203.0.113.0/24`. To remove the restrictions, provide an empty list (`[]`).

            {% include [cidr-blocks-whitelist-description](../../_includes/managed-ytsaurus/cidr-blocks-whitelist-description.md) %}

        * `spec`: Configuration of {{ ytsaurus-name }} cluster components:

            * `storage`: Storage settings:

               * `hdd.count`: Number of HDDs. You can only increase this number.
               * `ssd.count`: Number of SSDs. You can only increase this number.

            * `compute`: Configuration of exec nodes:

               * `scale_policy.fixed.size`: Number of exec nodes for the fixed scaling policy. {{ myt-name }} only supports this policy.

            * `odin.checks_ttl`: Frequency of checks by Odin, an internal monitoring tool. Specify it in seconds (`s`).

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
