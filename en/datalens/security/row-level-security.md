# Managing access at the data row level (RLS)

Using RLS (_row-level security_), you can restrict data access for users within a single dataset. For example, you can restrict access for different customers.

{% include [rls-note](../../_includes/datalens/datalens-rls-note.md) %}

You can restrict data access at the row level both in a [dataset](#dataset-rls) and [data source](#datasource-rls).

## Configuring RLS at the dataset level {#dataset-rls}

You can restrict access to any dataset dimension. Each user can be granted rights to an unlimited number of measure values.

Restrictions are set in the access configuration and look like this:

```yaml
'[value 1]': [user 1], [user 2]
'[value 2]': [user 3]
'[value 3]': [user 1], [user 2], [user 3]
```

For example, to configure user access to the `first-company` value in the `Company name` field, specify the following configuration:

```yaml
'first-company': login-to-access-your-row-data@yandex.ru
```

To configure access for multiple users, list their accounts separated by commas in the access configuration:

```yaml
'first-company': login1-to-access-your-row-data@yandex.ru, login2-to-access-your-row-data@yandex.ru, login3-to-access-your-row-data@yandex.ru
```

Values and users can be defined using wildcard characters:

* `User 1` and `user 2` can access any values of the field

  ```yaml
  *: [user 1], [user 2]
  ```

  For example, to configure user access to all the values in the `Company name` field, specify the following configuration:

  ```yaml
  *: login1-to-access-your-row-data@yandex.ru, login2-to-access-your-row-data@yandex.ru
  ```

* The `value 1` value is available to all users

  ```yaml
  '[value 1]': *
  ```

  For example, to enable access for all users to the `first-company` value in the `Company name` field, specify the following configuration:

  ```yaml
  'first-company': *
  ```

Quotes in values are set using double quotes:

```yaml
'value in ''quotes''': [user 1], [user 2]
```

For example, to set quotation marks for the `first-company "Example"` company name in the `Company name` field, specify the following configuration:

```yaml
'first-company ''Example''': login1-to-access-your-row-data@yandex.ru, login2-to-access-your-row-data@yandex.ru
```

You can also use the `"` character:

```yaml
'first-company "Example"': login1-to-access-your-row-data@yandex.ru, login2-to-access-your-row-data@yandex.ru
```

With RLS, a query to a dataset passes through the following filter:

```sql
where [dimension] in ([value 1], [value 2] ... [value N])
```

## Configuring RLS at the data source level {#datasource-rls}

Configuring RLS at the dataset level requires editing the datatset every time the RLS settings change.

To avoid this, you can transfer the logic of access control at the row level to the data source:

1. Add a new field for storing user IDs to the source data. All requests to the source will be filtered by this field.

    You can view your ID [at the link]{% if region == "int" %}(https://console.cloud.yandex.com/iam){% else %}(https://console.cloud.yandex.ru/iam){% endif%}. If you need another user's ID, ask them to open this   link and pass the ID to you.

1. For each row of source data, specify the ID of the user who is allowed to access this row. If multiple users should have access to the same row, you can move the access control logic to a separate table and [join](../concepts/dataset/settings.md#multi-table) it to the main table at the dataset level.

1. In the dataset field with the IDs in the RLS settings, enter `userid:userid`. The `userid` variable can be used together with the regular RLS type in the dataset:

   ```yaml
   '[value 1]': [user 1], [user 2]
   '[value 2]': [user 3]
      userid:userid
   ```

{% note info %}

You can transfer the RLS logic to the source side for sources where the data structure can be changed. In Yandex Metrica and AppMetrica, the data structure is closed, so this method is unavailable.

{% endnote %}

## How to change permissions to a row in a dataset {#how-to-manage-rls}

To configure permissions for a data row value:

{% include [datalens-manage-rls](../../_includes/datalens/operations/datalens-manage-rls.md) %}

