# Moving a VM to another folder

When a VM is being created, it's placed in the current folder.

In {{ yandex-cloud }}, you can move a VM to another folder within one cloud. You do not have to stop the VM when moving it.

You can learn more about the resource hierarchy in {{ yandex-cloud }} [here](../../../resource-manager/concepts/resources-hierarchy.md).

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

   Use the [move](../../api-ref/Instance/move.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Move](../../api-ref/grpc/instance_service.md#Move) gRPC API call.

   Below is a sample Bash script for the REST API that can be run from Linux environments. It also uses the [move](../../api-ref/Disk/move.md) method for the [Disk](../../api-ref/Disk/index.md) resource (if you do not move the boot disk, it will remain in the source folder).

   [Authentication in the Compute Cloud API](../../api-ref/authentication.md) is based on an [IAM token](../../../iam/operations/iam-token/create.md). You can get it via an [OAuth token](https://yandex.ru/dev/id/doc/ru/access) for your Yandex ID account.

   Make sure to install the following in your Linux environment:
   * curl to get an OAuth token and make HTTP POST requests.
   * jq to fetch an OAuth token from the JSON output of the script's first command.


   You can move a VM without stopping it.

   > [!NOTE]
   > A moved VM remains connected to the Virtual Private Cloud subnet in the source folder. You can disconnect your VM from this subnet in the network interface settings on the VM page.

   ```#!/bin/bash

   # Set the IAM_TOKEN variable. The variable (in brackets) contains a command that receives an IAM token and fetches it from the JSON output (jq). Replace "Oauth_Token" with the OAuth token of your Yandex ID account.
   IAM_TOKEN=$(curl -d "{\"yandexPassportOauthToken\":\"OAuth_Token\"}" "https://iam.api.cloud.yandex.net/iam/v1/tokens" | jq -r '.iamToken')

   instanceId='ID_of_VM_to_move'
   bootDiskId='ID_of_this_VM's_boot_disk'
   destinationFolderId='ID_of_VM_target_folder'

   # VM move command:
   curl -X POST "https://compute.api.cloud.yandex.net/compute/v1/instances/{${instanceId}}:move" \
   -H "Authorization: Bearer ${IAM_TOKEN}" \
   -d '{ "destinationFolderId": "'"${destinationFolderId}"'" }'

   # Boot disk move command:
   curl -X POST "https://compute.api.cloud.yandex.net/compute/v1/disks/{${bootDiskId}}:move" \
   -H "Authorization: Bearer ${IAM_TOKEN}" \
   -d '{ "destinationFolderId": "'"${destinationFolderId}"'" }'```

   
{% endlist %}
