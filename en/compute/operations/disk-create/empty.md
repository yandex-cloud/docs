# Creating an empty disk

You can create an empty disk of the specified size.

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create a disk.
  1. Select **{{ compute-name }}**.
  1. On the **Virtual machines** page, go to the **Disks** tab.
  1. Click **Create disk**.
  1. Enter the disk name.

      {% include [name-format](../../../_includes/name-format.md) %}

  1. If necessary, add a description of the disk.
  1. Specify the necessary disk size.
  1. Click **Save disk**.

- CLI

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI's create disk commands:
      ```bash
      yc compute disk create --help
      ```

  1. Create a disk in the default folder:
      ```bash
      yc compute disk create \
         --name first-disk \
         --size 10 \
         --description "my first disk via yc"
      ```

      This command creates a 10 GB disk with the name `first-disk` and description `my first disk via yc`.

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

      Get the same list with more details in YAML format:
      ```bash
      yc compute disk list --format yaml
      ```

      Result:
      ```yaml
      - id: fhm4aq4hvq5g3nepvt9b
          folder_id: b1gm3og7ei7aegv8i73m
          created_at: "2018-10-29T07:43:06Z"
          name: first-disk
          description: my first disk via yc
          type_id: network-hdd
          zone_id: ru-central1-a
          size: "10737418240"
          status: READY
      - id: fhmo6rdqg5folrc3lsaf
          folder_id: b1gm3og7ei7aegv8i73m
          created_at: "2018-10-29T07:33:04Z"
          name: second-disk
          description: my second disk via yc
          type_id: network-hdd
          zone_id: ru-central1-a
          size: "8589934592"
          product_ids:
          - f2en2dtd08b5la74mlde
          status: READY
          source_image_id: fdvk34al8k5nltb58shr
          instance_ids:
          - fhm5b617fjnj44ovhcun
      ```

- Terraform

  If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create an empty disk:

  1. Describe the resource parameters in the `yandex_compute_disk` configuration file.

     Example configuration file structure:
     ```
     resource "yandex_compute_disk" "disk-1" {
     
       name = "empty-disk"
       type = "network-hdd"
       zone = "<availability zone>"
       size = "<disk size in GB>"
     }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  1. Make sure that the configuration files are correct.
     1. In the command line, go to the directory where you created the configuration file.
     1. Run the check using the command:
        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  1. Deploy the cloud resources.
     1. If the configuration doesn't contain any errors, run the command:
        ```bash
        terraform apply
        ```

     1. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in [management console]({{ link-console-main }}).

{% endlist %}