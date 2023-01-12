# Source code formatting

* To highlight a source code snippet, such as a function name, in the text, wrap it in back quotes ``` ` ```.

* To format multiple source code lines, paste three back quotes ` ``` ` in the row preceding the code block and the row following the code block.

Example:

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
