---
title: Markdown in Editor
description: In this article, you will learn about the Advanced chart widget.
---

# Markdown

Visualization for rendering Markdown, a simplified markup language.

It supports [GitHub Flavored Markdown (GFM)](https://github.github.com/gfm/), except for inline raw HTML, certain plugins, and [Yandex Flavored Markdown](https://diplodoc.com/docs/ru/index-yfm) features.

Charts are rendered using the [@diplodoc/transform](https://www.npmjs.com/package/@diplodoc/transform) library. For more information, see the [relevant Diplodoc article](https://diplodoc.com/docs/ru/tools/transform/).

## Available markup components {#about-markdown}

- [General info](#common-markdown)
- [JavaScript](#javascript)
- [Basic information about Markdown](#about-markdown)
    - [Headers](#headers)
    - [Styles](#text-styles)
    - [Text color](#text-color)
    - [Lists](#lists)
        - [Unordered list](#unordered-list)
        - [Ordered list](#ordered-list)
    - [Tables](#tables)
    - [Cuts](#cuts)
    - [Tabs](#tabs)
    - [Accordion](#accordion)
    - [Links](#links)
    - [Inserting code](#code)
    - [Images](#images)
    - [Emoji](#emoji)
    - [Mermaid diagrams](#mermaid)
    - [Tooltips](#term)

### Headings {#headers}

To create a heading, use the (#) character, for example:

```markdown
# H1 heading
## H2 heading
### H3 heading
#### H4 heading
```

Use h1 as the page heading. For a section, use the h2 heading; for subsections, use the appropriate lower level headings. Make sure you maintain the nesting structure of headings.

### Styles {#text-styles}

To make text **bold**, wrap it in double asterisks:

```markdown
This text is **bold**.
```

To make text _italic_, wrap it in underscores:

```markdown
This text is _italic_.
```

To make text _**bold and italic**_, use both double asterisks and underscores:

```markdown
This text is _**bold and italic**_.
This text is **_bold and italic_**.
```

To apply ~~strikethrough~~ formatting to text, wrap it in double tildes (~~):

```markdown
This text is ~~strikethrough~~.
```

To make text <u>underlined</u>, wrap it in double pluses (++):

```markdown
This text is ++underlined++.
```

To create a <sub>subscript</sub>, wrap the text in tilde characters (~):

```markdown
This text is in ~subscript~.
```

To create a ^superscript^, wrap the text in (^) characters:

```markdown
This text is in ^superscript^.
```

To make text <samp>monospaced</samp>, wrap it in (##) characters:

```markdown
This text is ##monospaced##.
```

To <mark>highlight</mark> text, wrap it in double equal characters (==):

```markdown
This text is ==highlighted==.
```

### Text color {#text-color}

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
This text is {green}green.
```

will be displayed as:

This text is <font color=green>green</font>.

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

To make a list nested in another list, add an indent for child list items. Markup:

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

You can format an ordered (step) list using corresponding numbers. Markup:

```
1. Item 1
1. Item 2
1. Third item
```

will be displayed as:

1. Item 1
2. Item 2
3. Third item

To make a list nested in another list, add an indent for child list items. Here is an example:

```
1. Item 1
    1. Nested item
    1. Nested item
1. Item 2
```

### Tables {#tables}

Tables are not included in the Markdown basic specification, but they're supported by GFM. You can create tables using the pipe character (`|`) and a hyphen (`-`). With hyphens, you can create a header for each column. Vertical bars are column separators. To make sure a table is displayed properly, add an empty line before it.

Markup:

```markdown
Left-aligned column | Right-aligned column | Center-aligned column
:--- | ---: | :---:
Text | Text | Text
```

will be displayed as:

Left-aligned column | Right-aligned column | Center-aligned column
:--- | ---: | :---:
Text | Text | Text

To add a line break or a more complex element (such as a list or code block) to a table cell, use an alternative markup:
```
#|
|| **Heading1** | **Heading2** ||
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


### Cuts {#cuts}

Use `cuts` to hide certain content, e.g., additional information or large blocks of code.

Markup:

```markdown

{% cut "`cut` title" %}

Content displayed on click.

{% endcut %}

```

will be displayed as:

{% cut "`cut` title" %}

Content displayed on click.

{% endcut %}

### Tabs {#tabs}

Use tabs for mutually exclusive sections. For example, to separate instructions for different operating systems.

Markup:

```markdown

{% list tabs %}

- Tab 1 name

  Tab 1 text

  * You can use lists.
  * And **other** markup.

- Tab 2 name

  Tab 2 text

{% endlist %}

```

will be displayed as:

{% list tabs %}

- Tab 1 name

  Tab 1 text

  * You can use lists.
  * And **other** markup.

- Tab 2 name

  Tab 2 text

{% endlist %}

If you want an element to be expanded by default, add the `{selected}` attribute to it:

Markup:

```markdown

{% list tabs %}

- Tab 1 name

  Tab 1 text

- Tab 2 name {selected}

  The item will be expanded by default.

- Tab 3 name

  Tab 3 text

{% endlist %}

```

will be displayed as:

{% list tabs %}

- Tab 1 name

  Tab 1 text

- Tab 2 name {selected}

  The item will be expanded by default.

- Tab 3 name

  Tab 3 text

{% endlist %}

### Accordion {#accordion}

An accordion allows you to collapse or expand content, which is helpful when you need to organize large amounts of information.

Markup:

```markdown
{% list tabs accordion %}

- Name of item 1

  Content for item 1

- Name of item 2

  Content for item 2
 
- Name of item 3

  Content for item 3

{% endlist %}
```

will be displayed as:

{% list tabs accordion %}

- Name of item 1

  Content for item 1

- Name of item 2

  Content for item 2
 
- Name of item 3

  Content for item 3

{% endlist %}

If you want an element to be expanded by default, add the {selected} attribute to it:

Markup:

```markdown
{% list tabs accordion %}

- Name of item 1

  Content for item 1

- Name of item 2 {selected}

  The item will be expanded by default.
 
- Name of item 3

  Content for item 3

{% endlist %}
```

will be displayed as:

{% list tabs accordion %}

- Name of item 1

  Content for item 1

- Name of item 2 {selected}

  The item will be expanded by default.
 
- Name of item 3

  Content for item 3

{% endlist %}

### Links {#links}

The Markdown syntax for an embedded link consists of the `[link text] and `(URL)` :

`[DataLens](https://datalens.yandex.cloud)`

[{{ datalens-short-name }}]({{ link-datalens-main }})

### Inserting code {#code}

Using Markdown, you can both embed code snippets in a clause and place them between clauses as separate blocks.

```js
const a = 10;
```

This insert is converted to a highlighted code.

```js
const a = 10;
```

`<html class="ie no-js">` inline code.

```markdown
To insert inline code, wrap it in backticks: `<html class="ie no-js">`.
```

### Line break

To add a line break in a paragraph, use two spaces (⋅⋅) at the end of a line.

### Tooltips {#term}

Tooltips allow you to display term definitions when clicking a term. Definitions are linked to their respective terms using a term key. Markup:

```markdown

[*term_key]: Term definition which may include _basic_ markup:
* Lists
* Links
* Images, etc.


[Term](*term_key) used in the text.

```

will be displayed as:

`[Term](*term_key)` used in the text.

{% note info %}

Currently, you can only use tooltips in code blocks that do not specify a language.

{% endnote %}

### Images {#images}

```markdown
![alt text](https://yastatic.net/q/logoaas/v2/DataLens.svg "Text for tip on hover" =100x200)
```

![alt text](https://yastatic.net/q/logoaas/v2/DataLens.svg "Text for tip on hover")

### Emoji {#emoji}

To add an emoji, enter a keyword and add a colon (:) on both sides. You can see the list of available keywords in the visual editor.

For example, the following markup:

```markdown
Emoji :smiley:.
```

will be displayed as:

Emoji 😀.

### Mermaid diagrams {#mermaid}

Mermaid is a library for creating diagrams and flowcharts in a browser using a simple markup language. It allows you to create diagrams using a syntax similar to Markdown.

Mermaid has many built-in templates and functions for creating various types of diagrams, such as flowcharts, graphs, trees, Gantt charts, mind maps, and C4 diagrams.

Using text definitions, you can set a description of the structure, which is then converted into a diagram. Markup:

<pre><code>
```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
</code></pre>

will be displayed as:

![mermaid-flowcharts-example](../../../../_assets/datalens/internal/editor/mermaid-flowcharts-example.svg)

See the [Mermaid documentation](https://mermaid.js.org/intro/) for details.

{% note info %}

When using Mermaid, keep the following limitations in mind:

* There is no HTML support.
* You cannot use the `class` attribute to style diagrams.
* You cannot use CSS variables for colors.
* Markdown inside diagram sections is only supported in part (e.g., links do not work).

{% endnote %}

## Examples {#examples}

* [Markdown chart with parameterization](https://datalens.yandex/nvkfwnekf9xy9?tab=x6v#Markdown%20чарт%20с%20параметрами)
* [Mermaid diagrams and flowcharts](https://datalens.yandex/nvkfwnekf9xy9?tab=x6v#Markdown%20чарт%20c%20Mermaid-диаграммами)

```mermaid

[*term_key]: Term definition which may include _basic_ markup:
* Lists
* Links
* Images, etc.

```