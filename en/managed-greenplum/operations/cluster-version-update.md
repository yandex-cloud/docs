---
title: How to change a cluster version in {{ mgp-full-name }}
description: Follow this guide to change a {{ GP }} cluster version.
---

# {{ mgp-full-name }} version upgrade

You can change the database version of your {{ mgp-name }} cluster.

{{ GP }} upgrades from version 6.28 to 6.29 are supported.

The following are not supported:

* Manual upgrades between {{ GP }} minor versions, e.g., from 6.29.1 to 6.29.2. Such upgrades are performed automatically during maintenance.
* {{ CB }} version upgrades.
* Migrations between {{ GP }} and {{ CB }}.

To learn about upgrades within the same version and host maintenance, see [Maintenance](../concepts/maintenance.md).


## Viewing a list of available versions {#versions-list}

{% list tabs group=instructions %}

- Management console {#console}

  In the [management console]({{ link-console-main }}), open the {{ mgp-name }} cluster [create](cluster-create.md) or [update](update.md) page. You can view the list in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Versions.List](../api-ref/Versions/list.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
          --request GET \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/versions'
      ```

  1. Check the [server response](../api-ref/Versions/list.md#responses) to make sure your request was successful.

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
          -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/versions_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.greenplum.v1.VersionsService.List
      ```

  1. Check the [server response](../api-ref/grpc/Versions/list.md#yandex.cloud.mdb.greenplum.v1.ListVersionsResponse) to make sure your request was successful.

{% endlist %}


## Before a version upgrade {#before-update}

Make sure the upgrade will not disrupt your applications:

1. Learn how upgrades may affect your applications:

    * [{{ GP }} release notes](https://github.com/open-gpdb/gpdb/releases)
    * [{{ CB }} release notes](https://cloudberry.apache.org/blog/announce-apache-cloudberry-2.1.0/)

1. Try upgrading a test cluster. You can [deploy it from a backup](cluster-backups.md#restore) of the main cluster, if {{ mgp-name }} [supports](#version-supported) the database version in the backup.
1. [Back up](cluster-backups.md#create-backup) your main cluster before upgrading.


## Upgrading a cluster {#start-update}

{% note alert %}

Once your database version is upgraded, you cannot revert the cluster to the previous version.

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the relevant folder.
  1. [Navigate]({{ link-console-main }}/link/managed-greenplum) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. In the cluster row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. Select the new version number in the **{{ ui-key.yacloud.mdb.forms.base_field_version }}** field.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file with the infrastructure plan.

      For information on how to create this file, see [{#T}](cluster-create.md).

  1. In the `config` section of the {{ mgp-name }} cluster, add the `version` field (the database version) or update its value if it already exists:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<cluster_name>" {
        ...
        version = "<version>"
      }
      ```

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mgp }}).

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
          -url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>' \
          --data '{
                    "updateMask": "config.version",
                    "config": {
                      "version": "<version>"
                    }
                  }'
      ```

      Where:

      * `updateMask`: Comma-separated string of settings to update.

          Here, we only specified a single setting, `config.version`.

      * `config.version`: Target database version.

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
          -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "update_mask": {
                  "paths": [
                    "config.version"
                  ]
                },
                "config": {
                  "version": "<version>"
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.greenplum.v1.ClusterService.Update
      ```

      Where:

      * `update_mask`: List of settings to update as an array of strings (`paths[]`).

          Here, we only specified a single setting, `config.version`.

      * `config.version`: Target database version.

      You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
