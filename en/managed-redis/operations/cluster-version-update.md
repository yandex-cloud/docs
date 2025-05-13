# {{ VLK }} version upgrade

You can upgrade a {{ mrd-name }} cluster to any supported version.


## Supported versions {#version-supported}

All {{ VLK }} versions, which were supported in {{ mrd-name }}, will remain available as long as the vendor continues to support them. Normally, this is for 24 months after a version is released. For more information, see the relevant [{{ VLK }} documentation](https://valkey.io/topics/releases/).


### Viewing a list of available {{ VLK }} versions {#version-list}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Select a cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Open the list in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

{% endlist %}

## Before a version upgrade {#before-update}

Make sure this does not affect your applications:

1. See {{ VLK }} [changelog](https://docs.redis.com/latest/rs/release-notes/) for how upgrades may affect your applications.
1. Try a version upgrade on a test cluster. You can [deploy it from a backup](cluster-backups.md#restore) of the main cluster, provided {{ mrd-name }} [supports](#version-supported) the {{ VLK }} version in the backup.
1. [Create a backup](cluster-backups.md#create-backup) of the main cluster directly before the version upgrade.

## Upgrading a cluster {#start-update}

{% note alert %}

* After updating the DBMS, the cluster cannot be rolled back to the previous version.
* The success of a {{ VLK }} version upgrade depends on multiple factors, including cluster settings and data stored in databases. We recommend that you begin by [upgrading a test cluster](#before-update) that has the same data and settings.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to upgrade.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Select the cluster from the list and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the new version.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

  As soon as you run the upgrade, the cluster status will change to **Updating**. Wait for the operation to complete and then check the cluster version.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Get a list of your {{ VLK }} clusters using this command:

     ```bash
     {{ yc-mdb-rd }} cluster list
     ```

  1. Get information about the cluster you need and check the {{ VLK }} version in the `config.version` parameter:

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

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For more information about creating this file, see [Creating clusters](./cluster-create.md).

    1. Under `config`, change the `version` parameter to the {{ VLK }} version you want to upgrade to.

        ```hcl
        resource "yandex_mdb_redis_cluster" "<cluster_name>" {
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

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<cluster_ID>' \
            --data '{
                      "updateMask": "configSpec.version",
                      "configSpec": {
                        "version": "<{{ VLK }}_version>"
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Only one parameter is provided in this case.

        * `configSpec.version`: New {{ VLK }} version.

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

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Only one parameter is provided in this case.

        * `config_spec.version`: New {{ VLK }} version.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Examples {#examples}

Let's assume you need to upgrade your cluster from version {{ versions.cli.previous }} to version {{ versions.cli.latest }}.

{% list tabs group=instructions %}

- CLI {#cli}

   1. To retrieve a list of clusters and find out their IDs and names, run the command below:

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

   1. To get information about a cluster named `redis406`, run the following command:

      ```bash
      {{ yc-mdb-rd }} cluster get redis406
      ```

      Result:

      ```text
      id: c9q8p8j2gaih********
      ...
      config:
        version: "{{ versions.cli.previous }}"
        ...
      ```

   1. To upgrade a cluster named `redis406` to version {{ versions.cli.latest }}, run the following command:

      ```bash
      {{ yc-mdb-rd }} cluster update redis406 --redis-version {{ versions.cli.latest }}
      ```

{% endlist %}
