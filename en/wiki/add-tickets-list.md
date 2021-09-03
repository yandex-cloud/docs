# Adding links to Tracker issues

[{{ tracker-full-name }}]({{ link-tracker }}) users can add {{ wiki-name }} links to individual issues or issue lists to pages.


## Issue links {#tasks}

To add a link to an issue, specify the issue key in your text.

Example:

| Markup | Result |
| ----- | ----- |
| ``` Fix a mistake in TEST-123 ``` | ![](../_assets/wiki/tracker-magic-link.png) |

## Issue lists {#list}

Using the [dynamic action `not_var{{tasks}}`](actions/objects.md#section_ad2_fkg_1db), you can embed an automatically generated issue list on the page. For example:

```
{{tasks url="filter or queue address"}}
```

## Issue lists with parameters {#tasks-vars}

You can use dynamic tables to embed issue lists and their main parameters on Wiki pages:

1. [Create](create-grid.md) a dynamic table.

1. Create a column with the **Tracker issue** data type.

1. Add the required number of rows and list the issue keys in them.

1. Create additional columns. Specify the required issue parameters as your data type. For example: **Title**, **Author**, or **Type**.

1. Save your table.

The columns with issue parameters will be filled in automatically. The resulting table can be [embedded on a wiki page](add-grid.md).

Example:

![](../_assets/wiki/tickets-grid-example.png)

