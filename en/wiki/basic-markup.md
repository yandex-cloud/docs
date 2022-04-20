# Formatting text

You can format text using special symbols called markup elements. Markup elements are used to bold or italize a piece of text, add headings and lists to a page, embed links, images, tables, and more.

To add markup elements to your page, use the [formatting toolbar](#buttons) or type [markup symbols](#markup) on your keyboard. You'll see the result in the preview panel on the right.

## Formatting toolbar {#buttons}

Use the toolbar at the top of the page to add common formatting elements to the text.

![](../_assets/wiki/format_pane.png)

There are two ways you can use the formatting toolbar:

- To add a markup element to your text, place the cursor in the desired position and click a button on the formatting toolbar. A markup template will appear in the text. Insert your own text in the template. Clicking **Add link** or **Embed code** will open a new window. Enter your text in the window and click **Add**.

- To format text that has already been added to the page, select a text fragment and click a button on the formatting toolbar.

To undo text formatting, delete the markup symbols manually.

{% note info %}

You may notice that the toolbar buttons create markup symbols that are different from the Markdown markup. This markup type is supported along with Markdown and is correctly displayed on the page.

{% endnote %}

## Markup elements {#markup}

{{ wiki-name }} supports [Markdown markup]({{ link-about-markdown }}) with additional formatting elements that are not present in the standard Markdown syntax.

This section lists the most common markup features. For a complete list of supported elements, see [{#T}](static-markup.md).

| Element | Markup | Result |
| --- | --- | --- |
| Headings | `# The first level header`<br/>`## The second level header`<br/>`### The third level header` | ![](../_assets/wiki/h1-h3.png) |
| New paragraph | `First line of the paragraph.`<br/>`Second line of the paragraph.`<br/><br/>`New paragraph.` | ![](../_assets/wiki/new-par.png) |
| Horizontal line | `---` | ![](../_assets/wiki/hr.png) |
| Bold | `**Bold text**` | ![](../_assets/wiki/bold.png) |
| Italics | `*Italic text*` | ![](../_assets/wiki/italic.png) |
| Underline | `__Underlined text__` | ![](../_assets/wiki/underlined.png) |
| Strikethrough | `~~Strikethrough text~~` | ![](../_assets/wiki/crossed.png) |
| Highlighted text | `??Highlighted text??` | ![](../_assets/wiki/red-background.png) |
| Red text | `!!Red text!!` | ![](../_assets/wiki/red-colored.png) |
| Colored text.<br/><br/>Supported colors:<br/><br/><ul><li>`red`;</li><li>`green`;</li><li>`blue`;</li><li>`grey`/`gray`;</li><li>`yellow`;</li><li>`cyan`;</li><li>`orang`;</li><li>`violet`.</li></ul> | `!!(blue)Blue text!!` | ![](../_assets/wiki/colored.png) |
| Numbered list | `1. List item`<br/>`2. List item`<br/>`3. List item` | ![](../_assets/wiki/ol-flat.png) |
| Bulleted list | `- List item`<br/>`- List item`<br/>`- List item` | ![](../_assets/wiki/ul-flat.png) |
| Link | `[link text](http://example.com/)` | ![](../_assets/wiki/hyperlink.png) |
| Image | `![Alternative text](yandex-logo.png)` | ![](../_assets/wiki/logo95x37x8.png) |
| Quotations | `>Quoted text` | ![](../_assets/wiki/quote-short.png) |
| Collapsed text | `<{Read the entire text`<br/>`you need to click the "Read the entire text" link.`<br/>`}>` | ![](../_assets/wiki/cut.png) |
| Code in the line | ``` `code snippet` ``` | ![](../_assets/wiki/source-code-2.png) |
| Code block | ` ```php`<br/>`<?`<br/>`phpinfo();`<br/>`$s = "Hello, World!\n";`<br/>`print $s;`<br/>` ``` ` | ![](../_assets/wiki/code-block.png) |

#### See also

- [{#T}](add-image.md)

- [{#T}](add-grid.md)

- [{#T}](attach-file.md)

- [{#T}](actions/toc.md)

