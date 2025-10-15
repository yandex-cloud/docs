---
title: Exporting and importing Hive metadata in a {{ metastore-full-name }} cluster
description: Follow this guide to export and import Hive metadata in a {{ metastore-name }} cluster.
---

# Exporting and importing Hive metadata in a {{ metastore-name }} cluster

## Getting started {#before-you-begin}

1. [Create a service account](../../../iam/operations/sa/create.md) named `my-account` with the `storage.uploader` and `managed-metastore.integrationProvider` roles.
1. [Configure the network and create a {{ metastore-name }} cluster](cluster-create.md). When creating it, specify the `my-account` service account.
1. [Create a bucket](../../../storage/operations/buckets/create.md) in {{ objstorage-full-name }}. It will store the metadata file for import and export.
1. [Grant](../../../storage/operations/buckets/edit-acl.md) the `READ and WRITE` permission to `my-account` for the bucket you created earlier.

For more information about connecting to the bucket with configured bucket policies, see [this guide](s3-policy-connect.md).

## Exporting data {#export}

{% list tabs group=instructions %}

- Management console {#console}

   1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
   1. Click ![image](../../../_assets/console-icons/ellipsis.svg) for the cluster you need and select ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud.metastore.action_export }}**.
   1. In the window that opens, specify the following:

      * Bucket you [created earlier](#before-you-begin) for cluster data export.
      * The `.sql` file the cluster data will be written to. If a file with that name already exists, it will be overwritten.

   1. Click **{{ ui-key.yacloud.metastore.dialog.import-export.action_export }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To export metadata from a {{ metastore-name }} cluster, run this command:

   ```bash
   {{ yc-metastore }} cluster export-data <cluster_name_or_ID> \
      --bucket <bucket_name> \
      --filepath <data_file>
   ```

   Where:

   * `--bucket`: Bucket you [created earlier](#before-you-begin) for cluster data export.
   * `--filepath`: Path to the `.sql` file to which the cluster data will be written. If a file with that name already exists, it will be overwritten.

   You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.ExportData](../../api-ref/Cluster/exportData.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-metastore }}/managed-metastore/v1/clusters/<cluster_ID>:export' \
            --data '{
                       "bucket": "<bucket_name>",
                       "filepath": "<data_file>"
                    }'
        ```

        Where:

         * `bucket`: Bucket you [created earlier](#before-you-begin) for cluster data export.
         * `filepath`: Path to the `.sql` file to which the cluster data will be written. If a file with that name already exists, it will be overwritten.

         You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../../api-ref/Cluster/exportData.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.ExportData](../../api-ref/grpc/Cluster/exportData.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "bucket": "<bucket_name>",
                    "filepath": "<data_file>"
                }' \
            {{ api-host-metastore }}:{{ port-https }} \
            yandex.cloud.metastore.v1.ClusterService.ExportData
        ```

        Where:

         * `bucket`: Bucket you [created earlier](#before-you-begin) for cluster data export.
         * `filepath`: Path to the `.sql` file to which the cluster data will be written. If a file with that name already exists, it will be overwritten.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../../api-ref/grpc/Cluster/exportData.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Importing data {#import}

Before importing, [upload](../../../storage/operations/objects/upload.md#simple) the `.sql` file with metadata into the bucket you [created earlier](#before-you-begin). For information on how to prepare a file and how the import process works, see [{#T}](../../tutorials/metastore-import.md).

{% list tabs group=instructions %}

- Management console {#console}

   To import data to a {{ metastore-name }} cluster:

   1. Navigate to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
   1. Click ![image](../../../_assets/console-icons/ellipsis.svg) for the cluster you need and select ![image](../../../_assets/console-icons/arrow-down-to-square.svg) **{{ ui-key.yacloud.metastore.action_import }}**.
   1. In the window that opens, select the bucket you [created earlier](#before-you-begin) and the file to import the cluster data from.
   1. Click **{{ ui-key.yacloud.metastore.dialog.import-export.action_import }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To import metadata to a {{ metastore-name }} cluster, run this command:

   ```bash
   {{ yc-metastore }} cluster import-data <cluster_name_or_ID> \
      --bucket <bucket_name> \
      --filepath <data_file>
   ```

   Where:

   * `--bucket`: Bucket you [created earlier](#before-you-begin) to import the cluster data from.
   * `--filepath`: Path to the `.sql` file to import the cluster data from.

   You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.ImportData](../../api-ref/Cluster/importData.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-metastore }}/managed-metastore/v1/clusters/<cluster_ID>:import' \
            --data '{
                       "bucket": "<bucket_name>",
                       "filepath": "<data_file>"
                    }'
        ```

        Where:

         * `bucket`: Bucket you [created earlier](#before-you-begin) to import the cluster data from.
         * `filepath`: Path to the `.sql` file to import the cluster data from.

         You can get the cluster ID and name with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../../api-ref/Cluster/importData.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.ImportData](../../api-ref/grpc/Cluster/importData.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/metastore/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "bucket": "<bucket_name>",
                    "filepath": "<data_file>"
                }' \
            {{ api-host-metastore }}:{{ port-https }} \
            yandex.cloud.metastore.v1.ClusterService.ImportData
        ```

        Where:

         * `bucket`: Bucket you [created earlier](#before-you-begin) for cluster data export.
         * `filepath`: Path to the `.sql` file to which the cluster data will be written. If a file with that name already exists, it will be overwritten.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../../api-ref/grpc/Cluster/importData.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [metastore-trademark](../../../_includes/metadata-hub/metastore-trademark.md) %}
