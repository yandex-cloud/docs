# Marketplace

The {{ datalens-short-name }} Marketplace is a platform that includes ready-made solutions and extensions for {{ datalens-short-name }}. These solutions and extensions are called _products._ They enhance the {{ datalens-short-name }} functionality and let you add more datasets.

{% note info %}

{{ datalens-short-name }} {{ marketplace-short-name }} is available at a [special page in {{ datalens-short-name }}](https://datalens.yandex.com/marketplace/) and the [Yandex {{ marketplace-name }}](https://cloud.yandex.com/marketplace?tab=datalens) page under the **Data analysis** tab.

{% endnote %}

## Product {#product}

A _product_ is an object prepared for running in {{ datalens-short-name }}. Products may contain drivers for new [connections](connection.md), data for analysis as well as various [chart](chart/index.md) and [dashboard](dashboard.md) templates.

Products are provided by _publishers_. {{ marketplace-short-name }} publishers are companies (such as, Yandex). Publishers post their products to the {{ marketplace-short-name }} and set a [price](#pricing)for them. Publishers can also update and upgrade their products.

{% note warning %}

Publishers may restrict CSV data export for a {{ marketplace-short-name }} product.

{% endnote %}

You can access {{ marketplace-short-name }} products as:

* User able to add existing products to or remove such products from your {{ datalens-short-name }} instance.
* Publisher ({{ datalens-short-name }} partner) able to offer a new product if you are a legal entity.

### Product categories {#product-types}

{{ datalens-short-name }} {{ marketplace-short-name }} contains products in the following categories:

* **Datasets**: Sets of data with pre-configured dashboards. You can use them to create your own charts and dashboards, and enrich your data.

* **Geo layers**: Datasets linked to location (regions, cities, districts, and smaller areas inside cities). You can use these to create various [maps](../visualization-ref/map-chart.md) to add to dashboards.

* **Connectors**: Additional types of connections. They let you create connections to external systems not supported in {{ datalens-short-name }} by default.

* **Templates**: The dashboard templates that you can use with your data. To do this, replace the connection used for the template.

If you are a publisher and wish to offer a new product for the following categories:
* Datasets, Geo layers, or Templates: on the [{{ marketplace-short-name }}](https://cloud.yandex.com/marketplace?tab=datalens) home page, click **Offer product** and complete an application.
* Connectors: go to the instructions [{#T}](../operations/marketplace/create-connector-for-partners.md).

### Pricing {#pricing}

There are two types of pricing policy for {{ marketplace-short-name }} products:

* **Free-of-charge **(_Free_). The product is free of charge.
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

#### Partial calculation example {#pricing-example}

As an example, let's say you bought a data subscription for one city (Moscow) and then added another city (Saint Petersburg). After that, you decided to cancel your subscription for one of the cities (Moscow). In this case, the following will happen:

| Date | Event |
---- | -----
| **3.10.2020** | You purchased the data for Moscow. {{ datalens-short-name }} debits the applicable amount right away. The next payment date is ** 3.11.2020**. |
| **5.10.2020** | You purchased the data for Saint Petersburg. {{ datalens-short-name }} debits the applicable amount right away. The next payment date is **5.11.2020**. |
| **15.10.2020** | You canceled the subscription for the Moscow data. {{ datalens-short-name }} considers this data as paid, so you can access the data until **3.11.2020**. |
| **3.11.2020** | {{ datalens-short-name }} will not renew your subscription to Moscow data. The data for this city will no longer be available to you. |
| **5.11.2020** | {{ datalens-short-name }} will renew your subscription to Saint Petersburg data and debit the applicable amount right away. |

### Adding a product from {{ marketplace-short-name }} {#how-to-add-a-marketplace-product}

{% include [name-format](../../_includes/datalens/operations/datalens-add-marketplace-product.md) %}

### Deleting a product from previously added {{ marketplace-short-name }} {#how-to-delete-a-marketplace-product}

{% include [name-format](../../_includes/datalens/operations/datalens-delete-marketplace-product.md) %}