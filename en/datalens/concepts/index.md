# Overview

{{ datalens-full-name }} is a business analytics service that lets you upload, process, and visualize data for analysing and testing hypotheses.
You can use it to make important marketing and other decisions related to your product.

You can only create one {{ datalens-full-name }} instance in a [Yandex.Cloud folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

## Relationship between objects {#component-interrelation}

{{ datalens-short-name }} consists of multiple objects that let you perform the full data cycle.

![image](../../_assets/datalens/concepts/datalens.svg)

{{ datalens-short-name }} consists of the following objects:

- **Connection**: Contains parameters for accessing a data source. Connections to different data sources are created using connectors. They contain presets for uploading data.
- **Dataset**: A set of data and its description. {{ datalens-short-name }} lets you visualize uploaded data using a special wizard.
- **Chart**: Data from a dataset visualized as diagrams and tables. You can use charts to quickly test hypotheses or save them as widgets for later use.
- **Dashboard**: A page with a set of widgets. Various visualization objects and management tools are placed on dashboards.

