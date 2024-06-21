1. [Prepare your cloud](#before-you-begin).
1. [Create a public bucket](#create-public-bucket).
1. [Enable a website for a bucket](#turn-on-hosting).
1. [Configure the DNS](#configure-dns).
1. [Upload the website files](#upload-files).
1. [Check that the website is running](#test-site).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [static-paid-resources](../_tutorials_includes/static-paid-resources.md) %}

## Create a public bucket {#create-public-bucket}

{% list tabs group=instructions %}

- Management console {#console}

   To create a bucket for static website files:
   1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to perform your steps in.
   1. On the folder page, click **Create resource** and select **Bucket**.
   1. In the **Name** field, enter a name for the bucket, e.g., `www.example.com`. The bucket name will become a part of the website domain name. Once configured, the bucket will be available at two addresses:
      * `http(s)://<bucket_name>.{{ s3-web-host }}`
      * `http(s)://{{ s3-web-host }}/<bucket_name>`

      The name must meet the following requirements:

      {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

      {% note info %}

      If you plan to use your own domain for the website, the bucket name must exactly match the name of your domain, and this must be a third-level domain or higher. For more information, see [{#T}](../../storage/operations/hosting/own-domain.md).

      {% endnote %}

   1. Specify the maximum size of the bucket in GB.
   1. Enable **Public** access to read [objects](../../storage/concepts/object.md).
   1. Click **Create bucket**.

{% endlist %}

## Enable a website for a bucket {#turn-on-hosting}

{% list tabs group=instructions %}

- Management console {#console}

   You should upload and configure the index page and error page. To do this:
   1. Create the following files on your computer:
      * `index.html` containing the `Hello world!` string.

         The file contents will be displayed when accessing the website's home page.
      * `error.html` containing the `Error!` string.

         The file contents will appear in website responses with `4xx` errors.
   1. Go to your bucket's page, open the **Objects** tab, and click **Upload**. In the window that opens, select the created files and click the confirmation button.
   1. Click **Upload**.
   1. Open the **Website** tab on your bucket page.
   1. Select **Hosting**.
   1. In the **Home page** field, specify `index.html`.
   1. In the **Error page** field, specify `error.html`.
   1. Click **Save**.
   1. Make sure the website's home page opens. To do this, access the website from a browser at `http://<bucket_name>.{{ s3-web-host }}`.
   1. Make sure the error page opens. To do this, access the website from a browser at `http://<bucket_name>.{{ s3-web-host }}/error-check`.

   {% note info %}

   By default, the website is accessible only over HTTP, for instance, `http://www.example.com` or `http://www.example.com.{{ s3-web-host }}`. To provide HTTPS support for your website, [upload your own security certificate](../../storage/operations/hosting/certificate.md) to {{ objstorage-name }}.

   {% endnote %}

{% endlist %}

## Configure the DNS {#configure-dns}

If you have a registered domain name, assign it to the bucket. To do this, create a [CNAME](../../dns/concepts/resource-record.md) [DNS record](../../dns/concepts/resource-record.md#cname).

You can use the {{ dns-name }} service to manage the domain.

{% note info %}

The bucket name must exactly match the name of your domain, and this must be a third-level domain or higher. For more information, see [{#T}](../../storage/operations/hosting/own-domain.md).

{% endnote %}

The tutorial below describes configuring DNS for the third-level `www.example.com` domain name.

### Add a zone {#create-dns-zone}

{% list tabs group=instructions %}

- Management console {#console}

   To add a public zone:
   1. Open the **{{ dns-name }}** section of the folder where you need to create a DNS zone.
   1. Click **Create zone**.
   1. Specify the zone settings:
      * Zone **name**: `example-zone-1`.
      * **Zone**: `example.com.`. Specify your registered domain.
      * **Type**: **Public**.
   1. Click **Create**.

{% endlist %}

### Create a CNAME record {#create-cname-record}

{% list tabs group=instructions %}

- Management console {#console}

   Create a [CNAME](../../dns/concepts/resource-record.md#cname) DNS record in the public zone.
   1. Select `example.com` from the list.
   1. Click **Create record**.
   1. Set the record parameters:
      * **Name**: `www`.
      * **Record type**: Select `CNAME` as the value.
      * **TTL** (record time to live): Keep the default value.
      * **Value**: Enter `www.example.com.{{ s3-web-host }}.`.
   1. Click **Create**.

{% endlist %}

### Delegate the domain name {#delegate-domain}

Delegation is the transfer of authority from the registrar's servers to yours. For a domain, [NS](../../dns/concepts/resource-record.md#ns) resource records are created (`ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}`).

To delegate a domain, specify its DNS servers in the registrar's account.

Delegation does not take effect immediately. It usually takes up to 24 hours (86,400 seconds) for internet service providers to update records. This depends on the [TTL](https://en.wikipedia.org/wiki/Time_to_live) value which specifies how long domain records are cached.

You can check domain delegation using [Whois](https://www.reg.com/whois/check_site) or the `dig` utility:

```bash
dig +short NS example.com
```

Result:

```text
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```

## Upload the website files {#upload-files}

After you configure and test availability, upload the remaining files that are necessary for website operation. To do this, use the [management console]({{ link-console-main }}), [S3 API](../../storage/s3/api-ref/object/upload.md), [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md), or other [tools for working with {{ objstorage-name }}](../../storage/tools/).

## Check that the website is running {#test-site}

{% include [static-test-site](../_tutorials_includes/static-test-site.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources:
* [Delete the uploaded files](../../storage/operations/objects/delete.md).
* [Delete the DNS zone](../../dns/operations/zone-delete.md).