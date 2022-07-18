# Static website in {{ objstorage-full-name }}

In this guide, you'll learn how to upload your the static HTML files of your website to [{{ objstorage-full-name }}](../../storage) storage and link your domain name to a [bucket](../../storage/concepts/bucket.md) that will store the files.

To host a static website in Object Storage:

1. [Before you start](#before-you-begin).
1. [Create a bucket with public access](#create-public-bucket).
1. [Configure the website homepage and error page](#index-and-error).
1. [Set up using your own domain](#connect-your-domain).
1. [Upload the website files](#upload-files).
1. [Check that the website is running](#test-site).

If you no longer need the website, [delete its files from storage](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}



### Required paid resources {#paid-resources}

The cost of hosting a static website includes:

* A fee for storing static website data (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-storage)).
* A fee for data operations (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-operations)).
* The cost of outgoing traffic from {{ yandex-cloud }} to the internet (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md#prices-traffic)).


## Create a public bucket {#create-public-bucket}

To create a bucket for static website files:

1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you want to perform the operations.

1. On the folder page, click **Create resource** and select **Bucket**.

1. In the **Name** field, enter a name for the bucket (for instance, `www.example.com`). The bucket name will be used in the website domain name: `https://www.example.com.{{ s3-web-host }}`.

   The name must meet the following requirements:

   {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

   {% note info %}

   If you plan to use your own domain for the website, the bucket name must exactly match the name of your domain, and this must be a third-level or higher domain.

   {% endnote %}

1. Specify the maximum size of the bucket in GB.

1. Choose **Public** access to the bucket.

1. Click **Create bucket**.

## Configure the website homepage and error page {#index-and-error}

You should upload and configure the index page and error page. To do this:

1. Create the following files on your computer:
   * `index.html` with the text `Hello world!`.
The file content gets displayed when accessing the home page of the website.
   * `error.html` with the text `Error!`.
The file content appears in website responses with `4xx` errors.
1. Go to your bucket's page, open the **Objects** tab, and click **Upload**. In the window that opens, select the created files and click the confirmation button.
1. Click **Upload**.
1. Open the **Website** tab on your bucket page.
1. Select **Hosting**.
1. In the **Home page** field, specify `index.html`.
1. In the **Error page** field, specify `error.html`.
1. Click **Save**.
1. Make sure the website's home page opens. To do this, access the website from a browser via a link like `https://{bucket-name}.{{ s3-web-host }}`.
1. Make sure the error page opens. To do this, access the website from a browser via a link like `https://{bucket-name}.{{ s3-web-host }}/error-check`.

## Set up using your own domain {#connect-your-domain}

To use your own domain for a website:

- Make sure the bucket name is exactly the same as the domain name. This must be a third-level or higher domain (for example, `www.example.com`).
- Create a CNAME (Canonical Name) record at your DNS provider or on your own DNS server.

{% note info %}

By default, the website is accessible only over HTTP, for instance, `http://www.example.com` or `http://www.example.com.{{ s3-web-host }}`. To provide HTTPS support for your website, [upload your own security certificate](../../storage/operations/hosting/certificate.md) to {{ objstorage-name }}.

{% endnote %}

The instructions below describe how to configure an external DNS service using [reg.com](https://www.reg.com/) for the `www.example.com.{{ s3-web-host }}` and `www.example.com` domain names:

1. Find the website address on the **Website** tab of the bucket page in the [management console]({{ link-console-main }}).
1. Log in to the control panel of the external DNS service. Go to the [list of your domains](https://www.reg.com/user/domain_list) and click on the required domain name.
1. Follow the **Zone management** link in the **Domain management** section.
1. Create a CNAME record with the following field values:
   * **Subdomain**: `www`.
   * **Canonical name**: Website address with a dot at the end (for instance, `www.example.com.{{ s3-web-host }}.`.
1. Wait 15-20 minutes for DNS record changes to take effect. The waiting time may differ for your DNS service.

## Upload the website files {#upload-files}

After you configure and test the website's availability, upload the remaining files that are necessary for website operation. To do this, use the [management console]({{ link-console-main }}), [API](../../storage/s3/api-ref/object/upload.md), or one of the available [tools for working with {{ objstorage-name }}](../../storage/tools/).

## Check that the website is running {#test-site}

To make sure the website is running, open the following address in your browser:

* `http://www.example.com.{{ s3-web-host }}`
* `http://{{ s3-web-host }}/www.example.com`

## How to delete created resources {#clear-out}

To stop paying for file storage, [delete](../../storage/operations/objects/delete.md) the uploaded files.
