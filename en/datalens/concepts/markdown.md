# Using Markdown in DataLens

{{ datalens-short-name }} allows you to use the Markdown markup language in the [{#T}](dashboard.md#text) widget on the dashboard.
You can insert explanatory text, links, tables, or use formatting to highlight key points.

In text widgets, you can use the following elements:

- [Headings](#headings)
- [Bold and italics](#emphasizing)
- [Lists](#lists)
  - [Simple unordered list](#unordered-list)
  - [Nested unordered list](#unordered-sublist)
  - [Simple ordered list](#ordered-list)
  - [Nested ordered list](#ordered-sublist)
- [Tables](#tables)
- [Links](#links)
- [Code formatting](#code)
  - [Inline code snippet](#inline-code)
  - [Code block](#codeblock)

## Headings {#headings}

You can use four levels of headings in the widget.
Use `#` to mark up headings.

Syntax example:

```markdown
# Level 1 heading
## Level 2 heading
### Level 3 heading
#### Level 4 heading
```

## Highlighted text {#emphasizing}

Use formatting to highlight key points in your text:

* To make text **bold**, use double `*`:

  ```markdown
  This text will be **bold**.
  ```

* To make text _italic_, use `_`:

  ```markdown
  This text will be _italic_.
  ```

* To combine _**bold and italics**_, use double `*` and `_` at the same time:

  ```markdown
  This text will be _**bold and italic**_.
  This text will be **_bold and italic_**.
  ```

## Lists {#lists}

You can use multiple list types to arrange the data on the dashboard.

### Simple unordered list {#unordered-list}

To make an unordered bulleted list, use such characters as `*`, `-`, or `+`.

For example, the following markup:

```markdown
* Item 1
* Item 2
* Item 3
```

will be displayed as:

* Item 1
* Item 2
* Item 3

### Nested unordered list {#unordered-sublist}

To make a nested unordered list, add an indent for the lines with the nested list items. The indent can be from two to five spaces.

For example, the following markup:

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

### Simple ordered list {#ordered-list}

To make an ordered list, use numbers with the `.` or `)` character.

For example, the following markup:

```markdown
1. First item
1. Second item
1. Third item
```

will be displayed as:

1. First item
1. Second item
1. Third item

### Nested ordered list {#ordered-sublist}

To make a nested ordered list, add an indent for the lines with the nested list items. The indent can be from three to six spaces.

For example, the following markup:

```markdown
1. First item
   1. Nested item
   1. Nested item
1. Second item
```

will be displayed as:

1. First item

   1.1. Nested item<br>
   1.2. Nested item
1. Second item

## Tables {#tables}

A table consists of a single row with headers, a separator row, and rows with data.

Each row in a table consists of cells that are separated from each other by `|` characters.

The cells of the separator row only allow the `-` character and `:` character. The colon (`:`) is used at the beginning, end, or on both sides of the cell content of the separator row to indicate left, right, or center alignment of text in the corresponding column, respectively.

A table should be separated from the surrounding text with empty lines.

For example, the following markup:

```markdown
Left-aligned | Right-aligned | Centered
:--- | ---: | :---:
Text | Text | Text
```

will be displayed as:

| Left-aligned | Right-aligned | Centered |
| :--- | ---: | :---: |
| Text | Text | Text |

## Links {#links}

You can use links to enter information related to the dashboard or charts.
For example, you can add links to other dashboards and specify data sources.

A link consists of two parts:

  * `[text]` is the link text.
  * `(link)` is the URL or path to the file referenced.

For example, the following markup:

```markdown
[link to yandex.com](https://yandex.com).
```

will be displayed as:

[link to yandex.com](https://yandex.com).

## Code formatting {#code}

You can use inline code snippets or code blocks.

### Inline code snippet {#inline-code}

Use <code>`</code> to format inline code snippets.

For example, the following markup:

```markdown
A sentence with a `code snippet`.
```

will be displayed as:

A sentence with a `code snippet`.

### Code block {#codeblock}

Use triple <code>`</code> and the programming language name to format your snippet as a code block.

For example, the following markup:

```markdown
    ```kotlin
    val a: Int = 1
    ```
```

will be displayed as a highlighted Kotlin code snippet:

```kotlin
val a: Int = 1
```

