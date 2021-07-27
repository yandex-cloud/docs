---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Managing access at the data row level (RLS)

Using RLS (_row-level security_), you can restrict data access for users within a single dataset.
For example, you can restrict access for different customers.

In a dataset, you can restrict data access at the row level.
You can restrict access to any dataset dimension.
Each user can be granted rights to an unlimited number of measure values.

Restrictions are set in the access configuration and look like this:

```yaml
'[value 1]': [user 1], [user 2]
'[value 2]': [user 3]
'[value 3]': [user 1], [user 2], [user 3]
```

Values and users can be defined using wildcard characters:

- `User 1` and `user 2` can access any values of the field

    ```yaml
    *: [user 1], [user 2]
    ```

- The `value 1` value is available to all users

    ```yaml
    '[value 1]': *
    ```

Quotes in values are set using double quotes:

```yaml
 'value in ''quotes''': [user 1], [user 2]
```

With RLS, a query to a dataset passes through the following filter:

```sql
where [dimension] in ([value 1], [value 2]... [value N])
```

{% include [rls-note](../../_includes/datalens/datalens-rls-note.md) %}

## How to change permissions to a row in a dataset {#how-to-manage-rls}

To configure permissions for a data row value:

{% include [datalens-manage-rls](../../_includes/datalens/operations/datalens-manage-rls.md) %}

