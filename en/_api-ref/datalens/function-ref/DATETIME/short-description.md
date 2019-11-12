**Syntax:**`DATETIME( expression [ , timezone ] )`

Converts the `expression` expression to date and time format. When converting `Date` to `DateTime`, the time is set to '00:00:00'.
The date must be in the format `YYYY-MM-DDThh:mm:ss` or `YYYY-MM-DD hh:mm:ss`.

If `expression` is a number, then the date and time can be converted to the specified time zone when the `timezone` option is available.