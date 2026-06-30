---
title: Getting started with {{ cdn-full-name }}
description: Follow this guide to use {{ cdn-full-name }} to create and set up a CDN resource with a {{ compute-full-name }} VM instance or {{ baremetal-full-name }} server as the origin.
---

# Creating a CDN resource with an origin server in {{ yandex-cloud }}



{% include [pricing-change-short-warning](../../_includes/cdn/pricing-change-short-warning.md) %}


{% include [create-other-resources](../../_includes/cdn/create-other-resources-note.md) %}

Set up content distribution over a CDN with a {{ compute-full-name }} [VM instance](../../compute/concepts/vm.md) or {{ baremetal-full-name }} [server](../../baremetal/concepts/servers.md) as the origin:

1. [Create a web server](#create-server).
1. [Create a CDN resource](#create-cdn-resource).
1. [Configure a CNAME for your domain](#setup-cname).
1. [Test the CDN](#check-cdn-working).

## Getting started {#before-you-begin}

1. Make sure you have a domain name and can access the DNS settings on your DNS hosting provider’s website. This is usually the company that registered your domain.
1. Navigate to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }}, or sign up if you have not already.
1. If you do not have a folder yet, [create](../../resource-manager/operations/folder/create.md) one.

    {% cut "Learn more about creating a folder" %}

    {% include [create-folder](../../_includes/create-folder.md) %}

    {% endcut %}

## Create a web server {#create-server}

If you do not have a web server yet:

1. [Create](../../compute/operations/vm-create/create-linux-vm.md) a {{ compute-name }} instance or [rent](../../baremetal/operations/servers/server-lease.md) a {{ baremetal-name }} server.
1. Install a web server on the new server or VM instance, e.g., [Apache](https://httpd.apache.org/) or [nginx](https://nginx.org/).

    When installing the web server on a VM instance, remember to associate it with a [security group](../../vpc/concepts/security-groups.md) that allows incoming and outgoing network traffic on the appropriate ports, e.g., `80` and `443`. To learn more about creating security groups, see [{#T}](../../vpc/operations/security-group-create.md).
1. Upload content to your web server.
1. Make sure your web server is available from the internet.

    To check the availability of a web server created on a {{ compute-name }} VM instance or {{ baremetal-name }} server, enter the [public IP address](../../vpc/concepts/address.md#public-addresses) of the instance or server in the address bar, for example:

    ```text
    http://198.51.100.27/
    ```

    As a result, you should see the main page of the application deployed on the server in your browser window.

Learn more about creating a website based on a {{ compute-name }} VM instance [here](../../tutorials/web/lamp-lemp/index.md).

## Create a CDN resource {#create-cdn-resource}

<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplva6365yoayxar6ore?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
1. In the ![image](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.cdn.label_resources-list }}** tab, click **{{ ui-key.yacloud.cdn.button_resource-create }}**.
1. Under **{{ ui-key.yacloud.cdn.value_stepper-main-settings }}**, configure the basic CDN resource settings:
    * Under **{{ ui-key.yacloud.cdn.label_section-content }}**:
        * Enable **{{ ui-key.yacloud.cdn.label_access }}**.
        * In the **{{ ui-key.yacloud.cdn.label_content-query-type }}** field, select `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`.
        * In the **{{ ui-key.yacloud.cdn.label_source-type }}** field, select `{{ ui-key.yacloud.cdn.value_source-type-url }}`.
        * In the **{{ ui-key.yacloud.cdn.field_origin }}** field, specify the [public IP address](../../vpc/concepts/address.md#public-addresses) of your VM instance or {{ baremetal-name }} server with a web server.
        * In the **{{ ui-key.yacloud.cdn.label_protocol }}** field, select `{{ ui-key.yacloud.common.label_http }}`.
        * In the **{{ ui-key.yacloud.cdn.label_personal-domain }}** field, specify the primary domain name you will use in your website links to CDN-hosted content, e.g., `cdn.example.com`.

            {% note alert %}

            You cannot change the primary domain name used for content distribution after creating a CDN resource.

            {% endnote %}

    * Under **{{ ui-key.yacloud.cdn.label_section-additional }}**:
        * In the **{{ ui-key.yacloud.cdn.label_redirect }}** field, select `{{ ui-key.yacloud.cdn.value_do-not-use }}`.
        * In the **{{ ui-key.yacloud.cdn.label_certificate-type }}** field, select `{{ ui-key.yacloud.cdn.value_certificate-no }}`.
        * In the **{{ ui-key.yacloud.cdn.label_host-header }}** field, select `{{ ui-key.yacloud.cdn.value_host-header-default }}`.

            The **{{ ui-key.yacloud.cdn.label_host-header }}** field value must match the name of the virtual host configured on the origin server.

1. Click **{{ ui-key.yacloud.common.continue }}**.
1. Under **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}**, and **Advanced**, leave the default settings, then click **Continue**. You can configure these settings later, if required.
   
{% include [create-resource-time](../../_includes/cdn/create-resource-time.md) %}

{% include [content-prefetch-quickstart-tip](../../_includes/cdn/content-prefetch-quickstart-tip.md) %}

## Configure a CNAME for your domain {#setup-cname}

{% include [quickstart-setup-resource-cname](../../_includes/cdn/quickstart-setup-resource-cname.md) %}

## Test the CDN {#check-cdn-working}

{% include [quickstart-check-cdn-working](../../_includes/cdn/quickstart-check-cdn-working.md) %}

#### See also {#see-also}

* [{#T}](./bucket.md)
* [{#T}](../concepts/index.md)
* [Creating a VM from a public Linux image](../../compute/operations/vm-create/create-linux-vm.md)
* [Renting a stock-configuration {{ baremetal-name }} server](../../baremetal/operations/servers/server-lease.md)
* [Creating a website on the LAMP or LEMP stack](../../tutorials/web/lamp-lemp/index.md)
* [Configuring a web server](../tutorials/protected-access-to-content/console.md#setup-web-server)