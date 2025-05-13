# {{ OS }} version upgrade

You can update a {{ mos-name }} cluster to a newer {{ OS }} version.

To learn more about updates within a single version and host maintenance, see [Maintenance](../concepts/maintenance.md).

## Viewing a list of available versions {#version-list}

{% list tabs group=instructions %}

- Management console {#console}

    In the [management console]({{ link-console-main }}), open the {{ mos-name }} cluster [create](cluster-create.md) or [update](update.md) page. You can view the list in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

{% endlist %}

## Before a version upgrade {#before-version-update}

Make sure the update does not affect your applications:

1. See {{ OS }} [changelog](https://opensearch.org/docs/latest/version-history/) for how upgrades may affect your applications.
1. Try a version upgrade on a test cluster. You can deploy it from a backup of the main cluster.
1. [Create a backup](cluster-backups.md) of the main cluster directly before the version upgrade.

## Updating the version {#start-version-update}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Select a cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the appropriate {{ OS }} version.
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

    1. Update the {{ OS }} version:

        ```bash
        {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
           --version <{{ OS }}_version>
        ```

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

        For a complete list of available {{ mos-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}).

    1. In the cluster description, change the `version` parameter value under `config`. If there is no such parameter, add it.

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

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

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
                            "version": "<{{ OS }}>_version"
                        }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Only one parameter is provided in this case.

        * `configSpec.version`: New {{ OS }} version.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

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
                        "version": "<{{ OS }}>_version"
                    }
                }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Only one parameter is provided in this case.

        * `config_spec.version`: New {{ OS }} version.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}
