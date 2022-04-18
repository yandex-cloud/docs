# HTML elements

## Tags {#html-tags}

You can use HTML tags to embed markup elements not supported by Markdown.

Example:

* ```html
  <p style="color: gray; font-weight: bold;">Grey text</p>
  ```

    {% cut "See the result" %}

    <p style="color: gray; font-weight: bold;">Grey text</p>

    {% endcut %}

* ```html
  <p style="border-width: 4px; border-style: double; border-color: orange;">Framed text</p>
  ```

    {% cut "See the result" %}

    <p style="border-width: 4px; border-style: double; border-color: orange;">Framed text</p>

    {% endcut %}

* ```html
  <table border="1">
    <tr><td>Value 1</td><td>Value 2</td></tr>
    <tr><td>Value 3</td><td>Value 4</td></tr>
  </table>
  ```

    {% cut "See the result" %}

    <table border="1">
      <tr><td>Value 1</td><td>Value 2</td></tr>
      <tr><td>Value 3</td><td>Value 4</td></tr>
    </table>

    {% endcut %}

{% if audience == "internal" %}

## Wiki snippets {#snippets}

You can add additional formatting elements to the page using HTML code templates called snippets. Snippets for {{ wiki-name}} are available via the links:

* [Page layout with multiple columns](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#1.razmetkastranicysetka)
* [Buttons](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#2.knopki)
* [Alerts](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#3.alerty)
* [Badges](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#4.bejjdzhi)
* [Icons](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#5.ikonki)
* [Blocks with a table of contents and useful links](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#6.bloksoglavleniemipoleznymissylkami)
* [Images with captions](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#7.izobrazhenijaspodpisjami)
* [Progress bars](https://wiki.yandex-team.ru/wiki/vodstvo/syntax/wiki-snippets/#8.progressbary)

{% endif %}

