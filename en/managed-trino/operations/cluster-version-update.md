---
title: How to change a {{ TR }} cluster version in {{ mtr-name }}
description: Follow this guide to change a {{ TR }} cluster version.
---

# {{ TR }} version upgrade

You can change the {{ TR }} version to any of the versions [supported](#available-versions) by {{ mtr-name }}. You can either upgrade or downgrade the version.

Updates and fixes within a version are installed automatically during [maintenance](../concepts/maintenance.md).

## Get a list of available versions {#available-versions}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Select a cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** on the top panel. This will open the cluster editing page.
      
        You can see the list of available versions in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

{% endlist %}

## Before upgrading a version {#before-update}

Make sure the update does not affect your applications:

1. Look up {{ TR }} [release notes](https://trino.io/docs/current/release.html) for info on how upgrades may affect your applications.
1. Try upgrading the {{ TR }} version on a test cluster.

## Upgrading the version {#update}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Select a cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** on the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, select {{ TR }}.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the {{ TR }} version:

    1. View the description of the CLI command for updating a cluster:

        ```bash
        {{ yc-mdb-tr }} cluster update --help
        ```

    1. Change the version by running this command:

        ```bash
        {{ yc-mdb-tr }} cluster update <cluster_name_or_ID> \
          --version <{{ TR }}_version>
        ```

        You can get the cluster name and ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.   

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For information on how to create this file, see [Creating a cluster](cluster-create.md).
        
    1. Edit the `version` parameter in the cluster's description:
      
        ```hcl
        resource "yandex_trino_cluster" "<cluster_name>" {
          ...
          version = "<{{ TR }}_version>"
          ...
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and set it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Create a file named `body.json` and paste the following code into it:

        ```json
        {
          "updateMask": "trino.version",
          "trino": {
            "version": "<{{ TR }}_version>"
          }
        }
        ```

        Where:

        * `updateMask`: Comma-separated list of parameters to update.

            {% note warning %}

            When you update a cluster, all parameters of the object you are modifying will take their defaults unless explicitly provided in the request. To avoid this, list the settings you want to change in the `updateMask` parameter.

            {% endnote %}

        * `trino.version`: {{ TR }} version.

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

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

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
            "version": "<{{ TR }}_version>"
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

        * `version`: {{ TR }} version.

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}