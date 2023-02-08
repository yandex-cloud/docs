# Creating an empty disk with a large block

{% include [default-catalogue](../../../_includes/compute/disk-blocksize.md) %}

{% list tabs %}

- Management console

   See section [{#T}](../../../compute/operations/disk-create/empty.md).

- CLI

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's create disk commands:

      ```bash
      yc compute disk create --help
      ```

   1. Create a disk in the default folder:

      ```bash
      yc compute disk create \
        --name big-disk \
        --block-size 8K \
        --size 40G \
        --description "my 8k blocksize disk via yc"
      ```

      This command will create a 40 GB disk with an 8 KB block size, named `big-disk` and described as `my 8k blocksize disk via yc`.

      {% include [name-format](../../../_includes/name-format.md) %}

   1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

      Get the same list with more details in YAML format:

      ```bash
      yc compute disk list --format yaml
      ```

      Result:
      ```yaml
      - id: fhmm0br99mig46rc0em0
         folder_id: b1gb9jeqoiordtmv1lbo
         created_at: "2021-01-11T09:35:05Z"
         name: big-disk
         description: 8k blocksize disk
         type_id: network-hdd
         zone_id: {{ region-id }}-a
         size: "42949672960"
         block_size: "8192"
         status: READY
         disk_placement_policy: {}
      ```

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-empty-disk-create](../../../_includes/compute/terraform-empty-disk-create.md) %}

{% endlist %}
