# Moving a disk to a different availability zone

A disk is created in a single [availability zone](../../../overview/concepts/geo-scope.md). To attach the disk to a VM from a different availability zone, move it:

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI disk move command:

      ```bash
      {{ yc-compute }} disk relocate --help
      ```

   1. Request a list of available disks:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

   1. Select the `ID` of the appropriate disk.

   1. Move the disk to a different availability zone:

      ```bash
      {{ yc-compute }} disk relocate --id <disk_ID> \
        --destination-zone-id <availability_zone>
      ```

      Where:

      * `--id`: ID of the disk to move.
      * `--destination-zone-id`: ID of the availability zone to move the disk to, e.g., `{{ region-id }}-a`.

{% endlist %}

{% note info %}

If data is being written to the disk, its move may fail. In this case, stop the disk write operation or shut down the VM and restart the disk move.

{% endnote %}
