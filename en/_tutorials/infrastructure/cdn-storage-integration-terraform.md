1. [Get your cloud ready](#before-you-begin).
1. [Deploy the infrastructure for integration of an L7 load balancer with {{ cdn-name }} and {{ objstorage-name }}](#deploy).
1. [Test the solution](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/cdn-storage-integration/paid-resources.md) %}

## Deploying the infrastructure for integration of an L7 load balancer with {{ cdn-name }} and {{ objstorage-name }} {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing {{ yandex-cloud }} (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Set up your infrastructure description files:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. Clone the repository with configuration files:

         ```bash
         git clone https://github.com/yandex-cloud-examples/cdn-storage-integration-config
         ```

      1. Navigate to the repository directory. It should now contain the following files:
          * `cdn-storage-integration-config.tf`: New infrastructure configuration file.
          * `cdn-storage-integration.auto.tfvars`: File with the values of user-defined variables.
          * `index.html`: Test file of your service, used to health-check the solution.

    - Manually {#manual}

      1. Create a folder for configuration files. In this folder:

          1. {% include [create-index-html](../_tutorials_includes/cdn-storage-integration/create-index-html.md) %}
          1. Create a configuration file named `cdn-storage-integration-config.tf`:

              {% cut "**cdn-storage-integration-config.tf**" %}

              {% include [cdn-storage-integration-config](../_tutorials_includes/cdn-storage-integration/cdn-storage-integration-config.md) %}

              {% endcut %}

          1. Create a file with user data named `cdn-storage-integration.auto.tfvars`:

              **cdn-storage-integration.auto.tfvars**

              ```hcl
              folder_id       = "<folder_ID>"
              bucket_name     = "<bucket_name>"
              domain_name     = "<domain_name>"
              index_file_path = "<local_filepath_to_index.html>"
              ```

    {% endlist %}

    Learn more about the properties of {{ TF }} resources in the relevant provider guides:

    * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Subnet](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Security group](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * [DNS zone](../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
    * [DNS resource record](../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).
    * [TLS certificate](../../certificate-manager/concepts/managed-certificate.md): [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate).
    * [Bucket](../../storage/concepts/bucket.md): [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
    * [Object](../../storage/concepts/object.md): [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object).
    * [Origin group](../../cdn/concepts/origins.md#groups): [yandex_cdn_origin_group]({{ tf-provider-resources-link }}/cdn_origin_group).
    * [CDN resource](../../cdn/concepts/resource.md): [yandex_cdn_resource]({{ tf-provider-resources-link }}/cdn_resource).
    * [Backend group](../../application-load-balancer/concepts/backend-group.md): [yandex_alb_backend_group]({{ tf-provider-resources-link }}/alb_backend_group).
    * [HTTP router](../../application-load-balancer/concepts/http-router.md): [yandex_alb_http_router]({{ tf-provider-resources-link }}/alb_http_router).
    * [Virtual host](../../application-load-balancer/concepts/http-router.md#virtual-host): [yandex_alb_virtual_host]({{ tf-provider-resources-link }}/alb_virtual_host).
    * [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md): [yandex_alb_load_balancer]({{ tf-provider-resources-link }}/alb_load_balancer).

1. In the `cdn-storage-integration.auto.tfvars` file, set the values of the user-defined variables:
    * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
    * `bucket_name`: Bucket name consistent with the [naming conventions](../../storage/concepts/bucket.md#naming).
    * `domain_name`: Name of the domain to host the test service.

        To use domain names in the public DNS zone, you need to delegate it to authoritative name servers. Specify the addresses of the `ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}` servers in your account on your domain name registrar's website.
    * `index_file_path`: Local path to the `index.html` file that contains your test service contents, e.g., `/Users/MyUser/Repos/cdn-storage-integration/index.html`.

1. Create the resources:

   {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

This will create and configure all the required infrastructure in the folder you selected.

## Test the solution {#test}

{% include [test](../_tutorials_includes/cdn-storage-integration/test.md) %}

## How to delete the resources you created {#clear-out}

{% note warning %}

Before deleting the infrastructure, [delete](../../storage/operations/objects/delete.md) all objects in the created bucket.

{% endnote %}

To stop paying for the resources you created:

1. Open the `cdn-storage-integration-config.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}
