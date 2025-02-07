---
title: Integrating {{ certificate-manager-full-name }} with {{ yandex-cloud }} services
description: In this tutorial, you will learn which {{ yandex-cloud }} services support {{ certificate-manager-name }} certificates.
---

# Integration with {{ yandex-cloud }} services


You can use {{ certificate-manager-name }} certificates in the following {{ yandex-cloud }} services:
* [{{ objstorage-full-name }}](#os).
* [{{ alb-full-name }}](#alb).
* [{{ api-gw-full-name }}](#api-gw).
* [{{ cdn-full-name }}](#cdn).

You can also store a user certificate's private key as a [{{ lockbox-full-name }}](#lockbox) secret using {{ TF }}.

## {{ objstorage-full-name }} {#os}

If using a bucket to host a static website, use a {{ certificate-manager-name }} [certificate](../../storage/operations/hosting/certificate.md#cert-manager) to access the website over `HTTPS`. When you change a certificate in {{ certificate-manager-name }}, it updates automatically in all the buckets that use it.

{% note warning %}

* `HTTPS` access to the bucket becomes available within thirty minutes of selecting a certificate.
* Certificate updates may take another thirty minutes to apply.

{% endnote %}

## {{ alb-full-name }} {#alb}

[{{ alb-name }}](../../application-load-balancer/index.yaml) can handle TLS traffic: establish connections and terminate TLS sessions using certificates added to {{ certificate-manager-name }}. Certificates from {{ certificate-manager-name }} can be used in [L7 load balancer](../../application-load-balancer/operations/application-load-balancer-create.md) listeners.

## {{ api-gw-full-name }} {#api-gw}

{{ api-gw-full-name }} allows you to merge multiple microservices into a single product. Microservices can be run on VMs and containers or implemented as functions. You can use the domain to access the API.

A certificate linked to the domain is used to provide a TLS connection.

## {{ cdn-full-name }} {#cdn}

{{ cdn-full-name }} allows you to set up content delivery to your end users via a content delivery network (CDN). 

To access [CDN resources](../../cdn/concepts/resource.md) over HTTPS, you can [use](../../storage/operations/hosting/certificate.md#cert-manager) certificates from {{ certificate-manager-name }}.

## {{ lockbox-full-name }} {#lockbox}

You can store a {{ certificate-manager-name }} user certificate's private key in {{ lockbox-name }} [using {{ TF }}](../operations/import/cert-create.md#create-lockbox).

#### See also {#see-also}

* [Static website in {{ objstorage-name }}](../../tutorials/web/static/index.md)
* [{{ api-gw-full-name }}](../../api-gateway/)