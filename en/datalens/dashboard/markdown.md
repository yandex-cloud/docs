# Markdown

{{ datalens-short-name }} lets you use the Markdown markup language in the [{#T}](./widget.md#text) widget on the dashboard.
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

* Use double `*` for **bold**:

  ```markdown
  This text will be **bold**.
  ```

* Use `_` for _italic_:

  ```markdown
  This text will be _italic_.
  ```

* To combine **_bold and italics_**, use double `*` and `_` at the same time:

  ```markdown
  This text will be **_bold and italic_**.
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

This text is <font color=green>green</font>.

## Lists {#lists}

You can use multiple list types to arrange the data on the dashboard.

### Simple unordered list {#unordered-list}

To make an unordered bulleted list, use `*`, `-`, or `+`.

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
   1.2. Nested item
1. Second item

## Tables {#tables}

A table consists of a single row with headers, a separator row, and rows with data.

Each table row consists of cells that are separated from each other by `.|`.

In the separator row cells, only `-` and `:` can be used. The colon (`:`) is used at the beginning, end, or on both sides of the separator row cell content to indicate left, right, or center alignment of text in the column, respectively.

A table should be separated from the surrounding text with empty lines.

For example, the following markup:

```markdown
Left-aligned | Right-aligned | Centered
:--- | ---: | :---:
Text | Text | Text
```

will be displayed as:

Left-aligned | Right-aligned | Centered
:--- | ---: | :---:
Text | Text | Text

To add a line break or a more complex element (such as a list or code block) to a table cell, use an alternative markup:

```
#|
|| **Header_1** | **Header_2** ||
|| Text | Text ||
|#
```

Sample markup with line breaks and a list:

```
#|
||Text
in two lines
|
- Item 1
- Item 2
- Item 3
- Item 4||
|#
```

For more information, see the [YFM documentation](https://ydocs.tech/ru/syntax/tables/multiline).

## Links {#links}

You can use links to enter information related to the dashboard or charts.
For example, you can add links to other dashboards and specify data sources.

A link consists of two parts:

* `[text]`: Link text.
* `(link)`: URL or path to the referenced file.

For example, the following markup:


```markdown
[link to yandex.ru](https://yandex.ru).
```


will be displayed as:


[link to yandex.ru](https://yandex.ru).



## Code formatting {#code}

You can use inline code snippets or code blocks.

### Inline code snippet {#inline-code}

Use <code>`</code> to format an inline code snippet.

For example, the following markup:

```markdown
A sentence with a `code snippet`.
```

will be displayed as:

A sentence with a `code snippet`.

### Code block {#codeblock}

Use triple <code>`</code> and the appropriate programming language name to format your snippet as a code block.

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



You can add images from the [{{ objstorage-full-name }}](../../storage/quickstart.md) storage to the widget. To learn more about the service pricing plans, see [{#T}](../../storage/pricing.md). Images from external sources are not supported.




You can add images of any format using [object links](../../storage/concepts/object.md#object-url) in `https://{{ s3-storage-host }}/<bucket>/<key>` format.


To upload an image from **{{ objstorage-short-name }}** to a widget:

1. Open the [management console]({{ link-console-main }}).
1. In the top-left corner, click ![image](../../_assets/console-icons/dots-9.svg) and select **{{ objstorage-short-name }}**.
1. [Create a bucket](../../storage/operations/buckets/create.md).
1. [Upload the image](../../storage/operations/objects/upload.md) to the bucket.
1. Go to the object you got and click **Get link**.
1. Specify link lifetime and copy the link.

   {% note warning %}

   When the specified lifetime expires, the image will become unavailable (30 days maximum).

   {% endnote %}

1. Open the dashboard in {{ datalens-name }} and [create](../operations/dashboard/add-text.md) a **Text** widget.
1. Paste the following code in the widget:

   ```markdown
   ![alt text](https://link_to_image "Text for tip on hover" =100x200)
   ```

{% cut "How to create a permanent link" %}

For the uploaded image to be permanently available, open access to it via an [ACL](../../storage/concepts/acl.md) object.

{% note warning %}

Public access to the file is granted to an unlimited number of anonymous users. For more information about methods of access management in {{ objstorage-name }}, see the [relevant documentation](../../storage/security/overview.md).

{% endnote %}

1. Open the [management console]({{ link-console-main }}).
1. In the top-left corner, click ![image](../../_assets/console-icons/dots-9.svg) and select **{{ objstorage-short-name }}**.
1. [Create a bucket](../../storage/operations/buckets/create.md). When selecting a bucket name, use these [recommendations](../../storage/concepts/bucket.md#naming).
1. [Upload the image](../../storage/operations/objects/upload.md) to the bucket.
1. Configure an ACL for the object you created:

   1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the object name and select **{{ ui-key.yacloud.storage.bucket.button_action-permissions }}**.
   1. Grant the `READ` permission to the `allUsers` group.

1. Make a link to the object in the bucket in `https://{{ s3-storage-host }}/<bucket>/<key>` format, where:

   * `<bucket>`: Bucket name.
   * `<key>`: Object [key](../../storage/concepts/object.md#key) (file path).

1. Open the dashboard in {{ datalens-name }} and [create](../operations/dashboard/add-text.md) a **Text** widget.
1. Paste the following code in the widget:

   ```markdown
   ![alt text](https://link_to_image "Text for tip on hover" =100x200)
   ```

{% endcut %}




