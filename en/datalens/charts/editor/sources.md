---
title: What types of data sources are used in Editor
description: In this tutorial, you will learn what types of data sources are available in Editor.
---

# Data sources

{% include [business-note](../../../_includes/datalens/datalens-functionality-available-business-note.md) %}

## Source types {#source-types}

You can request the data using:

* [Dataset](./tabs.md#sources-dataset)
* [Database connection via an SQL query](./tabs.md#sources-database)
* [Connection via API Connector](./tabs.md#sources-api-connector)

For more information, see [Sources](./tabs.md#sources).

## Limitations {#limits}

There are limits on the size and time of data loading:

* 100 MB on the total size from all sources per request.
* 50 MB on the size of data from one source.
* 95 seconds on the total time of data upload from all sources per request.
* 95 seconds on the time of loading data from a single data source.
* 10 seconds on executing the [Prepare](./tabs.md#prepare) tab.

These limits are set to ensure stable operation for the service and its sources.