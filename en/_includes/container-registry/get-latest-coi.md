Find out the ID of the latest version of the [public](../../compute/operations/images-with-pre-installed-software/get-list.md) {{ coi }}.

The {{ coi }} in the [{{ container-registry-full-name }}](../../container-registry/) can be updated and changed according to releases. This will not automatically update the VM image to the latest version. To create an instance group with the latest {{ coi }} version, you need to check whether it's available yourself:

{% list tabs %}

- CLI

  ```bash
  yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
  ```

  Result:

  ```bash
  id: <ID of latest COI version>
  folder_id: standard-images
  ...
  ```

- Marketplace
  
  1. Go to the page {{ marketplace-name }} and select the image with the desired configuration:
     * [{{ coi }}](/marketplace/products/yc/container-optimized-image).
     * [{{ coi }} GPU](/marketplace/products/yc/container-optimized-image-gpu).
  1. Under **Product IDs**, copy the value of `image_id`.

{% endlist %}