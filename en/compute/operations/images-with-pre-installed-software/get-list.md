---
title: How to get a list of public images in {{ compute-full-name }}
description: Follow this guide to get a list of public images in {{ compute-full-name }}.
---

# Getting a list of public images

When creating a virtual machine, you need to select an [image](../../concepts/image.md) with the software that you want to use.

{% list tabs group=instructions %}

- Management console {#console}

  You can view a list of public images when creating a virtual machine:

  1. In the [management console]({{ link-console-main }}), open the folder where you want to create your VM.
  1. At the top right, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}** from the list that opens.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, click **{{ ui-key.yacloud.compute.instances.create.button_show-all-marketplace-products }}**. You will see a list of all available public images.

  To [view information](./get-info.md) about a specific image, click ![image](../../../_assets/console-icons/circle-info.svg).

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  A list of public images resides in the **standard-images** folder.

  * {% include [standard-images](../../../_includes/standard-images.md) %}

      {% note info %}

      By default, the command returns only the first 1,000 images. To view the full list of images, include the `--limit 0` parameter.

      {% endnote %}

  * To get a list of IDs of available [image families](../../concepts/image.md#family), run the following command:

      ```bash
      yc compute image list \
        --folder-id standard-images \
        --limit 0 \
        --jq '.[].family' | sort | uniq
      ```

      Result:

      ```text
      ...
      ubuntu-2204-lts
      ubuntu-2204-lts-oslogin
      ubuntu-2204-lts-vgpu-v13
      ...
      ```

  * To get a list of available public images belonging to a particular family, run this command:

      ```bash
      yc compute image list --folder-id standard-images | grep <family_ID>
      ```

      Where `<family_ID>` is the image family ID, e.g., `ubuntu-2204-lts-oslogin`.

      Result:

      ```text
      ...
      | fd827n44qr0q******** | ubuntu-2204-lts-oslogin-v20240617 | ubuntu-2204-lts-oslogin | f2eofgd2cj0e******** | READY |
      | fd827ukfjohd******** | ubuntu-2204-lts-oslogin-v20240701 | ubuntu-2204-lts-oslogin | f2evubhrcfsh******** | READY |
      | fd82sdt0b96a******** | ubuntu-2204-lts-oslogin-v20240304 | ubuntu-2204-lts-oslogin | f2ecb2d55npl******** | READY |
      ...
      ```

  For more information about the `yc compute image list` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/image/list.md).

- API {#api}

  1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) used for authentication in these examples:
     * [Guide](../../../iam/operations/iam-token/create.md) for users with a Yandex account.
     * [Guide](../../../iam/operations/iam-token/create-for-sa.md) for a service account.
     * [Guide](../../../iam/operations/iam-token/create-for-federation.md) for a federated account.
  1. Get a list of public images from {{ yandex-cloud }} using the [list](../../api-ref/Image/list.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/List](../../api-ref/grpc/Image/list.md) gRPC API call. In your request, specify the following parameters:
     * Specify `standard-images` as the folder ID.
     * The folder contains many images, so specify `pageSize=1000` or use the obtained value of `nextPageToken` to get the next page.

    Write the result to a file, e.g., `output.json`:

    ```bash
    export IAM_TOKEN=CggaATEVAgA...
    curl \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      "https://compute.{{ api-host }}/compute/v1/images?folderId=standard-images&pageSize=1000" > output.json
    ```

{% endlist %}

You can also view information about all available public images in [{{ marketplace-name }}](/marketplace).