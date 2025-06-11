---
title: How to get a list of disk images in {{ compute-full-name }}
description: Follow this guide to get a list of disk images.
---

# Getting a list of disk images

To get a list of disk images:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your disk images.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.images_e7RdQ }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for using disk images:

      ```bash
      yc compute image --help
      ```

  1. Get a list of disk images in the default folder:

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

  Use the [list](../../api-ref/Image/list.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/List](../../api-ref/grpc/Image/list.md) gRPC API call.

{% endlist %}