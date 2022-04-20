# Source code formatting

* To highlight a fragment of the source code (for example, the name of a function), enclose the fragment in backquotes ``` ` ```.

* To format multiple lines of the source code, insert three backquotes ` ``` ` in the lines above and below the code.

Example:

* ```
  `exit()` function 
  ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/code-line.png)

    {% endcut %}

* ```
      Start of the code snippet
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

