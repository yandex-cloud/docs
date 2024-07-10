1. [Prepare your cloud](#before-you-begin).
1. [Create a public bucket](#create-public-bucket).
1. [Enable a website for a bucket](#turn-on-hosting).
1. [Configure the DNS](#configure-dns).
1. [Upload the website files](#upload-files).
1. [Test the website](#test-site).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [static-paid-resources](../_tutorials_includes/static-paid-resources.md) %}

## Create a public bucket {#create-public-bucket}

To create a bucket for static website files:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create a bucket in.
   1. On the folder page, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_storage }}**.
   1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the bucket. Once configured, the bucket will be available at two addresses:

      * `http(s)://<bucket_name>.{{ s3-web-host }}`
      * `http(s)://{{ s3-web-host }}/<bucket_name>`

      The name must meet the following requirements:

      {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

      If you have a registered domain name (e.g., `example.com`) and you want your website to be accessible at `www.example.com`, specify `www.example.com` as the bucket name.

      {% note info %}

      If you plan to use your own domain for the website, the bucket name must exactly match the name of your domain, and this must be a third-level domain or higher. For more information, see [{#T}](../../storage/operations/hosting/own-domain.md).

      {% endnote %}

   1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** field, specify `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
   1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

## Enable a website for a bucket {#turn-on-hosting}

1. Upload and configure the home page and error handling page for the future website. To do this, create the following files on your computer:

   * `index.html` containing the `Hello world!` string. The file contents will be displayed when accessing the website's home page.
   * `error.html` containing the `Error!` string. The file contents will be displayed when the website responds with `4xx` errors.

1. Upload the created files to the bucket:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the bucket is located.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**. In the window that opens, select the previously created bucket.
      1. On the **{{ ui-key.yacloud.storage.bucket.switch_files }}** tab of your bucket page, click **{{ ui-key.yacloud.storage.bucket.button_upload }}**. In the window that opens, select the created files and confirm the upload.
      1. Open the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab. In the window that opens, do the following:

         1. Select `{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}`.
         1. In the **{{ ui-key.yacloud.storage.bucket.website.field_index }}** field, specify `index.html`.
         1. In the **{{ ui-key.yacloud.storage.bucket.website.field_error }}** field, specify `error.html`.
         1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

   {% endlist %}

1. Make sure the home page of your website opens. To do this, access the website from a browser at `http://<bucket_name>.{{ s3-web-host }}`.
1. Make sure the error page opens. To do this, access the website from a browser at `http://<bucket_name>.{{ s3-web-host }}/error-check`.

{% note info %}

By default, the website is accessible only over HTTP, for instance, `http://www.example.com` or `http://www.example.com.{{ s3-web-host }}`. To enable HTTPS for your website, [upload your own security certificate](../../storage/operations/hosting/certificate.md) to {{ objstorage-name }}.

{% endnote %}

## Configure the DNS {#configure-dns}

If you have a registered domain name, assign it to the bucket. To do this, create a [CNAME](../../dns/concepts/resource-record.md) [DNS record](../../dns/concepts/resource-record.md#cname).

You can use the {{ dns-name }} service to manage the domain.

{% note info %}

The bucket name must exactly match the name of your domain, and this must be a third-level domain or higher. For more information, see [{#T}](../../storage/operations/hosting/own-domain.md).

{% endnote %}

The tutorial below describes configuring DNS for the third-level `www.example.com` domain name.

### Add a zone {#create-dns-zone}

To create a public DNS zone:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a public zone.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
   1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**. In the window that opens, specify the DNS zone settings:

      * **{{ ui-key.yacloud.dns.label_zone }}**: Specify your registered domain name, e.g., `example.com.`. The field value must end with a dot.
      * **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.dns.label_public }}`.
      * **{{ ui-key.yacloud.common.name }}**: `example-zone-1`.

   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Add a CNAME resource record {#create-cname-record}

Create a [CNAME](../../dns/concepts/resource-record.md#cname) resource record in the public DNS zone:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder that houses the public DNS zone.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** and select the DNS zone you created previously.
   1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**. In the window that opens, set the record parameters:

      * In the **{{ ui-key.yacloud.common.name }}** field, select `{{ ui-key.yacloud.dns.label_create-subdomain }}` and enter the subdomain value, e.g., `www`.
      * In the **{{ ui-key.yacloud.common.type }}** field, select `CNAME`.
      * In the **{{ ui-key.yacloud.dns.label_records }}** field, specify the resource record value, e.g., `www.example.com.{{ s3-web-host }}`, where `www.example.com` is the name of the public bucket you created previously.

   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

The subdomain name in the CNAME record must match the name of the bucket. For example, if you are creating a CNAME record named `www.example.com.`, your bucket name should be `www.example.com`.

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

## Test the website {#test-site}

{% include [static-test-site](../_tutorials_includes/static-test-site.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources:
* [Delete the uploaded files](../../storage/operations/objects/delete.md).
* [Delete the bucket](../../storage/operations/buckets/delete.md).
* [Delete the DNS zone](../../dns/operations/zone-delete.md).