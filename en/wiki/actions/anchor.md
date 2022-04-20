# Bookmarks on pages

The `anchor` block contains an *anchor*, which is a label that redirects users to specified area on a page. You can't use anchors to redirect users to a specific line in a [dynamic table](../create-grid.md).

## Calling the block {#anchor-call}

```
{{anchor href="anchor"}}
```

or

```
{{a href="anchor"}}
```

## Block parameters {#anchor-params}

| Parameter | Description |
| --- | --- |
| `href` | Required parameter. Contains the anchor name. |
| `title` | Contains the anchor header. |
| `text` | Contains the anchor text. Displayed on the page. |

To insert an anchor link, enter the `#` symbol to the right of the page address followed by the anchor name:

```
{{ wiki-pagename }}/#Anchor
```

You don't have to enter the full address if you want to paste a link to an anchor located on the same page:

```
#Anchor
```

