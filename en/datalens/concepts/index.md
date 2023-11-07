---
title: "{{ datalens-full-name }}. Service overview"
description: "{{ datalens-full-name }} is a business analytics service. It allows you to connect to various data sources, visualize data, create dashboards, and share your results. This article will help you understand the relationship between entities and the difference between a workbook and collection."
---


# About

{{ datalens-full-name }} is a business analytics service. It allows you to connect to various data sources, visualize data, create dashboards, and share your results.
With {{ datalens-full-name }}, you can track your product and business metrics directly from data sources to make data-based decisions.


{% note warning %}

The maximum number of {{ datalens-short-name }} instances per {{ yandex-cloud }} [organization](../../organization/quickstart.md) or [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) is 1.

{% endnote %}


## Relationship between entities {#component-interrelation}

{{ datalens-short-name }} consists of multiple entities that ensure the full data cycle.

![image](../../_assets/datalens/concepts/datalens.svg)

{{ datalens-short-name }} includes the following entities:

- **Connection**: A set of parameters for accessing a data source.
- **Dataset**: A description of a dataset from a source.
- **Chart**: Data from a data source or a dataset visualized as tables, diagrams, or maps.
- **Dashboard**: A set of charts, selectors for filtering data, and text blocks.

You can create the entity objects yourself or use ready-made solutions from the [{{ datalens-short-name }} Marketplace](marketplace.md).

