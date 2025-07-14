# Creating an L7 load balancer with DDoS protection using {{ TF }}


To create an L7 load balancer with DDoS protection using {{ TF }}:

1. [Get your cloud ready](#before-begin).
1. [Create your infrastructure](#deploy).
1. [Test the load balancer](#test).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/alb-with-ddos-protection/paid-resources.md) %}


## Create your infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure with {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the {{ yandex-cloud }} provider source (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), Step 1).
1. Prepare the infrastructure description file:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository with configuration files:

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-alb-ddos-protection.git
        ```

     1. Navigate to the repository directory. Make sure it contains the following files:
        * `alb-with-ddos-protection.tf`: New infrastructure configuration.
        * `alb-with-ddos-protection.auto.tfvars`: User data.

   - Manually {#manual}

     1. Create a folder for the infrastructure description file.
     1. In the folder, create a configuration file named `alb-with-ddos-protection.tf`:

        {% cut "alb-with-ddos-protection.tf" %}

        {% include [alb-with-ddos-protection-tf-config](../../_includes/web/alb-with-ddos-protection-tf-config.md) %}

        {% endcut %}

     1. In the folder, create a user data file named `alb-with-ddos-protection.auto.tfvars`:

        {% cut "alb-with-ddos-protection.auto.tfvars" %}

        {% include [alb-with-ddos-protection-tf-variables](../../_includes/web/alb-with-ddos-protection-tf-variables.md) %}

        {% endcut %}

   {% endlist %}

   Learn more about the properties of {{ TF }} resources in the relevant {{ TF }} guides:

   * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Role](../../iam/concepts/access-control/roles.md): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
   * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Security groups](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [Image](../../compute/concepts/image.md): [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [Instance group](../../compute/concepts/instance-groups/index.md): [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group).
   * [Static public IP address](../../vpc/concepts/address.md#public-addresses): [yandex_vpc_address]({{ tf-provider-resources-link }}/vpc_address).
   * [Backend group](../../application-load-balancer/concepts/backend-group.md): [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group).
   * [HTTP router](../../application-load-balancer/concepts/http-router.md): [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
   * [Virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host): [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
   * [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md): [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer).

1. In the `alb-with-ddos-protection.auto.tfvars` file, set the following user-defined properties:

    * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
    * `vm_user`: VM user name.
    * `ssh_key_path`: Path to the public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Create the resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

After creating the infrastructure, [test](#test) it.

## Test the load balancer {#test}

{% include [test](../_tutorials_includes/alb-with-ddos-protection/test.md) %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `alb-with-ddos-protection.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
