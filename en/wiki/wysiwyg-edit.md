# Working in the new editor

The visual editor only works on pages created in the [new editor](pages-types.md#wysiwyg).

You cannot convert pages created in the new editor into pages of the old editor and cannot use Wiki markup and [dynamic blocks](actions.md) on them.

## Editing a page {#edit-page}

To edit a page [created](wysiwyg-create.md) in the new editor:

1. Open the page you need and click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-comment.edit }}** in the top-right corner.

1. Make changes to the page. To format text and lists, embed tables and images, use the following toolbar buttons:

   ![](../_assets/wiki/tools-panel.png)

1. To cancel or repeat an action, use ![](../_assets/wiki/svg/wysiwyg/undo.svg) (**Ctrl** + **Z** or **⌘** + **Z** on Mac OS) and ![](../_assets/wiki/svg/wysiwyg/redo.svg) (**Ctrl** + **Shift** + **Z** or **⌘** + **Shift** + **Z** on Mac OS).

1. To format text using [{{ yfm }} markup]({{ yfm-link }}), click ![](../_assets/wiki/svg/wysiwyg/mode-wswg.svg) to the right of the toolbar and select **Markdown markup** mode.

1. To disable the toolbar, click ![](../_assets/wiki/svg/wysiwyg/mode-wswg.svg) next to it and turn off the **Toolbar** option. If the toolbar is disabled, you can run commands using the `/` character or the `+` button.

## Formatting text {#format-wysiwyg}

To format text, use the following toolbar buttons or keyboard shortcuts:

| Formatting | Toolbar button | Windows shortcuts | Mac OS shortcuts |
--- | --- | --- | ---
| Header | ![](../_assets/wiki/svg/wysiwyg/header.svg) ![](../_assets/wiki/svg/wysiwyg/show.svg) | **Ctrl** + **Alt** + **1**—**6** | **⌘** + **⌥** + **1**—**6** |
| Bold text | ![](../_assets/wiki/svg/wysiwyg/bold.svg) | **Ctrl** + **B** | **⌘** + **B** |
| Italic | ![](../_assets/wiki/svg/wysiwyg/italic.svg) | **Ctrl** + **I** | **⌘** + **I** |
| Underlined text | ![](../_assets/wiki/svg/wysiwyg/underline.svg) | **Ctrl** + **U** | **⌘** + **U** |
| Strikethrough text | ![](../_assets/wiki/svg/wysiwyg/strikethrough.svg) | **Ctrl** + **Shift** + **S** | **⌘** + **Shift** + **S** |
| Colored text | ![](../_assets/wiki/svg/wysiwyg/color.svg) ![](../_assets/wiki/svg/wysiwyg/show.svg) | — | — |

## Lists {#lists-wysiwyg}

To add a list, select one or more paragraphs and use the following toolbar buttons or keyboard shortcuts:

| List | Toolbar button | Windows shortcuts | Mac OS shortcuts |
--- | --- | --- | ---
| Bulleted list | ![](../_assets/wiki/svg/wysiwyg/ul.svg) | **Ctrl** + **Shift** + **L** | **⌘** + **Shift** + **L** |
| Numbered list | ![](../_assets/wiki/svg/wysiwyg/ol.svg) | **Ctrl** + **Shift** + **M** | **⌘** + **Shift** + **M** |
| Decrease indent | ![](../_assets/wiki/svg/wysiwyg/nested-list-up.svg) | **Shift** + **⇥** | **Shift** + **⇥** |
| Increase indent | ![](../_assets/wiki/svg/wysiwyg/nested-list-down.svg) | **⇥** | **⇥** |
| Checklist (checkbox) | ![](../_assets/wiki/svg/wysiwyg/checkbox.svg) | — | — |

## Block formatting {#block-wysiwyg}

To add a quote, note, cut, formatted block, or block section, select one or more paragraphs and use the following toolbar buttons or keyboard shortcuts:

| Block | Toolbar button | Windows shortcuts | Mac OS shortcuts |
--- | --- | --- | ---
| Comment | ![](../_assets/wiki/svg/wysiwyg/note.svg) | **Ctrl** + **Alt** + **8** | **⌘** + **⌥** + **8** |
| Cut | ![](../_assets/wiki/svg/wysiwyg/cut.svg) | **Ctrl** + **Alt** + **7** | **⌘** + **⌥** + **7** |
| Quote | ![](../_assets/wiki/svg/wysiwyg/quote.svg) | **Ctrl** + **>** | **⌘** + **>** |
| Formatting block | ![](../_assets/wiki/svg/wysiwyg/block.svg) | — | — |
| Section | ![](../_assets/wiki/svg/wysiwyg/section.svg) | — | — |

For the **Note** block, you can choose its type: <q>Note</q>, <q>Advice</q>, <q>Important</q>, or <q>Attention</q>.

To configure the visual representation of a **Formatting block**, click ![](../_assets/wiki/svg/wysiwyg/set.svg) in the top-right corner and set its parameters.

