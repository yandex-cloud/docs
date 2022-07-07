# Page structure

## Sections and headings {#sections-and-titles}

Add headings to divide a page into sections. To add a heading, insert from 1 to 6 `#` symbols and a space before the heading text. The heading level depends on the number of `#` symbols you use.

You can use a different markup style for the first and second level headings:

- To create a first-level heading, insert any number of `=` signs in the line under the heading.

- To create a second-level heading, insert any number of `-` signs in the line under the heading.

| Markup | Result |
| --- | --- |
| `# The first level header` | ![](../../_assets/wiki/h1.png) |
| `The first level header`<br>`======` | ![](../../_assets/wiki/h1.png) |
| `## The second level header` | ![](../../_assets/wiki/h2.png) |
| `The second level header`<br>`--------------` | ![](../../_assets/wiki/h2.png) |
| `### The third level header` | ![](../../_assets/wiki/h3.png) |
| `#### The fourth level header` | ![](../../_assets/wiki/h4.png) |
| `##### The fifth level header` | ![](../../_assets/wiki/h5.png) |
| `###### The sixth level header` | ![](../../_assets/wiki/h6.png) |

### Get a section link {#section-link}

1. Hover your cursor over the section heading and click the **§** symbol, which will appear to the right of the heading.

1. Copy the cluster address from the browser's address bar.

Learn more in the [{#T} section](../actions/anchor.md).

## Paragraphs {#section_paragraphs}

To start a new paragraph, insert an empty line to separate it from the existing text:

```
First line of a paragraph.
Second line of a paragraph.

New paragraph.
```

{% cut "See the result" %}

![](../../_assets/wiki/new-par.png)

{% endcut %}

{% note info %}

To insert several empty lines between blocks of text, enter a backslash at the beginning of each line: `\`.

{% endnote %}

## Indents {#section_spacing}

- Indentation with spaces is used at the start of each line in second-level and third-level [lists](lists.md).

- If you add spaces at the beginning of a paragraph, they won't be displayed. The paragraph will not have an indent.

- To indent a paragraph, enter several non-breaking spaces using the code ` `.

| Markup | Result |
| --- | --- |
| ![](../../_assets/wiki/spacing1.png) | ![](../../_assets/wiki/spacing2.png) |

## Horizontal line {#section_rulers}

- To insert a horizontal line between parts of your text, enter 3 or more hyphens `-`, <q>asterisks</q>`*`, or underscores `_` inside an empty line.

- If you use hyphens, add another empty line before the horizontal line. Otherwise the previous line will turn into a heading.

| Markup | Result |
| --- | --- |
| `---` | ![](../../_assets/wiki/3-rules.png) |
| `****` | ![](../../_assets/wiki/3-rules.png) |
| `___` | ![](../../_assets/wiki/3-rules.png) |

## Collapsed text {#section-cut}

To collapse a part of your text:

1. In the line before the text, insert the `<{` symbols and the title of the collapsible text.

1. Enter the collapsible text in the new line.

1. At the end of the collapsible text, enter the `}>` symbols.

| Markup | Result |
| --- | --- |
| `<{Read the entire text`<br>`To see the full text,`<br>`click Read more.`<br>`}>` | ![](../../_assets/wiki/cut.png) |

