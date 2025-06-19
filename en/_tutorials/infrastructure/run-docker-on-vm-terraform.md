1. [Get your cloud ready](#before-begin).
1. [Create your infrastructure](#deploy).
1. [Build and push the Docker image to {{ container-registry-name }}](#create-image).
1. [Push the Docker image to the VM](#run).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/run-docker-on-vm/paid-resources.md) %}


### Create an SSH key pair {#create-ssh}

{% include [create-ssh](../_tutorials_includes/run-docker-on-vm/create-ssh.md) %}


### Install and configure Docker {#configure-docker}

{% include [configure-docker](../../_includes/container-registry/configure-docker.md) %}


## Create your infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the {{ yandex-cloud }} provider source (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), Step 1).
1. Prepare your infrastructure description files:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. Clone the [repository](https://github.com/yandex-cloud-examples/yc-run-docker-on-vm) with configuration files:

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-run-docker-on-vm.git
          ```

      1. Navigate to the repository directory. Make sure it contains the `run-docker-on-vm-config.tf` file with the new infrastructure configuration.

    - Manually {#manual}

      1. Create a folder for the infrastructure description file.
      1. In the folder, create a configuration file named `run-docker-on-vm.tf`:

          {% cut "Contents of the run-docker-on-vm.tf file" %}

          {% include [run-docker-on-vm-tf-config](../../_includes/container-registry/run-docker-on-vm-tf-config.md) %}

          {% endcut %}

    {% endlist %}

    Learn more about the properties of {{ TF }} resources in the relevant Terraform guides:

    * [Registry](../../container-registry/concepts/registry.md): [yandex_container_registry]({{ tf-provider-resources-link }}/container_registry)
    * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account)
    * [Folder access binding](../../iam/concepts/access-control/index.md#access-bindings): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member)
    * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
    * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
    * [Disk](../../compute/concepts/disk.md): [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk)
    * [VM instance](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)

1. Under `locals`, set the following parameters for the new resources:
    * `zone`: [Availability zone](../../overview/concepts/geo-scope.md) the VM will reside in.
    * `username`: VM user name.
    * `ssh_key_path`: Path to the public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `target_folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to host the VM.
    * `registry_name`: Name of the registry in {{ container-registry-name }}.
    * `sa_name`: Service account name.
    * `network_name`: Name of the cloud network.
    * `subnet_name`: Subnet name.
    * `vm_name`: VM name.
    * `image_id`: ID of the image to create the VM from. For more information, see [{#T}](../../compute/operations/images-with-pre-installed-software/get-list.md).

1. Create the resources:

    {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

After creating the infrastructure, [build and push the Docker image to {{ container-registry-name }}](#create-image).


## Build and push the Docker image to {{ container-registry-name }} {#create-image}

{% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

{% include [create-image](../_tutorials_includes/run-docker-on-vm/create-image.md) %}


## Push the Docker image to the VM {#run}

{% include [run](../_tutorials_includes/run-docker-on-vm/run.md) %}


## Check the result {#check-out}

{% include [test](../_tutorials_includes/run-docker-on-vm/test.md) %}


## How to delete the resources you created {#clear-out}

To delete the infrastructure and stop paying for the resources you created:

1. Open the `run-docker-on-vm-config.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}