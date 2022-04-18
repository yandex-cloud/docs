# Table of contents

You can embed a table of contents on your Wiki page. The table is generated automatically based on page headings. To do this:

1. Make sure that the Wiki page headings are [correctly marked up](../basic-markup.md#markup). To preview the table of contents for a Wiki page, click on the icon on the left-hand panel ![](../../_assets/wiki/ico-toc.png).
If the page has repeating headings, the links in the table of contents may work incorrectly.

1. Create a table of contents using a dynamic block:

    ```
    not_var{{toc}}
    ```

By default, all headings from the Wiki page are automatically included in the table of contents. You can change how your table of contents is displayed by using [additional parameters](#toc-params).

> An example of a table of contents that includes first- (`h1`) to third-level (`h3`) headings.
>
>```
>{{toc from="h1" to="h3"}}
>```

## Block parameters (optional) {#toc-params}

| Parameter | Description |
| --- | --- |
| `from` | Highest heading level to be included in the table of contents. |
| `to` | Lowest heading level to be included in the table of contents. |
| `page` | Relative address of the page used for compiling the table of contents. For example: `userName/pageName/`. By default, this refers to the address of the page with the `toc` block. |

