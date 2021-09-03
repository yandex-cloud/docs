# Quotations

## Quoting a paragraph

- To quote a paragraph, add the `>` symbol at the start of that paragraph.

- To create a subquote, add `>>` symbols at the start of the paragraph.

- After you're finished, add an empty line before writing the rest of the text.

- You can use other kinds of formatting inside quotes, such as headings, lists, or bold font.

Markup examples:

- ```
  >Quoted text
  ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/qote-short.png)

    {% endcut %}

- ```
  >The first level of quoting.
  >>Nested quote.
  >
  >Back to the first level.
  ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/quote-nested.png)

    {% endcut %}

- ```
  >#### Subheading
  > * *First* list item.
  >* **Second** list item.
  >
  >`code snippet`
  ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/quote-formatting.png)

    {% endcut %}

## Quoting a long text

To quote a long piece of text, enclose the quote between the `<[` and `]>` symbols.

This type of quote also supports subquotes and other markup featues.

- ```
  <[The first level of quoting. 
  >Nested quote.

  Back to the first level.]>
  ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/quote-nested.png)

    {% endcut %}

- ```
  <[#### Subheading
  * *First* list item.
  * **Second** list item.

  `code snippet`]>
  ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/quote-formatting.png)

    {% endcut %}

