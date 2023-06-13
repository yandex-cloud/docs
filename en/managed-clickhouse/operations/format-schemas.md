# Managing data format schemas in {{ mch-name }}

{% include [Format schemas intro](../../_includes/mdb/mch/format-schemas-intro.md) %}

Examples of working with the Cap'n Proto and Protobuf formats when inserting data into a cluster are given in [{#T}](../tutorials/insert.md).

## Before connecting the format schema {#prereq}

{{ mch-name }} only works with readable data format schemas imported to {{ objstorage-full-name }}. Before connecting the schema to a cluster:

1. Prepare a file with a format schema (see the documentation for [Cap'n Proto](https://capnproto.org/language.html) and [Protobuf](https://developers.google.com/protocol-buffers/docs/tutorials?hl=ru)).


1. [Import](../../storage/operations/objects/upload.md) the file with the data format schema to {{ objstorage-full-name }}.

1. Configure access to the schema file using one of the methods:

   * Use a [service account](../../iam/concepts/users/service-accounts.md) (recommended). This method enables you to access the file without entering account information.

      1\. [Connect a service account to a cluster](s3-access.md#connect-service-account).
      2\. [Assign the account the role](s3-access.md#configure-acl) of `storage.viewer`.
      3\. In the bucket ACL, [grant the account](../../storage/operations/buckets/edit-acl.md) `READ` permission.

   * [Enable public access](../../storage/operations/objects/edit-acl.md) to the bucket containing the file.

1. [Get a link](s3-access.md#get-link-to-object) to the schema file.


## Connecting the format schema {#add-format-schema}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and select the **Data format schemas** tab.
   1. Click **Add schema**.
   1. In the **Add schema** dialog box, fill out the form by completing the **URL** field with the previously generated link to the format schema file.
   1. Click **Add**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To connect a format schema to a cluster, run the command:
   - For **Cap'n Proto**:

      ```bash
      {{ yc-mdb-ch }} format-schema create "<format schema name>" \
        --cluster-name="<cluster name>" \
        --type="capnproto" \
        --uri="<link to the file in {{ objstorage-full-name }}>"
      ```

   - For **Protobuf**:

      ```bash
      {{ yc-mdb-ch }} format-schema create "<format schema name>" \
        --cluster-name="<cluster name>" \
        --type="protobuf" \
        --uri="<link to the file in {{ objstorage-full-name }}>"
      ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. Add the `format_schema` block to the {{ mch-name }} cluster description:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        format_schema {
          name = "<schema name>"
          type = "<schema type: FORMAT_SCHEMA_TYPE_CAPNPROTO or FORMAT_SCHEMA_TYPE_PROTOBUF>"
          uri  = "<link to data format schema file in {{ objstorage-full-name }}>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To add a data format schema, use the [create](../api-ref/FormatSchema/create.md) REST API method for the [FormatSchema](../api-ref/FormatSchema/index.md) resource or the [FormatSchemaService/Create](../api-ref/grpc/format_schema_service.md#Create) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).
   * Format schema name in the `formatSchemaName` parameter.
   * Schema type: `FORMAT_SCHEMA_TYPE_CAPNPROTO` or `FORMAT_SCHEMA_TYPE_PROTOBUF` in the `type` parameter.
   * Link to the file in {{ objstorage-full-name }} in the `uri` parameter.

{% endlist %}

## Changing a format schema {#update-format-schema}

{{ mch-name }} doesn't track changes in the format schema file that is in the {{ objstorage-full-name }} bucket.

To update the contents of a schema that is already connected to the cluster:


1. [Upload the file](../../storage/operations/objects/upload.md) with the current format schema to {{ objstorage-full-name }}.
1. [Get a link](s3-access.md#get-link-to-object) to this file.
1. Change the parameters of the format schema that is connected to {{ mch-name }} by providing a new link to the format schema file.


{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and select the **Data format schemas** tab.
   1. Select the schema, click ![image](../../_assets/options.svg), and select **Edit**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To change the link to the file in object storage with the format schema, run the command:

   ```bash
   {{ yc-mdb-ch }} format-schema update "<data schema name>" \
     --cluster-name="<cluster name>" \
     --uri="<new link to the file in {{ objstorage-full-name }}>"
   ```

   You can request the schema name with a [list of format schemas in the cluster](#list-format-schemas) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. In the {{ mch-name }} cluster description, change the parameter of the `uri` value in the `format_schema` block:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<cluster name>" {
        ...
        format_schema {
          name = "<schema name>"
          type = "<schema type>"
          uri  = "<new link to the schema file in {{ objstorage-full-name }}>"
        }
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

      {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To update a data format schema, use the [update](../api-ref/FormatSchema/update.md) REST API method for the [FormatSchema](../api-ref/FormatSchema/index.md) resource or the [FormatSchemaService/Update](../api-ref/grpc/format_schema_service.md#Update) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).
   * Format schema name in the `formatSchemaName` parameter. You can request the schema name with a [list of format schemas in the cluster ](#list-format-schemas).
   * The new link to the file in {{ objstorage-full-name }} in the `uri` parameter.
   * List of cluster configuration fields to be changed in the `updateMask` parameter.

      {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Disabling a format schema {#disable-format-schema}

{% note info %}


After disabling a format schema, the corresponding object is kept in the {{ objstorage-full-name }} bucket. If this object with the format schema is no longer needed, you can [delete](../../storage/operations/objects/delete.md).


{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and select the **Data format schemas** tab.
   1. Select the appropriate schema, click ![image](../../_assets/options.svg), and select **Delete**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To disable a format schema, run the command:

   ```bash
   {{ yc-mdb-ch }} format-schema delete "<format schema name>" \
     --cluster-name="<cluster name>"
   ```

   You can request the schema name with a [list of format schemas in the cluster](#list-format-schemas) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }}

   1. Open the current {{ TF }} configuration file with an infrastructure plan.

      For more information about how to create this file, see [Creating clusters](cluster-create.md).

   1. Delete the `format_schema` block describing the required format schema from the {{ mch-name }} cluster description.

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

   To delete a data format schema, use the [delete](../api-ref/FormatSchema/delete.md) REST API method for the [FormatSchema](../api-ref/FormatSchema/index.md) resource or the [FormatSchemaService/Delete](../api-ref/grpc/format_schema_service.md#Delete) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).
   * Format schema name in the `formatSchemaName` parameter. You can request the schema name with a [list of format schemas in the cluster ](#list-format-schemas).

{% endlist %}

## Getting a list of format schemas in a cluster {#list-format-schemas}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ mch-name }}**.
   1. Click on the name of the cluster you need and select the **Data format schemas** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of format schemas in a cluster, run the command:

   ```bash
   {{ yc-mdb-ch }} format-schema list --cluster-name="<cluster name>"
   ```

   The cluster name can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get a list of data format schemas, use the [list](../api-ref/FormatSchema/list.md) REST API method for the [FormatSchema](../api-ref/FormatSchema/index.md) resource or the [FormatSchemaService/List](../api-ref/grpc/format_schema_service.md#List) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting detailed information about a format schema {get-format-schema}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get detailed information about a format schema, run the command:

   ```bash
   {{ yc-mdb-ch }} format-schema get "<format schema name>" \
     --cluster-name="<cluster name>"
   ```

   You can request the schema name with a [list of format schemas in the cluster](#list-format-schemas) and the cluster name with a [list of clusters in the folder](cluster-list.md#list-clusters).

- API

   To get detailed information about a data format schema, use the [get](../api-ref/FormatSchema/get.md) REST API method for the [FormatSchema](../api-ref/FormatSchema/index.md) resource or the [FormatSchemaService/Get](../api-ref/grpc/format_schema_service.md#Get) gRPC API call and provide the following in the request:

   * Cluster ID in the `clusterId` parameter. You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).
   * Format schema name in the `formatSchemaName` parameter. You can request the schema name with a [list of format schemas in the cluster ](#list-format-schemas).

{% endlist %}
