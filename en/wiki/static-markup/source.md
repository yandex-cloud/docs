---
title: "Source code formatting in {{ wiki-full-name }}"
description: "In this tutorial, you will learn about the methods of formatting a source code snippet in your text."
---

# Source code formatting

{% list tabs %}

- Old editor

   * To highlight a source code snippet, such as a function name, in the text, wrap it in back quotes (` ` `).

   * To format multiple source code lines, paste three back quotes (` ``` `) in the row preceding the code block and the row following the code block.

   For example:

   * ```
     Function `exit()`
     ```

      {% cut "See the result" %}

      ![](../../_assets/wiki/code-line.png)

      {% endcut %}

   * ```
      Start of a code snippet
      ```
      <?
      phpinfo();
      $s = "Hello, World!\n";
      print $s;
      ```
      End of the code snippet
     ```

      {% cut "See the result" %}

      ![](../../_assets/wiki/listing-nomark.png)

      {% endcut %}

   #### See also

   [{#T}](highlight.md)

{% endlist %}
