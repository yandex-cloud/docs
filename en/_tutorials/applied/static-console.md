1. [Get your cloud ready](#before-you-begin).
1. [Create a public bucket](#create-public-bucket).
1. [Enable a website for a bucket](#turn-on-hosting).
1. [Configure DNS](#configure-dns).
1. [Upload the website files](#upload-files).
1. [Test the website](#test-site).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [static-paid-resources](../_tutorials_includes/static-paid-resources.md) %}

## Create a public bucket {#create-public-bucket}

To create a bucket for static website files:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create a bucket in.
  1. On the folder page, click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select **{{ ui-key.yacloud.iam.folder.dashboard.value_storage }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify the bucket name. Once configured, the bucket will be available at two addresses:

     * `http(s)://<bucket_name>.{{ s3-web-host }}`
     * `http(s)://{{ s3-web-host }}/<bucket_name>`

     The name must meet the following requirements:

     {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

     If you have a registered domain name (e.g., `example.com`) and want your website to be accessible at `example.com`, specify `example.com` as the bucket name.

     {% note info %}

     If you plan to use your own domain for the website, the bucket name must be an exact match of your domain name. Use a second-level domain or higher. For more information, see [{#T}](../../storage/operations/hosting/own-domain.md).

     {% endnote %}

  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** field, specify `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

## Enable a website for a bucket {#turn-on-hosting}

1. Upload and configure the home page and error handling page for your intended website. To do this, create the following files on your computer:

    * `index.html` containing the text `Hello world!`. The file contents will be displayed on the website's home page.
    * `error.html` containing the text `Error!`. The file contents will be displayed when the website responds with `4xx` errors.

1. Upload the files you created to the bucket:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the bucket is located.
      1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**. In the window that opens, select the bucket created earlier.
      1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
      1. Click **{{ ui-key.yacloud.storage.bucket.button_upload }}**. In the window that opens, select the files you created and confirm the upload.
      1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
      1. On the **{{ ui-key.yacloud.storage.bucket.switch_website }}** tab:

          1. Navigate to the `{{ ui-key.yacloud.storage.bucket.switch_website }}` tab and select `{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}`.
          1. In the **{{ ui-key.yacloud.storage.bucket.website.field_index }}** field, specify `index.html`.
          1. In the **{{ ui-key.yacloud.storage.bucket.website.field_error }}** field, specify `error.html`.
          1. Click **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

    {% endlist %}

1. Make sure your website's home page opens. To do this, access the website from a browser at `http://<bucket_name>.{{ s3-web-host }}`.
1. Make sure the error page opens. To do this, access the website from a browser at `http://<bucket_name>.{{ s3-web-host }}/error-check`.

By default, the website is only accessible over HTTP, e.g., at `http://example.com.{{ s3-web-host }}`. To provide HTTPS support for your website:
1. Add your [own security certificate](../../certificate-manager/operations/import/cert-create.md) or a [Let's Encrypt certificate](../../certificate-manager/operations/managed/cert-create.md) in {{ certificate-manager-full-name }}.
1. [Configure](../../storage/operations/hosting/certificate.md) HTTPS support for your bucket. Your website will then be accessible over HTTPS at `https://example.com.website.yandexcloud.net`.

    {% include [bucket-https](../../_includes/storage/bucket-https.md) %}

1. For access by the short domain name (`example.com`), [configure DNS](#configure-dns).

## Configure DNS {#configure-dns}

If you have a registered domain name, assign it to the bucket. To do this, create an [ANAME](../../dns/concepts/resource-record.md) [DNS record](../../dns/concepts/resource-record.md#cname).

You can use {{ dns-name }} to manage the domain.

{% note info %}

The bucket name must be an exact match of your domain name. Use a second-level domain or higher. For more information, see [{#T}](../../storage/operations/hosting/own-domain.md).

{% endnote %}

The tutorial below describes how to set up DNS for an `example.com` second-level domain.

### Add a zone {#create-dns-zone}

To create a public DNS zone:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a public zone.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**. In the window that opens, specify the DNS zone settings:

      * **{{ ui-key.yacloud.dns.label_zone }}**: Specify your registered domain name, e.g., `example.com.`. The field value must end with a trailing dot.
      * **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.dns.label_public }}`.
      * **{{ ui-key.yacloud.common.name }}**: `example-zone-1`.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Add an ANAME resource record {#create-cname-record}

Create an [ANAME](../../dns/concepts/resource-record.md#aname) resource record in the public DNS zone:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder that houses the public DNS zone.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** and then, the DNS zone you created earlier. 
  1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**. In the window that opens, set the record properties:

      * In the **{{ ui-key.yacloud.common.name }}** field, select `{{ ui-key.yacloud.dns.label_create-subdomain }}` and enter the domain value, e.g., `example.com`.
      * In the **{{ ui-key.yacloud.common.type }}** field, select `ANAME`.
      * In the **{{ ui-key.yacloud.dns.label_records }}** field, specify the resource record value, e.g., `example.com.{{ s3-web-host }}`, where `example.com` is the name of the public bucket you created earlier.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

The domain name in the ANAME record must match the bucket name. For example, if you are creating an ANAME record named `example.com`, your bucket name should also be `example.com`.

### Delegate the domain name {#delegate-domain}

Delegation is the transfer of authority from the registrar's servers to yours. For a domain, [NS](../../dns/concepts/resource-record.md#ns) resource records (`ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}`) are created.

To delegate a domain, specify its DNS servers in the registrar's account.

Delegation does not take effect immediately. It usually takes up to 24 hours (86,400 seconds) for internet service providers to update records. This depends on the [TTL](https://en.wikipedia.org/wiki/Time_to_live) value, which specifies how long domain records are cached.

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

After you configure and test availability, upload the remaining files required for website operation. To do this, use the [management console]({{ link-console-main }}), [S3 API](../../storage/s3/api-ref/object/upload.md), [{{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md), or other [tools for operating {{ objstorage-name }}](../../storage/tools/).

## Test the website {#test-site}

{% include [static-test-site](../_tutorials_includes/static-test-site.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources:
1. [Delete the files you uploaded](../../storage/operations/objects/delete.md).
1. [Delete the bucket](../../storage/operations/buckets/delete.md).
1. [Delete the DNS zone](../../dns/operations/zone-delete.md).