---
title: Getting started with {{ cdn-full-name }}
description: Follow this guide to use {{ cdn-full-name }} to create and set up a CDN resource with an {{ objstorage-full-name }} bucket as the origin.
---

# Creating a CDN resource with an {{ objstorage-full-name }} origin bucket

{% include [create-other-resources](../../_includes/cdn/create-other-resources-note.md) %}

Set up content distribution over a CDN with an {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md) as the origin:

1. [Create a CDN resource](#create-cdn-resource).
1. [Configure a CNAME for your domain](#setup-cname).
1. [Test the CDN](#check-cdn-working).

## Getting started {#before-you-begin}

1. Make sure you have a domain name and can access the DNS settings on your DNS hosting provider’s website. This is usually the company that registered your domain.
1. Navigate to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.
1. If you do not have a folder yet, [create](../../resource-manager/operations/folder/create.md) one.

    {% cut "Learn more about creating a folder" %}

    {% include [create-folder](../../_includes/create-folder.md) %}

    {% endcut %}

1. If you do not have an {{ objstorage-name }} bucket yet:

   1. [Create a bucket](../../storage/operations/buckets/create.md).
   1. [Enable public access](../../storage/operations/buckets/bucket-availability.md) to the objects in the bucket and the object list.
   1. [Upload your content](../../storage/operations/objects/upload.md) to the bucket.
      
## Create a CDN resource {#create-cdn-resource}

1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
1. In the ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.cdn.label_resources-list }}** tab, click **{{ ui-key.yacloud.cdn.button_resource-create }}**.
1. Under **{{ ui-key.yacloud.cdn.value_stepper-main-settings }}**, configure the basic CDN resource settings:
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
      * In the **{{ ui-key.yacloud.cdn.label_custom-host-header }}** field, specify the domain name from the [bucket URL](../../storage/concepts/bucket.md#bucket-url) in `<bucket_name>.{{ s3-storage-host }}` format, omitting the schema (`http` or `https`), e.g.,

         ```
         my-bucket.{{ s3-storage-host }}
         ```

         {% note warning %}

         If the `Host` header is misconfigured, {{ objstorage-name }} will return errors in response to CDN server requests.

         {% endnote %}

1. Click **{{ ui-key.yacloud.common.continue }}**.
1. Under **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}**, and **Advanced**, leave the default settings, then click **Continue**. You can configure these settings later, if required.

{% include [create-resource-time](../../_includes/cdn/create-resource-time.md) %}

{% include [content-prefetch-quickstart-tip](../../_includes/cdn/content-prefetch-quickstart-tip.md) %}

## Configure a CNAME for your domain {#setup-cname}

{% include [quickstart-setup-resource-cname](../../_includes/cdn/quickstart-setup-resource-cname.md) %}

## Test the CDN {#check-cdn-working}

{% include [quickstart-check-cdn-working](../../_includes/cdn/quickstart-check-cdn-working.md) %}

#### See also {#see-also}

* [{#T}](./server.md)
* [{#T}](../concepts/index.md)
* [{#T}](../../storage/operations/buckets/create.md)