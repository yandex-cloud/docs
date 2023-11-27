# Transferring VMs between folders or clouds



## Issue description {#case-description}

You need to transfer a VM instance from one cloud or folder to another cloud or folder.

## Solution {#case-resolution}

{% list tabs %}

- Transfer between clouds

   To transfer a VM between clouds, complete the following steps:

   1. [Create an image from the disk of the required VM](../../../compute/operations/image-create/create-from-disk.md)
   2. [Add an IAM user](../../../iam/operations/users/create.md) to the cloud with the image you want to transfer;
   3. [Assign the IAM user the minimum required roles](../../../iam/operations/roles/grant.md) of `resource-manager.clouds.member` and `compute.images.user`.
   4. [Set up](../../../cli/quickstart.md) the YC CLI tool for the user in the target cloud.
   5. Get the ID of your image. For this, in the web interface, find the **ID** field in the **Images** tab, or get the ID using the YC CLI `yc compute image list` command.
   6. Get the ID of the cloud where the original image is located. For this, in the web interface, find the **ID** field on the cloud's home page, or get the ID using the YC CLI `yc resource-manager cloud list` command.
   7. Create a new image in the target cloud using the YC CLI tool:

   ```
   yc compute image create --name <new_image_name> \
   --source-image-id <ID_of_original_image> \
   --cloud-id <ID_of_cloud_where_original_image_is_located>
   ```

   After performing these actions, [create a new VM instance](../../../compute/operations/vm-create/create-from-user-image.md#create-vm-from-image) from the resulting image.

- Transfer between folders

   To change the folder of a VM instance, complete the following steps:

   * In the CLI:

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      1. Get a list of all VMs in the default folder:

         ```bash
         yc compute instance list
         ```

         Result:

         ```bash
         +----------------------+-----------------+---------------+---------+----------------------+
         |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
         +----------------------+-----------------+---------------+---------+----------------------+
         | fhm0b28lgfp4tkoa3jl6 | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
         | fhm9gk85nj7gcoji2f8s | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
         +----------------------+-----------------+---------------+---------+----------------------+
         ```

      1. Get a list of all folders in the default cloud:

         ```bash
         yc resource-manager folder list
         ```

         Result:

         ```bash
         +----------------------+--------------------+------------------+--------+
         |          ID          |        NAME        |      LABELS      | STATUS |
         +----------------------+--------------------+------------------+--------+
         | b1gd129pp9ha0vnvf5g7 | my-folder          |                  | ACTIVE |
         | b1g66mft1vopnevbn57j | default            |                  | ACTIVE |
         +----------------------+--------------------+------------------+--------+
         ```

      1. View the description of the CLI command for moving a VM:

         ```bash
         yc compute instance move --help
         ```

      1. Move the VM to another folder with the following parameters:

         * In `id`, enter the ID of the VM, for example, `fhm0b28lgfp4tkoa3jl6`.
         * In `destination-folder-id`, enter the ID of the destination folder, for example, `b1gd129pp9ha0vnvf5g7`.

         ```bash
         yc compute instance move \
             --id fhm0b28lgfp4tkoa3jl6 \
             --destination-folder-id b1gd129pp9ha0vnvf5g7
         ```

         For more information about the `yc compute instance move` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance/move.md).

{% endlist %}