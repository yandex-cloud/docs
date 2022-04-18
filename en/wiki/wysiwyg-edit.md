# Working in the visual editor (Wysiwyg)

{% note info %}

You can only use the visual editor with [Wysiwyg pages](pages-types.md#wysiwyg) that are accessible from the internal Yandex {{wiki-name}}.

{% endnote %}

The visual editor is currently in the beta phase, so it may be unstable. Wysiwyg pages have certain limitations:

* They are not compatible with the Wiki markup or [dynamic blocks](actions.md).

* They can't be converted into Wiki pages with the common markup.

* They can't be found via the [intranet search](search.md).

## Editing Wysiwyg pages {#edit-page}

To edit a page [created](wysiwyg-create.md) in the visual editor (Wysiwyg):

1. Open the Wysiwyg page and click **Edit** in the upper-right corner.

1. Make edits on the Wysiwyg page. Use the toolbar buttons to format text, edit lists, or insert tables and images:

    ![](../_assets/wiki/tools-panel.png)

## Text formatting {#format-wysiwyg}

To format text, use the toolbar buttons or keyboard shortcuts:

| Formatting | Toolbar button | Keyboard shortcut |
| --- | --- | --- |
| Header | ![](../_assets/wiki/tool-headrs.png) | — |
| Bold | ![](/../_assets/wiki/bold.png) | **Ctrl** + **B** |
| Italics | ![](../_assets/wiki/tool-curve.png) | **Ctrl** + **I** |
| Strikethrough | ![](../_assets/wiki/tool-line.png) | **Ctrl** + **Shift** + **S** |
| Underline | ![](../_assets/wiki/tool-underline.png) | **Ctrl** + **U** |
| Code line | ![](../_assets/wiki/tool-codeline.png) | — |

## Lists {#lists-wysiwyg}

To add a list, select one or more paragraphs and use the buttons on the toolbar:

| List | Toolbar button |
| --- | --- |
| Bulleted list | ![](../_assets/wiki/tool-list-mark.png) |
| Numbered list | ![](../_assets/wiki/tool-list-num.png) |

To format a nested list item, select a paragraph and press the tab key at the beginning of the line.

## Quotes and code blocks {#src-wysiwyg}

To add a quote or a code block, select one or more paragraphs and use the buttons on the toolbar:
Block | Toolbar button
--- / ---
Quote | ![](../_assets/wiki/tool-quote.png)
Code block | ![](../_assets/wiki/tool-codeblock.png)

## Links {#links-wysiwyg}

To add a link:

1. Select a text fragment or click on the area where you want to add the link.

1. Click ![](../_assets/wiki/tool-link.png) on the toolbar.

1. Enter a direct or [relative](static-markup/links.md#wiki-ref) link address and click **OK**.

To change or delete a link:

1. Click the link.

1. Click ![](../_assets/wiki/tool-link.png) on the toolbar.

1. Make edits and click **OK**.

## Images {#pictures-wysiwyg}

{% note info %}

You can't upload images to a page in the visual editor. To add an image, copy its address from a different Wiki page. A user will be able to view the image on your page if they have access to the Wiki page with the original file.

{% endnote %}

To insert an image:

1. Upload the image to a [Wiki page](add-image.md) or a file hosting service, such as [Jing](https://jing.yandex-team.ru/). You can't change the size of an image in the visual editor, so make sure to adjust the size beforehand.

1. Copy the page address.

1. Click ![](../_assets/wiki/tool-pic.png) on the toolbar.

1. Paste the image address and click **OK**.

1. To delete an image, use the _Backspace_ or _Del_ keys.

## Tables {#tables-wysiwyg}

To add a table, click ![](../_assets/wiki/tool-tab.png) on the toolbar and fill in the cells. You can format text in the table cells.

To edit a table, select a cell and use the toolbar buttons:
Action | Toolbar button --- | --- Delete table | ![](../_assets/wiki/tool-del-tab.png)
Insert row | ![](../_assets/wiki/tool-tab-add-line.png)
Delete row | ![](../_assets/wiki/tool-tab-del-line.png)
Insert column | ![](../_assets/wiki/tool-tab-add-column.png)
Delete column | ![](../_assets/wiki/tool-tab-del-column.png)

#### See also

* [{#T}](wysiwyg-create.md)

