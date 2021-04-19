# Getting started with the Marketplace partner interface

You can use the Marketplace partner interface to add images of your products to the Marketplace and manage their versions and pricing. Register in the Marketplace partner interface and upload your first image following the instructions.

## Registration {#registration}

Open the [Marketplace](https://cloud.yandex.com/marketplace) page and fill out an application to add your product to the Marketplace. In the text, specify the [billing account](../billing/concepts/billing-account.md) of the business that will publish the product. By submitting an application, you accept the [Offer](https://yandex.ru/legal/marketplace_offer/?lang=en) on Software Product Access on the Marketplace.

Once {{ yandex-cloud }} verifies your application, the specified billing account gets a Yandex Cloud Marketplace partner status and access to the [partner interface](https://partners.cloud.yandex.ru/). You'll recieve an email notification when this happens.

## Create a rate {#create-tariff}

{% note warning %}

{{ yandex-cloud }} charges a commission of 20% of the cost to use an image.

{% endnote %}

The rate determines the cost to use your products. Create a new rate to assign it to the product:

{% include [new-tariff](_includes_service/new-tariff.md) %}

## Upload an image {#upload-image}

To create a product, you need to [upload a VM image to {{ yandex-cloud }}](../compute/operations/image-create/upload.md).

## Create a product {#create-product}

Fill in the information about your product to be displayed in the Marketplace catalog:

{% include [new-product-desc](_includes_service/new-product-desc.md) %}

## Upload the first version of the product {#first-version}

Upload the first version of your product and set a rate for using it:

{% include [new-product-version](_includes_service/new-product-version.md) %}

The product's first version will be sent for moderation to {{ yandex-cloud }}. After it passes verification, you'll receive an email confirming that your product is available to users in the Marketplace public catalog.

