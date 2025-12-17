---
title: How to change a {{ CH }} cluster version in {{ mch-full-name }}
description: Follow this guide to change a {{ CH }} cluster version.
---

# {{ CH }} version upgrade

You can change the {{ CH }} version used by your cluster to any of the [versions supported by {{ mch-name }}](../concepts/update-policy.md#versioning-policy).

Learn more about minor version updates and host maintenance in [Maintenance](../concepts/maintenance.md).

## List of available versions

{% list tabs group=instructions %}

- Management console {#console}

    In the [management console]({{ link-console-main }}), open the {{ mch-name }} cluster [create](cluster-create.md) or [update](update.md) page. You can view the list in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of available versions, run this command:

    ```bash
    yc managed-clickhouse version list
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Versions.List](../api-ref/Versions/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/versions'
        ```

    1. View the [server response](../api-ref/Versions/list.md#responses) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [VersionsService.List](../api-ref/grpc/Versions/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/versions_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.VersionsService.List
        ```

    1. View the [server response](../api-ref/grpc/Versions/list.md#yandex.cloud.mdb.clickhouse.v1.ListVersionsResponse) to make sure your request was successful.

{% endlist %}

## Before upgrading a version {#before-update}

Make sure the upgrade will not disrupt your applications:

1. Check the {{ CH }} [release notes](https://clickhouse.com/docs/category/changelog) to learn how upgrades may affect your applications.
1. Try upgrading a test cluster. You can deploy it from a backup of the main cluster. In this case, you will only restore MergeTree tables.
1. [Create a backup](cluster-backups.md) of the main cluster immediately before upgrading.

## Upgrading the version {#start-update}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to update the {{ CH }} version.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**. 
    1. In the list of clusters, select the one to update.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, select the version in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

    As soon as you run the upgrade, the cluster status will switch to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Get a list of your {{ CH }} clusters and view their versions:

        ```bash
        {{ yc-mdb-ch }} cluster list

        +----------------------+------+-------------+---------+---------------------+--------+---------+
        |          ID          | NAME | ENVIRONMENT | VERSION |     CREATED AT      | HEALTH | STATUS  |
        +----------------------+------+-------------+---------+---------------------+--------+---------+
        | c9qf1kmm0ebi******** | mych | PRODUCTION  |    23.8 | 2024-06-06 10:23:22 | ALIVE  | RUNNING |
        +----------------------+------+-------------+---------+---------------------+--------+---------+
        ```

    1. Upgrade the {{ CH }} version for the cluster you need:

        ```bash
        {{ yc-mdb-ch }} cluster update --id <cluster_ID> --version <{{ CH }}_version>
        ```

        Specify the {{ CH }} version: {{ versions.cli.str }}.

    As soon as you run the upgrade, the cluster status will switch to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        For information on how to create such a file, see [Creating a cluster](cluster-create.md).

    1. Add the `version` field to the {{ mch-name }} cluster description or edit its value if it is already there:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          version = "<{{ CH }}_version>"
        }
        ```

        Specify the {{ CH }} version: {{ versions.tf.str }}.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

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
                      "updateMask": "configSpec.version",
                      "configSpec": {
                        "version": "<{{ CH }}_version>"
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated list of settings you want to update.

            Here, we only specified a single setting, `configSpec.version`.

        * `configSpec.version`: Target {{ CH }} version, {{ versions.api.str }}.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure your request was successful.

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
                      "config_spec.version"
                    ]
                  },
                  "config_spec": {
                    "version": "<{{ CH }}_version>"
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

            Here, we only specified a single setting, `config_spec.version`.

        * `config_spec.version`: Target {{ CH }} version, {{ versions.api.str }}.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
