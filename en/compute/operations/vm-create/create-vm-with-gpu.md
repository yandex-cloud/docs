# Creating a VM with a GPU

This section provides guidelines for creating a [VM](../../concepts/vm.md) with a GPU. For more information about VM configurations, see [{#T}](../../concepts/gpus.md).

By default, the [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) has a zero [quota](../../concepts/limits.md#quotas) for creating VMs with GPUs. To change the [quota]({{ link-console-quotas }}), contact [technical support]({{ link-console-support }}).


{% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}


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
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts-gpu \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```



      Where:
      * `name`: VM name.

         {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * `zone`: [Availability zone](../../../overview/concepts/geo-scope.md).

        
        {% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}


        
      * `platform`: ID of the [platform](../../concepts/vm-platforms.md):

        {% include [gpu-platforms-api](../../../_includes/compute/gpu-platforms-api.md) %}
        
      * `cores`: [The number of vCPUs](../../concepts/gpus.md).
      * `memory`: Amount of RAM.
      * `gpus`: Number of GPUs.
      * `preemptible`: If you need to make the VM [preemptible](../../concepts/preemptible-vm.md).
        
        
      * `create-boot-disk`: [Image](../images-with-pre-installed-software/get-list.md) of the OS.

        {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

      * `nat-ip-version=ipv4`: [Public IP address](../../../vpc/concepts/address.md#public-addresses). To create a VM without a public IP address, disable this parameter.

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

   To create a VM, use the [create](../../api-ref/Instance/create.md) REST API method for the [Instance](../../api-ref/Instance/) resource or the [InstanceService/Create](../../api-ref/grpc/instance_service.md#Create) gRPC API call.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the provider {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_compute_instance" "vm-1" {

        name        = "vm-with-gpu"
        zone        = "<availability zone>"
        platform_id = "gpu-standard-v3"

        resources {
          cores  = <number of vCPU cores>
          memory = <amount of RAM, GB>
          gpus   = <number of GPUs>
        }

        boot_disk {
          initialize_params {
            image_id = "<image ID>"
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
      * `yandex_compute_instance`: Description of the VM:
         * `name`: VM name.
         * `zone`: ID of the [availability zone](../../../overview/concepts/geo-scope.md) that will host your VM.

              
           {% include [gpu-zones](../../../_includes/compute/gpu-zones.md) %}
   

           
         * `platform_id`: ID of the [platform](../../concepts/vm-platforms.md):

           {% include [gpu-platforms-api](../../../_includes/compute/gpu-platforms-api.md) %}
 

         * `resources`: Number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
         * `boot_disk`: Boot [disk](../../concepts/disk.md) settings. Specify the ID of the selected [image](../../concepts/image.md). You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).

            {% include [gpu-os](../../../_includes/compute/gpu-os.md) %}

         * `network_interface`: [Network](../../../vpc/concepts/network.md#network) settings. Specify the ID of the selected [subnet](../../../vpc/concepts/network.md#network). To automatically assign a [public IP address](../../../vpc/concepts/address.md#public-addresses) to the VM, set `nat = true`.
         * `metadata`: In the metadata, pass the public key for VM access via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
      * `yandex_vpc_network`: Description of the cloud network.
      * `yandex_vpc_subnet`: Description of the subnet your VM will connect to.

      {% note info %}

      If you already have suitable resources, such as a cloud network and subnet, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

      {% endnote %}

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).
   1. Make sure the configuration files are valid.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.
   1. Deploy cloud resources.
      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Once you are done, all the resources you need will be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

#### See also {#see-also}

* Learn how to [change the VM configuration](../vm-control/vm-update-resources.md).