---
title: How to delete a desktop group in {{ cloud-desktop-full-name }}
description: In this tutorial, you will learn how to delete a desktop group in {{ cloud-desktop-full-name }}.
---

# Deleting a desktop group

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your desktop group.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the desktop group you want to delete, then select **{{ ui-key.yacloud.common.delete }}**.
  
      {% note tip %}

      To delete multiple desktop groups, select them in the list and click **{{ ui-key.yacloud.common.delete }}** at the bottom of the screen.

      {% endnote %}

  1. Confirm the deletion.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the [CLI](../../../cli/index.yaml) command for the [desktop group](../../../cloud-desktop/concepts/desktops-and-groups.md) deletion:

      ```bash
      yc desktops group delete --help
      ```

  1. Get a list of desktop groups in the default folder:

      {% include [desktops-group-list](../../../_includes/cloud-desktop/desktops-group-list.md) %}

  1. Select the desktop group `ID` or `NAME`, e.g., `my-desktop-group`.
  1. Delete the desktop group:

     ```bash
     yc desktops group delete <desktop_group_name_or_ID>
     ```

- API {#api}

  Use the [delete](../../api-ref/DesktopGroup/delete.md) REST API method for the [DesktopGroup](../../api-ref/DesktopGroup/index.md) resource or the [DesktopGroupService/Delete](../../api-ref/grpc/DesktopGroup/delete.md) gRPC API call.

{% endlist %}