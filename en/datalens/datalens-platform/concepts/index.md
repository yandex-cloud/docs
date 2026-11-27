---
title: '{{ datalens-platform-full-name }}. Overview'
description: 'Learn more about how {{ datalens-platform-short-name }} works: data ingestion, Lakehouse, visualization, development tools, and end-to-end features.'
alternate:
  - href: en/datalens/datalens-platform/concepts/index.md
    type: text/markdown
    title: Markdown version
---

# About {{ datalens-platform-full-name }}

{{ datalens-platform-full-name }} is a full-cycle data analytics platform: from connecting sources and ingestion to storing and processing data, its analysis, and visualization. In it, you can prepare data, run an SQL query, develop code for data ingestion and processing in Python or Scala, built a dashboard, and grant the team access to the results.

The platform implements the _Lakehouse_ approach which allows you to separate data storage and processing. It provides tools for data ingestion, {{ datalens-name }}-based visualization, as well as {{ AF }}-based development and orchestration. Neuroanalyst, external agents, all-in-one interface, search, metadata, and access management assist in working with data on various stages.

## Who should use the platform {#audience}

Data engineers can configure ingestion from sources, get tables ready for analysis, and automate their updates. Analysts can research data using SQL and Python, analyze A/B test results, calculate statistics, prepare data for machine learning, and create datasets, charts, and dashboards. Business users can monitor measures, view reports, and ask Neuroanalyst questions. All participants work with data in the same platform depending on the access permissions granted to them.

## Platform overview {#architecture}

The general data workflow has three stages: ingestion, Lakehouse, and visualization. Deliveries transfer data from sources to storage, computing engines process the data, and visualization tools help present results to users. Development tools allow you to research data and automate their processing. End-to-end features bring platform components together.


### Data ingestion {#data-ingestion}

_Data delivery_ transfers data from an external source to a REST catalog. You can ingest data once or configure regular scheduled copying. For more information, see [Data deliveries](data-transfer/index.md).

If data deliveries do not support the source yet, you can set up ingestion using code in {{ SPRK }} or by connecting to the source in {{ TR }}. Whether a connection is possible depends on the libraries and connectors available for the source.

### Lakehouse {#lakehouse}

{{ datalens-platform-short-name }} is based on Lakehouse which allows storing data separately from computing resources and process it with different engines. On the diagram, storage is represented by S3, {{ IBRG }}, and REST catalog, while processing, by {{ TR }} and {{ SPRK }}.

#### Storage {#data-storage}

Data is stored in an S3 object storage bucket in {{ IBRG }} format. A _REST catalog_ stores metadata of tables and views and provides a single interface for computing agents to get access to them. You can combine tables and views into namespaces, e.g., by projects or business areas, and provide access to them for specific users. For more information, see the [REST catalog](rest-catalog/index.md) section.

#### Processing {#data-processing}

Data processing is performed in {{ TR }} an {{ SPRK }} _clusters_. A {{ TR }} cluster runs SQL queries and a {{ SPRK }} cluster allows distributed processing of data in Python, Scala, and SQL. The size of resources and scaling limits can be customized.

An _environment_ specifies a cloud, network, and subnet to create platform resources. When the environment is created, the network is used to select a subnet. The associated REST catalogs and clusters must reside in the same cloud and environment.

