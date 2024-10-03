---
title: '{{ wiki-full-name }} release notes for February 2024'
description: Check out {{ wiki-full-name }} release notes for February 2024.
---

# {{ wiki-full-name }} release notes: February 2024

* [Sorting in the tree section](#edit-tree-sort)
* [Converting a heading into a paragraph](#title-paragraph-convert)

## Sorting in the _tree_ section {#edit-tree-sort}

The new editor now allows sorting pages of a cluster in the [tree](../actions/page-lists.md#tree) section. To do this:

1. In the section description, add the `sort_by` parameter and specify the field for sorting:

   * `title`: By heading
   * `cluster`: By cluster
   * `created_at`: By creation date
   * `modified_at`: By modification date

1. (Optional) Specify the sorting order in the `sort` parameter:

   * `asc`: In the ascending order
   * `desc`: In the descending order

For example, use the following for sorting by heading in the descending order:

```
{{ tree sort_by="title" sort="desc"}}
```

## Converting a heading into a paragraph {#title-paragraph-convert}

In the new editor, when [formatting a text](../wysiwyg/text-format.md#format-wysiwyg), a heading-to-text conversion takes place if you repeatedly select the same level heading for it.

You can now select the ![](../../_assets/console-icons/text.svg) **Text** level after clicking ![](../../_assets/console-icons/heading.svg) ![](../../_assets/console-icons/chevron-down.svg) on the toolbar.