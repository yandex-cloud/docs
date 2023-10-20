# Importing an image from another cloud or folder

1. Make sure you have the following roles for the cloud or folder hosting the required image:

   * Role for the cloud: `resource-manager.clouds.member`.
   * Role for the folder: `viewer` or `compute.images.user`.

   For more information about assigning roles, see [this guide](../../../iam/operations/roles/grant.md).
1. Import a copy of the image to your folder. Run this command in the [CLI](../../cli/):

   ```bash
   yc compute image create --source-image-id=<source_image_ID>
   ```
   