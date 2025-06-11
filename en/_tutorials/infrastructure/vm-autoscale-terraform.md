1. [Get your cloud ready](#before-begin).
1. [Create your infrastructure](#deploy).
1. [Test your instance group and network load balancer](#check-service).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [before](../../_includes/compute/before-solution.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/vm-autoscale/paid-resources.md) %}

## Create your infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an autoscaling instance group infrastructure with {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) and specify the {{ yandex-cloud }} provider installation source (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare your infrastructure description files:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository with configuration files:

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-vm-group-with-autoscale.git
        ```

     1. Navigate to the repository directory. Make sure it now contains the following files:
        * `vm-autoscale.tf`: New infrastructure configuration.
        * `declaration.yaml`: Description of the Docker container with a web server that will simulate the VM load.
        * `config.tpl`: VM user description.
        * `vm-autoscale.auto.tfvars`: User data.

   - Manually {#manual}

     1. Create a directory for configuration files.
     1. In the directory, create:
        1. `vm-autoscale.tf` configuration file:

           {% cut "vm-autoscale.tf" %}

           {% include [vm-autoscale-tf-config](../../_includes/instance-groups/vm-autoscale-tf-config.md) %}

           {% endcut %}

        1. `declaration.yaml` file with a description of the Docker container with a web server that will simulate the VM load:

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

        1. `config.tpl` VM user description file:

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
           vm_user   = "<VM_username>"
           ssh_key   = "<public_SSH_key_contents>"
           ```

           {% endcut %}

   {% endlist %}

   Learn more about the properties of {{ TF }} resources in the relevant {{ TF }} articles:

   * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Security group](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [Instance group](../../compute/concepts/instance-groups/index.md): [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group).
   * [Network load balancer](../../network-load-balancer/concepts/index.md): [yandex_lb_network_load_balancer]({{ tf-provider-resources-link }}/lb_network_load_balancer).

1. In the `vm-autoscale.auto.tfvars` file, set the following user-defined properties:
   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `vm_user`: VM user name.
   * `ssh_key`: Public SSH key file contents required to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Create the resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

Once you created the infrastructure, [test your instance group and network load balancer](#check-service).

## Test your instance group and network load balancer {#check-service}

{% include [check-service](../_tutorials_includes/vm-autoscale/check-service.md) %}

### Autoscaling test {#check-highload}

{% include [check-highload](../_tutorials_includes/vm-autoscale/check-highload.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `vm-autoscale.tf` configuration file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
