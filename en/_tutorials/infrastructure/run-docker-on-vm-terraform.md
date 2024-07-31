1. [Prepare your cloud](#before-begin).
1. [Create an infrastructure](#deploy).
1. [Build and upload the Docker image to {{ container-registry-name }}](#create-image).
1. [Download the Docker image to the VM](#run).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/run-docker-on-vm/paid-resources.md) %}

### Configure the environment {#prepare}

{% include [prepare](../_tutorials_includes/run-docker-on-vm/prepare.md) %}

## Create an infrastructure {#deploy}

{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) {{ TF }} and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare a file with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made archive {#ready}

      1. Create a directory for the file with the infrastructure description.
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/run-docker-on-vm-terraform.zip) (1.5 KB).
      1. Unpack the archive to the directory. As a result, it should contain the `run-docker-on-vm.tf` configuration file.

   - Manually {#manual}

      1. Create a directory for the file with the infrastructure description.
      1. In the directory, create a configuration file named `run-docker-on-vm.tf`:

         {% cut "Contents of the run-docker-on-vm.tf file" %}

         {% include [run-docker-on-vm-tf-config](../../_includes/container-registry/run-docker-on-vm-tf-config.md) %}

         {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [Registry](../../container-registry/concepts/registry.md): [yandex_container_registry]({{ tf-provider-resources-link }}/container_registry)
   * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account)
   * [Folder access binding](../../iam/concepts/access-control/index.md#access-bindings): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member)
   * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
   * [Disk](../../compute/concepts/disk.md): [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk)
   * [VM instance](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance)

1. Under `locals`, set the parameters for resources to create:
   * `zone`: [Availability zone](../../overview/concepts/geo-scope.md) that will host the VM.
   * `username`: Name of the user to be created on the VM.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `target_folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to host the VM.
   * `registry_name`: {{ container-registry-name }} registry name.
   * `sa_name`: Service account name.
   * `network_name`: Name of the cloud network.
   * `subnet_name`: Subnet name.
   * `vm_name`: VM name.
   * `image_id`: ID of the image to create the VM from. For more information, see [{#T}](../../compute/operations/images-with-pre-installed-software/get-list.md).

1. Create resources:

   {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

After creating the infrastructure, [build and upload the Docker image to {{ container-registry-name }}](#create-image).

## Build and upload the Docker image to {{ container-registry-name }} {#create-image}

{% include [create-image](../_tutorials_includes/run-docker-on-vm/create-image.md) %}

## Download the Docker image to the VM {#run}

{% include [run](../_tutorials_includes/run-docker-on-vm/run.md) %}

## Check the result {#check-out}

{% include [test](../_tutorials_includes/run-docker-on-vm/test.md) %}

## How to delete the resources you created {#clear-out}

To delete the infrastructure and stop paying for the resources you created:

1. Open the `run-docker-on-vm-config.tf` configuration file and delete from it the description of the infrastructure you created.
1. Apply the changes:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}