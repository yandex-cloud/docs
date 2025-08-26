# Setting up static website hosting in a {{ objstorage-full-name }} bucket with {{ cdn-full-name }} access


In this tutorial, you will create a static website in a [{{ objstorage-full-name }}](../../storage/) [bucket](../../storage/concepts/bucket.md) and publish it as a content origin in [{{ cdn-full-name }}](../../cdn/). The connection between the client and the CDN server can use TLS 1.0 and TLS 1.1; the connection between the CDN server and {{ objstorage-name }} can use TLS 1.2 or higher. The website will be available via the domain name delegated in [{{ dns-full-name }}](../../dns/), for which a TLS certificate will be issued in [{{ certificate-manager-full-name }}](../../certificate-manager/). The website domain name will be mapped to the CDN resource using a [CNAME](../../dns/concepts/resource-record.md#cname) record in DNS.

We will use the `cdn.yandexcloud.example` domain name as an example.

To set up static website hosting in a bucket with CDN access:
1. [Get your cloud ready](#before-you-begin).
1. [Add a certificate to {{ certificate-manager-name }}](#add-certificate).
1. [Create a bucket in {{ objstorage-name }} and upload your website files to it](#create-bucket).
1. [Set up static website hosting](#hosting).
1. [Create a CDN resource](#create-cdn-resource).
1. [Configure DNS for the CDN resource](#configure-dns).
1. [Test the CDN](#check-cdn).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost for a bucket-hosted site with CDN access includes:
* Fee for CDN server outbound traffic (see [{{ cdn-name }} pricing](../../cdn/pricing.md)).
* Fee for data storage in {{ objstorage-name }}, data operations, and outbound traffic (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Fee for public DNS requests and [DNS zones](../../dns/concepts/dns-zone.md) if using [{{ dns-full-name }}](../../dns/) (see [{{ dns-name }} pricing](../../dns/pricing.md)).


## Add a certificate to {{ certificate-manager-name }} {#add-certificate}

{% include [certificate-usage](../../_includes/cdn/certificate-usage.md) %}

For a Let's Encrypt® certificate, pass an [ownership check](../../certificate-manager/operations/managed/cert-validate.md) for the domain specified in the certificate.


## Create a bucket in {{ objstorage-name }} and upload your website files to it {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  1. Create a website home page file named `index.html` on your computer.

      {% cut "Example of the `index.html` file" %}

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

  1. On the bucket page, click ![image](../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}** and select `index.html`.

{% endlist %}


## Set up static website hosting {#hosting}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [hosting-setup-console](../../_includes/storage/hosting-setup-console.md) %}

{% endlist %}


## Create a CDN resource {#create-cdn-resource}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Click **{{ ui-key.yacloud.cdn.button_resource-create }}**.
  1. Configure the basic CDN resource settings:
      * Under **{{ ui-key.yacloud.cdn.label_section-content }}**:
        * Enable **{{ ui-key.yacloud.cdn.label_access }}**.
        * In the **{{ ui-key.yacloud.cdn.label_content-query-type }}** field, select `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`.
        * In the **{{ ui-key.yacloud.cdn.label_source-type }}** field, select `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`.
        * In the **{{ ui-key.yacloud.cdn.label_bucket }}** field, select the bucket you need from the list.
        * In the **{{ ui-key.yacloud.cdn.label_protocol }}** field, select `{{ ui-key.yacloud.common.label_http }}`.
        * In the **{{ ui-key.yacloud.cdn.label_personal-domain }}** field, specify `cdn.yandexcloud.example`.

          {% note alert %}

          The `cdn.yandexcloud.example` domain name will become the primary one, and you will not be able to edit it after you create a CDN resource.

          {% endnote %}

      * Under **{{ ui-key.yacloud.cdn.label_section-additional }}**:
        * In the **{{ ui-key.yacloud.cdn.label_redirect }}** field, select `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}`.
        * In the **{{ ui-key.yacloud.cdn.label_certificate-type }}** field, specify `{{ ui-key.yacloud.cdn.value_certificate-custom }}` and select a [certificate](#add-certificate) for the `cdn.yandexcloud.example` domain name.
        * In the **{{ ui-key.yacloud.cdn.label_host-header }}** field, select `{{ ui-key.yacloud.cdn.value_host-header-custom }}` and, in **{{ ui-key.yacloud.cdn.label_custom-host-header }}**, specify the origin domain name in `<name_of_bucket_with_files>.{{ s3-web-host }}` format for the source bucket to respond to CDN server requests correctly.
  1. Click **{{ ui-key.yacloud.common.continue }}**.
  1. Under **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}**, and **Advanced**, leave the default settings, then click **Continue**.

{% endlist %}


## Configure DNS for the CDN resource {#configure-dns}

The `cdn.yandexcloud.example` domain name must be mapped to the CDN using DNS records.

To configure DNS:

1. Get the {{ cdn-name }} provider domain name:

   {% list tabs group=instructions %}
   
   - Management console {#console}

     1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
     1. From the list of CDN resources, select the one with `cdn.yandexcloud.example` as its primary domain name.
     1. From **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** at the bottom of the page, copy the domain name in `{{ cname-example-yc }}` or `{{ cname-example-edge }}` format depending on your [CDN provider](../../cdn/concepts/providers.md).

   {% endlist %}

1. On the website of your DNS hosting provider, navigate to the DNS settings.
1. Create or edit a CNAME record for `cdn.yandexcloud.example` so that it points to the domain name you copied:

   ```text
   cdn CNAME {{ cname-example-yc }}
   ```

   {% include [note-dns-aname](../../_includes/cdn/note-dns-aname.md) %}

   If you use {{ dns-name }}, follow this guide to configure the record:
   
   {% cut "Configuring DNS records for {{ dns-name }}" %}
   
   {% list tabs group=instructions %}
   
   - Management console {#console}
   
     1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
     1. If you do not have a public DNS zone, create one:

        1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
        1. In the **{{ ui-key.yacloud.dns.label_zone }}** field, enter the website domain name with a trailing dot: `yandexcloud.example.`.
        1. In the **{{ ui-key.yacloud.common.type }}** field, select `{{ ui-key.yacloud.dns.label_public }}`.
        1. In the **{{ ui-key.yacloud.common.name }}** field, specify `example-dns-zone`.
        1. Click **{{ ui-key.yacloud.common.create }}**.
      
     1. Create a CNAME record for `cdn.yandexcloud.example` in the zone:

        1. Select `example-dns-zone`.
        1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
        1. In the **{{ ui-key.yacloud.common.name }}** field, specify `cdn`.
        1. In the **{{ ui-key.yacloud.common.type }}** field, specify `CNAME`.
        1. In the **{{ ui-key.yacloud.dns.label_records }}** field, paste the copied value in `{{ cname-example-yc }}.` or `{{ cname-example-edge }}.` format (depending on your [CDN provider](../../cdn/concepts/providers.md)) with a trailing dot.
        1. Click **{{ ui-key.yacloud.common.create }}**.

   {% endlist %}

   {% endcut %}

## Test the CDN {#check-cdn}

Check your website for availability:
1. Wait for the DNS records to get updated (this may take several hours) and for the files to be prefetched to the CDN servers.
1. Open your website at the new URL:

   ```http
   https://cdn.example.com
   ```

## How to delete the resources you created {#clear-out}

To shut down the infrastructure and stop paying for the resources you created:

1. [Delete](../../dns/operations/zone-delete.md) the DNS zone named `example-dns-zone` if you created it in {{ dns-name }}.
1. Delete the CDN resource with `cdn.yandexcloud.example` as its primary domain name.
1. [Delete](../../storage/operations/objects/delete.md) all objects from the bucket.
1. [Delete](../../storage/operations/buckets/delete.md) the bucket.