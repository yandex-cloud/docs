---
title: '{{ datalens-full-name }} error ERR.DS_API.REQUEST_TIMEOUT'
description: This page describes the Backend app request timeout exceeded {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Backend app request timeout exceeded

`ERR.DS_API.REQUEST_TIMEOUT`

Request processing timeout expired.

Possible causes:

* It takes too long to process the request on the data source side.
* It takes too long to prepare the request to the data source on the {{ datalens-short-name }} side.

{% include [datalens-dataset-timeout-recommendations](../../../_includes/datalens/datalens-dataset-timeout-recommendations.md) %}
