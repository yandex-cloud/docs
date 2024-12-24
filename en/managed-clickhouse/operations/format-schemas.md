---
title: How to manage data format schemas in {{ mch-name }}
description: Follow this guide to learn how to manage data format schemas in {{ mch-name }}.
---

# Managing data format schemas in {{ mch-name }}

{% include [Format schemas intro](../../_includes/mdb/mch/format-schemas-intro.md) %}

You can find examples of working with the Cap'n Proto and Protobuf formats when inserting data into a cluster in the [Adding data to a cluster](../tutorials/insert.md) section.

## Before connecting the format schema {#prereq}

{{ mch-name }} only works with readable data format schemas imported to {{ objstorage-full-name }}. Before connecting the schema to a cluster:

1. Prepare a file with a format schema (see the documentation for [Cap'n Proto](https://capnproto.org/language.html) and [Protobuf](https://developers.google.com/protocol-buffers/docs/tutorials?hl=ru)).


1. To link your [service account](../../iam/concepts/users/service-accounts.md) to the cluster, [make sure](../../iam/operations/roles/get-assigned-roles.md) your {{ yandex-cloud }} account has the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher.
1. [Import](../../storage/operations/objects/upload.md) the file with the data format schema to {{ objstorage-full-name }}.
1. [Connect the service account to the cluster](s3-access.md#connect-service-account). You will use this service account to configure permissions to access the schema file.
1. [Assign](s3-access.md#configure-acl) the `storage.viewer` role to the service account.
1. In the bucket's ACL, [add](../../storage/operations/buckets/edit-acl.md) the `READ` permission to the service account.
1. [Get a link](s3-access.md#get-link-to-object) to the schema file.


## Creating a format schema {#add-format-schema}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_format-schemas }}** tab.
    1. Click **{{ ui-key.yacloud.clickhouse.cluster.format-schemas.button-action_add-format-schema }}**.
    1. In the **{{ ui-key.yacloud.clickhouse.cluster.format-schemas.dialog.title_add }}** dialog box, fill out the form by completing the **{{ ui-key.yacloud.clickhouse.cluster.format-schemas.dialog.field_format-schema-uri }}** field with the previously generated link to the format schema file.
    1. Click **{{ ui-key.yacloud.clickhouse.cluster.format-schemas.dialog.label_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a format schema, run this command:
  - For **Cap'n Proto**:

    ```bash
    {{ yc-mdb-ch }} format-schema create "<format_schema_name>" \
      --cluster-name="<cluster_name>" \
      --type="capnproto" \
      --uri="<link_to_file_in_Object_Storage>"
    ```

  - For **Protobuf**:

    ```bash
    {{ yc-mdb-ch }} format-schema create "<format_schema_name>" \
      --cluster-name="<cluster_name>" \
      --type="protobuf" \
      --uri="<link_to_file_in_Object_Storage>"
    ```

  You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Add a `format_schema` block to the {{ mch-name }} cluster description:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          format_schema {
            name = "<schema_name>"
            type = "<schema_type>"
            uri  = "<link_to_data_format_schema_file_in_Object_Storage>"
          }
        }
        ```

        Where `type` is the schema type, `FORMAT_SCHEMA_TYPE_CAPNPROTO` or `FORMAT_SCHEMA_TYPE_PROTOBUF`.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [FormatSchema.Create](../api-ref/FormatSchema/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }/managed-clickhouse/v1/clusters/<cluster_ID>/formatSchemas' \
            --data '{
                      "formatSchemaName": "<schema_name>",
                      "type": "<schema_type>",
                      "uri": "<file_link>"
                    }'
        ```

        Where:

        * `formatSchemaName`: Schema name.
        * `type`: Schema type, `FORMAT_SCHEMA_TYPE_CAPNPROTO` or `FORMAT_SCHEMA_TYPE_PROTOBUF`.
        * `uri`: Link to the file with the schema in {{ objstorage-name }}.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/FormatSchema/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [FormatSchemaService.Create](../api-ref/grpc/FormatSchema/create.md) call and and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/format_schema_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "format_schema_name": "<schema_name>",
                    "type": "<schema_type>",
                    "uri": "<file_link>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.FormatSchemaService.Create
        ```

        Where:

        * `format_schema_name`: Schema name.
        * `type`: Schema type, `FORMAT_SCHEMA_TYPE_CAPNPROTO` or `FORMAT_SCHEMA_TYPE_PROTOBUF`.
        * `uri`: Link to the file with the schema in {{ objstorage-name }}.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/FormatSchema/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing a format schema {#update-format-schema}

{{ mch-name }} does not track changes in the format schema file that is in the {{ objstorage-full-name }} bucket.

To update the contents of a schema that is already connected to the cluster:


1. [Upload the file](../../storage/operations/objects/upload.md) with the current format schema to {{ objstorage-full-name }}.
1. [Get a link](s3-access.md#get-link-to-object) to this file.
1. Change the parameters of the format schema that is connected to {{ mch-name }} by providing a new link to the format schema file.


{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_format-schemas }}** tab.
    1. Select the appropriate schema, click ![image](../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the link to the file in object storage with the format schema, run the command:

    ```bash
    {{ yc-mdb-ch }} format-schema update "<data_schema_name>" \
      --cluster-name="<cluster_name>" \
      --uri="<new_link_to_file_in_Object_Storage>"
    ```

    You can request the schema name with a [list of format schemas in the cluster](#list-format-schemas) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. In the {{ mch-name }} cluster description, change the `uri` parameter value under `format_schema`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
          ...
          format_schema {
            name = "<schema_name>"
            type = "<schema_type>"
            uri  = "<new_link_to_schema_file_in_Object_Storage>"
          }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

        {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [FormatSchema.Update](../api-ref/FormatSchema/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }/managed-clickhouse/v1/clusters/<cluster_ID>/formatSchemas/<schema_name>' \
            --data '{
                      "updateMask": "uri",
                      "uri": "<file_link>"
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Here only one parameter is specified: `uri`.

        * `uri`: Link to the new file with the schema in {{ objstorage-name }}.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/FormatSchema/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [FormatSchemaService.Update](../api-ref/grpc/FormatSchema/update.md) call and and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/format_schema_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "format_schema_name": "<schema_name>",
                    "update_mask": {
                      "paths": ["uri"]
                    },
                    "uri": "<file_link>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.FormatSchemaService.Create
        ```

        Where:

        * `format_schema_name`: Schema name.
        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Here only one parameter is specified: `uri`.

        * `uri`: Link to the new model file in {{ objstorage-name }}.

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/FormatSchema/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Disabling a format schema {#disable-format-schema}

{% note info %}


After disabling a format schema, the corresponding object is kept in the {{ objstorage-full-name }} bucket. If you no longer need this format schema object, you can [delete](../../storage/operations/objects/delete.md) it.


{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_format-schemas }}** tab.
   1. Select the appropriate schema, click ![image](../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To disable a format schema, run the command:

  ```bash
  {{ yc-mdb-ch }} format-schema delete "<format_schema_name>" \
    --cluster-name="<cluster_name>"
  ```

  You can request the schema name with a [list of format schemas in the cluster](#list-format-schemas) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file with an infrastructure plan.

        For more information about creating this file, see [Creating clusters](cluster-create.md).

    1. Delete the `format_schema` description section for the appropriate data format schema from the {{ mch-name }} cluster description.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    For more information, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [FormatSchema.Delete](../api-ref/FormatSchema/delete.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/formatSchemas/<schema_name>'
        ```

        You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the schema name with a [list of schemas](#list-format-schemas) in the cluster.

    1. View the [server response](../api-ref/FormatSchema/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [FormatSchemaService.Delete](../api-ref/grpc/FormatSchema/delete.md) call and and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/format_schema_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "format_schema_name": "<schema_name>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.FormatSchemaService.Delete
        ```

        You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the schema name with a [list of schemas](#list-format-schemas) in the cluster.

    1. View the [server response](../api-ref/grpc/FormatSchema/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Getting a list of format schemas in a cluster {#list-format-schemas}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.clickhouse.cluster.switch_format-schemas }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of format schemas in a cluster, run the command:

  ```bash
  {{ yc-mdb-ch }} format-schema list --cluster-name="<cluster_name>"
  ```

  You can request the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [FormatSchema.List](../api-ref/FormatSchema/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/formatSchemas'
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/FormatSchema/list.md#yandex.cloud.mdb.clickhouse.v1.ListFormatSchemasResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [FormatSchemaService.List](../api-ref/grpc/FormatSchema/list.md) call and and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/format_schema_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.FormatSchemaService.List
        ```

        You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/FormatSchema/list.md#yandex.cloud.mdb.clickhouse.v1.ListFormatSchemasResponse) to make sure the request was successful.

{% endlist %}

## Getting detailed information about a format schema {get-format-schema}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get detailed information about a format schema, run the command:

  ```bash
  {{ yc-mdb-ch }} format-schema get "<format_schema_name>" \
    --cluster-name="<cluster_name>"
  ```

  You can request the schema name with a [list of format schemas in the cluster](#list-format-schemas) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [FormatSchema.Get](../api-ref/FormatSchema/get.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/formatSchemas/<schema_name>'
        ```

        You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the schema name with a [list of schemas](#list-format-schemas) in the cluster.

    1. View the [server response](../api-ref/FormatSchema/list.md#yandex.cloud.mdb.clickhouse.v1.ListFormatSchemasResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [FormatSchemaService.Get](../api-ref/grpc/FormatSchema/get.md) call and and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/format_schema_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "format_schema_name": "<schema_name>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.FormatSchemaService.Get
        ```

        You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters) and the schema name with a [list of schemas](#list-format-schemas) in the cluster.

    1. View the [server response](../api-ref/grpc/FormatSchema/get.md#yandex.cloud.mdb.clickhouse.v1.FormatSchema) to make sure the request was successful.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
