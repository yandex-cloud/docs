---
title: ERR.DS_API.REQUEST_TIMEOUT error
description: This page describes the ERR.DS_API.REQUEST_TIMEOUT error.
---

# Backend app request timeout exceeded

`ERR.DS_API.REQUEST_TIMEOUT`

Request processing timeout expired.

Possible causes:

* It takes too long to process the request on the data source side.
* It takes too long to prepare the request to the data source on the {{ datalens-short-name }} side.

To fix this error:

* Optimize the data in the source.
* Reduce the number of complex expressions with nested aggregations.
* Reduce the number of fields in a dataset.
* Create calculated fields at the dataset level instead of fields at the chart level.