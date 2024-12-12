# {{ RD }} version upgrade

You can upgrade a {{ mrd-name }} cluster to any supported version.


## Supported versions {#version-supported}

All {{ RD }} versions, which were supported in {{ mrd-name }}, will remain available as long as the vendor continues to support them. Normally, this is for 24 months after a version is released. For more information, see the [{{ RD }} documentation](https://docs.redis.com/latest/rs/release-notes/).

{% note info %}

As of September 9, 2024, {{ RD }} versions 6.2 and 7.0 are discontinued. You cannot create a cluster with these versions. All existing clusters will be automatically upgraded to version 7.2.

{% endnote %}

### Viewing a list of available {{ RD }} versions {#version-list}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Select a cluster and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. Open the list in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

{% endlist %}

## Before a version upgrade {#before-update}

Make sure this does not affect your applications:

1. See the {{ RD }} [changelog](https://docs.redis.com/latest/rs/release-notes/) to check how updates might affect your applications.
1. Try upgrading the version on a test cluster. You can [deploy it from a backup](cluster-backups.md#restore) of the main cluster. To do this, the {{ RD }} version in the backup must be [supported](#version-supported) in {{ mrd-name }}.
1. [Create a backup](cluster-backups.md#create-backup) of the main cluster directly before the version upgrade.

## Upgrading a cluster {#start-update}

{% note alert %}

* After updating the DBMS, the cluster cannot be rolled back to the previous version.
* The success of a {{ RD }} version upgrade depends on multiple factors, including cluster settings and data stored in databases. We recommend that you begin by [upgrading a test cluster](#before-update) that has the same data and settings.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing the cluster to upgrade.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Select the cluster from the list and click **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field, select the new version.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

  As soon as you run the upgrade, the cluster status will change to **Updating**. Wait for the operation to complete and then check the cluster version.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Get a list of your {{ RD }} clusters using this command:

     ```bash
     {{ yc-mdb-rd }} cluster list
     ```

  1. Get information about the cluster you need and check the {{ RD }} version in the `config.version` parameter:

     ```bash
     {{ yc-mdb-rd }} cluster get <cluster_name_or_ID>
     ```

  1. Run the {{ RD }} upgrade:

     ```bash
     {{ yc-mdb-rd }} cluster update <cluster_name_or_ID> \
       --redis-version <new_version_number>
     ```

     As soon as you run the upgrade, the cluster status will change to **Updating**. Wait for the operation to complete and then check the cluster version.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

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
                        "version": "<{{ RD }}_version>"
                      }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Only one parameter is provided in this case.

        * `configSpec.version`: New {{ RD }} version.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

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
                    "version": "<{{ RD }}_version>"
                  } 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Only one parameter is provided in this case.

        * `config_spec.version`: New {{ RD }} version.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

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
