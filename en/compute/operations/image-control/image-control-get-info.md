---
title: "How to get information about a disk image in {{ compute-full-name }}"
---

# Getting information about a disk image

To get information about a disk image:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command to get information about a disk image:

      ```bash
      yc compute image get --help
      ```

   1. Get information about your disk image by specifying its name or ID:

      ```bash
      yc compute image get <image_name>
      ```

      Result:

      ```bash
      id: fd8orln8oii5********
      folder_id: b1g72vbihiut********
      created_at: "2023-05-19T06:46:14Z"
      name: image-ubuntu-20-04
      description: ubuntu-20.04.6-live-server-amd64
      storage_size: "1488977920"
      min_disk_size: "1488977920"
      status: READY
      os:
        type: LINUX
      ```

{% endlist %}
