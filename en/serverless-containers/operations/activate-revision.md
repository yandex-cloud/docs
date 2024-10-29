---
title: Making a revision active
description: Follow this guide to make a container revision active.
---

# Making a revision active

{% include [active-revision](../../_includes/serverless-containers/active-revision.md) %}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the folder with your container.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Select the container.
  1. In the row with the revision you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.serverless-containers.label_edit-active-revision }}** from the drop-down list.
  1. In the window that opens, click **{{ ui-key.yacloud.serverless-containers.popup-confirm-edit-active-revision_button_confirm }}**. The revision status will change from `Obsolete` to `Active`.
  

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  {% include [get-revision-list](../../_includes/serverless-containers/get-revision-list.md) %}

  To make a container revision active, run this command:

  ```bash
  yc serverless containers rollback \
   --name <container_name> \
   --revision-id <revision_ID>
  ```

  Where:

  * `--name`: Name of the container whose active revision you want to change.
  * `--revision-id`: ID of the container revision you want to make active.

  Result:

  ```text
  id: bba610kqnj8b********
  folder_id: b1g3f9i71bpm********
  created_at: "2023-11-15T12:49:49.795Z"
  name: container
  url: https://bba610kqnj8b********.containers.yandexcloud.net/
  status: ACTIVE
  ```

- API {#api}

  To make a container revision active, use either the [rollback](../../serverless-containers/containers/api-ref/Container/rollback.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/Rollback](../../serverless-containers/containers/api-ref/grpc/Container/rollback.md) gRPC API call.

{% endlist %}