# Bookmarks on pages

The `anchor` block contains an *anchor* that enables users to navigate to a certain place on the page. You can't use anchors to navigate to rows in a [dynamic table](../create-grid.md).

## Using the block {#anchor-call}

```
{{anchor href="anchor"}}
```
or
```
{{a href="anchor"}}
```

## Block parameters {#anchor-params}

| Parameter | Description |
--- | --- 
| `href` | Required parameter. Contains the anchor name. |
| `title` | Contains the anchor heading. |
| `text` | Contains the anchor text. Shown on the page. |

To insert an anchor link, add the `#` symbol to the right of the page address and place the anchor name after it:

```
{{ wiki-pagename }}/#Anchor
```

To add a link to an anchor on the same page, you don't need to specify the full URL:

```
#Anchor
```
