# Quotes

## Quoting a paragraph

* To quote a paragraph, add the `>` symbol at the start of that paragraph.

* To create a subquote, add `>>` symbols at the start of the paragraph.

* Separate the quote from the following text with an empty line.

* You can use other kinds of formatting inside quotes, such as headings, lists, or a bold font.

Markup examples:

* ```
  >Quoted text
  ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/quote-short.png)

    {% endcut %}

* ```
  >First-level quote.
  >>Second-level quote.
  >
  >First level again.
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

## Quoting a long text

To quote a long piece of text, enclose the quote between the `<[` and `]>` symbols.

This citation format also supports nested quotes and other markup elements.

* ```
  <[First-level quote. 
  >Second-level quote.

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

