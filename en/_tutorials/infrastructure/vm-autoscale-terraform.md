1. [Prepare your cloud](#before-begin).
1. [Create an infrastructure](#deploy).
1. [Test your instance group and network load balancer](#check-service).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [before](../../_includes/compute/before-solution.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/vm-autoscale/paid-resources.md) %}

## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure to automatically scale an instance group using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository with configuration files:

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-vm-group-with-autoscale.git
        ```

     1. Go to the directory with the repository. Make sure it contains the following files:
        * `vm-autoscale.tf`: New infrastructure configuration.
        * `declaration.yaml`: Description of the Docker container with a web server that will be run on the VM to simulate the load on the service.
        * `config.tpl`: Description of VM user parameters.
        * `vm-autoscale.auto.tfvars`: User data.

   - Manually {#manual}

     1. Create a folder for configuration files.
     1. In the folder, create:
        1. `vm-autoscale.tf` configuration file

           {% cut "vm-autoscale.tf" %}

           {% include [vm-autoscale-tf-config](../../_includes/instance-groups/vm-autoscale-tf-config.md) %}

           {% endcut %}

        1. `declaration.yaml` file describing the Docker container with a web server that will be run on the VM to simulate the load on the service.

           {% cut "declaration.yaml" %}

           ```yaml
           spec:
           containers:
           - image: {{ registry }}/yc/demo/web-app:v1
             securityContext:
               privileged: false
             tty: false
             stdin: false
           ```

           {% endcut %}

        1. `config.tpl` file with VM user parameters:

           {% cut "config.tpl" %}

           ```yaml
           users:
             - name: "${VM_USER}"
               groups: sudo
               shell: /bin/bash
               sudo: 'ALL=(ALL) NOPASSWD:ALL'
               ssh_authorized_keys:
                 - "${SSH_KEY}"
           ```

           {% endcut %}

        1. `vm-autoscale.auto.tfvars` user data file:

           {% cut "vm-autoscale.auto.tfvars" %}

           ```hcl
           folder_id = "<folder_ID>"
           vm_user   = "<VM_user_name>"
           ssh_key   = "<public_SSH_key_contents>"
           ```

           {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Security group](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [VM group](../../compute/concepts/instance-groups/index.md): [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group).
   * [Network load balancer](../../network-load-balancer/concepts/index.md): [yandex_lb_network_load_balancer]({{ tf-provider-resources-link }}/lb_network_load_balancer).

1. In the `vm-autoscale.auto.tfvars` file, set the following user-defined parameters:
   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `vm_user`: VM user name.
   * `ssh_key`: Contents of the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Create resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

After creating an infrastructure, [test your VM group and network load balancer](#check-service).

## Test your instance group and network load balancer {#check-service}

{% include [check-service](../_tutorials_includes/vm-autoscale/check-service.md) %}

### Test autoscaling {#check-highload}

{% include [check-highload](../_tutorials_includes/vm-autoscale/check-highload.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `vm-autoscale.tf` configuration file and delete the description of the new infrastructure from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
