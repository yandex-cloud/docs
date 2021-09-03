# Inserting a table of contents

You can insert a table of contents automatically compiled from page headings. To do this:

1. Make sure the page headings have the [correct markup](basic-markup.md#headers).

1. Create a table of contents using a dynamic block:

    ```
    not_var{{toc}}
    ```

By default, all the titles of the current page will be included in the table of contents. You can configure the output of the table of contents using [additional parameters](actions/objects.md#toc).

> An example of a table of contents that includes first (`h1`) to third (`h3`) level headings.
>
>```
>{{toc from="h1" to="h3"}}
>```

{% note info %}

To quickly view the page's table of contents, click on the left panel ![](../_assets/wiki/ico-toc.png).

{% endnote %}

