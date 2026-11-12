* `filter`: Maintenance job list filer. This is an optional setting. The valid values include:

    * `status`: Show maintenance jobs with a specified status:

        * `SCHEDULED`
        * `RUNNING`
        * `SUCCEEDED`
        * `CANCELLED`


    > Here is an example: `filter=status="CANCELLED"`.

* `orderBy`: Maintenance job list sorting. This is an optional setting.

    * `<sorting_field>`: Name of the field to sort by. The valid values include:

        * `created_at`: Sorting by date and maintenance job creation time.
        * `start_scheduled_at`: Sorting by scheduled date and maintenance start time.
        * `started_at`: Sorting by date and actual maintenance start time.

            {% note info %}

            For a maintenance job that has not been started yet, you cannot use filtering by `started_at`.

            {% endnote %}

    * `<sorting_direction>`: Valid values include:

        * `asc`: Sorting in ascending order.
        * `desc`: Sorting in descending order.

    > Here is an example: `orderBy=created_at asc`. 
