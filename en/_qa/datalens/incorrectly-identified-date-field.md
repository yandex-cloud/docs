### The date field is recognized as a string. What should I do? {#incorrectly-identified-date-field}

{{ datalens-short-name }} uses dates in ISO format. This means, if a date in your source data is `01.01.2020` (its format is `DD.MM.YYYY`), {{ datalens-short-name }} will treat it as a string.

To convert this kind of field value to the `Date` type, create a new field with this formula: `DATE_PARSE([field_name_with_date_in_the_DD.MM.YYYY_format])`.

The [`DATETIME_PARSE`](../../datalens/function-ref/DATETIME_PARSE.md) function works similarly and converts a string to the `Date and Time` type.

