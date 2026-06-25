### How do I convert a Unix time field to the {{ datalens-short-name }} Date and time field? {#unix-time}

To do this, convert the Unix time to seconds and use the [DATETIME](../../datalens/function-ref/DATETIME.md) function. For example, convert this Unix time in milliseconds: `DATETIME(1380717142785/1000)`, where the `/1000` operation converts milliseconds to seconds.

For Unix time fields, the data type in {{ datalens-short-name }} is an integer or fraction.

