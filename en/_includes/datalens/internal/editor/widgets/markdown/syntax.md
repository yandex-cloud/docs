## Basic information about Markdown {#about-markdown}
### Headers {#headers}

To create a header, use the (#) character, for example:

```markdown
# Header h1
## Header h2
### Header h3
#### Header h4
```

Use h1 header as a page header. Then follows a section with h2 header. Use other headers depending on nesting levels. Important! Make sure you maintain the nesting structure of headers.

### Styles {#text-styles}

To make text **bold**, wrap it in double asterisks:

```markdown
This text will be **bold**.
```

To make text _italic_, wrap it in underscores:

```markdown
This text will be _italic_.
```

To make text _**bold and italic**_, use both double asterisks and underscores:

```markdown
This text will be _**bold and italic**_.
This text will be **_bold and italic_**.
```

To make text ~~strikethrough~~, wrap it in double tildes: 

```markdown
This text will be ~~strikethrough~~.
```

### Lists {#lists}

#### Unordered list {#unordered-list}

You can format an unordered (bulleted) list using an asterisk (*), hyphen (-), or plus sign (+). For example, the following Markdown markup:

```markdown
- Item 1
- Item 2
- Item 3
```

will be displayed as:

- Item 1
- Item 2
- Item 3

To make a list nested in another list, add an indent for child list items. For example, the following Markdown markup:

```markdown
- Item 1
  - Item A
  - Item B
- Item 2
```

will be displayed as:

- Item 1
   - Item A
   - Item B
- Item 2

#### Ordered list {#ordered-list}

You can format an ordered (step) list using corresponding numbers. For example, the following Markdown markup:

```
1. First item
1. Second item
1. Third item
```

will be displayed as:

1. First item
2. Second item
3. Third item

To make a list nested in another list, add an indent for child list items. For example, the following Markdown markup:

```
1. First item
    1. Nested item
    1. Nested item
1. Second item
```


### Tables {#tables}

Tables are not included in the Markdown basic specification, but they're supported by GFM.
You can create tables using the vertical bar character (|) and a hyphen (-).
With hyphens, you can create a header for each column. Vertical bars are column separators. To make sure a table is displayed properly, add an empty line before it.

For example, the following Markdown markup:

```markdown
Left column | Right column | Center column
:--- | ---: | :---:
Text | Text | Text
```

will be displayed as:

| Left column | Right column | Center column |
:--- | ---: | :---:
| Text | Text | Text |

To add a line break or a more complex element (such as a list or code block) to a table cell, use an alternative markup:
```
#|
|| **Header1** | **Header2** ||
|| Text | Text ||
|#
```

Sample markup with line breaks and a list:
```
#|
||Text
on two lines
|
- Item 1
- Item 2
- Item 3
- Item 4||
|#
```
See learn more in the [YFM documentation](https://ydocs.tech/en/syntax/tables/multiline).

### Links {#links}

The Markdown syntax for an embedded link consists of the `[link text]` part
that contains the text of a hyperlink and the `(URL)` part with the URL that the link points to:

`[{{ datalens-short-name }}](https://datalens.yandex-team.ru)`

[{{ datalens-short-name }}](https://datalens.yandex-team.ru)

{% if audience == "internal" %}

Ticket keys and usernames are converted to links in Tracker and Staff.

For example, `SOMEQUEUE-123` is converted to the link `https://st.yandex-team.ru/SOMEQUEUE-123` specifying the status and assignee,
while `@login` or `login@` is converted to the link `https://staff.yandex-team.ru/login` with the username.

{% endif %}


### Code inserts {#code}

Using Markdown, you can both embed code snippets in a clause and place them between clauses as separate blocks.

    ```js
    const a = 10;
    ```

This insert is converted to a highlighted code.

```js
const a = 10;
```

Inline code `<html class="ie no-js">`.

```markdown
To embed a code inside clauses, put the code in apostrophes like `<html class="ie no-js">`.
```


### Images {#images}


```markdown
![alt text](https://yastatic.net/q/logoaas/Yandex.Charts.svg "Text of a hint displayed when hovering over the image" =100x200)
```

![alt text](https://yastatic.net/q/logoaas/Yandex.Charts.svg "Text of a hint displayed when hovering over the image")

### Line break

To add a line break in a paragraph, use two spaces ⋅⋅ at the end of a line.
