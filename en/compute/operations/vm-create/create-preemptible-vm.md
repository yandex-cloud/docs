---
title: Making a VM preemptible
description: Follow this guide to make a VM preemptible.
---

# Making a VM preemptible


You can [create a preemptible](#create-preemptible) [VM](../../concepts/vm.md) or [change the type](#preemptible-to-regular) of a VM that already exists.

{% include [role-note](../../../_includes/compute/role-note.md) %}

## Creating a preemptible VM {#create-preemptible}

To create a [preemptible VM](../../concepts/preemptible-vm.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your preemptible VM.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an [image](../../concepts/image.md) and OS version.

      {% include [change-custom-disk-settings-image](../../../_includes/compute/create/change-custom-disk-settings-image.md) %}

  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select the [availability zone](../../../overview/concepts/geo-scope.md) to host your preemptible VM.
  1. Optionally, configure the boot [disk](../../concepts/disk.md) under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**:

      * Select the [disk type](../../concepts/disk.md#disks_types).
      * Specify the required disk size.
      * {% include [encryption-section-secondary](../../../_includes/compute/encryption-section-secondary.md) %}

      {% include [change-custom-disk-settings-storages](../../../_includes/compute/create/change-custom-disk-settings-storages.md) %}
  1. {% include [section-storages-secondary-disk](../../../_includes/compute/create/section-storages-secondary-disk.md) %}
  1. {% include [section-storages-filesystem](../../../_includes/compute/create/section-storages-filesystem.md) %}
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:

      * Navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab.
      * Select a [platform](../../../compute/concepts/vm-platforms.md).
      * Specify the [guaranteed performance](../../../compute/concepts/performance-levels.md) and required number of vCPUs, as well as RAM size.
      * In the **{{ ui-key.yacloud.component.compute.resources.field_advanced }}** field, enable **{{ ui-key.yacloud.component.compute.resources.field_preemptible }}**.
      * Optionally, enable a [software-accelerated network](../../concepts/software-accelerated-network.md).
  1. {% include [network-settings](../../../_includes/compute/create/section-network.md) %}
  1. {% include [section-access](../../../_includes/compute/create/section-access.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify a name for the preemptible VM:

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

  1. {% include [section-additional](../../../_includes/compute/create/section-additional.md) %}
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  The preemptible VM will appear in the list.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a preemptible VM:

     ```bash
     yc compute instance create --help
     ```

  1. [Prepare](../vm-connect/ssh.md#creating-ssh-keys) a key pair (public and private keys) for SSH access to the preemptible VM.
  1. Select a public Linux-based [image](../images-with-pre-installed-software/get-list.md) from [{{ marketplace-full-name }}](../../../marketplace/), e.g., [CentOS 7](/marketplace/products/yc/centos-7).

     {% include [standard-images](../../../_includes/standard-images.md) %}

  1. Create a preemptible VM in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc compute instance create \
       --name first-preemptible-instance \
       --zone {{ region-id }}-a \
       --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
       --preemptible \
       --create-boot-disk image-folder-id=standard-images,image-family=centos-7,kms-key-id=<key_ID> \
       --ssh-key ~/.ssh/id_ed25519.pub
     ```

     {% include [vm-platform-cli](../../../_includes/compute/vm-platform-cli.md) %}

     Where:
     * `--name`: Name of the preemptible VM. Follow these naming requirements:

       {% include [name-format](../../../_includes/name-format.md) %}

       {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md) matching the selected [subnet](../../../vpc/concepts/network.md#subnet).
     * `--network-interface`: VM [network interface](../../concepts/network.md) settings:
         * `subnet-name`: Name of the selected subnet.
         * `nat-ip-version=ipv4`: [Public IP address](../../../vpc/concepts/address.md#public-addresses). To create a VM without a public IP address, omit this parameter.

         {% include [add-several-net-interfaces-notice-cli](../../../_includes/compute/add-several-net-interfaces-notice-cli.md) %}

     * `--preemptible`: Select to create a preemptible VM.
     * `--create-boot-disk`: VM boot disk settings:
         * `image-family`: [Image family](../../concepts/image.md#family), e.g., `centos-7`. This option allows you to install the latest version of the OS from the specified family.
         * `kms-key-id`: ID of the [{{ kms-short-name }} symmetric key](../../../kms/concepts/key.md) to create an encrypted boot disk. This is an optional parameter.

           {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
           
           {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

           {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

     * `--ssh-key`: Path to the file with the [public SSH key](../vm-connect/ssh.md#creating-ssh-keys). The preemptible VM will automatically create a user named `yc-user` for this key.

         {% include [ssh-note](../../../_includes/compute/ssh-note.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, define the parameters of the resources you want to create:

     ```hcl
     resource "yandex_compute_disk" "boot-disk" {
       name     = "<disk_name>"
       type     = "<disk_type>"
       zone     = "<availability_zone>"
       size     = "<disk_size>"
       image_id = "<image_ID>"
     }

     resource "yandex_compute_instance" "vm-1" {
       name                      = "preemptible-vm"
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

       scheduling_policy {
         preemptible = true
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
       * `name`: Disk name.
       * `type`: Disk [type](../../concepts/disk.md#disks_types).
       * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) the disk will reside in.
       * `size`: Disk size in GB.
       * `image_id`: ID of the [image](../../concepts/image.md) to create the preemptible VM from. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).

         {% include [id-info](../../../_includes/compute/id-info.md) %}

     * `yandex_compute_instance`: Description of the preemptible VM:
       * `name`: Name of the preemptible VM.
       * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
       * `platform_id`: [Platform](../../concepts/vm-platforms.md).
       * `zone`: Availability zone to host the preemptible VM.
       * `resources`: Number of vCPUs and amount of RAM available to the preemptible VM. The values must match the selected platform.
       * `boot_disk`: Boot disk settings. Specify the disk ID.
       * `network_interface`: VM [network interface](../../concepts/network.md) settings. Specify the ID of the selected [subnet](../../../vpc/concepts/network.md#subnet). To automatically assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to the VM, set `nat = true`.

           {% include [add-several-net-interfaces-notice-tf](../../../_includes/compute/add-several-net-interfaces-notice-tf.md) %}

       * `metadata`: In metadata, provide the public key for SSH access to the preemptible VM. For more information, see [{#T}](../../concepts/vm-metadata.md).
       * `scheduling_policy`: Scheduling policy. To create a preemptible VM, select `preemptible = true`.
     * `yandex_vpc_network`: Cloud network description.
     * `yandex_vpc_subnet`: Description of the subnet to connect your preemptible VM to.

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

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

## Changing the VM type {#preemptible-to-regular}

To change the type of a VM, such as making it non-preemptible:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the preemptible VM is located.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the VM you need and select **{{ ui-key.yacloud.common.stop }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**. The VM status will change to `Stopped`.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the VM you need and select **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, disable **{{ ui-key.yacloud.component.compute.resources.field_preemptible }}**.
  1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.
  1. At the top right, click ![image](../../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.common.start }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for stopping a VM:

     ```bash
     yc compute instance stop --help
     ```

  1. Get a list of all VMs in the default folder:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Select `ID` or `NAME` of the VM, e.g., `first-instance`.
  1. Stop the VM:

     ```bash
     yc compute instance stop <VM_name_or_ID>
     ```

     Result:

     ```text
     done (15s)
     ```

  1. Edit the VM parameters:

     ```bash
     yc compute instance update <VM_name_or_ID> \
       --preemptible=false
     ```

     Result:

     ```text
     done (1s)
     id: fhm0b28lgfp4********
     folder_id: b1ghgf288nvg********
     ...
     network_settings:
       type: STANDARD
     placement_policy: {}
     ```

  1. Restart the VM:

     ```bash
     yc compute instance start <VM_name_or_ID>
     ```

     Result:

     ```text
     done (11s)
     id: fhm0b28lgfp4********
     folder_id: b1ghgf288nvg********
     ...
     network_settings:
       type: STANDARD
     placement_policy: {}
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, find the section specifying the scheduling policy of the VM you want to make non-preemptible:

     ```hcl
     scheduling_policy {
       preemptible = true
     }
     ```

  1. Delete the `scheduling_policy` field with the `preemptible = true` value.

     For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}/).
  1. Make sure the configuration files are correct.
     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

     If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out.
  1. Deploy the cloud resources.
     1. If the configuration does not contain any errors, run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the resources.

     This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [update](../../api-ref/Instance/update.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Update](../../api-ref/grpc/Instance/update.md) gRPC API call. Under `schedulingPolicy` in the request body, specify `"preemptible": false`.

{% endlist %}

This will affect the cost of running this VM. Learn more about VM pricing [here](../../pricing.md#prices-instance-resources).

#### See also {#see-also}

* [{#T}](../vm-connect/ssh.md).
* [{#T}](../../tutorials/nodejs-cron-restart-vm.md).
* [{#T}](../../tutorials/hpc-on-preemptible.md).
* [{#T}](../../tutorials/serverless-trigger-budget-vm.md).