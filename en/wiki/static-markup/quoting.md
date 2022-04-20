# Quotations

## Quoting a paragraph

* To quote a paragraph, insert the `>` symbol at the start of the paragraph.

* To create a nested quote, insert the `>>` symbols at the start of the paragraph.

* Add an empty line after the quote to separate it from the following text.

* Use other text formatting elements within quotes, for example: headings, lists, or bold font.

Markup examples:

* ```
  >Quoted text
  ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/quote-short.png)

    {% endcut %}

* ```
  >First-level quote.
  >Second-level quote.
  >
  >>>First level again.
  ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/quote-nested.png)

    {% endcut %}

* ```
  >#### Subtitle
  >* *First* item.
  >* **Second** item.
  >
  >`code snippet`
  ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/quote-formatting.png)

    {% endcut %}

## Long quotes

To quote a long piece of text, enclose the quote inside `<[` and `]>`.

This format also supports quotes within quotes and other markup features.

* ```
  <[First-level quote. 
  >Second-level quote

  First level again.]>
  ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/quote-nested.png)

    {% endcut %}

* ```
  <[#### Subtitle
  * *First* item.
  * **Second** item.

  `code snippet`]>
  ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/quote-formatting.png)

    {% endcut %}

