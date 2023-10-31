# HTML elements

{% include [static-markdown-alert](../../_includes/wiki/static-markdown-alert.md) %}

## Tags {#html-tags}
To insert on a page design elements that are not included in the Markdown markup language, you can use HTML tags in the text.

For example:

*
   ```html
   <p style="color: gray; font-weight: bold;">Text in gray</p>
   ```
   {% cut "See the result" %}

<p style="color: gray; font-weight: bold;">Text in gray</p>

   {% endcut %}

*
   ```html
   <p style="border-width: 4px; border-style: double; border-color: orange;">Text in a border</p>
   ```

   {% cut "See the result" %}

<p style="border-width: 4px; border-style: double; border-color: orange;">Text in a border</p>

   {% endcut %}

*
   ```html
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


