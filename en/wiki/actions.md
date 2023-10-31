# Dynamic blocks

{% include [actions-alert](../_includes/wiki/actions-alert.md) %}

Using a dynamic block, you can insert a fragment with content generated automatically based on the page info data or information from an external source.

You can use dynamic blocks to:

* Make [page lists](actions/page-lists.md) related to a specified page.

* Embed a [dynamic table](actions/grid-reference.md).

* Generate a document's [table of contents](actions/toc.md).

* Insert [objects from external sources](actions/iframe.md) into your page.

* Set up integration with [{{ forms-full-name }}](actions/forms.md) and [{{ tracker-full-name }}](actions/tracker.md).

General format for calling dynamic blocks:

```
{{blockName parameter1="value1" parameter2="value2" ...}}
```

### See also

* [{#T}](static-markup.md)
* [{#T}](formatter.md)