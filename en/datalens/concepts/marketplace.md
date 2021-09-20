# Marketplace

{{ datalens-short-name }} Marketplace is a platform that contains ready-made solutions and extensions for {{ datalens-short-name }}. These solutions and extensions are called _products_. They enhance the {{ datalens-short-name }} functionality and let you add more datasets.

{% note info %}

{{ datalens-short-name }} Marketplace is available on a [special page in {{ datalens-short-name }}](https://datalens.yandex.com/marketplace/) and on the [Yandex {{ marketplace-name }}](https://cloud.yandex.com/marketplace?type=datalens) page (**Data analysis** tab).

{% endnote %}

## Product {#product}

_A product_ is an object prepared for running in {{ datalens-short-name }}. Products may contain drivers for new connections, data for analysis, and templates for charts and dashboards.

Products are provided by _publishers_. Marketplace publishers are companies (for example, Yandex). Publishers place their products in the Marketplace and assign [pricing plans](#pricing) for them. Publishers can also update and upgrade their products.

{% note warning %}

Publishers can restrict uploading of CSV data for their products in the Marketplace.

{% endnote %}

### Product categories {#product-types}

There are the following product categories in {{ datalens-short-name }} Marketplace:

* **Datasets**: Sets of data with pre-configured dashboards. You can use them to create your own charts and dashboards, and enrich your data.

* **Geolayers**: Datasets linked to location (regions, cities, districts, and smaller areas inside cities). You can use geolayers to create different [maps](chart/types.md#map-chart) and add them to dashboards.

* **Connectors**: Additional types of connections. They let you create connections to external systems not supported in {{ datalens-short-name }} by default.

* **Templates**: The dashboard templates that you can use with your data. To do this, replace the connection used for the template.

### Billing {#pricing}

There are two types of pricing policies for products from Marketplace, each with their own specifics:

* **Free-of-charge** (_Free_). The product is free of charge.
    * Any user of an {{ datalens-short-name }} instance can connect such a product.
    * You can access the data even after you cancel your subscription.

* **Subscription-based** (_Monthly_). The product fee is charged monthly.
    * Only a user with the role [datalens.instances.admin](../security/index.md#users-roles) can connect a subscription-based product.
    * The product fee is debited on the connection date.
    * Product subscription is automatically renewed: funds are debited on the same day of the following months.

        > For example, if you connected the product on May 2, the next charge will be on June 2.
    * For some products, you can pay the subscription partially (only for the data you need).
    * If you cancel your subscription, you can no longer access the data after the paid period ends.

        > For example, if you paid for a product on May 15 and canceled the subscription on May 26, the product will be available to you until June 15.

#### Partial fee calculation example {#pricing-example}

As an example, let's say you bought a data subscription for one city (Moscow) and then added another city (Saint Petersburg). After that, you decided to cancel your subscription for one of the cities (Moscow). In this case, the following will happen:

| Date | Event |
| ---- | ----- |
| **3.10.2020** | You purchased the data for Moscow. {{ datalens-short-name }} debits the applicable amount right away. The next payment date is **3.11.2020**. |
| **5.10.2020** | You purchased the data for Saint Petersburg. {{ datalens-short-name }} debits the applicable amount right away. The next payment date is **5.11.2020**. |
| **15.10.2020** | You canceled the subscription for the Moscow data. {{ datalens-short-name }} considers this data as paid, so you can access the data until **3.11.2020**. |
| **3.11.2020** | {{ datalens-short-name }} will not renew your subscription for the Moscow data. The data for this city will no longer be available to you. |
| **5.11.2020** | {{ datalens-short-name }} will renew your subscription for the Saint Petersburg data and debit the applicable amount right away. |

### Adding a product from Marketplace {#how-to-add-a-marketplace-product}

Any user of an {{ datalens-short-name }} instance can add a free product. Only a user with the role [datalens.instances.admin](../security/index.md#users-roles) can add a subscription-based product.

You can add a geolayer, dataset, connector, or template:

{% list tabs %}

- Geolayer
  1. On the {{ datalens-full-name }} home page, in the left menu select **Marketplace**.
  1. In the right menu under **Category**, select **Geolayers**.
  1. Select the product that you want to add. For example, choose the free geolayer [Companies: supply and demand](https://datalens.yandex.com/marketplace/f2e0alcha1ta8ocrn99f).
  1. In the product description window that opens, click **Connect**.
  1. Enter the path to save the product to and click **Save**. The product you added will be displayed on the [navigation page](https://datalens.yandex.com/navigation/).

- Datasets
  1. On the {{ datalens-full-name }} home page, in the left menu select **Marketplace**.
  1. In the right menu under **Category**, select **Datasets**.
  1. Select the product that you want to add. For example, choose the free dataset [Sample Superstore](https://datalens.yandex.com/marketplace/f2e0000r63qkp2ywqpco).
  1. In the description window that opens, click **Connect**.
  1. Enter the path to save the product to and click **Save**. The product you added will be displayed on the [navigation page](https://datalens.yandex.com/navigation/). You can use the dataset to create your own charts.

- Connector

  1. On the {{ datalens-full-name }} home page, in the left menu select **Marketplace**.

  1. In the right menu under **Category**, select **Connectors**.

  1. Select the product that you want to add. For example, the free connector [DashboardConnector](https://datalens.yandex.com/marketplace/f2euv3r73pln2g18nckh).

  1. In the description window that opens, click **Connect**.

  1. Confirm the purchase if necessary. After confirmation, you will be directed to the page where you can create a connection based on this connector.

      {% note info %}

      You can create a connection later using the **Deploy** button on the product page.

      {% endnote %}

  1. Create a connection based on the connector. After you create the connection, follow the instructions provided by the connector's publisher.

- Template
  1. On the {{ datalens-full-name }} home page, in the left menu select **Marketplace**.
  1. In the right menu under **Category**, select **Templates**.
  1. Select the product that you want to add. For example, choose the free template [Metrica Live Demo](https://datalens.yandex.com/marketplace/f2e5hpq5mc7bscsjc6jr).
  1. In the description window that opens, click **Connect**. The field appears in the list of fields. You can use it as your chart's data source.
  1. Enter the path to save the product to and click **Save**. The product you added will be displayed on the [navigation page](https://datalens.yandex.com/navigation/). Now you can go to the template's connection settings and edit them.

{% endlist %}

### Removing a product added earlier from the Marketplace {#how-to-delete-a-marketplace-product}

You can cancel your subscription for a Marketplace product:

1. On the {{ datalens-full-name }} home page, in the left menu select **Marketplace**.

1. Select the product you want to cancel your subscription for.

    {% note tip %}

    You can filter the products you purchased: under **Category**, select **Purchases**.

    {% endnote %}

1. On the product page, next to the **Deploy** button, click ![image](../../_assets/datalens/horizontal-ellipsis.svg) and select **Reject**.

1. Click **Confirm**. Your subscription for the product is canceled now.

