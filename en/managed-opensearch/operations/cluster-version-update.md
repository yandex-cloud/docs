# {{ OS }} version upgrade

You can upgrade a {{ mos-name }} cluster to a newer {{ OS }} version.

Learn more about minor version updates and host maintenance in [Maintenance](../concepts/maintenance.md).

## Viewing a list of available versions {#version-list}

{% list tabs group=instructions %}

- Management console {#console}

    In the [management console]({{ link-console-main }}), open the {{ mos-name }} cluster [create](cluster-create.md) or [update](update.md) page. You can view the list in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

{% endlist %}

## Before upgrading a version {#before-version-update}

Make sure the upgrade will not disrupt your applications:

1. Check the {{ OS }} [release notes](https://opensearch.org/docs/latest/version-history/) to learn how upgrades may affect your applications.
1. Try upgrading a test cluster. You can deploy it from a backup of the main cluster.
1. [Create a backup](cluster-backups.md) of the main cluster immediately before upgrading.

## Upgrading the version {#start-version-update}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}** service.
    1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the {{ OS }} version you need.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Get the name and ID of the cluster you need with the list of all {{ OS }} clusters:

        ```bash
        {{ yc-mdb-os }} cluster list
        ```

    1. Get information about the cluster you need and check the version in the `config.version` parameter:

        ```bash
        {{ yc-mdb-os }} cluster get <cluster_name_or_ID>
        ```

    1. Upgrade the {{ OS }} version:

        ```bash
        {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
           --version <{{ OS }}_version>
        ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](cluster-create.md).

        For a complete list of {{ mos-name }} cluster configuration fields you can update, see [this {{ TF }} provider guide]({{ tf-provider-mos }}).

    1. Edit the `version` value in the `config` section of your cluster description. If there is no such parameter, add it.

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
          ...
          config {
            version = "<{{ OS }}_version>"
            ...
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mos/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>' \
            --data '{
                        "updateMask": "configSpec.version",
                        "configSpec": {
                            "version": "<{{ OS }}_version>"
                        }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated string of settings you want to update.

            Here, we provide only one setting.

        * `configSpec.version`: New {{ OS }} version.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "update_mask": {
                        "paths": [
                            "config_spec.version"
                        ]
                    },
                    "config_spec": {
                        "version": "<{{ OS }}_version>"
                    }
                }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

            Here, we provide only one setting.

        * `config_spec.version`: New {{ OS }} version.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
