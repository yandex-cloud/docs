To add a [secondary index](../concepts/secondary_indexes.md) when creating a table, use the statement `INDEX IndexName GLOBAL on (SomeKey1, ... SomeKeyN)`:

{% include [create-table-with-si-template](queries/create-table-with-si-template.md) %}

**Example**

The `series` table with the `views_index` secondary index for the `views` field and `users_index` secondary index for the `uploaded_user_id` field:

{% include [create-table-with-si-example](queries/create-table-with-si-example.md) %}

