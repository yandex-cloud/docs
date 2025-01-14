---
title: How to import an image from another cloud or folder in {{ compute-full-name }}
description: Follow this guide to import an image from another cloud or folder.
---

# Importing an image from another cloud or folder

To import an image from another cloud or folder:

  1. Make sure you have the following roles for the cloud or folder hosting the required image:

     * Role for cloud: `resource-manager.clouds.member`.
     * Role for folder: `viewer` or `compute.images.user`.

     For more information about assigning roles, see [{#T}](../../../iam/operations/roles/grant.md).

  1. Import a copy of this image to your folder using the [CLI](../../../cli/quickstart.md):

     {% include [cli-install](../../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

     1. See the description of the CLI command to create an image:

        ```bash
        {{ yc-compute }} image create --help
        ```

     1. To get a list of available images in the source cloud or folder, run the following command: `{{ yc-compute }} image list --folder-name <source_folder_name>`. Here is an example:

        ```bash
        {{ yc-compute }} image list --folder-name my-source-folder
        ```

        Result:

        ```text
        +----------------------+-------------+--------+----------------------+--------+
        |          ID          |    NAME     | FAMILY |     PRODUCT IDS      | STATUS |
        +----------------------+-------------+--------+----------------------+--------+
        | fd8eq6b2fkut******** | first-image |        | f2ehc12fue73******** | READY  |
        +----------------------+-------------+--------+----------------------+--------+
        ```

     1. Select `ID` or `NAME` of the image you are importing.

     1. To import an image, run the following command: `{{ yc-compute }} image create --source-image-id=<source_image_ID>`. Here is an example:

        ```bash
        {{ yc-compute }} image create --source-image-id=fd8o0pt9qfbt********
        ```

        Result:

        ```yaml
        done (12s)
        id: fd8eq6b2fkut********
        folder_id: b1g07hj5r6i4********
        created_at: "2024-08-14T17:45:44Z"
        storage_size: "2562719744"
        min_disk_size: "21474836480"
        product_ids:
          - f2ehc12fue73********
        status: READY
        os:
          type: LINUX
        ```

   1. Check the result by running the following command: `{{ yc-compute }} image list --folder-name <target_folder_name>`. Here is an example:

      ```bash
      {{ yc-compute }} image list --folder-name my-destination-folder
      ```

      Result:

      ```text
      +----------------------+--------------------+--------+----------------------+--------+
      |          ID          |        NAME        | FAMILY |     PRODUCT IDS      | STATUS |
      +----------------------+--------------------+--------+----------------------+--------+
      | fd8eq6b2fkut******** | first-image        |        | f2ehc12fue73******** | READY  |
      | fd8ghl1n3brd******** | second-image       |        | f2e87com7i95******** | READY  |
      +----------------------+--------------------+--------+----------------------+--------+
      ```