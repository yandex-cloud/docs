---
title: How to change a {{ CH }} cluster version in {{ mch-full-name }}
description: Follow this guide to change a {{ CH }} cluster version.
---

# {{ CH }} version upgrade

You can update the {{ CH }} version used by the cluster to any of the [supported {{ mch-name }} versions](../concepts/update-policy.md#versioning-policy); however, switching from versions lower than 23.8 to 23.8 or higher is performed in steps. For example, for {{ mch-name }}, the upgrade sequence from version 22.8 to 24.3 is: 22.8 → 23.3 → 23.8 → 24.3.

To learn more about updates within a single version and host maintenance, see [Maintenance](../concepts/maintenance.md).

## List of available versions

{% list tabs group=instructions %}

- Management console {#console}

    In the [management console]({{ link-console-main }}), open the {{ mos-name }} cluster [create](cluster-create.md) or [update](update.md) page. You can view the list in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of available versions, run the following command:

    ```bash
    yc managed-clickhouse version list
    ```

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Versions.List](../api-ref/Versions/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/versions'
        ```

    1. View the [server response](../api-ref/Versions/list.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [VersionsService.List](../api-ref/grpc/Versions/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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

    1. View the [server response](../api-ref/grpc/Versions/list.md#yandex.cloud.mdb.clickhouse.v1.ListVersionsResponse) to make sure the request was successful.

{% endlist %}

## Before a version upgrade {#before-update}

Make sure this does not affect your applications:

1. See the {{ CH }} [changelog](https://clickhouse.com/docs/category/changelog) to check how updates might affect your applications.
1. Try a version upgrade on a test cluster. You can deploy it from a backup of the main cluster. In this case, you will only recover MergeTree tables.
1. [Create a backup](cluster-backups.md) of the main cluster directly before the version upgrade.

## Updating the version {#start-update}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), open the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}** page in the folder where you want to update the {{ CH }} version.
    1. In the list of clusters, select the one to change.
    1. Click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, select the appropriate version in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.
    1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

    When the change starts, the cluster status will switch to **UPDATING**. Wait for the operation to complete and then check the cluster version.

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

    1. Update the {{ CH }} version for any cluster as needed:

        ```bash
        {{ yc-mdb-ch }} cluster update --id <cluster_ID> --version <{{ CH }}_version>
        ```

        Specify the {{ CH }} version: {{ versions.cli.str }}.

    When the update starts, the cluster status will switch to **UPDATING**. Wait for the operation to complete and then check the cluster version.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. To the {{ mch-name }} cluster description, add the `version` field or change its value if it is already there:

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

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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
                        "version": "<{{ CH }}>_version"
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Here only one parameter is specified: `configSpec.version`.

        * `configSpec.version`: target {{ CH }} version, {{ versions.api.str }}.

        You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

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
                    "version": "<{{ CH }}>_version"
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Here only one parameter is specified: `config_spec.version`.

        * `config_spec.version`: target {{ CH }} version, {{ versions.api.str }}.

        You can get the cluster ID with a [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
