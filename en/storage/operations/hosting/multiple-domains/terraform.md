---
title: How to set up multiple domain name support for a website using {{ TF }}
description: Follow this guide to set up multiple domain name support for a website using {{ TF }}.
---

# Support for multiple domain names using {{ TF }}

To create an infrastructure to support [multiple website domain names](index.md) using {{ TF }}:
1. [Delegate the domain name](#delegate-domain).
1. [Create your infrastructure](#deploy).
1. [Check the performance of several domains](#test).


## Delegate the domain name {#delegate-domain}

You can use [{{ dns-full-name }}](../../../../dns/) to manage the domain.

{% include [dns-delegate](../../../../_tutorials/_tutorials_includes/bind-domain-vm/dns-delegate.md) %}


## Create your infrastructure {#deploy}


1. Set up your infrastructure description files:

   {% list tabs group=infrastructure_description %}

   - Ready-made configuration {#ready}

     1. Clone the repository with configuration files.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-s3-static-website-multiple-domain.git
        ```

     1. Navigate to the repository directory. It should now contain the following files:
        * `index.html`: Website home page file.
        * `website-multiple-domain.tf`: New infrastructure configuration.
        * `website-multiple-domain.auto.tfvars`: User data file.

   - Manually {#manual}

     1. Create a folder for configuration files.

     1. In the folder, create:

        1. `website-multiple-domain.tf` configuration file:

           {% cut "website-multiple-domain.tf" %}

           {% include [website-multiple-domain-tf](../../../../_includes/storage/website-multiple-domain-tf.md) %}

           {% endcut %}

        1. `website-multiple-domain.auto.tfvars` user data file:

           {% cut "website-multiple-domain.auto.tfvars" %}

           ```hcl
           folder_id    = "<folder_ID>"
           main_domain  = "<main_domain>"
           extra_domain = "<additional_domain>"
           ```

           {% endcut %}

        1. The home page file for the website, `index.html`:

           {% cut "index.html" %}

           ```html
           <!DOCTYPE html>
           <html>
             <head>
               <title>My site</title>
             </head>
             <body>
               <h1>This is my site!</h1>
             </body>
           </html>
           ```

           {% endcut %}

   {% endlist %}

   Learn more about the properties of {{ TF }} resources in the relevant provider guides:
   * [Bucket](../../../concepts/bucket.md): [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket)
   * [Object](../../../concepts/object.md): [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object)
   * DNS zone: [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
   * DNS resource record: [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)
   * TLS certificate: [yandex_cm_certificate]({{ tf-provider-resources-link }}/cm_certificate)

1. In the `website-multiple-domain.auto.tfvars` file, set the following user-defined properties:
   * `folder_id`: Folder ID.
   * `main_domain`: Main domain, e.g., `example.com`.
   * `extra_domain`: Additional domain, e.g., `example2.com`.

1. Create the resources:

   {% include [terraform-validate-plan-apply](../../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}


## Check the performance of several domains {#test}

{% include [website-multiple-domain-test](../../../../_includes/storage/website-multiple-domain-test.md) %}
