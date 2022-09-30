# Moving a VM to another folder

When a VM is being created, it's placed in the current folder.

In {{ yandex-cloud }}, you can move a VM to another folder within one cloud.

[Learn more about the resource hierarchy in {{ yandex-cloud }}](../../../resource-manager/concepts/resources-hierarchy.md).

## Limitations {#limits}

Limitations when moving a VM: 

* In [{{ monitoring-full-name }}](../../../monitoring/), metrics are not movable. The metrics in the previous folder stay there and new metrics will already be created in the new folder.
* You can move VMs only within a single cloud.

## Moving a VM {#change-folder}

To change a VM's folder:

{% list tabs %}

- CLI

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

- API

   Use the gRPC API [InstanceService/Move](../../api-ref/grpc/instance_service.md#Move) or the REST API [move](../../api-ref/Instance/move.md) method.

{% endlist %}
