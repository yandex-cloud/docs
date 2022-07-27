# HTML elements

## Tags {#html-tags}

To insert design elements on the page that are not provided for by Markdown markup, you can use HTML tags in the text.

For example:

* ```html
  <p style="color: gray; font-weight: bold;">Gray text</p>
  ```

    {% cut "See the result" %}

    <p style="color: gray; font-weight: bold;">Gray text</p>

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


