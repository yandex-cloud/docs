# Cannot parse

`ERR.DS_API.DB.CANNOT_PARSE`

Invalid data format. This error is usually caused by `null` (empty) values when converting data from one type to another.

To fix the error, process the empty values, e.g., with this formula:

```
FLOAT(IF([field_name]="") THEN "0.0" ELSE [field_name] END)
```

Where `field_name` is the name of the field which may have `null` (empty) values.
