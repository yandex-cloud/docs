* `retain_for_days`: Backup retention period in days. The possible value range is `7–1095` (up to three years).
* `cron`: Settings that define the schedule for creating backups.

    * `day_of_month`: Day of the month. The possible value is `1–31`.
    * `day_of_week`: Day of week. The possible values are `0–6` or `SUN–SAT`.
    * `month`: Month. The possible values are `1–12` or `JAN–DEC`.

    The schedule is defined as a cron expression without hours and minutes.

    Cron expressions also support the following special characters:

    * `*`: Selecting all possible values. A backup will be created on each scheduled interval (day or month) when possible, provided it does not conflict with other settings. This option is used by default if the setting is not specified.
    * `,`: Listing multiple values.
    * `–`: Specifying a range of values.
    * `/`: Specifying a step value. For example, `*/3` for the `day_of_month` setting means a backup will be created every three days.

    If no schedule settings are specified, backups are created using the cron expression `* * *`, meaning they run daily.

    Examples of cron expressions:

    * `1 */6 *`: Backup is created on the first day of the month, every six months.
    * `31 jan SUN`: Backup is created on Sundays in January, and also on January 31.
    * `* * WED`: Backup is created every Wednesday.

    You can test your cron expression in this [editor](https://crontab.guru).
