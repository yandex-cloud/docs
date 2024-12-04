1. [Prepare your cloud](#before-begin).
1. [Create an infrastructure](#deploy).
1. [Test instance group scaling](#test-scale).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/vm-scale-scheduled/paid-resources.md) %}

## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

Create an infrastructure using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository with configuration files.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-vm-group-scheduled-scaling
        ```

     1. Go to the directory with the repository. Make sure it contains the following files:
        * `vm-scale-scheduled.tf`: New infrastructure configuration.
        * `vm-scale-scheduled.auto.tfvars`: User data file.
        * `vm-scale-scheduled-function.zip`: Archive with the {{ sf-name }} function code.


   - Manually {#manual}

     1. Create a folder for files.
     1. In the folder, create:
        * `vm-scale-scheduled.tf` configuration file:

          {% cut "vm-scale-scheduled.tf" %}

          {% include [vm-scale-scheduled-tf-config](../../_includes/instance-groups/vm-scale-scheduled-tf-config.md) %}

          {% endcut %}

        * `vm-scale-scheduled.auto.tfvars` user data file:

          {% cut "vm-scale-scheduled.auto.tfvars" %}

          ```hcl
          folder_id    = "<folder_ID>"
          username     = "<VM_user_name>"
          ssh_key_path = "<path_to_public_SSH_key>"
          ```

          {% endcut %}

        * `handler.sh` file with the {{ sf-name }} function code:

          {% cut "handler.sh" %}

          {% include [warning-unix-lines](../_tutorials_includes/warning-unix-lines.md) %}

          {% include [vm-scale-scheduled-function-code](../../_includes/instance-groups/vm-scale-scheduled-function-code.md) %}

          {% endcut %}

     1. In the folder, create the `vm-scale-scheduled-function.zip` archive that contains the `handler.sh` file.

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [VM image](../../compute/concepts/image.md): [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [VM group](../../compute/concepts/instance-groups/index.md): [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group).
   * [Function](../../functions/concepts/function.md): [yandex_function]({{ tf-provider-resources-link }}/function).
   * [Trigger](../../functions/concepts/trigger/index.md): [yandex_function_trigger]({{ tf-provider-resources-link }}/function_trigger).

1. In the `vm-scale-scheduled.auto.tfvars` file, set the following user-defined properties:

   * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create the resources in.
   * `username`: Name of the user to create in the VM.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. You can create a key pair by following [this guide](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Create resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

After creating the infrastructure, [test instance group scaling](#test-scale).

## Test instance group scaling {#test-scale}

{% include [test-scale](../_tutorials_includes/vm-scale-scheduled/test-scale.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `vm-scale-scheduled.tf` configuration file and delete the description of the new infrastructure from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}