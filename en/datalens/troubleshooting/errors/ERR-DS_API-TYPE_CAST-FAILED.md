# Data type conversion error

`ERR.DS_API.TYPE_CAST.FAILED`

The error occurs because the source database uses values that do not match the column's data type. In this case, {{ datalens-short-name }} cannot convert such values to a type it can work with. For more information, see [{#T}](../../../datalens/dataset/types-lookup-table.md).

To fix the error, convert the values to the appropriate column data type in the source database. For example, if the source database has the `date` column with the `0000-00-00` value, convert it to the `1970-01-01` or `NULL` value.