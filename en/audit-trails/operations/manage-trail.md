---
title: How to manage {{ at-name }}
description: Follow this tutorial to update or delete {{ at-full-name }}.
---

# Managing a trail


You can update the [destination object](../concepts/trail.md#target), event [types](../concepts/control-plane-vs-data-plane.md) to collect, audit log [collection scopes](../concepts/trail.md#collecting-area), and [other trail settings](../concepts/trail.md#trail-settings), as well as [delete](#delete-trail) the trail.

## Updating a trail {#update-trail}

{% list tabs group=instructions %}

- Management console {#console}

  To update a trail:

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the trail.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. In the row with the trail you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the trail settings. For a list of trail settings you can edit, see [{#T}](../concepts/trail.md#trail-settings).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  See the description of the [CLI](../../cli/) trail editing command for details about the arguments you can use:

  ```bash
  yc audit-trails trail update --help
  ```

  You can update a trail by specifying its parameters in one of these two ways:

  {% cut "In the YAML specification" %}

  Create a YAML specification containing the updated trail parameters and specify this file in the command for creating the trail.
  
  This method simplifies working with trail parameters and reduces error probability. In addition, you can only customize the registration of [data events](../concepts/control-plane-vs-data-plane.md#data-plane-events) using the YAML specification.

  1. Create a YAML file with the updated trail configuration:

      {% include [trail-create-cli-yaml-config](../../_includes/audit-trails/trail-create-cli-yaml-config.md) %}

      Where:

      * `name`: Trail name. It must be unique within the folder.
      * `folder_id`: [ID](../../resource-manager/operations/folder/get-id.md) of the folder the trail will reside in.
      * `destination`: Settings of the selected destination the audit logs will be uploaded to.

          {% note warning %}

          Destination settings are mutually exclusive. Using some settings makes it impossible to use others.

          {% endnote %}

          * `object_storage`: Uploading logs to a {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md#naming):

              * `bucket_id`: [Bucket](../../storage/concepts/bucket.md#naming) name.

                  You can request the name of the bucket with the list of buckets in the folder (the default folder is used):

                  ```bash
                  yc storage bucket list
                  ```
              * `object_prefix`: [Prefix](../../storage/concepts/object.md#folder) that will be assigned to the objects with audit logs in the bucket. It is an optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

                  {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

          * `cloud_logging`: Uploading logs to a {{ cloud-logging-full-name }} [group](../../logging/concepts/log-group.md).

              Specify the log group ID in the `log_group_id` parameter. You can request the ID with the [list of log groups in the folder](../../logging/operations/list.md).
          * `data_stream`: Uploading logs to a [data stream](../../data-streams/concepts/glossary.md#stream-concepts) in {{ yds-full-name }}:

              * `stream_name`: Stream name. You can request the name with the [list of data streams in the folder](../../data-streams/operations/manage-streams.md#list-data-streams).
              * `database_id`: ID of the {{ ydb-short-name }} database used by {{ yds-name }}. You can request the ID with the [list of {{ ydb-short-name }} databases in the folder](../../ydb/operations/manage-databases.md#list-db).
      * `service_account_id`: Service account [ID](../../iam/operations/sa/get-id.md).

      {% include [trail-create-cli-yaml-desc-filtering](../../_includes/audit-trails/trail-create-cli-yaml-desc-filtering.md) %}

  1. To update a trail, run this command:

      ```bash
      yc audit-trails trail update --file <file_path>
      ```

  {% endcut %}

  {% cut "In the command arguments:" %}

  Use this method if your trail configuration is simple and contains few parameters.
  
  {% note info %}

  You can only customize the registration of [data events](../concepts/control-plane-vs-data-plane.md#data-plane-events) using the YAML specification.

  {% endnote %}

  To update a trail, run this command:

  ```bash
  yc audit-trails trail update \
    --name <trail_name> \
    --new-name <new_trail_name> \
    --description <trail_description> \
    --labels <label_list> \
    --service-account-id <service_account_ID> \
    --destination-bucket <bucket_name> \
    --destination-bucket-object-prefix <prefix_for_objects> \
    --destination-log-group-id <log_group_ID> \
    --destination-yds-stream <YDS_name> \
    --destination-yds-database-id <YDS_database_ID> \
    --filter-all-folder-id <folder_ID> \
    --filter-all-cloud-id <cloud_ID> \
    --filter-all-organisation-id <organization_ID> \
    --filter-some-folder-ids <cloud_folder_list> \
    --filter-from-cloud-id <cloud_ID_with_selected_folders> \
    --filter-some-cloud-ids <list_of_clouds_in_organization> \
    --filter-from-organisation-id <organization_ID_with_selected_clouds>
    ```

    Where:
    * `--name`: Name of the trail you need to update. Instead of a name, you can provide the trail ID in the `--id` parameter.
    * `--new-name`: New trail name. The name must be unique within the folder. This is an optional parameter.

    {% include [trail-cli-flag-desc](../../_includes/audit-trails/trail-cli-flag-desc.md) %}

  {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. To update a trail created with {{ TF }}, open the {{ TF }} configuration file and update the trail description fragment:

      {% include [trail-tf-manifest](../../_includes/audit-trails/trail-tf-manifest.md) %}

      Where:

      {% include [trail-create-tf-descs_part1](../../_includes/audit-trails/trail-create-tf-descs-part1.md) %}

      {% include [trail-create-tf-descs_logging](../../_includes/audit-trails/trail-create-tf-descs-logging.md) %}

      {% include [trail-create-tf-descs_part2](../../_includes/audit-trails/trail-create-tf-descs-part2.md) %}

      For more information about the `yandex_audit_trails_trail` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/audit_trails_trail).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources. You can check the new resources and their settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

     ```bash
     yc audit-trails trail get <trail_name>
     ```

- API {#api}

  To update a trail, use the [update](../api-ref/Trail/update.md) REST API method for the [Trail](../api-ref/Trail/index.md) resource or the [TrailService/Update](../api-ref/grpc/Trail/update.md) gRPC API call.

{% endlist %}

## Deleting a trail {#delete-trail}

{% list tabs group=instructions %}

- Management console {#console}

  To delete a trail:

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the trail.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. In the row with the trail you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the deletion.

- CLI {#cli}

  To delete a trail, run this command:

  ```bash
  yc audit-trails trail delete <trail_name_or_ID>
  ```

  To find out the names and IDs of available trails, use [this tutorial](./get-list.md).

- {{ TF }} {#tf}

  To delete a trail created using {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the trail description section.

      Example of a trail description in a {{ TF }} configuration:

      {% include [trail-tf-manifest](../../_includes/audit-trails/trail-tf-manifest.md) %}

  1. In the command line, go to the directory with the {{ TF }} configuration file.
  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```bash
     Success! The configuration is valid.
     ```
  1. Run this command:

     ```bash
     terraform plan
     ```

     The terminal will display a list of resources with their parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```
  1. Confirm the changes: type `yes` into the terminal and press **Enter**.
  1. To make sure the trail has been deleted, use [this tutorial](./get-list.md).

- API {#api}

  To delete a trail, use the [delete](../api-ref/Trail/delete.md) REST API method for the [Trail](../api-ref/Trail/index.md) resource or the [TrailService/Delete](../api-ref/grpc/Trail/delete.md) gRPC API call.

{% endlist %}