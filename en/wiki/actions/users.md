# Links to employees and current date

You can add links to employees' profiles on Staff in {{ wiki-name }}. If you hover over such a link, you'll see a summary and photo of the user. To add this link, specify the employee's [username](#staff-ref).

If you want to add a link to an authorized user's profile or the current date to the page, use [macros](#macroses).

## Links to Staff {#staff-ref}

* To add a link to an employee's page on Staff, enter their username after `staff:`:

    `staff:{{ username-oleg }}`

    {% cut "See the result" %}

    ![](../../_assets/wiki/staff-ref.png)

    {% endcut %}

{% if locale == "ru" %}

* In Russian, the employee's first and last name can be declined by case. To do this, add the following case prefixes before the username:

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

* For the link to include a username with a `@`, use the syntax `@username` or `username@`:

    ```
    @{{ username-oleg }} or {{ username-oleg }}@
    ```

    {% cut "See the result" %}

    ![](../../_assets/wiki/staff-ref-login.png)

    {% endcut %}

* If you use `@` with a mailing list name (for example, `tools-dev`), the link will open the intranet search results.

## Macros: username and date {#macroses}

A macro is an action that is executed on a page after it has been saved. Unlike wiki markup elements, after you save a page, macros are replaced by their values in the page source.

| Macro markup | Value | Markup after saving |
| --- | --- | --- |
| `::::` | Name of an authorized user | `staff:{{ username-oleg }}` |
| `::@::` | The name of an authorized user and the current date in the format `/DD.MM.YYYY hh:mm/` | `staff:{{ username-oleg }} /16.12.2021 21:25/` |
| `::+::` | Current date in the format `/DD.MM.YYYY hh:mm/` | `/16.12.2021 21:25/` |

{% note info %}

Macros won't work in [dynamic tables](../create-grid.md) or page comments.

{% endnote %}

