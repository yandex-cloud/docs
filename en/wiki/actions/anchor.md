# Bookmarks on pages

To go to the specified area on the current or any other page, use an *anchor*:

1. Open the page in [edit mode](../edit-page.md) and add to its text a label using the [`anchor` block](#anchor-call).

1. When generating a link to the specified part of the page, [insert an anchor link](#add-anchor-to-link).

Clicking the link will redirect the user to the part of the page where the label is placed.

{% note info %}

You cannot use anchors to navigate to rows in a [dynamic table](../create-grid.md).

{% endnote %}

## Adding an anchor block {#anchor-call}

```
{{anchor href="anchor_name"}}
```
or
```
{{a href="anchor_name"}}
```

### Block parameters {#anchor-params}

| Parameter | Description |
--- | ---
| `href` | This parameter is required. Contains the anchor name. Do not use spaces in the anchor name. |
| `title` | Contains the anchor heading. |
| `text` | Contains the anchor text. Shown on the page. |


## Inserting an anchor link {#add-anchor-to-link}

Add the `#` character to the right of the page URL and place the anchor name after it:

```
{{ wiki-pagename }}/#anchor_name
```

To add a link to an anchor on the same page, you don't need to specify the full URL:

```
#anchor_name
```
