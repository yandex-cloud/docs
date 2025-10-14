---
title: Cron expressions in {{ si-full-name }}
description: In this article, you will learn about the cron expression format used in {{ si-name }}.
---

# Cron expressions in {{ si-name }}

You can set schedules in {{ si-name }} using [cron expressions](https://{{ lang }}.wikipedia.org/wiki/Cron). By default, cron expression uses [UTC+0](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).


## Cron expression format {#cron-expression}

Cron expression field order: `Seconds Minutes Hours Day-of-month Month Day-of-week`.


## Possible field values {#field-and-value}

{% note info %}

Special characters, as well as months and days of the week, are case-insensitive: `MON` is the same as `mon`.

{% endnote %}

Field <br>name | Required <br>field | Acceptable <br>values | Supported <br>special <br>characters
--- | --- | --- | ---
`Seconds`, seconds | Yes | 0-59 | `,`, `-`, `*`, `/`
`Minutes`, minutes | Yes | 0-59 | `,`, `-`, `*`, `/`
`Hours`, hours | Yes| 0-23 | `,`, `-`, `*`, `/`
`Day of month`, day of the month| Yes | 1-31 | {{ er-name }}: `,`, `-`, `*`, `?`, `/`, `L`, `W`; {{ sw-name }}: all of the above except `?`, `L`, and `W`.
`Month`, month| Yes | 1-12, <br>JAN-DEC | `,`, `-`, `*`, `/`
`Day of week`, day of the week| Yes | 1-7, <br>MON-SUN | {{ er-name }}: `,`, `-`, `*`, `?`, `/`, `L`, `#`; {{ sw-name }}: all of the above except `?`, `L`, and `#`.


## Special characters {#special-characters}

You can use the following special characters in cron expressions:

* `*`: Selects all values in the field.

    > `*` in `Minutes`: The timer starts every minute.

* `?`: Selects any field value. You cannot specify `Day of month` and `Day of week` at the same time. If you have entered a value in one of these fields, put `?` in the other one. {{ sw-name }} does not support `?` in the `Day of week` field.

    > `10` in `Day of month` and `?` in `Day of week`: The timer starts every tenth day of the month.

* `-` : Selects a range of values.

    > `10-12` in `Hours`: The timer starts at 10 a.m., 11 a.m., and 12 p.m.

* `,`: Selects multiple values.

    > `MON,WED,FRI` in `Day of week`: The timer starts on Monday, Wednesday, and Friday.

* `/`: Increment the value.

    > `0/15` in `Minutes`: The timer starts at 0, 15, 30, and 45 minutes past each hour.

* `L`: This character functions differently in the two fields it is valid for:

    * In the `Day of month` field, it stands for the last day of the month.
    * In the `Day of week` field, it stands for the last day of the week, `7` (Sunday, `SUN`).
 
    It is only supported for {{ er-name }}.

    > `L` in `Day of month`: The timer starts on January 31, February 28, and so on.

* `W`: Selects the weekday nearest to the specified date. It is only supported for {{ er-name }}.

    > `15W` in `Day of month`: The timer starts on the weekday nearest to the 15th day of the month. If the 15th day is a Saturday, the timer starts on Friday the 14th.

    {% note info %}

    `L` and `W` in the `Day of month` field can also merge into the `LW` combination, starting the timer on the last weekday of the month.

    {% endnote %}

* `#`: Selects the Nth day of the month. It is only supported for {{ er-name }}.

    > `6#3` in `Day of week`: The timer starts on the third Friday of the month (6 for Friday; 3 for the third Friday of the month).


## Examples of cron expressions {#examples}

Cron expression | Description
--- | ---
`0 * * * * ?` | The timer starts every minute.
`0 0 * ? * *`| The timer starts every hour.
`0 15 10 ? * *` | The timer starts every day at 10:15.
