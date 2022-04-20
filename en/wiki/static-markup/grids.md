# Tables

Static tables do not have any dynamic elements and are marked up manually.

{{ wiki-name }} also supports table markup using standard [HTML tags](html-code.md).

{% list tabs %}

- Tables in the {{ wiki-name }} format

    * To format your table, use the following markup:

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

    * To fit the table to the full page width without borders, use the following markup:

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

    You can use [text formatting](formatting.md) inside table cells.

    {% endnote %}

- Markdown table

    Add an empty line before inserting the table.
    To format your table, use the following markup:

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

    You can use [text formatting](formatting.md) inside table cells.

    {% endnote %}

- Table in CSV format

    To display [CSV data](csv.md) as a table, use the following markup:

    ```
    %%(csv delimiter=; head=1)
    Heading 1; Heading 2; Heading 3
    cell 11;cell 12;cell 13
    cell 21; cell 22; cell 23
    %%
    ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/csv-table.png)

    {% endcut %}

    Markup parameters:

    - `delimiter`: a field separator used in CSV tables.

    - `head`: if set to 1, the first row of the table becomes a header.

    {% note info %}

    You can't use text formatting elements in CSV tables.

    {% endnote %}

{% endlist %}

