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


