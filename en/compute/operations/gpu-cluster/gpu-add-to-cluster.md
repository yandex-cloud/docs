# Adding a VM to a GPU cluster

In GPU clusters, you can only create VMs running {{ a100-epyc }} with 8 GPUs. You will need to prepare a disk image with drivers by following this [guide](../image-create/custom-image.md) and use it when creating your VM.

{% note info %}

GPU clusters are now only available in the `ru-central1-a` availability zone. You can only add a VM to a cluster from the same availability zone.

{% endnote %}

{% list tabs %}

- CLI

   ```bash
   export YC_GPU_CLUSTER=$(yc compute gpu-cluster list --format=json | jq -r .[].id)
   export YC_ZONE="ru-central1-a"
   export SUBNET_NAME="my-subnet-name"
   export SUBNET_ID=$(yc vpc subnet get --name=$SUBNET_NAME --format=json | jq -r .id)
   yc compute instance create --name node-gpu-test \
     --create-boot-disk size=64G,image-id=<ID_of_image_with_drivers>,type=network-ssd \
     --ssh-key=$HOME/.ssh/id_rsa.pub \
     --gpus 8 --cores 224 --memory=952G \
     --zone $YC_ZONE \
     --network-interface subnet-id=$SUBNET_ID,nat-ip-version=ipv4 \
     --platform gpu-standard-v3 \
     --gpu-cluster-id=$YC_GPU_CLUSTER
   ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the {{ TF }} configuration file, describe the parameters of the resource to create:

      
      ```hcl
      provider "yandex" {
        zone = "{{ region-id }}-a"
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
          initialize_params {
            image_id = "<ID_of_image_with_drivers>"
            size     = "64"
          }
        }

        network_interface {
          subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
          nat       = true
        }

        metadata = {
          user-data = "#cloud-config\nusers:\n  - name: <username>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("<path_to_public_SSH_key>")}"
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

      * `gpu_cluster_id`: GPU cluster ID. Required parameter.
      * `image_id`: ID of the image with the drivers. Required parameter.
      * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md).
      * `yandex_vpc_subnet`: Description of the [subnet](../../../vpc/concepts/network.md#subnet) your VM will be created in.


      {% note info %}

      If you already have suitable resources, such as a cloud network and subnet, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

      {% endnote %}

      For more information about the `yandex_compute_instance` resource parameters, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/compute_instance).

   1. Under `metadata`, enter your username and path to the public SSH key. For more information, see [{#T}](../../../compute/concepts/vm-metadata.md).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

   This will create a VM in the specified cluster. You can check the new VM and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```bash
   yc compute instance get <VM_name>
   ```

{% endlist %}