# Moving a VM to another folder

When you create a VM, it is placed in the current folder.

In {{ yandex-cloud }}, you can move a VM to another folder within one cloud. You do not have to stop the VM when moving it.

You can learn more about the resource hierarchy in {{ yandex-cloud }} [here](../../../resource-manager/concepts/resources-hierarchy.md).

## Limitations {#limits}

Limitations when moving a VM:

* In [{{ monitoring-full-name }}](../../../monitoring/), metrics are not movable. The metrics in the previous folder stay there and new metrics will already be created in the new folder.
* You can move VMs only within a single cloud.

## Moving a VM {#relocate-vm}

### Updating a VM's folder {#change-folder}

{% list tabs group=instructions %}

- CLI {#cli}

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
      | fhm0b28lgfp4******** | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7g******** | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
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
      | b1gd129pp9ha******** | my-folder          |                  | ACTIVE |
      | b1g66mft1vop******** | default            |                  | ACTIVE |
      +----------------------+--------------------+------------------+--------+
      ```

   1. View the description of the CLI command for moving a VM:

      ```bash
      yc compute instance move --help
      ```

   1. Move the VM to another folder with the following parameters:

      * In `id`, enter the ID of the VM, e.g., `fhm0b28lgfp4********`.
      * In `destination-folder-id`, enter the ID of the destination folder, e.g., `b1gd129pp9ha********`.

      ```bash
      yc compute instance move \
        --id fhm0b28lgfp4******** \
        --destination-folder-id b1gd129pp9ha********
      ```

      For more information about the `yc compute instance move` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/instance/move.md).

- API {#api}

   Use the [move](../../api-ref/Instance/move.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Move](../../api-ref/grpc/instance_service.md#Move) gRPC API call.

   **Example**

   Below is a sample Bash script for Linux OS.

   To use the example, [authenticate](../../api-ref/authentication.md) in the API and install [cURL](https://curl.haxx.se).

   You can move a VM without stopping it.

   1. Create a script file:

      ```bash
      sudo touch <filename>
      ```

   1. Open the file to write the script to:

      ```bash
      sudo nano <filename>
      ```

   1. Place the script in the file:

      ```bash
      #!/bin/bash

      # Creating variables

      export IAM_TOKEN=`yc iam create-token`

      instanceId='<VM_ID>'
      bootDiskId='<VM_boot_disk_ID>'
      destinationFolderId='<folder_ID>'

      # Moving the VM

      curl -X POST "https://compute.{{ api-host }}/compute/v1/instances/{${instanceId}}:move" \
      -H "Authorization: Bearer ${IAM_TOKEN}" \
      -d '{ "destinationFolderId": "'"${destinationFolderId}"'" }'

      # Moving the boot disk

      curl -X POST "https://compute.{{ api-host }}/compute/v1/disks/{${bootDiskId}}:move" \
      -H "Authorization: Bearer ${IAM_TOKEN}" \
      -d '{ "destinationFolderId": "'"${destinationFolderId}"'" }'
      ```

      Where:

      * `IAM_TOKEN`: IAM token used for authentication in the API.
      * `instanceId`: ID of the VM to move.
      * `bootDiskId`: ID of the boot disk of the VM being moved.
      * `destinationFolderId`: ID of the folder to move the VM to.

   1. Make the file executable:

      ```bash
      chmod +x <filename>
      ```

   1. Run the script:

      ```bash
      ./<filename>
      ```

{% endlist %}

### Updating a VM's subnet {#change-subnet}

A moved VM remains connected to the [subnet](../../../vpc/concepts/network.md#subnet) in the source folder. To move your VM to a subnet in the destination folder:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you moved the VM.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. Click the VM name.
   1. Click **{{ ui-key.yacloud.common.stop }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**.
   1. Under **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}**, click ![image](../../../_assets/options.svg) and select **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
   1. In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select a new subnet and click **{{ ui-key.yacloud.common.save }}**.
   1. Click **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Stop the VM:

      ```bash
      yc compute instance stop fhm0b28lgfp4********
      ```

   1. View a description of the update subnet CLI command:

      ```bash
      yc compute instance update-network-interface --help
      ```

   1. Run this command:

      ```bash
      yc compute instance update-network-interface fhm0b28lgfp4******** \
        --subnet-id e2lfibapq818******** \
        --ipv4-address auto \
        --network-interface-index 0 \
        --security-group-id enpi8m85mj14********
      ```

      Where:

      * `--subnet-id`: Subnet in the destination folder.
      * `--ipv4-address`: VM internal IP.
      * `--network-interface-index`: VM's network interface index.
      * `--security-group-id`: ID of the security group to be assigned to the VM.

      Result:

      ```text
      done (9s)
      id: epdk82knf9rj********
      folder_id: b1gd73mbrli7********
      created_at: "2023-11-16T06:09:46Z"
      name: oslogigor1
      zone_id: {{ region-id }}-b
      platform_id: standard-v3
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: STOPPED
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: epdophaf2gh9********
        auto_delete: true
        disk_id: epdophaf2gh9********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:14:40:a9:77
          subnet_id: e2lfibapq818********
          primary_v4_address:
          address: 10.129.0.22
      gpu_settings: {}
      fqdn: relocated-vm.{{ region-id }}.internal
      scheduling_policy: {}
      network_settings:
      type: STANDARD
      placement_policy: {}
      ```

   1. Run the VM:

      ```bash
      yc compute instance start fhm0b28lgfp4********
      ```

- API {#api}

   Use the [updateNetworkInterface](../../api-ref/Instance/updateNetworkInterface.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/UpdateNetworkInterface](../../api-ref/grpc/instance_service.md#UpdateNetworkInterface) gRPC API call.

{% endlist %}