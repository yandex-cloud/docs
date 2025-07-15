Get the ID of the latest version of the [public](../../compute/operations/images-with-pre-installed-software/get-list.md) {{ coi }}.

A {{ coi }} in [{{ container-registry-name }}](../../container-registry/) may get updates and modifications that come with new releases. This will not automatically update the [VM](../../compute/concepts/vm.md) image to the latest version. To create an [instance group](../../compute/concepts/instance-groups/index.md) with the latest {{ coi }} version, perform an availability check:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
  ```

  Result:

  ```bash
  id: <latest_COI_version_ID>
  folder_id: standard-images
  ...
  ```

- {{ marketplace-full-name }} {#marketplace}

  1. Go to the {{ marketplace-name }} page and select the image with the configuration you need:
     * [{{ coi }}](/marketplace/products/yc/container-optimized-image).
     * [{{ coi }} GPU](/marketplace/products/yc/container-optimized-image-gpu).
  1. Under **{{ ui-key.yacloud_components.marketplace.label_product-ids }}**, copy the `image_id` value.

{% endlist %}