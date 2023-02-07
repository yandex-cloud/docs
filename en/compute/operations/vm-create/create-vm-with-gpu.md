# Creating a VM with a GPU

This section provides guidelines for creating VMs with a GPU. For more information about VM configurations, see [{#T}](../../concepts/gpus.md).

By default, the cloud has a zero [quota](../../concepts/limits.md#quotas) for creating VMs with GPUs. To change the [quota]({{ link-console-quotas }}), contact [technical support]({{ link-console-support }}).

{% if product == "yandex-cloud" %}

{% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}

{% endif %}

{% if product == "cloud-il" %}

{% include [gpu-zones-il](../../../_includes/compute/gpu-zones-il.md) %}

{% endif %}

{% list tabs %}

- Management console

   {% include [create-vm-with-gpu](../../../_includes/compute/create/create-vm-with-gpu-console.md) %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI create VM command:

      ```bash
      yc compute instance create --help
      ```

   1. Prepare the [key pair](../vm-connect/ssh.md#creating-ssh-keys) (public and private keys) for SSH access to the VM.
   1. Select a public [image](../images-with-pre-installed-software/get-list.md).

      {% include [gpu-images](../../../_includes/gpu-images.md) %}

      {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

   1. Create a VM in the default folder:

      {% if product == "cloud-il" %}

      ```bash
      yc compute instance create \
        --name gpu-instance \
        --zone {{ region-id }}-a \
        --platform=gpu-standard-v3 \
        --cores=8 \
        --memory=96 \
        --gpus=1 \
        --network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts-gpu-a100 \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```

      {% else %}

      ```bash
      yc compute instance create \
        --name gpu-instance \
        --zone {{ region-id }}-a \
        --platform=gpu-standard-v3 \
        --cores=8 \
        --memory=96 \
        --gpus=1 \
        --network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts-gpu \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```
      
      {% endif %}

      Where:

      * `name`: VM name.

         {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * `zone`: [availability zone](../../../overview/concepts/geo-scope.md).
      * `platform`: [platform](../../concepts/vm-platforms.md) ID:
         {% if product == "yandex-cloud" %}*`gpu-standard-v1` for {{ v100-broadwell }}.{% endif %}
         {% if product == "yandex-cloud" %}*`gpu-standard-v2` for {{ v100-cascade-lake }}.{% endif %}
      * `gpu-standard-v3` for {{ a100-epyc }}.
      * `cores`: [The number of vCPUs](../../concepts/gpus.md).
      * `memory`: [the RAM size](../../concepts/gpus.md).
      * `gpus`: [Number of GPUs](../../concepts/gpus.md).
      * `preemptible`: If you need to make the VM [preemptible](../../concepts/preemptible-vm.md).
      * `create-boot-disk`: [Image](../images-with-pre-installed-software/get-list.md) of the OS.
      {% if product == "cloud-il" %}* `ubuntu-2004-lts-gpu-a100`: [Ubuntu 20.04 LTS GPU A100](/marketplace/products/yc/ubuntu-2004-lts-gpu-a100) image.{% endif %}
      {% if product == "yandex-cloud" %}`ubuntu-1604-lts-gpu`: [Ubuntu 16.04 LTS GPU](/marketplace/products/yc/ubuntu-16-04-lts-gpu) image with CUDA drivers.{% endif %}
      * `nat-ip-version=ipv4`: Public IP. To create a VM without a public IP, disable a parameter.

      Get a description of the created VM:

      ```bash
      yc compute instance get --full gpu-instance
      ```

      Result:

      ```bash
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

- API

   To create a VM, use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. In the configuration file, describe the parameters of resources that you want to create:

      ```
      resource "yandex_compute_instance" "vm-1" {

        name        = "vm-with-gpu"
        platform_id = "gpu-standard-v3"
        zone        = "<availability zone>"

        resources {
          cores  = <number of vCPU cores>
          memory = <RAM amount, GB>
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

      Where:

      * `yandex_compute_instance`: Description of the [VM](../../concepts/vm.md):
         * `name`: VM name.
         * `platform_id`: ID of the [platform](../../concepts/vm-platforms.md):
            {% if product == "yandex-cloud" %}* `gpu-standard-v1` for Intel Broadwell with NVIDIA® Tesla® V100.{% endif %}
            {% if product == "yandex-cloud" %}* `gpu-standard-v2` for Intel Cascade Lake with NVIDIA® Tesla® V100.{% endif %}
            * `gpu-standard-v3` for AMD EPYC 7662 with NVIDIA® Ampere® A100.
         * `zone`: ID of the [availability zone](../../../overview/concepts/geo-scope.md) that will host your VM.
         * `resources`: The number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
         * `boot_disk`: Boot disk settings. Specify the ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).

            {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

         * `network_interface`: Network settings. Specify the ID of the selected subnet. To automatically assign a public IP address to the VM, set `nat = true`.
         * `metadata`: In the metadata, pass the public key for VM access via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
      * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md#network).
      * `yandex_vpc_subnet`: Description of the [subnet](../../../vpc/concepts/network.md#network) your VM will connect to.

      {% note info %}

      If you already have suitable resources, such as a cloud network and subnet, you don't need to describe them again. Use their names and IDs in the appropriate parameters.

      {% endnote %}

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure that the configuration files are correct.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains errors, {{ TF }} will point them out.
   1. Deploy the cloud resources.
      1. If the configuration doesn't contain any errors, run the command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### See also {#see-also}

* Learn how to [change the VM configuration](../vm-control/vm-update-resources.md).
