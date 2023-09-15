# Table of contents

[{{ wiki-name }} pages](../pages-types.md#page) created in the old editor may automatically generate a table of contents based on headings. This is done using a dynamic block named `toc`.

## Adding a table of contents for a page {#single-page}

1. Make sure your page is created in the [old editor](../create-page.md).
1. Make sure the page headings are [marked up properly](../basic-markup.md#markup). To quickly view the table of contents for a page, click ![](../../_assets/wiki/ico-toc.png) in the right-hand panel.
   If there are matching headers on the page, the links in the table of contents may not work correctly.

1. Create a table of contents using a dynamic block:

   ```text
   not_var{{toc}}
   ```

By default, all headings of the current {{ wiki-name }} page are added to the table of contents. You can configure the additional TOC settings using the [advanced parameters](#toc-params).

> Here is an example of a table of contents that includes first (`h1`) to third (`h3`) level headings:
>
> ```text
> {{toc from="h1" to="h3"}}
> ```

### Block parameters (optional) {#toc-params}

| Parameter | Description |
--- | ---
| `from` | Highest level of headings to be included first in the table of contents |
| `to` | Lowest level of headings to be included last in the table of contents |
| `page` | Relative address of the table of contents source page, e.g., `userName/pageName/`; default address of the page where the `toc` block is added |

## Adding a table of contents for a page group {#group-pages}

There are two ways to add a table of contents:

1. Following the [guide](page-lists.md).

1. Using links:

   {% list tabs %}

   - {{ wiki-name }}

      ```text
      ((<link> <page_name>))
      ```

   - Markdown

      ```text
      [<page_name>](<link>)
      ```

   {% endlist %}