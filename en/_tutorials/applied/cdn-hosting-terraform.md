1. [Get your cloud ready](#before-you-begin).
1. [Add a certificate to {{ certificate-manager-name }}](#add-certificate).
1. [Create your infrastructure](#deploy).
1. [Test the CDN](#check-cdn).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../../_tutorials/_tutorials_includes/cdn-hosting/paid-resources.md) %}


## Add a certificate to {{ certificate-manager-name }} {#add-certificate}

{% include [add-certificate](../../_tutorials/_tutorials_includes/cdn-hosting/add-certificate.md) %}


## Create your infrastructure {#deploy}

{% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:
1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing {{ yandex-cloud }} (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Set up your infrastructure description files:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository with configuration files.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-s3-cdn-hosting.git
        ```

     1. Navigate to the repository directory. It should now contain the following files:
        * `index.html`: Website home page file.
        * `yc-cdn-hosting.tf`: New infrastructure configuration.
        * `yc-cdn-hosting.auto.tfvars`: User data file.

   - Manually {#manual}

     1. Create a folder for configuration files.
     1. In the folder, create:
        1. The home page file for the website, `index.html`:

           {% cut "index.html" %}
           
           ```html
           <!DOCTYPE html>
           <html>
             <head>
               <title>My site</title>
             </head>
             <body>
               <p>The site is working</p>
             </body>
           </html>
           ```
           
           {% endcut %}

        1. `yc-cdn-hosting.tf` configuration file:

           {% cut "yc-cdn-hosting.tf" %}

           {% include [yc-cdn-hosting](../../_tutorials/_tutorials_includes/cdn-hosting/tf-config.md) %}

           {% endcut %}

        1. `yc-cdn-hosting.auto.tfvars` user data file:

           {% cut "yc-cdn-hosting.auto.tfvars" %}

           ```hcl
           folder_id = "<folder_ID>"
           domain    = "<domain_name>"
           cert_id   = "<TLS_certificate_ID>"
           ```

           {% endcut %}

   {% endlist %}

   Learn more about the properties of {{ TF }} resources in the relevant provider guides:
   * [TLS certificate](../../certificate-manager/concepts/managed-certificate.md): [yandex_cm_certificate]({{ tf-provider-datasources-link }}/cm_certificate) data source.
   * [Bucket](../../storage/concepts/bucket.md): [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
   * [Configuring](../../storage/operations/buckets/edit-acl.md) access permissions for a bucket using [ACL Object Storage](../../storage/concepts/acl.md): [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/yandex_storage_bucket_grant).
   * [Object](../../storage/concepts/object.md): [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object).
   * [DNS zone](../../dns/concepts/dns-zone.md): [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone).
   * [DNS resource record](../../dns/concepts/resource-record.md): [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset).
   * [CDN resource](../../cdn/concepts/resource.md): [yandex_cdn_resource]({{ tf-provider-resources-link }}/cdn_resource).
   * [Origin group](../../cdn/concepts/origins.md#groups): [yandex_cdn_origin_group]({{ tf-provider-resources-link }}/cdn_origin_group).

1. In the `yc-cdn-hosting.auto.tfvars` file, set the following user-defined properties:
   * `folder_id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
   * `domain`: Primary domain name, e.g., `example.com`. 
       To use domain names in the public DNS zone, you need to delegate it to authoritative name servers. Specify `ns1.yandexcloud.net` and `ns2.yandexcloud.net` server addresses in your registrar's account settings.
   * `cert_id`: {{ certificate-manager-name }} TLS certificate ID, with domain ownership verified.

1. Create the resources:

   {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

{% include [start-warn](../_tutorials_includes/cdn-hosting/start-warn.md) %}


## Test the CDN {#check-cdn}

{% include [check-cdn](../../_tutorials/_tutorials_includes/cdn-hosting/check-cdn.md) %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `yc-cdn-hosting.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
