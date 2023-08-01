# Marketplace

{{ datalens-short-name }} {{ marketplace-short-name }} is a platform that contains ready-made solutions and extensions for {{ datalens-short-name }}. These solutions and extensions are called _products._ They enhance the {{ datalens-short-name }} functionality and let you add more datasets.

{% note info %}

{{ datalens-short-name }} {{ marketplace-short-name }} is available on a [separate page in {{ datalens-short-name }}]({{ link-datalens-main }}/marketplace/) and the [Yandex {{ marketplace-name }}](/marketplace?tab=datalens) page in the **Data analysis** tab.

{% endnote %}

## Product {#product}

A _product_ is an object prepared for running in {{ datalens-short-name }}. Products may contain drivers for new [connections](connection.md), data for analysis as well as various [chart](chart/index.md) and [dashboard](dashboard.md) templates.

Products are provided by _publishers_. {{ marketplace-short-name }} publishers are companies (such as, Yandex). Publishers place their products in the {{ marketplace-short-name }}. Publishers can also update and upgrade their products.

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

* **Connectors**: Additional types of connections. They allow you to create connections to external systems not supported in {{ datalens-short-name }} by default.

* **Templates**: Dashboard templates that you can use with your data. To do this, replace the connection used for the template.

If you are a publisher and wish to offer a new product for the following categories:
* Datasets, Geo layers, or Templates: on the [{{ marketplace-short-name }}](/marketplace?tab=datalens) home page, click **Offer product** and complete an application.
* Connectors: go to the instructions [{#T}](../operations/marketplace/create-connector-for-partners.md).

