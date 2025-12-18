# How to move a VM across folders or clouds



## Case description {#case-description}

You need to move a VM from one cloud or folder to another.

## Solution {#case-resolution}

{% list tabs %}

- Moving across clouds

    To move a VM across clouds, complete the following steps:

    1. [Create an image from the disk of the required VM](../../../compute/operations/image-create/create-from-disk.md).
    1. [Add an {{ iam-short-name }} user](../../../organization/operations/add-account.md) to the cloud with the image you want to transfer.
    1. [Assign the {{ iam-short-name }} user the minimum required roles](../../../iam/operations/roles/grant.md): `{{ roles-cloud-member }}` and `{{ roles-image-user }}`.
    1. [Set up](../../../cli/quickstart.md) YC CLI for the user in the target cloud.
    1. Get the ID of your image. To do this, in the [management console]({{ link-console-main }}), find the **{{ ui-key.yacloud.common.id }}** field on the **{{ ui-key.yacloud.compute.images.label_title }}** tab. Alternatively, you can get the ID by running this YC CLI command: `yc compute image list`.

    1. Get the ID of the cloud where the original image is located. To do this, in the [management console]({{ link-console-main }}), find the **{{ ui-key.yacloud.common.id }}** field. Alternatively, you can get the ID by running this YC CLI command: `yc resource-manager cloud list`.

    1. With your YC CLI, create a new image in the target cloud:

        ```
        yc compute image create --name <new_image_name> \
        --source-image-id <original_image_ID> \
        --cloud-id <original_image_home_cloud_ID>
        ```

    After performing these actions, [create a new VM](../../../compute/operations/vm-create/create-from-user-image.md#create-vm-from-image) from the image you got.

- Moving across folders

    To change a VM folder, follow these steps in your CLI:

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Get a list of all VMs in the default folder:

        ```bash
        yc compute instance list
        ```

        Result:

        ```bash
        +----------------------+-----------------+--------------------+---------+----------------------+
        |          ID          |       NAME      |       ZONE ID      | STATUS  |     DESCRIPTION      |
        +----------------------+-----------------+--------------------+---------+----------------------+
        | fhm***************** | first-instance  | {{ region-id }}-a  | RUNNING | my first vm via CLI  |
        | fhm***************** | second-instance | {{ region-id }}-a  | RUNNING | my second vm via CLI |
        +----------------------+-----------------+--------------------+---------+----------------------+
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
        | b1g***************** | my-folder          |                  | ACTIVE |
        | b1g***************** | default            |                  | ACTIVE |
        +----------------------+--------------------+------------------+--------+
        ```

    1. See the description of the CLI command for moving a VM:

        ```bash
        yc compute instance move --help
        ```

    1. Move the VM to a different folder by specifying the following values: 

        * In `id`, enter the VM ID, e.g., `fhm*****************`.
        * In `destination-folder-id`, specify the destination folder ID, e.g., `b1g*****************`.

        ```bash
        yc compute instance move \
            --id fhm***************** \
            --destination-folder-id b1g*****************
        ```

        For more information about `yc compute instance move`, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/instance/move.md).

{% endlist %}