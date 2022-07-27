# Source code formatting

* To format a fragment of source code (like the name of a function), surround it with backquotes (``` ` ```) on both sides.

* To format multiple lines of source code, insert three backquotes (` ``` `) in the line before the actual code starts, and three more in the line after it ends.

Example:

* ```
  `exit()` function 
  ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/code-line.png)

    {% endcut %}

* ```
      Beginning of the code snippet
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

