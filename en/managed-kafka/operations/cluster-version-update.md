---
title: '{{ KF }} version upgrade'
description: Follow this guide to upgrade your {{ mkf-name }} cluster.
---

# {{ KF }} version upgrade

{% note info %}

Starting March 1, 2025, support for {{ KF }} 2.8, 3.0, 3.1, 3.2, and 3.3 is discontinued. You cannot create a cluster with these versions. We recommend that you upgrade your existing clusters to version 3.9.

{% endnote %}

You can find the list of supported versions in the [{{ KF }} versioning policy](../concepts/update-policy.md) section. We recommend updating {{ KF }} step by step without skipping any versions. For example, the upgrade sequence from version 3.1 to 3.5 is: 3.1 → 3.2 → 3.3 → 3.4 → 3.5.

Learn more about minor version updates and host maintenance in [Maintenance](../concepts/maintenance.md).

## Before upgrading a version {#before-update}

Make sure this does not affect your applications: review the {{ KF }} [change log](https://kafka.apache.org/downloads).

## Upgrading a cluster {#start-update}

{% note alert %}

Once upgraded, you cannot roll an {{ KF }} cluster back to the previous version.

{% endnote %}

During an upgrade, topics may be unavailable if their [replication factor](../concepts/settings-list.md#settings-topic-replication-factor) is 1.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the new version number.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Get a list of your {{ mkf-short-name }} clusters:

        ```bash
        {{ yc-mdb-kf }} cluster list
        ```

    1. Get information about the cluster you need and check the version in the `config.version` property:

        ```bash
        {{ yc-mdb-kf }} cluster get <cluster_name_or_ID>
        ```

    1. Run the {{ KF }} upgrade:

        ```bash
        {{ yc-mdb-kf }} cluster update <cluster_name_or_ID> \
           --version=<new_version_number>
        ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

    1. In the `config` section of the required {{ mkf-name }} cluster, add the `version` field (the {{ KF }} version) or edit the existing one:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<cluster_name>" {
          ...
          config {
            version = "<version>"
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-mkf }}).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            -url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.version",
                      "configSpec": {
                        "version": "<version>"
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated string of settings you want to update.

          Here, we only specified a single setting, `configSpec.version`.

        * `configSpec.version`: Target {{ KF }} version, {{ versions.cli.str-without-latest }}.

       You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService/Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "update_mask": {
                    "paths": [
                      "config_spec.version"
                    ]
                  },
                  "config_spec": {
                    "version": "<version>"
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

          Here, we only specified a single setting, `config_spec.version`.

        * `config_spec.version`: Target {{ KF }} version, {{ versions.cli.str-without-latest }}.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Examples {#examples}

Let's assume you need to upgrade your cluster from version 2.8 to version 3.0.

{% list tabs group=instructions %}

- CLI {#cli}

    1. To get a list of clusters with their IDs and names, run this command:

        ```bash
        {{ yc-mdb-kf }} cluster list
        ```

        ```text
        +----------------------+---------------+---------------------+--------+---------+
        |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
        +----------------------+---------------+---------------------+--------+---------+
        | c9q8p8j2gaih******** |    kafka35    | 2021-10-23 12:44:17 | ALIVE  | RUNNING |
        +----------------------+---------------+---------------------+--------+---------+
        ```

    1. To get information about the `kafka35` cluster, run the following command:

        ```bash
        {{ yc-mdb-kf }} cluster get kafka35
        ```

        ```text
          id: c9q8p8j2gaih********
          ...
          config:
            version: "2.8"
            ...
        ```

    1. To upgrade the `kafka35` cluster to version 3.0, run this command:

        ```bash
        {{ yc-mdb-kf }} cluster update kafka35 --version=3.0
        ```

{% endlist %}
