# Escaping symbols

* To display markup symbols, escape them with a backward slash `\` or tilde `~`:

    ```
    \* — asterisk
    ~+ — plus
    ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/escape-symbols.png)

    {% endcut %}

* To escape all symbols in a certain text fragment, enclose this fragment in double quotes `""`:

    ```
    ""<tag>""
    ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/escape-tag.png)

    {% endcut %}

* If you want to display a backquote inside a source code snippet, place two backquotes on each side of the code snippet ` `` `:

    ```
    ``SELECT `id` FROM `table` ``
    ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/escape-backtick.png)

    {% endcut %}

* All markup symbols in the source code are escaped automatically:

    ```
        Text formatting: 
    
        ```
        *Italic*
        **Bold**
        ```
    ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/escape-codeblock.png)

    {% endcut %}

* Any text enclosed in angle brackets `<...>` is treated like an [HTML tag](html-code.md) and will not be visibly displayed on the page. If you need to display this text, you can escape the text and format it as a code snippet, or replace the opening parenthesis `<` with the code `<`:

    ```
    &lt;tag>
    ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/escape-tag.png)

    {% endcut %}

