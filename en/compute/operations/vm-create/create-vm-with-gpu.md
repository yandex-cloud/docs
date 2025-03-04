---
title: How to create a VM with a GPU
description: Use this guide to create a VM with a GPU.
---

# Creating a VM with a GPU


This section explains how to create a [VM](../../concepts/vm.md) with a GPU. For more information about VM configurations, see [{#T}](../../concepts/gpus.md).

By default, a [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) has a zero [quota](../../concepts/limits.md#quotas) for creating VMs with GPUs. To change the [quota]({{ link-console-quotas }}), contact [support]({{ link-console-support }}).

{% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}

{% list tabs group=instructions %}

- Management console {#console}



  {% include [create-vm-with-gpu](../../../_includes/compute/create/create-vm-with-gpu-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for creating a VM:

     ```bash
     yc compute instance create --help
     ```

  1. [Prepare](../vm-connect/ssh.md#creating-ssh-keys) a key pair (public and private keys) for SSH access to the VM.
  1. Select a public [image](../images-with-pre-installed-software/get-list.md).

     {% include [gpu-images](../../../_includes/gpu-images.md) %}

     {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

  1. Create a VM in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

     ```bash
     yc compute instance create \
       --name gpu-instance \
       --zone {{ region-id }}-a \
       --platform=gpu-standard-v3 \
       --cores=8 \
       --memory=96 \
       --gpus=1 \
       --network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts-gpu,kms-key-id=<key_ID> \
       --ssh-key ~/.ssh/id_ed25519.pub
     ```

     Where:
     * `--name`: VM name.

       {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md).

       {% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}

     * `--platform`: [Platform](../../concepts/vm-platforms.md) ID:

       {% include [gpu-platforms-api](../../../_includes/compute/gpu-platforms-api.md) %}

     * `--cores`: [Number of vCPUs](../../concepts/gpus.md).
     * `--memory`: Amount of RAM.
     * `--gpus`: Number of GPUs.
     * `--preemptible`: For a [preemptible](../../concepts/preemptible-vm.md) VM.
     * `--network-interface`: VM [network interface](../../concepts/network.md) settings:
         * `subnet-name`: Name of the selected subnet.
         * `nat-ip-version=ipv4`: [Public IP address](../../../vpc/concepts/address.md#public-addresses). To create a VM without a public IP address, omit this parameter.

         {% include [add-several-net-interfaces-notice-cli](../../../_includes/compute/add-several-net-interfaces-notice-cli.md) %}

     * `--create-boot-disk`: OS [image](../images-with-pre-installed-software/get-list.md).

         * `image-family`: [Image family](../../concepts/image.md#family), e.g., `ubuntu-1604-lts-gpu`. This option allows you to install the latest version of the OS from the specified family.
         * `kms-key-id`: ID of the [{{ kms-short-name }} symmetric key](../../../kms/concepts/key.md) to create en encrypted boot disk. This is an optional parameter.

           {% include [encryption-role](../../../_includes/compute/encryption-role.md) %}
           
           {% include [encryption-disable-warning](../../../_includes/compute/encryption-disable-warning.md) %}

           {% include [encryption-keys-note](../../../_includes/compute/encryption-keys-note.md) %}

     * `--ssh-key`: Path to the file with the [public SSH key](../vm-connect/ssh.md#creating-ssh-keys). The VM will automatically create a user named `yc-user` for this key.

     Get a description of the created VM:

     ```bash
     yc compute instance get --full gpu-instance
     ```

     Result:

     ```text
     name: gpu-instance
     zone_id: {{ region-id }}-a
     platform_id: gpu-standard-v3
     resources:
       memory: "103079215104"
       cores: "8"
       core_fraction: "100"
       gpus: "1"
     status: RUNNING
     ...
     ```

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
       name                      = "vm-with-gpu"
       allow_stopping_for_update = true
       platform_id               = "standard-v3"
       zone                      = "<availability_zone>"

       resources {
         cores  = <number_of_vCPUs>
         memory = <RAM_in_GB>
         gpus   = <number_of_GPUs>
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
       * `name`: Disk name.
       * `type`: Disk type.
       * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md) the disk will reside in.
       * `size`: Disk size in GB.
       * `image_id`: ID of the image to create the VM from. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).

         {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

     * `yandex_compute_instance`: VM description:
       * `name`: VM name.
       * {% include [terraform-allow-stopping](../../../_includes/compute/terraform-allow-stopping.md) %}
       * `platform_id`: [Platform](../../concepts/vm-platforms.md) ID:
       * `zone`: Availability zone the VM will reside in.

         {% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}

       * `platform_id`: [Platform](../../concepts/vm-platforms.md) ID:

         {% include [gpu-platforms-api](../../../_includes/compute/gpu-platforms-api.md) %}

       * `resources`: Number of vCPUs and amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
       * `boot_disk`: Boot disk settings. Specify the disk ID.
       * `network_interface`: VM [network interface](../../concepts/network.md) settings. Specify the ID of the selected [subnet](../../../vpc/concepts/network.md#subnet). To automatically assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to the VM, set `nat = true`.

           {% include [add-several-net-interfaces-notice-tf](../../../_includes/compute/add-several-net-interfaces-notice-tf.md) %}

       * `metadata`: In metadata, provide the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
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

  To create a VM, use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Create](../../api-ref/grpc/Instance/create.md) gRPC API call.

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### See also {#see-also}

* Learn how to update the VM configuration [here](../vm-control/vm-update-resources.md).