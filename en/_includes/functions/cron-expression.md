## Cron expression format {#cron-expression}

The order of fields in the cron expression: `Minutes Hours Day-of-month Month Day-of-week Year`.

### Possible field values {#field-and-value}

{% note info %}

Special characters used, as well as the names of months and days of the week, are case-insensitive: `MON` is the same as `mon`.

{% endnote %}

| Field <br>name | Required <br>field | Acceptable <br>values | Special <br>characters <br>supported |
|----|----|----|----|
| `Minutes` | Yes | 0-59 | `,`, `-`, `*`, `/` |
| `Hours` | Yes | 0-23 | `,`, `-`, `*`, `/` |
| `Day of month` | Yes | 1-31 | `,`, `-`, `*`, `?`, `/`, `L`, `W` |
| `Month` | Yes | 1-12, <br>JAN-DEC | `,`, `-`, `*`, `/` |
| `Day of week` | Yes | 1-7, <br>SUN-SAT | `,`, `-`, `*`, `?`, `/`, `L`, `#` |
| `Year` | No | empty, 1970-2099 | `,`, `-`, `*`, `/` |

### Special characters {#special-characters}

You can use the following special characters in cron expressions:
* `*`: Select all values in the field.

   > The `*` character in the `Minutes` field: The trigger starts `every minute`.
* `?`: Select any field value. You can't fill `Day of month` and `Day of week` at the same time. If you entered a value in one of these fields, enter `?` in the other field.

   > `10` in `Day of month` and `?` in `Day of week`: The trigger is launched every 10th day of the month.
* `-`: Select a range of values.

   > The `10-12` range in `Hours`: the trigger runs at 10 AM, 11 AM, and noon.
* `,`: Select multiple values.

   > `MON,WED,FRI` in the `Day of week` field: the trigger runs on Monday, Wednesday, and Friday.
* `/`: Increment the value.

   > `0/15` in the `Minutes` field: The trigger starts at 0, 15, 30, and 45 minutes past each hour.
* `L`: This character functions differently in the two fields where it's used:
   * In the `Day of month` field, it means the last day of the month.
   * In the `Day of week` field, it means the last day of the week, `7` (Saturday, `SAT`).

   > `L` in the `Day of month` field: the trigger runs on January 31, February 28, and so on.
* `W`: Select the weekday nearest to the specified date.

   > `15W` in the `Day of month` field: The trigger is run on the weekday nearest to the 15th day of the month. If the 15th day is Saturday, the trigger runs on Friday the 14th.

   {% note info %}

   The characters `L` and `W` in the `Day of month` field can be also merged into `LW`: The trigger is run on the last weekday of the month.

   {% endnote %}

* `#`: Select the Nth day of the month.

   > The value `6#3` in the `Day of week` field: The trigger runs on the third Friday of the month (6 — Friday, 3 — the third Friday of the month).

### Examples of cron expressions {#examples}

| Cron expression | Description |
|----|----|
| `* * * * ? *` | The trigger is run every minute. |
| `0 * ? * * *` | The trigger is run every hour. |
| `15 10 ? * * *` | The trigger is run every day at 10:15 AM. |