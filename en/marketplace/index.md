# Placing your product in {{ marketplace-full-name }}

{{ marketplace-name }} allows you to add your products to the catalog of ready-to-use {{ yandex-cloud }} solutions and earn a profit from them. There is a variety of categories for you to choose from:
* Pre-configured images for {{ compute-full-name }}.
* Applications for {{ managed-k8s-name }}.
* Solutions for {{ datalens-full-name }}.

## Submit an application {#send-application}

To become a {{ marketplace-short-name }} partner, fill out the form on the [Marketplace page](/marketplace) and describe your product. Provide some details on your product features and how it works, so that we could review your application faster. By submitting your application, you accept the [Offer](https://yandex.ru/legal/marketplace_offer/?lang=en) for Software Product Access on {{ marketplace-short-name }}. If your business already has a billing account, list it in your application.

Once the moderation is complete, you will receive a confirmation email to the address you specified in your application.

## Register an account {#registration}

To access the {{ marketplace-short-name }} partner account, you need the billing account of a business that is a resident of Russia or Kazakhstan. If you do not have a billing account yet, [create one](operations/registration.md).

{% include [billing-note](../_includes/marketplace/billing-note.md) %}

## Create a product in the partner interface {#create-product}

[Create a product](operations/create-product.md). Everything else happens after your application is approved. You can add details to your application and contact a {{ marketplace-short-name }} manager under **Application ticket**.

## Create a service plan {#create-tariff}

{% include [tariff-note](../_includes/marketplace/tariff-note.md) %}

The service plan determines the cost of running your product.

Create a [service plan](operations/create-tariff.md) to assign it to your product version.

## Create and upload a VM image or packages for {{ managed-k8s-name }} {#create-image}

In {{ marketplace-short-name }}, you can place VM images from {{ yandex-cloud }} public images and packages for {{ managed-k8s-name }}. Requirements for images and applications and recommendations for creating them are described in the sections:
* [{#T}](operations/create-image.md)
* [{#T}](operations/create-container.md)

## Create the first version of the product {#create-version}

For more information on creating the first version of a product in a {{ marketplace-name }} partner account, see [{#T}](operations/create-new-version.md).