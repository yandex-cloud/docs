# Escaping characters

* To display markup characters, escape them by using the backward slash (`\`) or tilde (`~`):

   ```
   \* — Asterisk.
   ~+ — Plus sign.
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/escape-symbols.png)

   {% endcut %}

* To escape all characters in a certain text fragment, enclose this fragment in double quotes `""`:

   ```
   ""<tag>""
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/escape-tag.png)

   {% endcut %}

* If you want to display a backquote inside a source code snippet, place two backquotes ` `` ` at the beginning and end of the code snippet:

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

* Any text in angle brackets `<...>` is handled as an [HTML tag](html-code.md) and is not explicitly displayed on the page. If you need to display this text, escape it, format it as a code snippet, or replace the opening parenthesis `<` with code `&lt;`:

   ```
   &lt;tag>
   ```

   {% cut "See the result" %}

   ![](../../_assets/wiki/escape-tag.png)

   {% endcut %}