# Moving a VM to a different folder

When you create a VM, it is placed in the current folder.

In {{ yandex-cloud }}, you can move a VM to a different folder within a single cloud. You do not have to stop the VM to move it.

Learn more about the {{ yandex-cloud }} resource hierarchy [here](../../../resource-manager/concepts/resources-hierarchy.md).

## Limitations {#limits}

When moving a VM, keep in mind the following limitations:

* [{{ monitoring-full-name }}](../../../monitoring/) does not support metric relocation: existing metrics remain in the source folder, and new ones will be created in the destination folder.
* You can only move VMs within a single cloud.

## Moving a VM {#relocate-vm}

### Updating a VM folder {#change-folder}

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

  1. See the description of the CLI command for moving a VM:

      ```bash
      yc compute instance move --help
      ```

  1. Move the VM to a different folder with the following parameters: 
      
      * In `id`, enter the VM ID, e.g., `fhm0b28lgfp4********`.
      * In `destination-folder-id`, specify the destination folder ID, e.g., `b1gd129pp9ha********`.

      ```bash
      yc compute instance move \
        --id fhm0b28lgfp4******** \
        --destination-folder-id b1gd129pp9ha********
      ```

      For more information about the `yc compute instance move` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/instance/move.md).

- API {#api}

  Use the [move](../../api-ref/Instance/move.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Move](../../api-ref/grpc/Instance/move.md) gRPC API call.

  **Example**

  Below is an example of a Bash script for Linux.
  
  To use it, [get authenticated](../../api-ref/authentication.md) with the API and install [cURL](https://curl.haxx.se).

  You can move a VM without stopping it.

  1. Create a script file:

      ```bash
      sudo touch <file_name>
      ```

  1. Open the file to write the script to:

      ```bash
      sudo nano <file_name>
      ```
  
  1. Place the script in the file: 

      ```bash
      #!/bin/bash

      # Creating variables

      export IAM_TOKEN=`yc iam create-token`
      
      instanceId='<VM_ID>'
      bootDiskId='<VM_boot_disk_ID>'
      destinationFolderId='<folder_ID>'
      
      # Moving a VM

      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '{ "destinationFolderId": "'"${destinationFolderId}"'" }' \
        "https://compute.{{ api-host }}/compute/v1/instances/{${instanceId}}:move"
      
      # Moving a boot disk

      curl \
        --request POST \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '{ "destinationFolderId": "'"${destinationFolderId}"'" }' \
        "https://compute.{{ api-host }}/compute/v1/disks/{${bootDiskId}}:move"
      ```

      Where:

      * `IAM_TOKEN`: IAM token for API authentication.
      * `instanceId`: ID of the VM to move.
      * `bootDiskId`: ID of the boot disk of the VM to move.
      * `destinationFolderId`: ID of the folder to move the VM to.

  1. Make the file executable:

      ```bash
      chmod +x <file_name>
      ```

  1. Run the script:

      ```bash
      ./<file_name>
      ```

{% endlist %}

### Updating a VM subnet {#change-subnet}

After moving a VM, its network interfaces remain connected to the [subnets](../../../vpc/concepts/network.md#subnet) in the source folder. To connect your VM to subnets in the destination folder, follow these steps:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you moved the VM to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Click the VM name.
  1. Click **{{ ui-key.yacloud.common.stop }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**.
  1. Under **{{ ui-key.yacloud.compute.instance.overview.section_network }}**, click ![image](../../../_assets/console-icons/ellipsis.svg) in the top-right corner of the relevant network interface section and select **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
  1. In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select a new subnet and click **{{ ui-key.yacloud.common.save }}**.
      If a VM has multiple [network interfaces](../../concepts/network.md), update the subnet for each one.
  1. Click **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating a subnet:

      ```bash
      yc compute instance update-network-interface --help
      ```

  1. Stop the VM:

      ```bash
      yc compute instance stop fhm0b28lgfp4********
      ```

  1. Get a list of VM network interfaces by specifying the VM ID:

     ```bash
     yc compute instance get fhm0b28lgfp4********
     ```

     Result:

     ```yml
     ...
     network_interfaces:
       - index: "0"
         mac_address: d0:0d:24:**:**:**
         subnet_id: e2lpp96bvvgp********
         primary_v4_address:
           address: 192.168.2.23
       - index: "1"
         mac_address: d0:1d:24:**:**:**
         subnet_id: e2lrucutusnd********
         primary_v4_address:
           address: 192.168.1.32
       - index: "2"
         mac_address: d0:2d:24:**:**:**
         subnet_id: e2lv9c6aek1d********
         primary_v4_address:
           address: 192.168.4.26
     ...
     ```

     Save the `index` field value, i.e., the number of the network interface you want to connect to a different subnet.

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
      * `--ipv4-address`: Internal IP address of the VM network interface in the subnet in the destination folder. Set to `auto` to enable automatic internal address assignment.
      * `--network-interface-index`: VM network interface number you saved earlier.
      * `--security-group-id`: ID of the security group to assign to the VM network interface.

      Result:

      ```text
      done (9s)
      id: fhm0b28lgfp4********
      folder_id: b1gd73mbrli7********
      created_at: "2023-11-16T06:09:46Z"
      name: oslogigor1
      zone_id: {{ region-id }}-a
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
          mac_address: d0:0d:24:**:**:**
          subnet_id: e2lfibapq818********
          primary_v4_address:
            address: 10.129.0.22
          security_group_ids:
            - enpi8m85mj14********
        - index: "1"
          mac_address: d0:1d:24:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.32
        - index: "2"
          mac_address: d0:2d:24:**:**:**
          subnet_id: e2lv9c6aek1d********
          primary_v4_address:
            address: 192.168.4.26
      gpu_settings: {}
      fqdn: relocated-vm.{{ region-id }}.internal
      scheduling_policy: {}
      network_settings:
      type: STANDARD
      placement_policy: {}
      ```

      If a VM has multiple network interfaces, update the subnet for each one.

  1. Run the VM:

      ```bash
      yc compute instance start fhm0b28lgfp4********
      ```

- API {#api}

  Use the [updateNetworkInterface](../../api-ref/Instance/updateNetworkInterface.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/UpdateNetworkInterface](../../api-ref/grpc/Instance/updateNetworkInterface.md) gRPC API call.

{% endlist %}