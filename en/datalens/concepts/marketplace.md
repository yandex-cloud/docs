# Marketplace

{{ datalens-short-name }} {{ marketplace-short-name }} is a platform that contains ready-made solutions and extensions for {{ datalens-short-name }}. These solutions and extensions are called _products._ They enhance the {{ datalens-short-name }} features and allow you to add more datasets.

{% note info %}

{{ datalens-short-name }} {{ marketplace-short-name }} is available on a [separate {{ datalens-short-name }} page]({{ link-datalens-main }}/marketplace/) and the [Yandex {{ marketplace-name }}](/marketplace?tab=datalens) page in the **Data analysis** tab.

{% endnote %}

## Product {#product}

A _product_ is an object that is ready to run in {{ datalens-short-name }}. Products may contain drivers for new [connections](connection.md), data for analysis, as well as various [chart](chart/index.md) and [dashboard](dashboard.md) templates.

Products are provided by _publishers_. {{ marketplace-short-name }} publishers are companies, such as Yandex. Publishers place their products in {{ marketplace-short-name }}; they may also update and upgrade their products.

{% note warning %}

Publishers may restrict CSV data export for a {{ marketplace-short-name }} product.

{% endnote %}

You can access {{ marketplace-short-name }} products as:

* User: Add existing products to or remove such products from your {{ datalens-short-name }} instance.
* Publisher ({{ datalens-short-name }} partner): Offer a new product if you are a business.

### Product categories {#product-types}

{{ datalens-short-name }} {{ marketplace-short-name }} contains the following product categories:

* **Datasets**: Sets of data with pre-configured dashboards. You can use them to create your own charts and dashboards, and enrich your data.

* **Geo layers**: Datasets linked to locations (regions, cities, districts, and smaller areas inside cities). You can use these to create various [maps](../visualization-ref/map-chart.md) to add to dashboards.

* **Connectors**: Additional types of connections. They allow you to create connections to external systems that are not supported in {{ datalens-short-name }} by default.

* **Templates**: Dashboard templates that you can use with your data by replacing the connection used for the template.

If you are a publisher and want to offer a new product:
* For the _datasets_, _geo layers_, or _templates_ category: Go to the [{{ marketplace-short-name }}](/marketplace?tab=datalens) home page, click **Offer product** and fill out the application form.
* For the _connectors_ category: See [{#T}](../operations/marketplace/create-connector-for-partners.md).

