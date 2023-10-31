# Tables

{% include [static-markdown-alert](../../_includes/wiki/static-markdown-alert.md) %}

Simple tables are static tables that are created manually using markup elements.

{{ wiki-name }} also supports table markup using standard [HTML tags](html-code.md).

{% list tabs %}

- Tables in {{ wiki-name }} format

    * To create a table, use the markup:

        ```
        #|
        || Heading 1 | Heading 2| Heading 3 ||
        || cell 11 | cell 12 | cell 13 ||
        || cell 21 | cell 22 | cell 23 ||
        |#
        ```

        {% cut "See the result" %}

        ![](../../_assets/wiki/table-with-border.png)

        {% endcut %}

    * To format a table at full page width without borders, use the markup:

        ```
        #||
        || cell 11 | cell 12 | cell 13||
        || cell 21 | cell 22 | cell 23||
        ||#
        ```

        {% cut "See the result" %}

        ![](../../_assets/wiki/table-without-border.png)

        {% endcut %}

    {% note info %}

    You can use [text styling elements](formatting.md) in table cells.

    {% endnote %}

-  Tables in Markdown format

    Add an empty line before the table.
    To create a table, use the markup:

    ```
    | Heading 1 | Heading 2 | Heading 3 |
    | --- | --- | --- |
    | cell 11 | cell 12 | cell 13 |
    | cell 21 | cell 22 | cell 23 |
    ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/table-with-border.png)

    {% endcut %}

    {% note info %}

    You can use [text styling elements](formatting.md) in table cells.

    {% endnote %}

- Tables in CSV format

    To display [CSV data](csv.md) as a table, use the markup:

    ```
    %%(csv delimiter=; head=1)
    Heading 1;Heading 2;Heading 3
    cell 11;cell 12;cell 13
    cell 21;cell 22;cell 23
    %%
    ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/csv-table.png)

    {% endcut %}

    Markup parameters:

    - `delimiter`: A field separator used in CSV tables.

    - `head`: If set to 1, the first row of the table becomes a heading.

    {% note info %}

    You cannot use text formatting elements in CSV tables.

    {% endnote %}

{% endlist %}
