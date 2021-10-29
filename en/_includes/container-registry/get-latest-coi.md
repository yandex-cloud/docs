Find out the ID of the latest version of the [public](../../compute/operations/images-with-pre-installed-software/get-list.md) {{ coi }}.

The {{ coi }} in the [{{ container-registry-name }}](../../container-registry/) can be updated and changed according to releases. In this case, the image on a VM isn't updated to the latest version automatically. To create an instance group with the latest {{ coi }} version, you need to check whether it's available yourself:

{% list tabs %}

- CLI

  ```bash
  yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
  ```

  Command execution result:

  ```bash
  id: fd8iv792kirahcnqnt0q
  folder_id: standard-images
  created_at: "2021-01-29T13:30:22Z"
  name: container-optimized-image-1611926453
  description: Build by Assembly-Workshop-build-66870
  family: container-optimized-image
  storage_size: "6157238272"
  min_disk_size: "10737418240"
  product_ids:
  - f2elj2f52bbqe4af8tfd
  status: READY
  os:
    type: LINUX
  ```

{% endlist %}