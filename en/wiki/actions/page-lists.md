# Creating page lists

## Section pages {#tree}

This block contains a list of all the pages for the selected section.

### Using a block {#tree-call}

```
{{tree for="pageAddress" nomark="0" depth="3" show_redirects="False" show_grids="True" show_files="False" show_owners="False" show_titles="True" show_created_at="False" show_modified_at="False" sort_by="title" sort="asc"}}
```

All parameters of the `not_var{{tree}}` block are optional. The example shows the default parameter values.

### Block parameters (optional) {#tree-params}

| Parameter | Description |
| --- | --- |
| `for` | The address of the page the tree is intended for |
| `page` | Alternative name (alias) for the `for` parameter |
| `depth` | Tree depth. Setting this to `0` makes the depth unlimited |
| `show_redirects` | Displaying redirects in a tree:<br>`true`: Redirects are included in the tree<br>`false`: Redirects are not displayed in the tree |
| `show_grids` | Displaying dynamic tables in a tree:<br>`true`: Dynamic tables are included in the tree<br>`false`: Dynamic tables are not displayed in the tree |
| `show_files` | Displaying attached files in a tree:<br>`true`: Files are included in the tree<br>`false`: Files are not displayed in the tree |
| `show_owners` | Displaying page authors:<br>`true`: Authors are displayed<br>`false`: Authors are hidden |
| `show_titles` | Displaying page titles:<br>`true`: Page titles are displayed<br>`false`: Page titles are hidden |
| `show_created_at` | Displaying page creation dates:<br>`true`: Dates are displayed<br>`false`: Dates are hidden |
| `show_modified_at` | Displaying the dates of page changes:<br>`true`: Dates are displayed<br>`false`: Dates are hidden |
| `sort_by` | Sort pages:<br>`title`: By title<br>`cluster`: By cluster<br>`created_at`: By date of creation<br>`modified_at`: By date of change |
| `sort` | Sorting order:<br>`asc`: Ascending order<br>`desc`: Descending order |

## List of pages linking to a specified page {#backlinks}

This block contains a list of all the pages with links to a specified page.

### Using a block {#backlink-call}

```
{{backLinks for="pageAddress"}}
```

### Block parameters (optional) {#baclink-params}

| Parameter | Description |
| --- | --- |
| `for` | Contains the address of the page the list is intended for. If no parameter is set, a list for the current page is created by default |

## Pages created by me {#mypages}

This block contains the list of all pages created by the user.

### Using a block {#mypages-call}

```
not_var{{mypages}}
```

All `not_var{{mypages}}` block parameters are optional. If no parameters are set, the list of pages created by the user currently reading the list is displayed. Pages are displayed in alphabetical order.

### Block parameters (optional) {#mypages-params}

| Parameter | Description |
| --- | --- |
| `user` | You can display the list of pages created by any user by specifying that user's login in the `user` parameter |
| `bydate` | Sorting by creation date:<br>`1`: Enable<br>`0`: Disable |
| `bychange` | Sorting by date of change:<br>`1`: Enable<br>`0`: Disable |

For example, if you want to display a list of pages created by `username` and sort them by the date of their last update, configure this block:

```
{{mypages bychange=1 user="username"}}
```

