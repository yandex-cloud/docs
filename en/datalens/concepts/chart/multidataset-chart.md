---
title: Multi-dataset charts
description: In this tutorial, you will learn about multi-dataset charts and their features.
---

# Multi-dataset charts

Multi-dataset charts are charts that visualize data from different datasets.

Queries for each dataset are processed independently of each other. You cannot create calculable fields from fields in multiple datasets.
When you add a second {{ datalens-short-name }} dataset, a link is automatically created based on the first match for the field name and field data type.

In this case, you can:

* Change links.
* Add new links.
* Delete links.

{% note info %}

You do not have to link datasets in a chart.

{% endnote %}

Consider the following specifics of working with linked datasets in charts, except for geochart layers:

* One chart can use any measures from datasets, regardless of their links.
* One chart can only use linked dimensions.
* Filters by linked dimensions are applied to all datasets.
* Filters by non-linked dimensions are applied only to their own dataset.

The following specifics apply to working with linked datasets in geovisualizations on different layers:

* A geolayer can use any measures from datasets regardless of their links.
* A geolayer can only use its linked dimensions.
* Filters by linked dimensions from the **General filters** section are applied to all datasets in all layers.
* Filters from the **General filters** section that use non-linked dimensions only apply to their own dataset in all layers.
* Filters in the **Layer filters** section that use linked dimensions apply to all datasets within the current layer.
* Filters in the **Layer filters** section that use non-linked dimensions only apply to their own dataset within the current layer.
* There are no restrictions on using non-linked dimensions in different layers.

