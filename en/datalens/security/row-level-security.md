# Managing access at the data row level (RLS)

With RLS (_row-level security_), you can restrict data access for users or [user groups](../../organization/concepts/groups.md) within a single dataset. For example, you can introduce data access control for different customers.

{% include [rls-note](../../_includes/datalens/datalens-rls-note.md) %}

You can introduce data access control at the row level either in a [dataset](#dataset-rls) or a [data source](#datasource-rls).

## Configuring RLS at the dataset level {#dataset-rls}

You can control access to any dataset dimension. Each [user](#user-rls) or [user group](#group-rls) can be granted permissions for an unlimited number of measure values.

With RLS, a query to a dataset passes through the following filter:

```sql
where dimension in (value_1, value_2 ... value_N)
```

### User access {#user-rls}

For users, access control is based on the access configuration which looks like this:

```yaml
'value_1': user_1, user_2
'value_2': user_3
'value_3': user_1, user_2, user_3
```

For example, to permit the `user-login` user to access the `first-company` value of the `Company name` field, [specify the following configuration](#how-to-manage-rls):



```yaml
'first-company': user-login@yandex.ru
```


To configure access for multiple users, list their accounts in the access configuration separated by commas:



```yaml
'first-company': user-login-1@yandex.ru, user-login-2@yandex.ru, user-login-3@yandex.ru
```


### Access for user groups {#group-rls}


For user groups, access control is based on the access configuration which looks like this:

```yaml
'value_1': @group:group_1_name
'value_2': @group:group_1_name, @group:group_2_name
```

The configuration specifies the group name rather than its identifier. If a group is renamed, you will need to update its RLS configuration accordingly.

For example, to allow the `group-name` user group to access the `first-company` value of the `Company name` field, specify the following configuration:

```yaml
'first-company': @group:group-name
```



To configure access for multiple user groups, list them in the access configuration separated by commas:


```yaml
'first-company': @group:group-name-1, @group:group-name-2, @group:group-name-3
```



You can configure access for users and groups at the same time:


```yaml
'first-company': user-login-1@yandex.ru, user-login-2@yandex.ru, @group:group-name-1, @group:group-name-2
```



### Wildcards and quotation marks in RLS configuration {#special-}

You can define values, users, and group names using wildcard characters:

* `User_1`, `user_2`, and `group_1_name` can access all the field's values

  ```yaml
  *: user_1, user_2, @group:group_1_name
  ```

  For example, to configure access to all values of the `Company name` field, specify the following configuration:


  ```yaml
  *: user-login-1@yandex.ru, @group:group-name-1
  ```


* `value_1` is available to all users and groups

  ```yaml
  'value_1': *
  ```

  For example, to allow all users and groups to access the `first-company` value in the `Company name` field, specify the following configuration:

  ```yaml
  'first-company': *
  ```

Quotes in values are set using double quotes:

```yaml
'value in ''quotes''': user_1, user_2
```

For example, to set quotation marks for the `first-company "Example"` company name in the `Company name` field, specify the following configuration:


```yaml
'first-company ''Example''': user-login-1@yandex.ru, @group:group-name-1
```


You can also use the `"` character:


```yaml
'first-company "Example"': user-login-1@yandex.ru, @group:group-name-1
```


## Configuring RLS at the data source level {#datasource-rls}

Configuring RLS at the dataset level requires editing the dataset every time the RLS settings change.

To avoid this, you can move the access control logic at the row level to the data source side:

1. Add a new field for storing user IDs to the source data. All requests to the source will be filtered by this field.


   To view your ID, follow [this link]({{ link-console-access-management }}). If you need another user's ID, ask them to open this link and pass the ID to you.


1. For each row of source data, specify the ID of the user who is allowed to access this row. If multiple users must have access to the same row, you can move the access control logic to a separate table and [join](../dataset/settings.md#multi-table) it to the main table at the dataset level.

1. In the dataset, enter `userid:userid` in the ID field under the RLS settings. The `userid` variable can be used together with the regular RLS type in the dataset:

   ```yaml
   'value_1': user_1, user_2
   'value_2': user_3
      userid:userid
   ```

{% note info %}

You can transfer the RLS logic to the source side for sources where the data structure can be changed. In Yandex Metrica and AppMetrica, the data structure is closed, so this method is unavailable.

{% endnote %}

## How to change permissions to a row in a dataset {#how-to-manage-rls}

To configure access to a data row value:

{% include [datalens-manage-rls](../../_includes/datalens/operations/datalens-manage-rls.md) %}
