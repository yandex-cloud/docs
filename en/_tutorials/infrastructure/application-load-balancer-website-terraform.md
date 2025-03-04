1. [Get your cloud ready](#before-begin).
1. [Create an infrastructure](#deploy).
1. [Upload the website files](#upload-files).
1. [Run a fault tolerance test](#test-ha).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/alb-website/paid-resources.md) %}

## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To host a fault-tolerant website in a VM group with load balancing with {{ alb-name }} using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare your infrastructure description files:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository with configuration files.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-website-high-availability-with-alb.git
        ```

     1. Navigate to the repository directory. Make sure it contains the following files:
        * `application-load-balancer-website.tf`: New infrastructure configuration.
        * `application-load-balancer-website.auto.tfvars`: User data file.

   - Manually {#manual}

     1. Create a folder for configuration files.
     1. In the folder, create:
        1. `application-load-balancer-website.tf`: New infrastructure configuration file:

           {% cut "application-load-balancer-website.tf" %}

           {% include [application-load-balancer-tf-config](../_tutorials_includes/alb-website/tf-config.md) %}

           {% endcut %}

        1. `application-load-balancer-website.auto.tfvars`: User data file:

           {% cut "application-load-balancer-website.auto.tfvars" %}

           ```hcl
           folder_id    = "<folder_ID>"
           vm_user      = "<instance_username>"
           ssh_key_path = "<path_to_public_SSH_key>"
           domain       = "<domain>"
           ```

           {% endcut %}

   {% endlist %}

   For more information about the properties of {{ TF }} resources, see these {{ TF }} guides:
   * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Role](../../iam/concepts/access-control/roles.md): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
   * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
   * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
   * [Security groups](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
   * [VM image](../../compute/concepts/image.md): [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image).
   * [Instance group](../../compute/concepts/instance-groups/index.md): [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group).
   * [Backend group](../../application-load-balancer/concepts/backend-group.md): [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group).
   * [HTTP router](../../application-load-balancer/concepts/http-router.md): [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
   * [Virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host): [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
   * [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md): [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer).
   * [DNS zone](../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
   * [DNS resource record](../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).

1. In the `application-load-balancer-website.auto.tfvars` file, set the following user-defined properties:
    * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
    * `vm_user`: VM username.
    * `ssh_key_path`: Path to the public SSH key that is required to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `domain`: Domain name, e.g., `alb-example.com`.

1. Create the resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

After creating the infrastructure, [upload the website files](#upload-files).

## Upload the website files {#upload-files}

{% include [upload-files](../../_tutorials/_tutorials_includes/alb-website/upload-files.md) %}

## Run a fault tolerance test {#test-ha}

{% include [test-ha](../../_tutorials/_tutorials_includes/alb-website/test-ha.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `application-load-balancer-website.tf` configuration file and delete the new infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}