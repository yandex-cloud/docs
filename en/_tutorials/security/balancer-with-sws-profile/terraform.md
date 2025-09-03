1. [Get your cloud ready](#before-begin).
1. [Create your infrastructure](#deploy).
1. [Configure DNS](#dns-config).
1. [Test the security profile](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../../_tutorials_includes/balancer-with-sws-profile/paid-resources.md) %}

## Create your infrastructure {#deploy}

{% include [terraform-definition](../../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:

1. [Install {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the credentials](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), Step 1).
1. Prepare your infrastructure description files:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository with configuration files:

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-alb-with-sws-profile.git
        ```

     1. Navigate to the repository directory. Make sure it contains the following files:
        * `alb-smartwebsecurity-config.tf`: New infrastructure configuration.
        * `alb-smartwebsecurity.auto.tfvars`: User data file.

   - Manually {#manual}

     1. Create a folder for configuration files.
     1. In the folder, create:
        1. `alb-smartwebsecurity-config.tf` configuration file:

           {% cut "alb-smartwebsecurity-config.tf" %}

           {% include [alb-smartwebsecurity-config](../../_tutorials_includes/balancer-with-sws-profile/alb-smartwebsecurity-config.md) %}

           {% endcut %}

        1. `alb-smartwebsecurity.auto.tfvars` user data file:

           {% cut "alb-smartwebsecurity.auto.tfvars" %}

           ```hcl
           folder_id    = "<folder_ID>"
           vm_user      = "<VM_user_name>"
           ssh_key_path = "<public_SSH_key_path>"
           allowed_ip   = "<allowed_IP_address_of_device>"
           ```
           {% endcut %}

   {% endlist %}

   Learn more about the properties of {{ TF }} resources in the relevant {{ TF }} guides:
   * [Network](../../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [Subnets](../../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
   * [Security groups](../../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
   * [VM image](../../../compute/concepts/image.md): [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image)
   * [Backend group](../../../application-load-balancer/concepts/backend-group.md): [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group)
   * [HTTP router](../../../application-load-balancer/concepts/http-router.md): [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router)
   * [Virtual host](../../../application-load-balancer/concepts/http-router.md#virtual-host): [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host)
   * [L7 load balancer](../../../application-load-balancer/concepts/application-load-balancer.md): [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer)
   * [Security profile](../../../smartwebsecurity/concepts/profiles.md): [yandex_sws_security_profile]({{ tf-provider-resources-link }}/sws_security_profile).

1. In the `alb-smartwebsecurity.auto.tfvars` file, set the following user-defined properties:
   * `folder_id`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
   * `vm_user`: VM user name.
   * `ssh_key_path`: Path to the public SSH key file. For more information, see [{#T}](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `allowed_ip`: Public IP address of the device that will be sending requests to the L7 load balancer.

1. Create the resources:

   {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Get the IP address](../../../application-load-balancer/operations/application-load-balancer-get.md) for your L7 load balancer: you will use it later [to test the security profile](#test).

After you create the infrastructure, [configure DNS](#dns-config) and [test the security profile](#test).

## Configure DNS {#dns-config}

{% include [dns-config](../../_tutorials_includes/balancer-with-sws-profile/dns-config.md) %}

## Test the security profile {#test}

{% include [test](../../_tutorials_includes/balancer-with-sws-profile/test.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `alb-smartwebsecurity-config.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../../_tutorials_includes/terraform-validate-plan-apply.md) %}