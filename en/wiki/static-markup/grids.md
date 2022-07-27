# Tables

Simple tables are static tables that are created manually using markup elements.

{{ wiki-name }} also supports table markup using standard [HTML tags](html-code.md).

{% list tabs %}

- Table in {{ wiki-name }} format

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

    In table cells, you can use [text styling elements](formatting.md).

    {% endnote %}

- Markdown table

    Add an empty row before the table.
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

    In table cells, you can use [text styling elements](formatting.md).

    {% endnote %}

- Table in CSV format

    To display [data in CSV format](csv.md) as a table, use the markup:

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

    - `delimiter` — a field separator used in CSV tables.

    - `head` — if set to 1, the first row of the table becomes a title.

    {% note info %}

    CSV tables don't support any other text markup.

    {% endnote %}

{% endlist %}

