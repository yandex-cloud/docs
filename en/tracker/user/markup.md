# Formatting text in issues

To add formatting to the issue description and comments, use the visual editor or [{{ yfm }} syntax]({{ yfm-link }}).

To format text and lists, embed tables and images, use the following toolbar buttons:

![](../../_assets/tracker/text-edit/toolbar.png)

1. To cancel or repeat an action, use the ![](../../_assets/tracker/text-edit/undo.svg) and ![](../../_assets/tracker/text-edit/redo.svg) buttons.

1. To format text using {{ yfm }} markup, click ![](../../_assets/tracker/text-edit/set.svg) and select **Markup** mode.

1. To disable the toolbar, click ![](../../_assets/tracker/text-edit/set.svg) and turn off the **Toolbar** option. If the toolbar is disabled, you can run commands using the `/`character in **Editor** mode.

## Formatting text {#format-wysiwyg}

To format text, use the following toolbar buttons or keyboard shortcuts:

| Formatting | Toolbar button | Windows shortcuts | Mac OS shortcuts |
--- | --- | --- | ---
| Header | ![](../../_assets/tracker/text-edit/header.svg) ![](../../_assets/tracker/text-edit/show.svg) | **Ctrl** + **Alt** + **1**—**6** | **⌘** + **⌥** + **1**—**6** |
| Bold text | ![](../../_assets/tracker/text-edit/bold.svg) | **Ctrl** + **B** | **⌘** + **B** |
| Italic | ![](../../_assets/tracker/text-edit/italic.svg) | **Ctrl** + **I** | **⌘** + **I** |
| Underlined text | ![](../../_assets/tracker/text-edit/underline.svg) | **Ctrl** + **U** | **⌘** + **U** |
| Strikethrough text | ![](../../_assets/tracker/text-edit/strikethrough.svg) | **Ctrl** + **Shift** + **S** | **⌘** + **Shift** + **S** |
| Colored text | ![](../../_assets/tracker/text-edit/color.svg) ![](../../_assets/tracker/text-edit/show.svg) | N/A | — |

## Lists {#lists-wysiwyg}

To add a list, select one or more paragraphs and use the following toolbar buttons or keyboard shortcuts:

| List | Toolbar button | Windows shortcuts | Mac OS shortcuts |
--- | --- | --- | ---
| Bulleted list | ![](../../_assets/tracker/text-edit/ul.svg) | **Ctrl** + **Shift** + **L** | **⌘** + **Shift** + **L** |
| Numbered list | ![](../../_assets/tracker/text-edit/ol.svg) | **Ctrl** + **Shift** + **M** | **⌘** + **Shift** + **M** |
| Checklist (checkbox) | ![](../../_assets/tracker/text-edit/checkbox.svg) | N/A | — |

To format a nested list item, select a paragraph and press the Tab key (**⇥**) at the beginning of the line.

## Block formatting {#block-wysiwyg}

To add a mathematical formula, quote, note, or cut, select one or more paragraphs, and use the following toolbar buttons or keyboard shortcuts:

| Block | Toolbar button | Windows shortcuts | Mac OS shortcuts |
--- | --- | --- | ---
| Comment | ![](../../_assets/tracker/text-edit/note.svg) | **Ctrl** + **Alt** + **8** | **⌘** + **⌥** + **8** |
| Cut | ![](../../_assets/tracker/text-edit/cut.svg) | **Ctrl** + **Alt** + **7** | **⌘** + **⌥** + **7** |
| Quote | ![](../../_assets/tracker/text-edit/quote.svg) | **Ctrl** + **>** | **⌘** + **>** |
| Formula | ![](../../_assets/tracker/text-edit/formula.svg) | N/A | — |

For the **Note** section, you can choose its type: **Note**, **Advice**, **Important**, or **Attention**.

## Code formatting {#src-wysiwyg}

To add a code block, select a line or paragraph and use the following toolbar buttons or keyboard shortcuts:

| Block | Toolbar button | Windows shortcuts | Mac OS shortcuts |
--- | --- | --- | ---
| Code block | ![](../../_assets/tracker/text-edit/code-block.svg) | **Ctrl** + **Alt** + **E** | **⌘** + **⌥** + **E** |
| Line of code in text | ![](../../_assets/tracker/text-edit/inline-code.svg) | **Ctrl** + **E** | **⌘** + **E** |

## Links {#links-wysiwyg}

To add a link:

1. Select a text fragment or click on the area to add a link to.

1. On the toolbar, click ![](../../_assets/tracker/text-edit/link.svg).

1. Enter the link's URL. If you did not select a text fragment, enter the text to be displayed as a link.

1. Click **Save**.

To change or delete a link:

1. Click on the link.

1. Make your changes and click **Save**.

## Embedded content {#content}

### Inserting an image from the clipboard {#clipboard}

1. Copy an image to the clipboard:

   * Copy a picture from an image editor or take a screenshot.

   * Copy a picture from a web page.

   * Copy an image file from the file manager on your computer.

1. Paste the image from the clipboard into the text.

The image will be uploaded to the description or comment and show up in a list of attached files under the issue description.

### Adding an image by a link or uploading it from a device {#image}

To add a file with an image, in the toolbar, click ![](../../_assets/tracker/text-edit/image.svg) and select the **Upload from device** tab. You can upload an image file in the JPEG, GIF, or PNG format with a size of no more than 1 MB.

To insert an image using a link:
1. If you want to insert a file link from a device, upload it to a file hosting.

1. Copy the image address.

1. In the toolbar, click ![](../../_assets/tracker/text-edit/image.svg) and select the **Add by link** tab.

   * In the **Link** field, paste the image URL.

   * Add a **Picture caption**. The caption will be displayed when you hover over the image.

   * Enter **Alternative text**. The text is displayed if the image fails to load.

   * Specify the image size.

1. Click **Save**.

The image will be uploaded to the description or comment and show up in a list of attached files under the issue description.

### Add files {#file}

To add a file to a description or comment to an issue, in the toolbar, click ![](../../_assets/tracker/svg/icon-file.svg).

* If the file is stored on your device, select the tab **Upload from device**, then click **Upload** to open the file manager.

* If your file is stored on the file hosting, select the **Add by link** tab. Paste a link to the file and enter the file name, then click **Save**.

The file will be uploaded to the description or comment and show up in a list of attached files under the issue description.

### Embedding objects from external sources {#iframe}

To embed an object or media file from an external source in your issue description or comment, use an embedded iFrame:

1. Copy the link to the resource to be displayed in the iFrame.

1. On the toolbar, click ![](../../_assets/tracker/text-edit/iframe.svg):

   * In the **Link** field, paste the resource URL.

   * Specify the frame size.

1. Click **Save**.

## Tables {#tables-wysiwyg}

To add a table, click ![](../../_assets/tracker/text-edit/table.svg) on the toolbar and fill in table cells. You can format text in the table cells.

To edit a table, select a cell and use the dynamic buttons.
