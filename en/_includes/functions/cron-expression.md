## Cron expression format {#cron-expression}

The fields in a cron expression are ordered as follows: `Minutes Hours Day-of-month Month Day-of-week Year`.

### Possible field values {#field-and-value}

{% note info %}

Special characters, as well as months and days of the week, are case-insensitive: `MON` is the same as `mon`.

{% endnote %}

| Field <br>name | Required <br>field | Acceptable <br>values | Supported <br>special <br>characters |
|----|----|----|----|
|`Minutes` | Yes | 0-59 | `,`, `-`, `*`, `/` |
|`Hours` | Yes| 0-23 | `,`, `-`, `*`, `/` |
|`Day of month`| Yes | 1-31 | `,`, `-`, `*`, `?`, `/`, `L`, `W` |
|`Month`| Yes | 1-12, <br>JAN-DEC | `,`, `-`, `*`, `/` |
|`Day of week`| Yes | 1-7, <br>SUN-SAT | `,`, `-`, `*`, `?`, `/`, `L`, `#`|
|`Year`| No | Empty, 1970-2099 | `,`, `-`, `*`, `/` |

### Special characters {#special-characters}

You can use the following special characters in cron expressions:
* `*`: Selects all values in the field.
    
    > `*` in the `Minutes` field: Trigger fires `every minute`.
* `?`: Selects any field value. You cannot specify `Day of month` and `Day of week` at the same time. If you have entered a value in one of these fields, put `?` in the other one.

    > `10` in `Day of month` and `?` in `Day of week`: Trigger fires on the 10th day of each month.
* `-`: Selects a range of values.
    
    > `10-12` in `Hours`: Trigger fires at 10 a.m., 11 a.m., and 12 p.m.
* `,`: Selects multiple values.

    > `MON,WED,FRI` in `Day of week`: Trigger fires on Monday, Wednesday, and Friday.
* `/`: Increments the value.

    > `0/15` in `Minutes`: Trigger fires at 0, 15, 30, and 45 minutes past each hour.
* `L`: This character has different meanings in the two fields it is valid for: 
    * In the `Day of month` field, it means the last day of the month.
    * In the `Day of week` field, it means the last day of the week, `7` (Saturday, `SAT`).
    
    > `L` in `Day of month`: Trigger fires on January 31, February 28, and so on.
* `W`: Selects the weekday nearest to the specified date.

    > `15W` in `Day of month`: Trigger fires on the weekday nearest to the 15th day of the month. If the 15th day falls on Saturday, the trigger fires on Friday the 14th.

    {% note info %}
    
    `L` and `W` in the `Day of month` field can also merge into the `LW` combination, firing the trigger on the last weekday of the month.
    
    {% endnote %}
                                                                                             
* `#`: Selects the Nth day of the month.

    > `6#3` in `Day of week`: Trigger will fire on the third Friday of the month (6 for Friday; 3 for third Friday of the month).

### Examples of cron expressions {#examples}

| Cron expression | Description |
|----|----|
| `* * * * ? *` | The trigger fires every minute. |
| `0 * ? * * *`| The trigger fires every hour. |
| `15 10 ? * * *` | The trigger fires every day at 10:15. |