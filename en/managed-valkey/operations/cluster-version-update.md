# {{ VLK }} version upgrade

You can upgrade a {{ mrd-name }} cluster to any supported version.


## Supported versions {#version-supported}

All {{ VLK }} versions supported in {{ mrd-name }} remain available as long as they are supported by the vendor. Typically, this is 24 months from the version release date. For more information, see [this {{ VLK }} article](https://valkey.io/topics/releases/).


### Viewing a list of available {{ VLK }} versions {#version-list}

{% list tabs group=instructions %}

- Management console {#console}

    1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Select a cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Open the list in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

    {% note info %}

    To specify a version number in the CLI, {{ TF }}, and the API, add the `-valkey` suffix to it, e.g., `{{ versions.cli.previous }}`.

    {% endnote %}

{% endlist %}

## Before upgrading a version {#before-update}

Make sure the upgrade will not disrupt your applications:

1. Check the {{ VLK }} [release notes](https://docs.redis.com/latest/rs/release-notes/) to learn how upgrades may affect your applications.
1. Try upgrading a test cluster. You can [deploy it from a backup](cluster-backups.md#restore) of the main cluster, if {{ mrd-name }} [supports](#version-supported) the {{ VLK }} version in the backup.
1. [Create a backup](cluster-backups.md#create-backup) of the main cluster immediately before upgrading.

## Upgrading a cluster {#start-update}

{% note alert %}

* After the DBMS upgrade, you cannot revert the cluster to the previous version.
* Whether a {{ VLK }} version upgrade succeeds depends on multiple factors, including your cluster’s configuration and the nature of the stored data. We recommend that you start with [upgrading a test cluster](#before-update) with the same data and configuration.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to upgrade.
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Select the cluster from the list and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the new version.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

  As soon as you run the upgrade, the cluster status will change to **Updating**. Wait for the operation to complete and then check the cluster version.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Get the list of your {{ VLK }} clusters using this command:

     ```bash
     {{ yc-mdb-rd }} cluster list
     ```

  1. Get information about the cluster in question and check its {{ VLK }} version in the `config.version` setting:

     ```bash
     {{ yc-mdb-rd }} cluster get <cluster_name_or_ID>
     ```

  1. Run the {{ VLK }} upgrade:

     ```bash
     {{ yc-mdb-rd }} cluster update <cluster_name_or_ID> \
       --redis-version <new_version_number>
     ```

     As soon as you run the upgrade, the cluster status will change to **Updating**. Wait for the operation to complete and then check the cluster version.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file describing your infrastructure.

        To learn how to create this file, see [Creating a cluster](./cluster-create.md).

    1. Update the `version` argument in the `config` section to specify the {{ VLK }} version you want to upgrade to:

        ```hcl
        resource "yandex_mdb_redis_cluster_v2" "<cluster_name>" {
            ...
            config {
                version  = "<new_version_number>"
                ...
            }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see [this {{ TF }} provider guide]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mvk/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.Update](../api-ref/Cluster/update.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.version",
                      "configSpec": {
                        "version": "<{{ VLK }}_version>"
                      }
                    }'
        ```

        Where:

        * `updateMask`: Comma-separated list of settings you want to update.

            Here, we provide only one setting.

        * `configSpec.version`: New {{ VLK }} version.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Call the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

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
                    "paths": [ "config_spec.version" ]
                  },
                  "config_spec": {
                    "version": "<{{ VLK }}_version>"
                  } 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).

            Here, we provide only one setting.

        * `config_spec.version`: New {{ VLK }} version.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Examples {#examples}

Let's assume you need to upgrade your cluster version from {{ versions.console.previous }} to {{ versions.console.latest }}.

{% list tabs group=instructions %}

- CLI {#cli}

   1. To get the list of clusters with their IDs and names, run this command:

      ```bash
      {{ yc-mdb-rd }} cluster list
      ```

	  Result:
	  
      ```text
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih******** |   redis406    | 2022-04-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. To get information about the `redis406` cluster, run the following command:

      ```bash
      {{ yc-mdb-rd }} cluster get redis406
      ```

      Result:

      ```text
      id: c9q8p8j2gaih********
      ...
      config:
        version: {{ versions.cli.previous }}
        ...
      ```

   1. To upgrade a cluster named `redis406` to version `{{ versions.console.latest }}`, run the following command:

      ```bash
      {{ yc-mdb-rd }} cluster update redis406 --redis-version {{ versions.cli.latest }}
      ```

{% endlist %}
