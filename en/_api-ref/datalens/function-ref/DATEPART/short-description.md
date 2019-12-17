**Syntax:**`DATEPART( datetime, unit [ , firstday ] )`

Returns a part of the date as an integer.

Depending on the argument, `unit` returns the following values:
- `"year"` — the year number (see [YEAR](../YEAR/short-description.md)),
- `"month"` — the number of the month in the year (see [MONTH](../MONTH/short-description.md)),
- `"week"` — the number of the week in the year according to [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) (see [WEEK](../WEEK/short-description.md)),
- `"dayofweek"`, `"dow"` — the number of the day of the week (see [DAYOFWEEK](../DAYOFWEEK/short-description.md)),
`"day"` — the number of the day in the month (see [DAY](../DAY/short-description.md)),
- `"hour"` — the number of the hour in the day (see [HOUR](../HOUR/short-description.md)),
- `"minute"` — the number of the minute in the hour (see [MINUTE](../MINUTE/short-description.md)),
- `"second"` — the number of the second in the minute (see [SECOND](../SECOND/short-description.md)).

If you select `"dayofweek"`, you can use the additional parameter `firstday` to specify the first day of the week (Monday by default). Learn more about this parameter in the [DAYOFWEEK](../DAYOFWEEK/short-description.md) function description.
