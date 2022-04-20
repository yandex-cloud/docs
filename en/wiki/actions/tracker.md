# {{ tracker-full-name }} issues

[{{ tracker-full-name }}]({{ link-tracker }}) is a service for managing projects and activities. Learn more about the service features in [service documentation {{ tracker-full-name }}](../../tracker/).

{{ tracker-full-name }} users can embed links to individual issues or issue lists on {{ wiki-name }} pages.


## Link to the issue {#ticket}

You can insert _magic links_ on Wiki pages to individual issues and issue lists. Such links always contain the issue key, name, status, and the assignee's username. To insert a link to an issue, copy the issue key and paste it into the page text.

Example:

| Markup | Result |
| ----- | ----- |
| ``` Fixing mistake in TEST-123 ``` | ![](../../_assets/tracker/magic-link.png) |

## Issue list {#ticket-list}

You can use the `not_var{{tasks}}` block to embed a generated issue list on your page. Example:

```
{{tasks url="URL of the filter or the queue"}}
```

* To display all issues in a queue, find the `url` parameter and specify the [queue key](../../tracker/manager/create-queue.md#key) or a link from your browser's address bar in the parameter.

* To display an issue [filter](../../tracker/user/create-filter.md), add a link to the filter from your browser's address bar in the `url` parameter.

    {% note info %}

    The `url` parameter in the `issues` block does not support the `"` symbol. If the filter link from the address bar contains this symbol, replace it with `%22`.

    {% endnote %}

### Issue lists with parameters {#tasks-vars}

You can use dynamic tables to display issue lists and their main parameters on Wiki pages:

1. [Create](../create-grid.md) a dynamic table.

1. Create a column and set its data type to **Tracker issue**.

1. Add the required number of rows and list the issue keys in them.

1. Create additional columns. Specify the required issue parameters as your data type. For example, specify the issue's **Heading**, **Owner**, or **Type**.

1. Save your table.

The columns with issue parameters will be filled in automatically. The resulting table can be [posted on a Wiki page](../add-grid.md).

Example:
![](../../_assets/wiki/tickets-grid-example.png)

