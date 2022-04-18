# Page lists

You can insert lists on Wiki pages:

* [{#T}](#tree)
* [{#T}](#backlinks)
* [{#T}](#mypages)

## Cluster pages {#tree}

This block contains the list of all pages for the selected cluster.

### Calling the block {#tree-call}

```
{{tree for="pageName" nomark="0" depth="3" show_redirects="False" show_grids="True" show_files="False" show_owners="False" show_titles="True" show_created_at="False" show_modified_at="False" sort_by="title" sort="asc"}}
```

All the `not_var{{tree}}` block parameters are optional. The example shows the default parameter values.

### Block parameters (optional) {#tree-params}

| Parameter | Description |
| --- | --- |
| `for` | The address of the page the tree is intended for. |
| `page` | Alternative name (alias) for the `for` parameter. |
| `depth` | Tree depth. If set to `0`, the depth is unlimited. |
| `show_redirects` | Displaying redirects in a tree:<br>`true` — redirects are included in the tree;<br>`false` — redirects are not displayed in the tree. |
| `show_grids` | Displaying dynamic tables in a tree:<br>`true` — dynamic tables are included in the tree;<br>`false` — dynamic tables are not displayed in the tree. |
| `show_files` | Displaying attached files in a tree:<br>`true` — files are included in the tree;<br>`false` — files are not displayed in the tree. |
| `show_owners` | Displaying page owners:<br>`true` — owners are displayed;<br>`false` — owners are hidden. |
| `show_titles` | Displaying page headings:<br>`true` — headings are displayed;<br>`false` — headings are hidden. |
| `show_created_at` | Displaying page creation dates:<br>`true` — dates are displayed;<br>`false` — dates are hidden. |
| `show_modified_at` | Displaying page change dates:<br>`true` — dates are displayed;<br>`false` — dates are hidden. |
| `sort_by` | Sorting pages:<br>`title` — by title;<br>`cluster` — by cluster;<br>`created_at` — by creation date;<br>`modified_at` — by update date. |
| `sort` | Sort order:<br>`asc` — ascending;<br>`desc` — descending. |

## List of pages linking to a specified page {#backlinks}

This block contains the list of all pages with links to a specified page.

### Calling the block {#backlink-call}

```
{{backLinks for="pageURL"}}
```

### Block parameters (optional) {#baclink-params}

| Parameter | Description |
| --- | --- |
| `for` | Contains the address of the page the list is intended for. If no parameter is set, a list for the current page is created by default. |

## Pages created by me {#mypages}

This block contains the list of all pages created by the user.

### Calling the block {#mypages-call}

```
not_var{{mypages}}
```

All parameters for the `not_var{{mypages}}` block are optional. If no parameters are set, the list of pages created by the user currently reading the list is displayed. Pages are displayed in alphabetical order.

### Block parameters (optional) {#mypages-params}

| Parameter | Description |
| --- | --- |
| `user` | You can display the list of pages created by a user by specifying their username in the `user` parameter. |
| `bydate` | Sorting by creation date:<br>`1` — enable;<br>`0` — disable. |
| `bychange` | Sorting by update date:<br>`1` — enable;<br>`0` — disable. |

For example, if you want to display a list of pages created by `username` and sort them by the last update date, configure this block:

```
{{mypages bychange=1 user="username"}}
```