Under **Section**, you can select:
* Number and position of cells:
   * ![](../_assets/wiki/svg/wysiwyg/section-two-cells.svg) **Two cells**
   * ![](../_assets/wiki/svg/wysiwyg/section-big-right.svg) **Large on the right**
   * ![](../_assets/wiki/svg/wysiwyg/section-big-left.svg) **Large on the left**
   * ![](../_assets/wiki/svg/wysiwyg/section-three-cells.svg) **Three cells**
* Position of the entire section:
   * ![](../_assets/wiki/svg/wysiwyg/section-all-left.svg) **Entire section on the left**
   * ![](../_assets/wiki/svg/wysiwyg/section-all-center.svg) **Entire section in the center**
   * ![](../_assets/wiki/svg/wysiwyg/section-all-right.svg) **Entire section on the right**

To add a paragraph separator, switch to **Editor** mode, open the list of commands using the `/` character, and select ![](../_assets/wiki/svg/wysiwyg/divider.svg) **Separator**.

## Code formatting {#src-wysiwyg}

To add a code block, select a line or paragraph and use the following toolbar buttons or keyboard shortcuts:

| Block | Toolbar button | Windows shortcuts | Mac OS shortcuts |
--- | --- | --- | ---
| Code block | ![](../_assets/wiki/svg/wysiwyg/code-block.svg) | **Ctrl** + **Alt** + **E** | **⌘** + **⌥** + **E** |
| Line of code in text | ![](../_assets/wiki/svg/wysiwyg/inline-code.svg) | **Ctrl** + **E** | **⌘** + **E** |

## Formulas {#equation}

To add a formula, click ![](../_assets/wiki/svg/wysiwyg/equation.svg) on the toolbar and select a design option:

* **Formula in text** to place your formula in the page text.

* **Block with formula** to place your formula in a separate block.

To create formulas, use the [Katex](https://katex.org/) library that supports TeX/LaTeX format.

## Links {#links-wysiwyg}

To add a link:

1. Select a text fragment or click on the area to add a link to.

1. On the toolbar, click ![](../_assets/wiki/svg/wysiwyg/link.svg).

1. Enter a direct or [relative](static-markup/links.md#wiki-ref) reference. If you have not selected a text fragment, enter the text to be displayed as a link.

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.

To change or delete a link:

1. Click on the link.

1. Make your changes and click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.

## Embedded content {#content-wysiwyg}


### Inserting an image from the clipboard {#clipboard}

1. Copy an image to the clipboard:

   - Copy a picture from an image editor or take a screenshot.

   - Copy a picture from a web page.

   - Copy an image file from the file manager on your computer.

1. Open the page and click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-comment.edit }}**.

1. Paste the image from the clipboard into the page text.

The image is automatically uploaded to {{ wiki-name }} and added to a [list of attached files](attach-file.md).

### Inserting an image using a link {#image}

1. Upload an image to a [page](add-image.md) or a file hosting service.

1. Copy the image address.

1. On the toolbar, click ![](../_assets/wiki/svg/wysiwyg/image.svg):

   * In the **Link** field, paste the image URL.

   * Add a **Picture caption**. The caption will be displayed when you hover over the image.

   * Enter **Alternative text**. The text is displayed if the image fails to load.

   * Specify the image size.

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.

### Files {#file}

To add a file to a page:

1. On the toolbar, click ![](../_assets/wiki/svg/wysiwyg/file.svg).

1. Select how to upload the file:

   * To upload it via a link, click **Add by link**. Next, enter the URL of the file and the name to display in the text. Save your changes

   * To attach a file from a device, click **Upload from device** and upload one or more files.

### Objects and media files {#iframe}

To embed an object or media file from an external source in a page, use an embedded iFrame:

1. Copy the link to the resource to be displayed in the iFrame.

1. On the toolbar, click ![](../_assets/wiki/svg/wysiwyg/iframe.svg):

   * In the **Link** field, paste the resource URL.

   * Specify the frame size.

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.

## Tables {#tables-wysiwyg}

To add a table, click ![](../_assets/wiki/svg/wysiwyg/table.svg) on the toolbar and fill in table cells. You can format text in the table cells.

To edit a table, select a cell and use the dynamic buttons.

## Charts {#chart}

You can add [PlantUML](https://plantuml.com/)-supported diagrams to your page.

To insert a diagram, switch to **Editor** mode, open the list of commands using the `/` character, and select ![](../_assets/wiki/svg/wysiwyg/chart.svg) **Diagram**.

To edit your diagram, click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-comment.edit }}** in the top-right corner of the diagram block and edit its syntax using the PlantUML markup language. Save your changes.

## Users {#user}

To mention a user of the organization on your page, switch to the **Editor** mode, click `@` or open the list of commands using the `/` character, and select ![](../_assets/wiki/svg/wysiwyg/user.svg) **{{ ui-key.yacloud.common.user }}**. Start typing the user's name or login.

## Includes {#include}

You can add content from another WYSIWYG page to your page:

1. Switch to **Editor** mode, open the list of commands using the `/` character, and select ![](../_assets/wiki/svg/wysiwyg/include.svg) **Include**.

1. Specify the URL of the page to include.

1. If required, enable the option to show an error message about pages the user has no access to.

#### See also

* [{#T}](wysiwyg-create.md)
