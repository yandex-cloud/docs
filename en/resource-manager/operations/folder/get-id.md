---
title: "How to get folder IDs in {{ yandex-cloud }}"
description: "In this tutorial, you will learn how to get a folder ID in {{ yandex-cloud }}."
---

# Getting the folder ID

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [management console]({{ link-console-cloud }}) and select the appropriate folder from the list on the left. On the page that opens, the folder ID is shown on top, next to the folder name.

   1. To copy the ID, hover over it and click ![image](../../../_assets/console-icons/copy.svg).

   You can also get the folder ID from the folder page URL in the management console:

   ```
   {{ link-console-main }}/folders/<folder_ID>
   ```

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   If you know the folder name, get its ID using the `get` command:

   ```bash
   yc resource-manager folder get my-folder
   ```

   Result:

   ```
   id: b1gd129pp9ha********
   ...
   ```

   If you don't, get a list of folders with IDs for the default cloud:

   ```bash
   yc resource-manager folder list
   ```

   Result:

   ```
   +----------------------+--------------------+------------------+--------+
   |          ID          |        NAME        |      LABELS      | STATUS |
   +----------------------+--------------------+------------------+--------+
   | b1gd129pp9ha******** | my-folder          |                  | ACTIVE |
   | b1g66mft1vop******** | default            |                  | ACTIVE |
   +----------------------+--------------------+------------------+--------+
   ```

   To view the list of folders in a different cloud, specify the folder ID in `cloud-id`:

   ```bash
   yc resource-manager folder list --cloud-id b1glku4lgd6g********
   ```

- API {#api}

   To get the list of folders with IDs, use the [list](../../api-ref/Folder/list.md) REST API method for the [Folder](../../api-ref/Folder/index.md) resource or the [FolderService/List](../../api-ref/grpc/folder_service.md#List) gRPC API call.

{% endlist %}
