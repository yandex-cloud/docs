---
title: How to manage {{ at-name }}
description: Follow this tutorial to update or delete {{ at-full-name }}.
---

# Managing a trail


You can update the [destination object](../concepts/trail.md#target), event [levels](../concepts/control-plane-vs-data-plane.md), audit log [collection scopes](../concepts/trail.md#collecting-area), and [other trail settings](../concepts/trail.md#trail-settings) or [delete](#delete-trail) the trail.

## Updating a trail {#update-trail}

You can add [conditions based on field values](../concepts/trail.md#field-filters) to data event filters using the CLI, {{ TF }}, or API. When updating your filter policy, provide it fully with the other relevant filters preserved.

{% list tabs group=instructions %}

- Management console {#console}

  To update a trail:

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the trail.
  1. [Navigate]({{ link-console-main }}/link/audit-trails) to **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. In the row with the trail, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the trail settings. For a list of editable trail settings, see [{#T}](../concepts/trail.md#trail-settings).
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  See the description of the CLI command for updating a trail:

  ```bash
  yc audit-trails trail update --help
  ```

  You can update a trail by specifying its parameters in one of these two ways:

  {% cut "In the YAML specification" %}

  Create a YAML specification containing the updated trail parameters and specify this file in the trail update command.
  
  This method simplifies working with trail parameters and reduces error probability. In addition, you can only customize the registration of [data events](../concepts/control-plane-vs-data-plane.md#data-plane-events) using the YAML specification.

  1. [Draft the YAML specification](prepare-spec.md) based on the current trail settings and update the parameters as needed.
  1. {% include [field-filter-cli](../../_includes/audit-trails/field-filter-cli.md) %}
  1. To update a trail, run this command:

      ```bash
      yc audit-trails trail update --file <file_path>
      ```

  {% endcut %}

  {% cut "In command parameters" %}

  Use this method if your trail configuration is simple and contains few parameters.
  
  {% note info %}

  You can only customize the registration of [data events](../concepts/control-plane-vs-data-plane.md#data-plane-events) using the YAML specification.

  {% endnote %}

  In the command, specify only the parameters you want to update. For example, to update the trail name, run this command:

  ```bash
  yc audit-trails trail update \
    --name <trail_name> \
    --new-name <new_trail_name>
  ```

  Command parameters:

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

      For more on the properties of the `yandex_audit_trails_trail` resource, see [this provider guide]({{ tf-provider-resources-link }}/audit_trails_trail).

  1. {% include [field-filter-tf](../../_includes/audit-trails/field-filter-tf.md) %}

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      Check the trail settings using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

     ```bash
     yc audit-trails trail get <trail_name>
     ```

- API {#api}

    1. [Get authenticated](../api-ref/authentication.md) in the API and use the [get](../api-ref/Trail/get.md) REST API method or the [TrailService/Get](../api-ref/grpc/Trail/get.md) gRPC API call to get the trail settings.
    1. Update the trail parameters as needed.
    1. {% include [field-filter-api](../../_includes/audit-trails/field-filter-api.md) %}
    1. Use the [update](../api-ref/Trail/update.md) REST API method for the [Trail](../api-ref/Trail/index.md) resource or the [TrailService/Update](../api-ref/grpc/Trail/update.md) gRPC API call to update the trail. Provide the trail ID, updated parameters, and update mask.

        If updating the filtering policy, enable `filteringPolicy` in `updateMask` for the REST API or `filtering_policy` in `update_mask.paths` for the gRPC API.

{% endlist %}

Examples of filters from the [guide on creating a trail](create-trail.md#filter-examples) can also be used to update a trail.

## Deleting a trail {#delete-trail}

{% list tabs group=instructions %}

- Management console {#console}

  To delete a trail:

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the trail.
  1. [Navigate]({{ link-console-main }}/link/audit-trails) to **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. In the row with the trail, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
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

  1. In the command line, navigate to the directory with the {{ TF }} configuration file.
  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is valid, you will get this message:

     ```bash
     Success! The configuration is valid.
     ```
  1. Run this command:

     ```bash
     terraform plan
     ```

     You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  
  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```
  1. Type `yes` and press **Enter** to confirm the changes.
  1. To make sure the trail has been deleted, use [this tutorial](./get-list.md).

- API {#api}

  To delete a trail, use the [delete](../api-ref/Trail/delete.md) REST API method for the [Trail](../api-ref/Trail/index.md) resource or the [TrailService/Delete](../api-ref/grpc/Trail/delete.md) gRPC API call.

{% endlist %}
