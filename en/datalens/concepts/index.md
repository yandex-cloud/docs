# Overview

{{ datalens-full-name }} is a business analytics service that lets you upload, process, and visualize data for analysing and testing hypotheses.
You can use it to make important marketing and other decisions related to your product.


{% note warning %}

The number of {{ datalens-short-name }} instances in one [{{ yandex-cloud }} cloud ](../../resource-manager/concepts/resources-hierarchy.md#cloud) is 1.

{% endnote %}

## Relationship between entities {#component-interrelation}

{{ datalens-short-name }} consists of multiple entities that ensure the full data cycle.

![image](../../_assets/datalens/concepts/datalens.svg)

{{ datalens-short-name }} includes the following entities:

- **Connection**: A set of parameters for accessing a data source.
- **Dataset**: A description of a dataset from a source.
- **Chart**: Data from a dataset visualized as tables, diagrams, or maps.
- **Dashboard**: A set of charts, selectors for filtering data, and text blocks.

You can create the entity objects yourself or use ready-made solutions from the [{{ datalens-short-name }} Marketplace](marketplace.md).

