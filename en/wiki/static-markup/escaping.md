---
title: Escaping characters in {{ wiki-full-name }}
description: In this tutorial, you will learn about the methods of escaping characters in your text.
---

# Escaping characters

{% list tabs %}

- New editor

   {% include [static-markdown-alert](../../_includes/wiki/static-markdown-alert.md) %}

   * If you want to display a backquote inside a source code fragment, enclose the code fragment in double backquotes (` `` `):

      ```
      ``SELECT `id` FROM `table` ``
      ```

      {% cut "See the result" %}

      ![](../../_assets/wiki/escape-backtick.png)

      {% endcut %}

   * All markup characters placed in the source code are escaped automatically:

      ```
          Formatting text:

          ```
          *Italics*
          **Bold**
          ```

      ```

      {% cut "See the result" %}

      ![](../../_assets/wiki/escape-codeblock.png)

      {% endcut %}

   * Any text in angle brackets (`<...>`) is handled as an [HTML tag](html-code.md) and is not explicitly displayed on the page. If you need to display this text, escape it, format it as a code snippet, or replace the opening angle bracket (`<`) with the `&lt;` code:

      ```
      &lt;tag>
      ```

      {% cut "See the result" %}

      ![](../../_assets/wiki/escape-tag.png)

      {% endcut %}

- Old editor

   * To display markup characters, escape them by using a backslash (`\`) or tilde (`~`):

      ```
      \*: Asterisk
      ~+: Plus sign
      ```

      {% cut "See the result" %}

      ![](../../_assets/wiki/escape-symbols.png)

      {% endcut %}

   * To escape all characters in a certain text fragment, enclose this fragment in double quotes (`""`):

      ```
      ""<tag>""
      ```

      {% cut "See the result" %}

      ![](../../_assets/wiki/escape-tag.png)

      {% endcut %}

   * If you want to display a backquote inside a source code fragment, enclose the code fragment in double backquotes (` `` `):

      ```
      ``SELECT `id` FROM `table` ``
      ```

      {% cut "See the result" %}

      ![](../../_assets/wiki/escape-backtick.png)

      {% endcut %}

   * All markup characters placed in the source code are escaped automatically:

      ```
          Formatting text:

          ```
          *Italics*
          **Bold**
          ```

      ```
      {% cut "See the result" %}

      ![](../../_assets/wiki/escape-codeblock.png)

      {% endcut %}

   * Any text in angle brackets (`<...>`) is handled as an [HTML tag](html-code.md) and is not explicitly displayed on the page. If you need to display this text, escape it, format it as a code snippet, or replace the opening angle bracket (`<`) with the `&lt;` code:

      ```
      &lt;tag>
      ```

      {% cut "See the result" %}

      ![](../../_assets/wiki/escape-tag.png)

      {% endcut %}

{% endlist %}