---
title: '{{ datalens-full-name }} error ERR.DS_API.PREVIEW_SOURCE_MODIFICATION_NOT_ALLOWED'
description: The page provides a description of the Data source modification is not allowed error in {{ datalens-full-name }}.
---

# [{{ datalens-full-name }}] error `Data source modification is not allowed`

`ERR.DS_API.PREVIEW_SOURCE_MODIFICATION_NOT_ALLOWED`

The error means that the user lacks the `{{ permission-read }}` permission for the connection used in the data source when attempting to modify the source via an API request.

For example, in the [Public API](../../operations/api-start.md), when the user has no `{{ permission-read }}` permission for the connection and attempts to modify the source in a dataset preview request.

Use one of the ways below to resolve the error:

* In your request, use the connection previously saved in the dataset.
* If you need to change the source parameters, request access from the connection administrator. For more on access permissions, see [{#T}](../../security/index.md).