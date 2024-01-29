---
title: "How to delete an origin group in {{ cdn-full-name }}"
description: "In this tutorial, you will learn how to delete a {{ cdn-name }} origin group."
---

# Deleting an origin group

## Deleting a single origin group {#deletion-group-single}

To delete an [origin group](../../concepts/origins.md):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a resource group.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}** and select the group to delete.
   1. Click **{{ ui-key.yacloud.common.delete }}** in the bottom panel.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   {% include [include](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI origin group delete command below:

      ```bash
      yc cdn origin-group delete --help
      ```

   1. Get a list of all origin groups in the default folder:

      ```bash
      yc cdn origin-group list --format yaml
      ```

      Result:

      ```text
      - id: "90209"
        folder_id: b1g86q4m5vej********
        name: test-group-1
      ...
          origin_group_id: "90208"
          source: www.a1.com
          enabled: true
      ```

   1. Delete a group of origins in the default folder:

      ```bash
      yc cdn origin-group delete --id <origin_group_ID>
      ```

      For more information about the `yc cdn origin-group delete` command, see the [CLI reference](../../../cli/cli-ref/managed-services/cdn/origin-group/delete.md).

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   If you created an origin group using {{ TF }}, you can delete it:
   1. In the command line, go to the folder with the {{ TF }} configuration file.
   1. Delete the group description from the configuration file.
   1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Delete the origin group.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

- API {#api}

   Use the [delete](../../api-ref/OriginGroup/delete.md) REST API method for the [OriginGroup](../../api-ref/OriginGroup/index.md) resource or the [OriginGroupService/Delete](../../api-ref/grpc/origin_group_service.md#Delete) gRPC API call.

{% endlist %}

## Deleting multiple origin groups {#summ-deletion-groups}

To delete multiple origin groups:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to delete several resource groups from.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.cdn.label_origins-groups-list }}** and select the groups to delete.

      To delete all the groups, select the relevant option in the table header next to the **{{ ui-key.yacloud.cdn.column_name }}** field.
   1. Click **{{ ui-key.yacloud.common.delete }}** in the bottom panel.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}