---
title: How to get a list of disk images in {{ compute-full-name }}
description: Follow this guide to get a list of disk images.
---

# Getting a list of disk images

To get a list of disk images:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where disk images are stored.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.switch_images }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for work with disk images:

      ```bash
      yc compute image --help
      ```

  1. Get a list of all the disks in the default folder:

      ```bash
      yc compute image list
      ```

      Result:

      ```text
      +----------------------+-------------+--------+-------------+--------+
      |          ID          |    NAME     | FAMILY | PRODUCT IDS | STATUS |
      +----------------------+-------------+--------+-------------+--------+
      | fd8n3spmksqm******** | first-image |        |             | READY  |
      +----------------------+-------------+--------+-------------+--------+
      ```

- API {#api}

  Use the [list](../../api-ref/Image/list.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/List](../../api-ref/grpc/image_service.md#List) gRPC API call.

{% endlist %}