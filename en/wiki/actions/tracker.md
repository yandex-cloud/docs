# Issues from {{ tracker-full-name }}

[{{ tracker-full-name }}]({{ link-tracker }}) is a service for managing projects and workflows. Read more about the service in the [{{ tracker-full-name }} documentation](../../tracker/).

{{ tracker-full-name }} users can add a link to an issue or to a list of issues in {{ wiki-name }} pages.



## Link to an issue {#ticket}

You can add _magic links_ to specific issues directly to the [Wiki page text and using the visual editor](../pages-types.md). These links always include the key, name, status of the issue, and the username of the performer. To insert a link to an issue, copy its key and paste it to the text of the page.

Example:

| Markup | Result |
| ----- | ----- |
| ``` Fix a mistake in TEST-123 ``` | ![](../../_assets/wiki/tracker-magic-link.png) |

## List of issues {#ticket-list}

Using the `not_var{{tasks}}` section, you can add an automatically generated list of issues to your Wiki page. For example:

```
{{tasks url="URL of the filter or the queue"}}
```

* To display all the issues in the queue, in the `url` parameter, specify its [key](../../tracker/manager/create-queue.md#key) or a link copied from the browser's address bar.

* To display [filtered](../../tracker/user/create-filter.md) issues, in the `url` parameter, specify a link to the filter copied from the browser's address bar.

    {% note info %}

    The `"` character isn't supported in the `url` parameter of the `tasks` block. If this character is present in the filter's URL copied from the address bar, replace it with `%22`.

    {% endnote %}

### Issue lists with parameters {#tasks-vars}

Using dynamic tables, you can add a list of issues and their main parameters to your Wiki page:

1. [Create](../create-grid.md) a dynamic table.

1. Create a column with the **Tracker issue** data type.

1. Add the required number of rows and list the task keys in them.

1. Create additional columns. Specify the necessary task parameters as the data type. For example, **Title**, **Author** or **Type** issues.

1. Save the table.

As a result, the columns with the task parameters will be filled in automatically. The resulting table can be [embedded in a wiki page](../add-grid.md).

Example:
![](../../_assets/wiki/tickets-grid-example.png)

