# Providing secure access to content in {{ cdn-name }} through {{ TF }}

To configure secure access to content in {{ cdn-name }}:

1. [Get your cloud ready](#before-you-begin).
1. [Delegate your domain to {{ dns-name }}](#delegate-domain).
1. [Create your infrastructure](#deploy).
1. [Publish the webiste on the web server](#publish-website).
1. [Test secure access to files](#check).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/protected-access-to-content/paid-resources.md) %}


## Delegate your domain to {{ dns-name }} {#delegate-domain}

{% include [delegate-domain](../_tutorials_includes/protected-access-to-content/delegate-domain.md) %}


## Create an infrastructure {#deploy}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the authentication credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the {{ yandex-cloud }} provider source (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), Step 1).
1. Prepare your infrastructure description files:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. Clone the repository with configuration files.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-cdn-protected-access
          ```

      1. Navigate to the repository directory. Make sure it contains the following files:

          * `yc-cdn-secure-token.tf`: New infrastructure configuration.
          * `yc-cdn-secure-token.auto.tfvars`: User data file.

    - Manually {#manual}

      1. Prepare files for uploading to the bucket:

          {% include [prepare-files](../_tutorials_includes/protected-access-to-content/prepare-files.md) %}

      1. Create a folder for configuration files.
      1. In the folder, create:

          1. `yc-cdn-secure-token.tf` configuration file:

              {% cut "yc-cdn-secure-token.tf" %}

              {% include [config](../_tutorials_includes/protected-access-to-content/config.md) %}

              {% endcut %}

          1. `yc-cdn-secure-token.auto.tfvars` user data file:

              {% cut "yc-cdn-secure-token.auto.tfvars" %}

              ```hcl
              folder_id         = "<folder_ID>"
              ssh_key_path      = "<path_to_public_SSH_key_file>"
              index_file_path   = "<name_of_website_homepage_file>"
              content_file_path = "<name_of_file_with_content_to_upload_to_bucket>"
              domain_name       = "<domain_name>"
              subdomain_name    = "<CDN_resource_subdomain_prefix>"
              bucket_name       = "<bucket_name>"
              cdn_cname         = "<CDN_provider_domain_name_value>"
              secure_key        = "<secret_key>"
              ```

              {% endcut %}

    {% endlist %}

    Learn more about the properties of {{ TF }} resources in the provider documentation:

    * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * Service account [role](../../iam/concepts/access-control/roles.md): [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Static access key](../../iam/concepts/authorization/access-key.md): [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
    * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Subnets](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Security group](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * VM [disk](../../compute/concepts/disk.md): [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
    * [VM instance](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [DNS zone](../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
    * [DNS resource record](../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).
    * [TLS certificate](../../certificate-manager/concepts/managed-certificate.md): [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate).
    * [Bucket](../../storage/concepts/bucket.md): [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
    * [Object](../../storage/concepts/object.md): [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object).
    * [Origin group](../../cdn/concepts/origins.md#groups): [yandex_cdn_origin_group]({{ tf-provider-resources-link }}/cdn_origin_group).
    * [CDN resource](../../cdn/concepts/resource.md): [yandex_cdn_resource]({{ tf-provider-resources-link }}/cdn_resource).

1. In the `yc-cdn-secure-token.auto.tfvars` file, set the following user-defined properties:

    * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
    * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
    * `index_file_path`: Path to the website homepage file.
    * `content_file_path`: Path to the file with content for uploading to the bucket.
    * `domain_name`: Your domain name, e.g., `example.com`.
    * `subdomain_name`: Prefix of subdomain for the CDN resource, e.g., `cdn`.
    * `bucket_name`: Bucket name consistent with the [naming conventions](../../storage/concepts/bucket.md#naming).
    * `cdn_cname`: [Domain name](../../cdn/operations/resources/get-resources-info.md#get-cname) of the {{ cdn-name }} provider for the folder's CDN resources.
    * `secure_key`: Secret key that is a string of 6 to 32 characters. It is required to restrict access to a resource using [secure tokens](../../cdn/concepts/secure-tokens.md).

1. Create the resources:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

{% include [after-changes-tip](../../_includes/cdn/after-changes-tip.md) %}

{% include [content-through-signed-links](../_tutorials_includes/protected-access-to-content/content-through-signed-links.md) %}


## Publish the webiste on the web server {#publish-website}

{% include [publish-website](../_tutorials_includes/protected-access-to-content/publish-website.md) %}


## Test secure access to files {#check}

{% include [check](../_tutorials_includes/protected-access-to-content/check.md) %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `yc-cdn-secure-token.tf` configuration file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}