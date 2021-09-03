# Page structure

## Sections and headings {#sections-and-titles}

Add headings to divide a page into sections. To format the headings, insert 1-6  `#` symbols and a space before the heading text. The heading level changes based on how many `#` symbols you type.

You can use a different markup style for the first- and second-level headings:

- For a first level heading, insert any number of `=` symbols in the line following the heading.

- For a second-level heading, insert any number of hyphens `-` in the line following the heading.

| Markup | Result |
| --- | --- |
| `# The first level header` | ![](../../_assets/wiki/h1.png) |
| `The first level header`<br>`======` | ![](../../_assets/wiki/h1.png) |
| `## The second level header` | ![](../../_assets/wiki/h2.png) |
| `The second level header`<br>`--------------` | ![](../../_assets/wiki/h2.png) |
| `### The third level header` | ![](../../_assets/wiki/h3.png) |
| `#### The forth level header` | ![](../../_assets/wiki/h4.png) |
| `##### The fifth level header` | ![](../../_assets/wiki/h5.png) |
| `###### The sixth level header` | ![](../../_assets/wiki/h6.png) |

### Get a link to the section {#section-link}

1. Hover over the section heading and click **§**, which will appear to the right of the heading.

1. Copy the cluster address from the browser's address bar.

Read more in [{#T}](../actions/objects.md#anchor).

## Paragraphs {#section_paragraphs}

To start a new paragraph, insert an empty line after the previous one:

```
First line of a paragraph.
Second line of a paragraph.

New paragraph.
```

{% cut "See the result" %}

![](../../_assets/wiki/new-par.png)

{% endcut %}

{% note info %}

To insert several empty lines between blocks of text, insert a backslash `\` at the beginning of each line.

{% endnote %}

## Margins {#section_spacing}

- Indents created with spaces at the beginning of the line are used for formatting second- and third-level [lists](lists.md).

- If you add spaces to the beginning of a paragraph, they will be ignored. The paragraph will be displayed without indentation.

- To indent a paragraph, insert a few non-breaking spaces using the code `&nbsp;`.

| Markup | Result |
| --- | --- |
|![](../../_assets/wiki/spacing1.png) | ![](../../_assets/wiki/spacing2.png) |

## Horizontal line {#section_rulers}

- To insert a horizontal line between parts of the text, insert three or more hyphens `-`, <q>asterisks</q>`*`, or underscores `_` in a row on an empty line.

- If you use hyphens, add an empty line before the line. Otherwise the previous line will turn into a heading.

| Markup | Result |
| --- | --- |
| `---` | ![](../../_assets/wiki/3-rules.png) |
| `****` | ![](../../_assets/wiki/3-rules.png) |
| `___` | ![](../../_assets/wiki/3-rules.png) |

## Collapsed text {#section-cut}

To make part of the page's text collapsable:

1. In the line before the text, insert the symbols `<{` and the heading of the collapsable text.

1. On a new line, enter the text that will be hidden under the collapsable section.

1. After the text, insert the symbols `}>`.

| Markup | Result |
| --- | --- |
| `<{ Read the entire text`<br>`This text can be seen,`<br>`by clicking the "read all" link.`<br>`}>` | ![](../../_assets/wiki/cut.png) |

