# Dynamic blocks

Using a dynamic block, you can insert a fragment into a [Wiki page](pages-types.md#page) with content generated automatically based on the page data or information from an external source.

You can use dynamic blocks to:

* Make [page lists](actions/page-lists.md) related to a specified page.

* Embed a [dynamic table](actions/grid-reference.md) in your Wiki page.

* Generate a document's [table of contents](actions/toc.md).

* Embed [objects from external sources](actions/iframe.md) in your Wiki page.

* Set up integration with [{{ forms-full-name }}](actions/forms.md) and [{{ tracker-full-name }}](actions/tracker.md).

General format for calling dynamic blocks:

```
{{blockName parameter1="value1" parameter2="value2" ...}}
```

### See also

* [{#T}](static-markup.md)
* [{#T}](formatter.md)