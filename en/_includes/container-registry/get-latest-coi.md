Find out the ID of the latest version of the [public](../../compute/operations/images-with-pre-installed-software/get-list.md) {{ coi }}.

A {{ coi }} in a [{{ container-registry-name }}](../../container-registry/) registry may be updated and changed with new releases. This will not automatically update the [VM](../../compute/concepts/vm.md) image to the latest version. To create an [instance group](../../compute/concepts/instance-groups/index.md) with the latest {{ coi }} version, you need to check whether it is available yourself:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
  ```

  Result:

  ```bash
  id: <ID_of_latest_COI_version>
  folder_id: standard-images
  ...
  ```

- {{ marketplace-full-name }} {#marketplace}

  1. Go to the {{ marketplace-name }} page and select the image with the configuration you need:
     * [{{ coi }}](/marketplace/products/yc/container-optimized-image).
     * [{{ coi }} GPU](/marketplace/products/yc/container-optimized-image-gpu).
  1. Under **{{ ui-key.yacloud_components.marketplace.label_product-ids }}**, copy the value of `image_id`.

{% endlist %}
