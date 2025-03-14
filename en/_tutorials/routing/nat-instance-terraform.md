1. [Get your cloud ready](#before-you-begin).
1. [Create an infrastructure](#deploy).
1. [Test the NAT instance](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/nat-instance/paid-resources.md) %}


## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare the infrastructure description file:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. Clone the repository with configuration files:

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-compute-nat-instance.git
         ```

      1. Navigate to the repository directory. Make sure it contains the following files:
         * `nat-instance.tf`: New infrastructure configuration.
         * `nat-instance.auto.tfvars`: User data.

    - Manually {#manual}

      1. Create a folder for the infrastructure description file.
      1. Create a configuration file named `nat-instance.tf` in the folder:

          {% cut "nat-instance.tf" %}

          {% include [nat-instance-tf-config](../../_includes/routing/nat-instance-tf-config.md) %}

          {% endcut %}

      1. In the folder, create a user data file named `nat-instance.auto.tfvars`:

          {% cut "nat-instance.auto.tfvars" %}

          {% include [nat-instance-tf-variables](../../_includes/routing/nat-instance-tf-variables.md) %}

          {% endcut %}

    {% endlist %}

    Learn more about the properties of {{ TF }} resources in the provider documentation:

    * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Security groups](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * [Image](../../compute/concepts/image.md): [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
    * [Disk](../../compute/concepts/disk.md): [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
    * [VM instance](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [Route table](../../vpc/concepts/routing.md#rt-vpc): [yandex_vpc_route_table]({{ tf-provider-resources-link }}/vpc_route_table).

1. In the `nat-instance.auto.tfvars` file, set the following user-defined properties:

    * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
    * `vm_user`: VM user name.
    * `vm_user_nat`: NAT instance user name.
    * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Create resources:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}


## Test the NAT instance {#test}

{% include [test](../_tutorials_includes/nat-instance/test.md) %}


## How to delete the resources you created {#clear-out}

To shut down the NAT instance and stop paying for the created resources:

1. Open the `nat-instance.tf` configuration file and delete the description of the new infrastructure from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}