During [{{ datalens-platform-short-name }} activation](../quickstart.md#activate-service), the platform automatically creates a cloud, network, subnet, environment, REST catalog, and {{ TR }} and {{ SPRK }} clusters, and then prompts you to configure an {{ AF }} cluster. If you skipped this stage, you can go back to configuring it from the home page. For more about environments, see [Clusters and environments](clusters/index.md).

### Visualization {#visualization}

{{ datalens-name }} tools are used for visualization. A _dataset_ describes data for building visualizations: fields, links, and computations. Based on it, you can create _charts_ (graphs and tables) and then bring them together on _dashboards_ or in _reports_. You can use the results for working and discussing the measures with your team.

[Mailing lists](../../concepts/maillists.md) and notifications help deliver analysis results to users. Embedded analytics allows you to place charts and dashboards on websites and in applications.

Learn more about [datasets](../../dataset/index.md), [charts](../../concepts/chart/index.md), [dashboards](../../concepts/dashboard.md), [reports](../../reports/index.md), and [visualization embedding](../../concepts/publishing-and-embedding.md).

## Development tools {#development-tools}

For development and automation of data processing, the {{ AF }} orchestration, built-in SQL editor, and workspaces are available.

### Orchestration {#pipelines}

A _pipeline_ describes a data processing sequence and dependencies between tasks. {{ AF }} manages pipelines: runs tasks (scheduled or on user demand) and tracks their progress. Tasks can utilize computations in the {{ TR }} and {{ SPRK }} clusters.

For example, you can use a pipeline to check the ingested data, transform them, and update the final table for analysis. To work with pipelines, [create an {{ AF }} cluster in the environment](../operations/airflow/manage-airflow.md#create-cluster). For more information, see [Pipelines](airflow/index.md).

### SQL editor {#development-environment}

To research data, use the [SQL editor](sql/index.md): write queries and view the results in your browser. Neuroanalyst helps you compose SQL queries based on a natural-language description of the task.

### Workspaces {#workspaces}

_Workspaces_ provide an environment for developing ingestion and data processing code in IDEs. They allow working with Python and Scala code and use {{ SPRK }} computations.

## End-to-end features {#shared-capabilities}

End-to-end features ensure data and object processing across different platform components.

### Neuroanalyst {#neuroanalyst}

_Neuroanalyst_ is the platform’s AI agent. It answers questions about data in a natural language, helps compose SQL queries as well as create charts and dashboards. You can use it for researching data and drafting visualizations. Neuroanalyst can only access the data and objects the current user has access to. For more information, see [AI tools](ai-tools/index.md).

### External agents {#external-agents}

To work with the platform, you can connect external AI agents via the public API, MCP, and Python SDK or use ready-made skills. This will allow you to include processing of the platform’s data and objects into scenarios of external agents.

### All-in-one interface {#unified-interface}

Data engineers, analysts, and business users work in the same interface. In it, you can switch from data ingestion and processing to researching, visualizing, and managing platform objects.

### Metadata {#metadata}

_Metadata_ is information about {{ datalens-platform-full-name }} data: what tables and dashboards exist, what they contain, where the data comes from, who is responsible for it, and how much it can be trusted. In a _metadata catalog_, you can examine the structure of data, add descriptions, distribute objects across domains, and assign them classification tags and glossary terms. For more information, see [Metadata](data-catalog/index.md).

Information about REST catalog objects is automatically added to the metadata catalog. Processing REST catalog tables in {{ TR }} and {{ SPRK }} forms information about relations between source and resulting data.

### All-in-one search {#search}

All-in-one search allows you to find platform data and objects. It is available from the home page or in the dedicated **Search** section.

### Access management {#access-management}

All-in-one access management model applies to two hierarchies: REST catalogs with their namespaces, tables, and views, as well as collections with platform objects placed in them. Navigation by objects depends on the permissions granted to the user. To get missing permissions, you can send an [access request](../security/manage-access.md#access-requests). This helps you organize coworking of engineers, analysts, and business users. To learn more, see [Access management](../security/index.md).

## Example of using the platform {#workflow}

For example, to create a regularly updated sales dashboard:

1. Set up an [environment](../operations/clusters/manage-environment.md#create-environment), [REST catalog](../operations/rest-catalog/create-rest-catalog.md), and [computing clusters](../operations/clusters/manage-clusters.md).
1. [Create a delivery](../operations/data-transfer/regular-copy.md) to regularly ingest sales data from a source to the REST catalog.
1. Create a table for analysis using {{ TR }} or {{ SPRK }}. To automate processing, [describe a pipeline in {{ AF }}](../operations/airflow/manage-airflow.md#add-pipeline).
1. Create a dataset and charts based on the table you created, then build a dashboard with sales measures.
1. Grant your coworkers access to results and [use metadata](../operations/data-catalog/metadata-markup.md) to describe the purpose of data.

To set up the service and try its main components, proceed with the [quick start](../quickstart.md).
