1. [Get your cloud ready](#before-begin).
1. [Create your infrastructure](#deploy).
1. [Test the hosting](#test).

We will use the `my-site.com` domain name as an example.

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [tls-termination-paid-resources](../_tutorials_includes/tls-termination/paid-resources.md) %}

## Create your infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the {{ yandex-cloud }} provider source (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), Step 1).
1. Prepare your infrastructure description files:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository with configuration files.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-alb-tls-termination.git
        ```

     1. Navigate to the repository directory. Make sure it contains the following files:
        * `tls-termination-config.tf`: New infrastructure configuration.
        * `tls-terminationg.auto.tfvars`: User data file.

   - Manually {#manual}

     1. Create a folder for configuration files.
     1. In the folder, create:
        1. `tls-termination-config.tf` configuration file:

           {% cut "tls-termination-config.tf" %}

           {% include [tls-termination-config](../../_includes/application-load-balancer/tls-termination-config.md) %}

           {% endcut %}

        1. `tls-termination.auto.tfvars` user data file:

           {% cut "tls-termination.auto.tfvars" %}

           ```hcl
           folder_id    = "<folder_ID>"
           vm_user      = "<VM_user_name>"
           ssh_key_path = "<public_SSH_key_path>"
           domain       = "<domain>"
           certificate  = "<certificate_file_path>"
           private_key  = "<private_key_file_path>"
           ```

           {% endcut %}

   {% endlist %}

   For more information about the properties of {{ TF }} resources, see the relevant {{ TF }} guides:
   * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network)
   * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet)
   * [Static public IP address](../../vpc/concepts/address.md#public-addresses): [yandex_vpc_address]({{ tf-provider-resources-link }}/vpc_address)
   * [Security groups](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group)
   * [TLS certificate](../../certificate-manager/concepts/imported-certificate.md): [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate)
   * [VM image](../../compute/concepts/image.md): [yandex_compute_image]({{ tf-provider-resources-link }}/compute_image)
   * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account)
   * [Role](../../iam/concepts/access-control/roles.md): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member)
   * [Instance group](../../compute/concepts/instance-groups/index.md): [yandex_compute_instance_group]({{ tf-provider-resources-link }}/compute_instance_group)
   * [Backend group](../../application-load-balancer/concepts/backend-group.md): [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group)
   * [HTTP router](../../application-load-balancer/concepts/http-router.md): [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router)
   * [Virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host): [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host)
   * [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md): [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer)
   * [DNS zone](../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
   * [DNS resource record](../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)

1. In the `tls-termination.auto.tfvars` file, set the following user-defined properties:
   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `vm_user`: VM user name.
   * `ssh_key_path`: Path to the public SSH key file. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
   * `domain`: Domain to host the website. 
       To get access to public zone domain names, you need to delegate the domain. Specify the addresses of the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` servers in your account on your registrar's website.
   * `certificate`: Path to the [user certificate](../../certificate-manager/operations/import/cert-create.md#create-file) file.
   * `private_key`: Path to the file with the user certificate's private key.
1. Create the resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

1. [Get the public IP addresses](../../compute/operations/instance-groups/get-info.md): you will need them later to [test the hosting](#test).

After creating the infrastructure, [test the hosting](#test).

## Test the hosting {#test}

{% include [tls-termination-test](../_tutorials_includes/tls-termination/test.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `tls-termination-config.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

