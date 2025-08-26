---
title: Getting started with {{ cdn-full-name }}
description: Follow this guide to create and set up a CDN resource.
---

# Getting started with {{ cdn-full-name }}

Use an {{ objstorage-name }} bucket to demonstrate how to set up content delivery over a CDN:

1. [Create a CDN resource](#create-cdn-resource).
1. [Upload your content to the CDN](#upload-content-to-CDN).
1. [Set up a CNAME record for your domain](#setup-cname).
1. [Test the CDN](#check-cdn-working).

## Getting started {#before-you-begin}

1. Make sure you have a domain name and can access the DNS settings on your DNS hosting provider’s website. This is typically your domain registrar.
1. Navigate to the [management console]({{ link-console-main }}) and either log in to {{ yandex-cloud }} or sign up if you do not have an account yet.
1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. If you do not have an {{ objstorage-name }} bucket yet:

   1. [Create a bucket](../storage/operations/buckets/create.md).
   1. [Enable public access](../storage/operations/buckets/bucket-availability.md) to the objects in the bucket and the object list.
   1. [Upload your content](../storage/operations/objects/upload.md) to the bucket.

## Create a CDN resource {#create-cdn-resource}

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
1. In the ![image](../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.cdn.label_resources-list }}** tab, click **{{ ui-key.yacloud.cdn.button_resource-create }}**.
1. Configure the basic CDN resource settings:
   * Under **{{ ui-key.yacloud.cdn.label_section-content }}**:
      * Enable **{{ ui-key.yacloud.cdn.label_access }}**.
      * In the **{{ ui-key.yacloud.cdn.label_content-query-type }}** field, select `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`.
      * In the **{{ ui-key.yacloud.cdn.label_source-type }}** field, select `{{ ui-key.yacloud.cdn.value_source-type-bucket }}`.
      * In the **{{ ui-key.yacloud.cdn.label_bucket }}** field, select the bucket you created in {{ objstorage-name }}.
      * In the **{{ ui-key.yacloud.cdn.label_protocol }}** field, select `{{ ui-key.yacloud.common.label_http }}`.
      * In the **{{ ui-key.yacloud.cdn.label_personal-domain }}** field, specify the primary domain name you will use in your website links to CDN-hosted content, e.g., `cdn.example.com`.

         {% note alert %}

         You cannot change the primary domain name used for content distribution after creating a CDN resource.

         {% endnote %}

   * Under **{{ ui-key.yacloud.cdn.label_section-additional }}**:
      * In the **{{ ui-key.yacloud.cdn.label_redirect }}** field, select `{{ ui-key.yacloud.cdn.value_do-not-use }}`.
      * In the **{{ ui-key.yacloud.cdn.label_certificate-type }}** field, select `{{ ui-key.yacloud.cdn.value_certificate-no }}`.
      * In the **{{ ui-key.yacloud.cdn.label_host-header }}** field, select `{{ ui-key.yacloud.cdn.value_host-header-custom }}`.
      * In the **{{ ui-key.yacloud.cdn.label_custom-host-header }}** field, specify the domain name from the [bucket URL](../storage/concepts/bucket.md#bucket-url) in `<bucket_name>.{{ s3-storage-host }}` format, omitting the schema (`http` or `https`). Here is an example:

         ```
         my-bucket.{{ s3-storage-host }}
         ```

         {% note warning %}

         If the `Host` header is misconfigured, {{ objstorage-name }} will return errors in response to CDN server requests.

         {% endnote %}

1. Click **{{ ui-key.yacloud.common.continue }}**.
1. Under **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}**, and **Advanced**, leave the default settings. Click **Continue**.

   {% note tip %}

   You can configure these settings later, if required.

   {% endnote %}

## Upload your content to the CDN {#upload-content-to-CDN}

{% note tip %}

We recommend preloading large content to the CDN, e.g., files larger than 200 MB. This is an optional step. If skipped, the CDN will load the content automatically when a user tries to access it for the first time.

{% endnote %}

To prefetch content to CDN servers:

1. On the CDN resource page, navigate to the ![image](../_assets/console-icons/box.svg) **{{ ui-key.yacloud.cdn.label_resource-content }}** tab.
1. In the top-right corner, click ![image](../_assets/console-icons/ellipsis.svg) and select ![image](../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.cdn.button_resource-content-prefetch-cache }}**.
1. In the **{{ ui-key.yacloud.cdn.label_resource-content-prefetch-cache-paths }}** field, enter the names of the files stored in the bucket, omitting the bucket name. See an example below:

    ```text
    /index.html
    /static/styles.css
    /static/app.js
    ```

1. Click **{{ ui-key.yacloud.cdn.button_resource-content-prefetch-cache }}**.


## Set up a CNAME record for your domain {#setup-cname}

1. In the ![image](../_assets/console-icons/flag.svg) **{{ ui-key.yacloud.common.overview }}** tab on the CDN resource page, under **{{ ui-key.yacloud.cdn.label_dns-settings_title }}**, copy the generated domain name in `{{ cname-example-yc }}` format.
1. Navigate to your domain’s DNS settings on your DNS hosting provider’s website.
1. Edit the relevant CNAME record so that it points to the previously copied URL in the `.yccdn.cloud.yandex.net` domain. For example, if the domain name you specified when creating your CDN resource is `cdn.example.com`, you need to create the following CNAME record or use it to replace the current record for `cdn`:

    ```http
    cdn CNAME {{ cname-example-yc }}.
    ```

    {% include [note-dns-aname](../_includes/cdn/note-dns-aname.md) %}

## Test the CDN {#check-cdn-working}

1. Wait for the DNS records to update. This may take several hours.
1. Make sure the `cdn` CNAME record in the DNS server's cache points to the generated URL, e.g., `{{ cname-example-yc }}`.
1. Open the website in your browser to make sure it is working. Here is an example:

    ```http
    http://cdn.example.com/index.html
    ```
