---
title: Adding a VM to a GPU cluster
description: Follow this guide to add a VM to a GPU cluster.
---

# Adding a VM to a GPU cluster


In [GPU clusters](../../concepts/gpus.md#gpu-clusters), you can create [VMs](../../concepts/vm.md) with 8 GPUs based on one of the following [platforms](../../concepts/vm-platforms.md#gpu-platforms):
* {{ a100-epyc }} (`gpu-standard-v3`).
* Gen2 (`gpu-standard-v3i`).
* GPU PLATFORM V4 (`gpu-standard-v4`).

Such VMs must be deployed from a [dedicated image](../../concepts/gpus.md#os) with NVIDIA drivers.


{% note info %}

You can host your GPU cluster in one of these [availability zones](../../../overview/concepts/geo-scope.md): `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d`. The VM must be created within the same availability zone as the cluster.

{% endnote %}


{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create the VM.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}** and click **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select an [image with pre-installed NVIDIA drivers](../../concepts/gpus.md#os).
  1. In the **{{ ui-key.yacloud.compute.instances.create.field_zone }}** field, select the [availability zone](../../../overview/concepts/geo-scope.md) where your GPU cluster resides.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and specify:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `{{ a100-epyc }}`, `GPU PLATFORM V4`, or `Gen2` [platform](../../concepts/vm-platforms.md#gpu-platforms).
      * **{{ ui-key.yacloud.component.compute.resources.field_gpus }}**: `8`.
      * **{{ ui-key.yacloud.component.compute.resources.field_gpu-cluster }}**: Previously [created](gpu-cluster-create.md) GPU cluster.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  In the terminal, run this command:

  ```bash
  export YC_GPU_CLUSTER=$(yc compute gpu-cluster list --format=json | jq -r .[].id)
  export YC_ZONE="{{ region-id }}-a"
  export SUBNET_NAME="my-subnet-name"
  export SUBNET_ID=$(yc vpc subnet get --name=$SUBNET_NAME --format=json | jq -r .id)
  yc compute instance create \
    --name node-gpu-test \
    --create-boot-disk size=64G,image-id=<image_ID_with_drivers>,type=network-ssd \
    --ssh-key=$HOME/.ssh/id_rsa.pub \
    --gpus 8 \
    --cores 224 \
    --memory=952G \
    --zone $YC_ZONE \
    --network-interface subnet-id=$SUBNET_ID,nat-ip-version=ipv4 \
    --platform gpu-standard-v3 \
    --gpu-cluster-id=$YC_GPU_CLUSTER
  ```

  Where:
  * `--name`: VM name.
  * `--create-boot-disk`: VM [disk](../../concepts/disk.md) properties.
  * `--ssh-key`: Path to the file with the [public SSH key](../../operations/vm-connect/ssh.md#creating-ssh-keys).
  * `--gpus`: Number of [GPUs](../../concepts/gpus.md).
  * `--cores`: Number of vCPUs.
  * `--memory`: Amount of RAM.
  * `--zone`: [Availability zone](../../../overview/concepts/geo-scope.md).
  * `--network-interface`: VM [network interface](../../concepts/network.md) settings.
  * `--platform`: [Platform](../../concepts/vm-platforms.md) ID.
  * `--gpu-cluster-id`: [GPU cluster](../../concepts/gpus.md#gpu-clusters) ID.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the {{ TF }} configuration file, describe the resource you want to create:

     ```hcl
     provider "yandex" {
       zone = "{{ region-id }}-a"
     }

     resource "yandex_compute_disk" "boot-disk" {
       name     = "<disk_name>"
       type     = "<disk_type>"
       zone     = "{{ region-id }}-a"
       size     = "<disk_size>"
       image_id = "<image_ID_with_drivers>"
     }

     resource "yandex_compute_instance" "default" {
       name           = "vm-gpu"
       platform_id    = "gpu-standard-v3"
       zone           = "{{ region-id }}-a"
       gpu_cluster_id = "<GPU_cluster_ID>"

       resources {
         cores  = "224"
         memory = "952"
         gpus   = "8"
       }

       boot_disk {
         disk_id = yandex_compute_disk.boot-disk.id
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         user-data = "#cloud-config\nusers:\n  - name: <username>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("<path_to_public_SSH_key>")}"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name           = "subnet1"
       zone           = "<availability_zone>"
       v4_cidr_blocks = ["192.168.10.0/24"]
       network_id     = "${yandex_vpc_network.network-1.id}"
     }
     ```

     Where:
     * `yandex_compute_disk`: Boot disk description, where `image_id` is the ID of the image with the drivers.
     * `gpu_cluster_id`: GPU cluster ID. This is a required setting.
     * `yandex_vpc_network`: [Cloud network](../../../vpc/concepts/network.md#network) description.
     * `yandex_vpc_subnet`: Description of the [subnet](../../../vpc/concepts/network.md#subnet) to create your VM in.

       {% note info %}

       If you already have suitable resources, such as a cloud network and subnet, you do not need to redefine them. Specify their names and IDs in the appropriate parameters.

       {% endnote %}

       For more information about `yandex_compute_instance` properties, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/compute_instance).
  1. Under `metadata`, specify your username and path to the public SSH key. For more information, see [{#T}](../../../compute/concepts/vm-metadata.md).
  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  This will create a VM in the specified GPU cluster. You can check the new VM and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

  ```bash
  yc compute instance get <VM_name>
  ```

- API {#api}

  To create a VM in a GPU cluster, use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/index.md) resource or the [InstanceService/Create](../../api-ref/grpc/Instance/create.md) gRPC API call. In the request body, specify the GPU cluster ID in the `gpuClusterId` field.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](gpu-cluster-create.md)
* [{#T}](gpu-cluster-update.md)
* [{#T}](gpu-cluster-delete.md)
* [{#T}](../../concepts/gpus.md)
* [{#T}](../../concepts/vm-platforms.md)
