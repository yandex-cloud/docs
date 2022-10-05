# Page lists

You can add lists to your [Wiki page](../pages-types.md#page):

* [{#T}](#tree)
* [{#T}](#backlinks)
* [{#T}](#mypages)

## Cluster pages {#tree}

This block contains the list of all pages for the selected cluster.

### Using the block {#tree-call}

```
{{tree for="pageName" nomark="0" depth="3" show_redirects="False" show_grids="True" show_files="False" show_owners="False" show_titles="True" show_created_at="False" show_modified_at="False" sort_by="title" sort="asc"}}
```

All parameters of the block `not_var{{tree}}` are optional. The example shows the default parameter values.

### Block parameters (optional) {#tree-params}

| Parameter | Description |
| --- | --- |
| `for` | The address of the page the tree is intended for. |
| `page` | Alternative name (alias) for the `for` parameter. |
| `depth` | The depth of the tree. Setting this to `0` makes the depth unlimited. |
| {% if audience == "draft" %}`show_redirects` | Displaying redirects in a tree:<br>`true`: Redirects are shown in the tree.<br>`false`: Redirects aren't shown in the tree.{% endif %} |
| `show_grids` | Displaying dynamic tables in a tree:<br>`true` – dynamic tables are included in the tree;<br>`false` – dynamic tables are not displayed in the tree. |
| `show_files` | Displaying attached files in a tree:<br>`true` – files are included in the tree;<br>`false` – files are not displayed in the tree. |
| `show_owners` | Displaying page authors:<br>`true` – authors are displayed;<br>`false` – authors are hidden. |
| `show_titles` | Displaying page titles:<br>`true` – page titles are displayed;<br>`false` – page titles are hidden. |
| `show_created_at` | Displaying page creation dates:<br>`true` – dates are displayed;<br>`false` – dates are hidden. |
| `show_modified_at` | Displaying the dates of page changes:<br>`true` – dates are displayed;<br>`false` – dates are hidden. |
| `sort_by` | Sort pages:<br>`title`: By title.<br>`cluster`: By cluster.<br>`created_at`: By date created.<br>`modified_at`: By date last modified. |
| `sort` | Sorting order:<br>`asc` – in ascending order;<br>`desc` – in descending order. |

## List of pages linking to a specified page {#backlinks}

The block contains a list of all pages that link to the specified page.

### Using a block {#backlink-call}

```
{{backLinks for="pageURL"}}
```

### Block parameters (optional) {#baclink-params}

| Parameter | Description |
| --- | --- |
| `for` | Contains the address of the page that the list is being built for. If this parameter is omitted, the list is built for the current page. |

## Pages created by me {#mypages}

The block contains a list of pages that the user authored.

### Using a block {#mypages-call}

```
not_var{{mypages}}
```

All block parameters `not_var{{mypages}}` are optional. By default, the block displays the current user's list of pages. The pages are displayed in alphabetical order.

### Block parameters (optional) {#mypages-params}

| Parameter | Description |
| --- | --- |
| `user` | You can display the list of pages created by any user by specifying that user's login in the `user` parameter. |
| `bydate` | Sorting by creation date:<br>`1` – enable;<br>`0` – disable. |
| `bychange` | Sorting by date of change:<br>`1` – enable;<br>`0` – disable. |

For example, if you want to display a list of pages created by `username` and sort them by the date of their last update, configure this block:

```
{{mypages bychange=1 user="username"}}
```

