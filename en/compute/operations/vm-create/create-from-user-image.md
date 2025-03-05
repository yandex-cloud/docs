
# Creating a VM from a custom image

## Getting started {#before-you-begin}

[Prepare and upload](../image-create/upload.md) an [image](../../concepts/image.md) to {{ compute-name }} to create a [VM](../../concepts/vm.md) from.

Make sure the image you upload has the `READY` status.

## Creating a VM from a pre-built image {#create-vm-from-image}

{% include [independent-resources](../../../_includes/compute/independent-resources.md) %}

{% list tabs group=instructions %}

- Management console {#console}



  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your VM.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}** from the list of services.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**:

      * Go to the **{{ ui-key.yacloud.compute.instances.create.image_value_custom_new }}** tab.
      * Click **{{ ui-key.yacloud.common.select }}** and select **{{ ui-key.yacloud.common.create-new }}** in the window that opens.
      * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then select the image you need from the list below.
      * Optionally, enable **{{ ui-key.yacloud.compute.field_additional }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** field if you need this disk automatically deleted when deleting the VM.
      * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../../overview/concepts/geo-scope.md) the VM will reside in.
  1. Add a [disk](../../concepts/disk.md):

      * Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
      * In the window that opens, select **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}** → `Create new`.
      * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and then select the image you need from the list below.
      * Enter a name for the disk.
      * Select the [disk type](../../concepts/disk.md#disks_types).
      * Specify the required disk size and block size.
      * Optionally, enable **{{ ui-key.yacloud.compute.field_additional }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** field if you need this disk automatically deleted when deleting the VM.
      * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.

  1. {% include [encryption-section-secondary](../../../_includes/compute/encryption-section-secondary.md) %}
  1. {% include [section-storages-filesystem](../../../_includes/compute/create/section-storages-filesystem.md) %}
  1. {% include [section-platform](../../../_includes/compute/create/section-platform.md) %}
  1. {% include [network-settings](../../../_includes/compute/create/section-network.md) %}
  1. {% include [section-access](../../../_includes/compute/create/section-access.md) %}
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, enter a name for the VM:

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}
  1. {% include [section-additional](../../../_includes/compute/create/section-additional.md) %}
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  The VM will appear in the list. The system automatically assigns an [IP address](../../../vpc/concepts/address.md) and [host name](../../../vpc/concepts/address.md#fqdn) (FQDN) to a VM once it is created.

  You can monitor the VM status in the serial console or [serial port output](../vm-info/get-serial-port-output.md).

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a VM:

     ```bash
     yc compute instance create --help
     ```

  1. Get a list of images in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc compute image list
     ```

     Result:

     ```text
     +----------------------+-----------------+--------+-------------+--------+
     |          ID          |      NAME       | FAMILY | PRODUCT IDS | STATUS |
     +----------------------+-----------------+--------+-------------+--------+
     |         ...          |        ...      |        |             |  ...   |
     | fd8gkcd3l6ov******** | your-test-image |        |             | READY  |
     |         ...          |        ...      |        |             |  ...   |
     +----------------------+-----------------+--------+-------------+--------+
     ```

  1. Select `ID` or `NAME` of the image you need.

  1. Select a [subnet](../../../vpc/concepts/network.md#subnet):

     ```bash
     yc vpc subnet list
     ```

     Result:

     ```text
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     |          ID          |           NAME            |      NETWORK ID      | ROUTE TABLE ID |       ZONE        |      RANGE      |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     | e9bnlm18l70a******** |   default-{{ region-id }}-a   | enpe3m3fa00u******** |                |   {{ region-id }}-a   | [10.128.0.0/24] |
     +----------------------+---------------------------+----------------------+----------------+-------------------+-----------------+
     ```

  1. Create a VM in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc compute instance create \
       --name <VM_name> \
       --zone <availability_zone> \
       --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4 \
       --create-boot-disk name=<disk_name>,size=<disk_size_in_GB>,image-id=<custom_image_ID>,kms-key-id=<key_ID> \
       --ssh-key <path_to_public_key_file>
     ```

     Where:
     * `--name`: VM name. The naming requirements are as follows:

       {% include [name-format](../../../_includes/name-format.md) %}

       {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) matching the selected subnet.
     * `--network-interface`: VM [network interface](../../concepts/network.md) settings:
         * `subnet-name`: Name of the selected subnet.
         * `nat-ip-version=ipv4`: [Public IP address](../../../vpc/concepts/address.md#public-addresses). To create a VM without a public IP address, omit this parameter.

         {% include [add-several-net-interfaces-notice-cli](../../../_includes/compute/add-several-net-interfaces-notice-cli.md) %}

     * `--create-boot-disk`: VM boot disk settings:
         * `name`: Boot disk name. The naming requirements are as follows:

             {% include [name-format](../../../_includes/name-format.md) %}

         * `size`: Disk size in GB.
         * `image-id`: ID of the custom image to create the VM from. Specify the ID of the [uploaded](../image-create/upload.md) image.
         * `kms-key-id`: ID of the [{{ kms-short-name }} symmetric key](../../../kms/concepts/key.md) to create en encrypted boot disk. This is an optional parameter.

           {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
           
           {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

           {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}
           
     * `--ssh-key`: Path to the file with the [public SSH key](../vm-connect/ssh.md#creating-ssh-keys). The VM will automatically create a user named `yc-user` for this key.

         {% include [ssh-note](../../../_includes/compute/ssh-note.md) %}

         If you want to add multiple users with SSH keys to your VM at the same time, [specify](../../concepts/vm-metadata.md#how-to-send-metadata) these users' data in the `--metadata-from-file` parameter.

  {% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

     Result:

      ```text
      id: fhmue131en37********
      folder_id: b1g681qpemb4********
      created_at: "2024-03-02T12:58:43Z"
      name: test-vm-from-image
      zone_id: {{ region-id }}-a
      platform_id: standard-v2
      resources:
        memory: "2147483648"
        cores: "2"
        core_fraction: "100"
      status: RUNNING
      metadata_options:
        gce_http_endpoint: ENABLED
        aws_v1_http_endpoint: ENABLED
        gce_http_token: ENABLED
        aws_v1_http_token: DISABLED
      boot_disk:
        mode: READ_WRITE
        device_name: fhmn9n1uhutc********
        auto_delete: true
        disk_id: fhmn9n1uhutc********
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1e:70:46:17
          subnet_id: e9bb9n0v4h17********
          primary_v4_address:
            address: 10.12*.*.**
            one_to_one_nat:
              address: 178.154.***.***
              ip_version: IPV4
      gpu_settings: {}
      fqdn: fhmue131en37********.auto.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create a VM from a custom image:
  1. In the configuration file, define the parameters of the resources you want to create:

     ```hcl
     resource "yandex_compute_disk" "boot-disk" {
       name     = "<disk_name>"
       type     = "<disk_type>"
       zone     = "<availability_zone>"
       size     = "<disk_size>"
       image_id = "<custom_image_ID>"
     }

     resource "yandex_compute_instance" "vm-1" {
       name                      = "vm-from-image"
       allow_stopping_for_update = true
       platform_id               = "standard-v3"
       zone                      = "<availability_zone>"

       resources {
         cores  = <number_of_vCPUs>
         memory = <RAM_in_GB>
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk.id
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         ssh-keys = "<username>:<SSH_key_contents>"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name       = "subnet1"
       zone       = "<availability_zone>"
       network_id = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Where:

     * `yandex_compute_disk`: Boot [disk](../../concepts/disk.md) description:
       * `name`: Disk name. The naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}

       * `type`: Disk type.
       * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) the disk will reside in.
       * `size`: Disk size in GB.
       * `image_id`: ID of the custom image to create the VM from. Specify the ID of the [uploaded](../image-create/upload.md) image.
     * `yandex_compute_instance`: VM description.
       * `name`: VM name. The naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}

          {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

       * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
       * `platform_id`: [Platform](../../concepts/vm-platforms.md).
       * `zone`: Availability zone the VM will reside in.
       * `resources`: Number of vCPUs and amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
       * `boot_disk`: Boot disk settings. Specify the disk ID.
       * `network_interface`: VM [network interface](../../concepts/network.md) settings. Specify the ID of the selected [subnet](../../../vpc/concepts/network.md#subnet). To automatically assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to the VM, set `nat = true`.

           {% include [add-several-net-interfaces-notice-tf](../../../_includes/compute/add-several-net-interfaces-notice-tf.md) %}

       * `metadata`: In metadata, provide the public key for SSH access to the VM. For more information, see [{#T}](../../concepts/vm-metadata.md).
     * `yandex_vpc_network`: Cloud network description.
     * `yandex_vpc_subnet`: Description of the subnet to connect your VM to.

     {% note info %}

     If you already have suitable resources, such as a cloud network and subnet, you do not need to redefine them. Specify their names and IDs in the appropriate parameters.

     {% endnote %}

     For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Create](../../api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}

## Disabling metadata verification {#disable-metadata-check}

{% include [disable-metadata-check](../../../_includes/compute/disable-metadata-check.md) %}

#### See also {#see-also}

* [{#T}](../image-create/custom-image.md)
* [{#T}](../vm-connect/ssh.md)
