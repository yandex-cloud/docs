# Static website in {{ objstorage-full-name }}

In this guide, you will learn how to upload your website [static files](../../storage/concepts/hosting.md) to [{{ objstorage-full-name }}](../../storage/) and link a domain name to a [bucket](../../storage/concepts/bucket.md).

To host a static website in Object Storage:

1. [Prepare your cloud](#before-you-begin).
1. [Create a public bucket](#create-public-bucket).
1. [Enable a website for a bucket](#turn-on-hosting).
1. [Configure the DNS](#configure-dns).
1. [Upload the website files](#upload-files).
1. [Check that the website is running](#test-site).

If you no longer need the website, [delete the files from the storage, as well as the availability zone](#clear-out).

You can also deploy the infrastructure for hosting a static website in {{ objstorage-name }} via {{ TF }} using a [ready-made configuration file](#terraform).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of hosting a static website includes:

* Fee for storing data for a static website (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-operations)).
* Cost of outgoing traffic from {{ yandex-cloud }} to the internet (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-traffic)).
* A fee for public DNS queries and zones (see [{{ dns-full-name }} pricing](../../dns/pricing.md)).


## Create a public bucket {#create-public-bucket}

{% list tabs %}

- Management console

   To create a bucket for static website files:

   1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you will perform the operations.
   1. On the folder page, click **Create resource** and select **Bucket**.
   1. In the **Name** field, enter a name for the bucket (for instance, `www.example.com`). The bucket name will become a part of the website domain name. After configuration is complete, the bucket becomes available at two addresses:

      * `http(s)://<bucket_name>.{{ s3-web-host }}`
      * `http(s)://{{ s3-web-host }}/<bucket name>`

      The name must meet the following requirements:

      {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

      {% note info %}

      If you plan to use your own domain for the website, the bucket name must exactly match the name of your domain, and this must be a third-level or higher domain. For more information, see [{#T}](../../storage/operations/hosting/own-domain.md).

      {% endnote %}

   1. Specify the maximum size of the bucket in GB.
   1. Enable **Public** read access to the objects.
   1. Click **Create bucket**.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Enable a website for a bucket {#turn-on-hosting}

{% list tabs %}

- Management console

   You should upload and configure the index page and error page. To do this:

   1. Create the following files on your computer:
      * `index.html` with the text `Hello world!`.
         The file content gets displayed when accessing the website's home page.
      * `error.html` with the text `Error!`.
         The file content appears in website responses with `4xx` errors.
   1. Go to your bucket's page, open the **Objects** tab, and click **Upload**. In the window that opens, select the created files and click the confirmation button.
   1. Click **Upload**.
   1. Open the **Website** tab on your bucket page.
   1. Select **Hosting**.
   1. In the **Home page** field, specify `index.html`.
   1. In the **Error page** field, specify `error.html`.
   1. Click **Save**.
   1. Make sure the website's home page opens. To do this, access the website from a browser via a link like `http://<bucket_name>.{{ s3-web-host }}`.
   1. Make sure the error page opens. To do this, access the website from a browser via a link like `http://<bucket_name>.{{ s3-web-host }}/error-check`.

   {% note info %}

   By default, the website is accessible only over HTTP, for instance, `http://www.example.com` or `http://www.example.com.{{ s3-web-host }}`. To provide HTTPS support for your website, [upload your own security certificate](../../storage/operations/hosting/certificate.md) to {{ objstorage-name }}.

   {% endnote %}

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Configure the DNS {#configure-dns}

If you have a registered domain name, assign it to the bucket. To do this, create a [CNAME](../../dns/concepts/resource-record.md#cname) record in the DNS.

You can use the {{ dns-name }} service to manage the domain.

{% note info %}

The bucket name must exactly match the name of your domain, and this must be a third-level or higher domain. For more information, see [{#T}](../../storage/operations/hosting/own-domain.md).

{% endnote %}

The tutorial below describes configuring DNS for the third-level `www.example.com` domain name.

### Add a zone {#create-dns-zone}

{% list tabs %}

- Management console

   To add a public zone:
   1. Open the **{{ dns-name }}** section of the folder where you need to create a [DNS zone](../../dns/concepts/dns-zone.md).
   1. Click **Create zone**.
   1. Specify the zone settings:
      * Zone **name**: `example-zone-1`.
      * **Zone**: `example.com`. Specify your registered domain.
      * **Type**: **Public**.
   1. Click **Create**.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

### Create a CNAME record {#create-cname-record}

{% list tabs %}

- Management console

   Create a [CNAME](../../dns/concepts/resource-record.md#cname) DNS record in the public zone.

   1. Select `example.com` from the list.
   1. Click **Create record**.
   1. Set the record parameters:
      * **Name**: `www`.
      * **Record type**: Select `CNAME` as the value.
      * **TTL** (record time to live): Leave the default value.
      * **Value**: Enter `www.example.com.{{ s3-web-host }}.`.
   1. Click **Create**.

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

### Delegate the domain name {#delegate-domain}

Delegation is the transfer of authority from the registrar's servers to yours. For a domain, [NS](../../dns/concepts/resource-record.md#ns) resource records are created (`ns1.{{ dns-ns-host-sld }}` and `ns2.{{ dns-ns-host-sld }}`).

To delegate a domain, specify its DNS servers in the registrar's account.

Delegation does not take effect immediately. It normally takes internet service providers up to 24 hours (86400 seconds) to update records. This depends on the TTL value that determines how long domain records are cached.

You can verify domain delegation using the [Whois](https://www.reg.com/whois/check_site) service or the `dig` utility:

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

{% list tabs %}

- {{ TF }}

   See [How to create an infrastructure using {{ TF }}](#terraform).

{% endlist %}

## Check that the website is running {#test-site}

To check that the website is running, use one of the standard {{ objstorage-name }} addresses:

* `http://www.example.com.{{ s3-web-host }}`
* `http://{{ s3-web-host }}/www.example.com`

If you configured your own domain, use `http://www.example.com`.

## How to delete the resources you created {#clear-out}

To stop paying for the resources:

* [Delete the uploaded files](../../storage/operations/objects/delete.md).
* [Delete a DNS zone](../../dns/operations/zone-delete.md).

## How to create an infrastructure using {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

To host a static website in {{ objstorage-name }} using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), step 1).
1. Prepare files with the infrastructure description:

   {% list tabs %}

   - Ready-made archive

      1. Create a directory for files:
      1. Download the [archive](https://{{ s3-storage-host }}/doc-files/static.zip) (2 KB).
      1. Unpack the archive to the directory. Now, the directory should include the `static.tf` configuration file, as well as the files `index.html` and `error.html`.

   - Creating files manually

      1. Create a directory for files:
      1. Create the `static.tf` configuration file in the directory:

         {% cut "static.tf" %}

         {% include [static-tf-config](../../_includes/web/static-tf-config.md) %}

         {% endcut %}

      1. In the directory, create an `index.html` file with the text `Hello world!`:

         {% cut "index.html" %}

         {% include [static-tf-config](../../_includes/web/index-html-config.md) %}

         {% endcut %}

      1. In the directory, create an `error.html` file with the text `Error!`:

         {% cut "error.html" %}

         {% include [static-tf-config](../../_includes/web/index-html-config.md) %}

         {% endcut %}

   {% endlist %}

   For more information about the parameters of resources used in {{ TF }}, see the provider documentation:

   * [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account)
   * [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member)
   * [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key)
   * [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket)
   * [yandex_dns_zone]({{ tf-provider-resources-link }}/dns_zone)
   * [yandex_dns_recordset]({{ tf-provider-resources-link }}/dns_recordset)

1. In the `static.tf` file, paste the following values in the `locals` section:

   * `token`: An [OAuth token](../../iam/concepts/authorization/oauth-token.md) (if you're using a [Yandex account](../../iam/concepts/index.md#passport)) or [IAM token](../../iam/concepts/authorization/iam-token.md) (if you're using a Yandex account or [federated account](../../iam/concepts/index.md#saml-federation)) to access {{ yandex-cloud }}. The IAM token is valid for up to 12 hours but can't exceed the federation's cookie lifetime. 
   * `cloud_id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) to create resources in.
   * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create resources in.

1. Create resources:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Check that the website is running](#test-site).