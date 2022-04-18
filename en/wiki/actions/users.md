# Links to employees and current date

You can add a link to an employee's Staff profile on {{ wiki-name }}. When you hover the cursor over the link, the employee's photo and some of their profile information will be displayed. To add the link, you need to [specify the employee's username](#staff-ref).

If you want to add a link to an authorized user profile or the current date, use [macros](#macroses).

## Links to Staff {#staff-ref}

* To add a link to an employee on Staff, enter their username after the `staff:` label:

    `staff:{{ username-oleg }}`

    {% cut "See the result" %}

    ![](../../_assets/wiki/staff-ref.png)

    {% endcut %}

{% if locale == "ru" %}

* If the employee's first and last name must take a certain grammatical case, specify the case before their username:

    ```
    Nominative: {{ username-oleg }}
    Genitive: {{ username-oleg }} or {{ username-oleg }}
    Dative: {{ username-oleg }}
    Accusative: {{ username-oleg }}
    Instrumental: {{ username-oleg }}
    Prepositional: {{ username-oleg }} or {{ username-oleg }}
    ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/staff-ref-cases.png)

    {% endcut %}

{% endif %}

* Use `@login` or `login@`formats to make the link look like the employee's username preceded by the `@` symbol:

    ```
    @{{ username-oleg }} or {{ username-oleg }}@
    ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/staff-ref.png)

    {% endcut %}

* You can also specify a mailing list name (such as `tools-dev`) instead of a username next to the `@` symbol. Then, the link will lead to the intranet search result page.

## Macros: user name and date {#macroses}

A macro is an action that is performed on a page after it is saved. Unlike Wiki markup elements, macros are replaced by their source text value after the page has been saved.

| Macro markup | Value | Markup after saving |
| --- | --- | --- |
| `::::` | Authorized user's name | `staff:{{ username-oleg }}` |
| `::@::` | The name of an authorized user and current date in the `/DD.MM.YYYY hh:mm/` format. | `staff:{{ username-oleg }} /16.12.2021 21:25/` |
| `::+::` | Current date in the `/DD.MM.YYYY hh:mm/` format | `/16.12.2021 21:25/` |

{% note info %}

Macros don't work in [dynamic tables](../create-grid.md) and page comments.

{% endnote %}

