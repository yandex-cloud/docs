---
title: How to delete a {{ container-registry-full-name }}
description: Follow this guide to delete a {{ container-registry-short-name }}.
---

# Deleting a registry

{% note info %}

You can only delete an empty [registry](../../concepts/registry.md). Make sure to [delete Docker images from the registry](../docker-image/docker-image-delete.md) before deleting the registry itself.

{% endnote %}

{% include [registry-get-id-name](../../../_includes/iot-core/registry-get-id-name.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To delete a registry:
  1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}** in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to delete a registry from.
  1. Click ![image](../../../_assets/console-icons/ellipsis-vertical.svg) in the line of the registry to delete.
  1. In the menu that opens, click **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.cr.overview.popup-confirm_button_delete }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete the registry:

     ```bash
     yc container registry delete new-reg
     ```

     The result will be as follows:

     ```text
     done
     ```

  1. Make sure the registry has been deleted:

     ```bash
     yc container registry list
     ```

     The result will be as follows:

     ```text
     +----+------+-----------+
     | ID | NAME | FOLDER ID |
     +----+------+-----------+
     +----+------+-----------+
     ```

- API {#api}

  To delete the registry, use the [delete](../../api-ref/Registry/delete.md) method for the [Registry](../../api-ref/Registry/) resource.

{% endlist %}