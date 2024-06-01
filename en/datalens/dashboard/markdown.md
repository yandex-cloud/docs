# Markdown

{{ datalens-short-name }} allows you to use the Markdown markup language in the [{#T}](./widget.md#text) widget on the dashboard.

You can insert explanatory text, links, tables, images, or use formatting to highlight key points.

In text widgets, you can use the following elements:

* [Headers](#headings)
* [Bold and italics](#emphasizing)
* [Text color](#text-color)
* [Lists](#lists)
   * [Simple unordered list](#unordered-list)
   * [Nested unordered list](#unordered-sublist)
   * [Simple ordered list](#ordered-list)
   * [Nested ordered list](#ordered-sublist)
* [Tables](#tables)
* [Links](#links)
* [Code formatting](#code)
   * [Inline code snippet](#inline-code)
   * [Code block](#codeblock)
* [Image](#image)
* [Cuts](#cuts)
* [Tooltips](#term)

## Headers {#headings}

You can use four levels of headings in the widget.
Use `#` to mark up headings.

Syntax example:

```markdown
# Level 1 heading
## Level 2 heading
### Level 3 heading
#### Level 4 heading
```

## Highlighting text {#emphasizing}

Use formatting to highlight key points in your text:

* To make text **bold**, use double `*`:

   ```markdown
   This text will be **bold**.
   ```

* To make text _italic_, use `_`:

   ```markdown
   This text will be _italic_.
   ```

* To combine _****bold and italics****_, use double `*` and `_` at the same time:

   ```markdown
   This text will be _**bold and italic**_.
   This text will be **_bold and italic_**.
   ```

## Text color {#text-color}

You can set the text color this way: `{color}(text)`. The following colors are supported:

* gray
* yellow
* orange
* red
* green
* blue
* violet

For example, the following markup:

```markdown
This text is {green}(green).
```

will be displayed as:

This text is <font color="green">green</font>.

## Lists {#lists}

You can use multiple list types to arrange the data on the dashboard.

### Simple unordered list {#unordered-list}

To make an unordered bulleted list, use characters such as `*`, `-`, or `+`.

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

* Item 1
   * Item A
   * Item B
* Item 2

### Simple ordered list {#ordered-list}

To make an ordered list, use numbers with a `.` or `)`.

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
   1.2 Nested item
1. Second item

## Tables {#tables}

A table consists of a single row with headers, a separator row, and rows with data.

Each row in a table consists of cells that are separated from each other by a `|`.

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

See more in the [YFM documentation](https://ydocs.tech/ru/syntax/tables/multiline).

## Links {#links}

You can use links to enter information related to the dashboard or charts.
For example, you can add links to other dashboards and specify data sources.

A link consists of two parts:

* `[text]`: Link text
* `(link)`: URL or path to the referenced file

For example, the following markup:


```markdown
[link to yandex.ru](https://yandex.ru).
```



will be displayed as:


[link to yandex.ru](https://yandex.ru).




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


## Image {#image}


You can add images from the `*.yandex.ru`, `*.yandex.net`, `yastat.net`, `yastatic.net`, or `storage.yandexcloud.net` domains. The easiest way is to upload and post an image in [{{ objstorage-full-name }}](../../storage/quickstart.md). The service is free of charge for up to 1 GB of standard storage per month.


You can add images of any format.

To upload an image from **{{ objstorage-short-name }}** to a widget:

1. Open the [management console]({{ link-console-main }}).
1. In the top-left corner, click ![image](../../_assets/console-icons/dots-9.svg) and select **{{ objstorage-short-name }}**.
1. [Create a bucket](../../storage/operations/buckets/create.md) with public access.
1. [Upload the image](../../storage/operations/objects/upload.md) to the bucket.
1. Go to the object you got and click **Get link**.

1. Copy the link to the image.

   {% note info %}

   The only supported [object link](../../storage/concepts/object.md#object-url) format is `https://{{ s3-storage-host }}/<bucket>/<key>`.

   {% endnote %}

1. Go to your {{ datalens-name }} dashboard and create a widget named **Text**.
1. Paste the following code in the widget:

   ```markdown
   ![alt text](https://image_link "Text of a hint displayed when hovering over the image" =100x200)
   ```


## Cuts {#cuts}

Use cuts to hide content, e.g., additional information or long blocks of code.

For example, the following markup:

```markdown

{% cut "Cut title" %}

Content displayed on click.

{% endcut %}

```

will be displayed as:

{% cut "Cut title" %}

Content displayed on click.

{% endcut %}


## Tooltips {#term}

Tooltips allow you to display term definitions when clicking a term. Definitions are linked to their respective terms using a term key.

Sample markup:

```markdown

[*term_key]: Term definition which may include _basic_ markup:
* Lists
* Links
* Images, etc.


[Term](*term_key) used in the text.

```


{% note info %}

Currently, you can only use tooltips in code blocks that do not specify a language.

{% endnote %}

