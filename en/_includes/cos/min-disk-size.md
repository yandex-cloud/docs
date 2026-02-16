To get the minimum boot disk size required for installing an image, run this command:
* `yc compute image get-latest-from-family container-optimized-image --folder-id standard-images` if you are installing a {{ coi }}.
* `yc compute image get-latest-from-family container-optimized-image-gpu --folder-id standard-images` if you are installing a GPU {{ coi }}.

You can find the minimum boot disk size in the `min_disk_size` property.
