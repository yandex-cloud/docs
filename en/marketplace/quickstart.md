---
title: Placing your product on {{ marketplace-full-name }}
description: Follow this guide to place your product on {{ marketplace-full-name }}.
---

# Placing your product on {{ marketplace-full-name }}

{{ marketplace-name }} allows you to add your products to the catalog of ready-to-use {{ yandex-cloud }} solutions and earn a profit from them. There is a variety of categories for you to choose from:
* Pre-configured images for {{ compute-full-name }}
* Applications for {{ managed-k8s-name }}
* Solutions for {{ datalens-full-name }}

## Submit an application {#send-application}

To become a {{ marketplace-short-name }} partner, fill out the form on the [Marketplace page](/marketplace) and describe your product. A detailed description of useful product functions and features will help us review your application faster. By submitting the request, you accept the Offer for Software Product Access on {{ marketplace-short-name }}:
* [Offer for partners making payments to {{ yandex-cloud }} in RUB](https://yandex.ru/legal/marketplace_offer/?lang=en)
* [Offer for partners making payments to {{ yandex-cloud }} in KZT](https://yandex.com/legal/marketplace_offer_kz/?lang=en)

If your business already has a billing account, list it in your application. Once the moderation is complete, you will receive a confirmation email to the address you specified in your application.

## Register an account {#registration}

To access the {{ marketplace-short-name }} partner dashboard, you need the billing account of a business that is a resident of Russia or Kazakhstan. If you do not have a billing account yet, [create one](operations/registration.md).

{% include [billing-note](../_includes/marketplace/billing-note.md) %}

The billing account details will be used for access to the [partner dashboard]({{ link-cloud-partners }}).

## Create a product in the partner dashboard {#create-product}

[Create a product](operations/create-product.md). Further actions will be available after your application is approved. You can add details to your application and contact a {{ marketplace-short-name }} manager under **{{ ui-key.yacloud_portal.marketplace_v2.common.menu_ticket }}**.

## Create a service plan {#create-tariff}

{% include [tariff-note](../_includes/marketplace/tariff-note.md) %}

The service plan determines the cost of running your product.

Create a [service plan](operations/create-tariff.md) to assign it to your product version.

## Create and upload a product {#create-image}

In {{ marketplace-short-name }}, you can place VM images from {{ yandex-cloud }} public images and packages for {{ managed-k8s-name }}. Make sure you read through the image and app requirements and recommendations:

* [{#T}](operations/create-image.md)
* [{#T}](operations/create-container.md)

## Create the first version of the product {#create-version}

For more information on creating the first version of the product in the {{ marketplace-name }} partner dashboard, see [{#T}](operations/create-new-version.md).

## Submit you version for moderation {#moderate-version}

All product versions listed in {{ marketplace-short-name }} undergo technical and content moderation to ensure they meet the {{ marketplace-short-name }} product requirements for [{{ compute-name }}](operations/create-image.md) and [{{ managed-k8s-name }}](operations/create-container.md). Once the moderation process is successfully completed, you will receive a notification and can start offering your product version to users.