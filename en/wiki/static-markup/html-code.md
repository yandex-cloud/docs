---
title: "HTML elements available in {{ wiki-full-name }}"
description: "In this tutorial, you will learn which HTML elements are available in {{ wiki-name }}."
---

# HTML elements

## Tags {#html-tags}

{% list tabs %}

- New editor

   {% include [static-markdown-alert](../../_includes/wiki/static-markdown-alert.md) %}

   The inserted HTML code in this type of editor will be displayed as text:

   For example:

   ```html
   <table border="1">
     <tr><td>Value 1</td><td>Value 2</td></tr>
     <tr><td>Value 3</td><td>Value 4</td></tr>
   </table>
   ```
   {% cut "See the result" %}
   ```
   <table border="1">
   <tr><td>Value 1</td><td>Value 2</td></tr>
   <tr><td>Value 3</td><td>Value 4</td></tr>
   </table>
   ```
   {% endcut %}


   In this type of editor, we recommend adding an HTML code to a page using the [visual editor](../pages-types.md#new-editor). Use the ![](../../_assets/wiki/svg/link.svg) button on the taskbar to insert the code.

- Old editor

   {% note alert %}

   Concurrent use of HTML and {{ wiki-name }} markup may cause unpredictable errors in HTML. This is due to markup overlaps and, consequently, violations of the page structure.

   {% endnote %}

   To insert on a page design elements that are not included in the Markdown markup language, you can use HTML tags in the text.

   For example:

   * ```html
     <p style="color: gray; font-weight: bold;">Text in gray</p>
     ```
       {% cut "See the result" %}

       <p style="color: gray; font-weight: bold;">Text in gray</p>

       {% endcut %}

   * ```html
     <p style="border-width: 4px; border-style: double; border-color: orange;">Text in a border</p>
     ```

       {% cut "See the result" %}

       <p style="border-width: 4px; border-style: double; border-color: orange;">Text in a border</p>

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

{% endlist %}

