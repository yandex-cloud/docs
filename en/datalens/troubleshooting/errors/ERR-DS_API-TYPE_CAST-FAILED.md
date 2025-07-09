---
title: ERR.DS_API.TYPE_CAST.FAILED error
description: This page describes the ERR.DS_API.TYPE_CAST.FAILED error.
---

# Data type conversion error

`ERR.DS_API.TYPE_CAST.FAILED`

The error occurs because the source database uses values that do not match the column's data type. In this case, {{ datalens-short-name }} cannot convert such values to a type it can work with. For more information, see [{#T}](../../../datalens/dataset/types-lookup-table.md).

To fix the error, convert the values to the appropriate column data type in the source database. For example, if the source database has the `0000-00-00` value in the `date` column, convert it to either the `1970-01-01` or `NULL` value.