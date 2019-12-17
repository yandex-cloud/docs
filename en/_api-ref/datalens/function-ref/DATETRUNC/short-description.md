**Syntax:**`DATETRUNC( datetime, unit [ , number ] )`

Rounds `datetime` down to the given `unit`. If optional `number` is given, then the value is rounded down to a `number` multiple of `unit` (omitting `number` is the same as `number = 1`).

Supported units:
- `"second"`,
- `"minute"`,
- `"hour"`,
- `"day"` (acts as the day of the year if `number` is specified),
- `"week"`,
- `"month"`,
- `"year"`.