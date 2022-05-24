# Creating a VM with a GPU

This section provides guidelines for creating VMs with a GPU. For more information about VM configurations, see [{#T}](../../concepts/gpus.md).

By default, the cloud has a [zero quota](../../concepts/limits.md#quotas) for creating virtual machines with GPUs. To change the [quota]({{ link-console-quotas }}), contact [technical support]({{ link-console-support }}).

{% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}

{% list tabs %}

- Management console

  {% include [create-vm-with-gpu](../../../_includes/compute/create/create-vm-with-gpu-console.md) %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for creating a VM:

     ```bash
     yc compute instance create --help
     ```

  1. Prepare a [pair of keys](../vm-connect/ssh.md#creating-ssh-keys) (public and private) for accessing the VM over SSH.
  1. Select a public [image](../images-with-pre-installed-software/get-list.md).

     {% include [gpu-images](../../../_includes/gpu-images.md) %}

     {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

  1. Create a VM in the default folder. Specify the following parameters:
     * Name of the instance.

       {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

     * [Availability zone](../../../overview/concepts/geo-scope.md).
     * ID of the [platform](../../concepts/vm-platforms.md):
       * `gpu-standard-v1` for {{ v100-broadwell }}.
       * `gpu-standard-v2` for {{ v100-cascade-lake }}.
       * `gpu-standard-v3` for {{ a100-epyc }}.
     * [Number of vCPUs](../../concepts/gpus.md).
     * [RAM](../../concepts/gpus.md).
     * [Number of GPUs](../../concepts/gpus.md).
     * If necessary, make your VM [preemptible](../../concepts/preemptible-vm.md) with the `--preemptible` option.
     * [Image](../images-with-pre-installed-software/get-list.md) of the OS. `ubuntu-1604-lts-gpu`: [Ubuntu 16.04.6 LTS](https://cloud.yandex.com/en-ru/marketplace/products/f2e0e2jmj38nmqe3cagl) with CUDA drivers.
     * Public IP. To create a VM without a public IP address, disable the `nat-ip-version=ipv4` option.

     For example:

     ```bash
     yc compute instance create \
       --name gpu-instance \
       --zone ru-central1-a \
       --platform=gpu-standard-v1 \
       --cores=8 \
       --memory=96 \
       --gpus=1 \
       --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
       --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts-gpu \
       --ssh-key ~/.ssh/id_rsa.pub
     ```

     This creates a VM named `gpu-instance` with a single GPU, 8 vCPUs, and 96 GB RAM:

     ```bash
     yc compute instance get --full gpu-instance
     ```

     Command result:

     ```bash
     name: gpu-instance
     zone_id: ru-central1-a
     platform_id: gpu-standard-v1
     resources:
       memory: "103079215104"
       cores: "8"
       core_fraction: "100"
       gpus: "1"
     status: RUNNING
     ...
     ```

- API

  To create a VM, use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.

- Terraform

  If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. In the configuration file, describe the parameters of resources that you want to create:

     {% note info %}

     If you already have suitable resources, such as a cloud network and subnet, you don't need to describe them again. Use their names and IDs in the appropriate parameters.

     {% endnote %}

     * `yandex_compute_instance`: Description of the [VM](../../concepts/vm.md):
       * `name`: VM name.
       * `platform_id`: ID of the [platform](../../concepts/vm-platforms.md):
         * `gpu-standard-v1` for Intel Broadwell with NVIDIA® Tesla® V100.
         * `gpu-standard-v2` for Intel Cascade Lake with NVIDIA® Tesla® V100.
         * `gpu-standard-v3` for AMD EPYC 7662 with NVIDIA® Ampere® A100.
       * `resources`: The number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
       * `boot_disk`: Boot disk settings. Specify the ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).

         {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

       * `network_interface`: Network settings. Specify the ID of the selected subnet. To automatically assign a public IP address to the VM, set `nat = true`.
       * `metadata`: In the metadata, pass the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
     * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md#network).
     * `yandex_vpc_subnet`: Description of the [subnet](../../../vpc/concepts/network.md#network) that the VM will be connected to.

     Example configuration file structure:

     ```
     resource "yandex_compute_instance" "vm-1" {

       name        = "vm-with-gpu"
       platform_id = "gpu-standard-v1"

       resources {
         cores  = <number of vCPU cores>
         memory = <RAM in GB>
         gpus   = <number of GPUs>
       }

       boot_disk {
         initialize_params {
           image_id = "fdv4f5kv5cvf3ohu4flt"
         }
       }

       network_interface {
         subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
         nat       = true
       }

       metadata = {
         ssh-keys = "<username>:<SSH key contents>"
       }
     }

     resource "yandex_vpc_network" "network-1" {
       name = "network1"
     }

     resource "yandex_vpc_subnet" "subnet-1" {
       name       = "subnet1"
       zone       = "<availability zone>"
       network_id = "${yandex_vpc_network.network-1.id}"
     }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation]({{ tf-provider-link }}).

  1. Make sure that the configuration files are correct.
     1. In the command line, go to the directory where you created the configuration file.
     1. Run the check using the command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.
  1. Deploy the cloud resources.
     1. If the configuration doesn't contain any errors, run the command:

        ```bash
        terraform apply
        ```

     1. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### See also {#see-also}

* Learn how to [change the VM configuration](../vm-control/vm-update-resources.md).