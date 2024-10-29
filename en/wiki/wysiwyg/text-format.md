---
title: How to work with text formatting in {{ wiki-full-name }}
description: In this tutorial, you will learn how to use text formatting in {{ wiki-name }}.
---

# Formatting text

{% include [old-editor-warning](../../_includes/wiki/wysiwyg-old-editor.md) %}

## Line formatting {#format-wysiwyg}

{% list tabs %}

- New editor

   To format text, use the following toolbar buttons or keyboard shortcuts:

   | Formatting | Toolbar button | Windows shortcuts | Mac OS shortcuts |
   --- | --- | --- | ---
   | Bold text | ![](../../_assets/wiki/svg/wysiwyg/bold.svg) | **Ctrl** + **B** | **⌘** + **B** |
   | Italic | ![](../../_assets/wiki/svg/wysiwyg/italic.svg) | **Ctrl** + **I** | **⌘** + **I** |
   | Underlined text | ![](../../_assets/wiki/svg/wysiwyg/underline.svg) | **Ctrl** + **U** | **⌘** + **U** |
   | Strikethrough text | ![](../../_assets/wiki/svg/wysiwyg/strikethrough.svg) | **Ctrl** + **Shift** + **S** | **⌘** + **Shift** + **S** |
   | Monospaced text | ![](../../_assets/console-icons/letter-m.svg) | — | — |
   | Highlighted text | ![](../../_assets/console-icons/font-cursor.svg) | — | — |
   | Heading | ![](../../_assets/wiki/svg/wysiwyg/header.svg) ![](../../_assets/wiki/svg/wysiwyg/show.svg) | **Ctrl** + **Alt** + **1**—**6** | **⌘** + **⌥** + **1**—**6** |
   | Colored text | ![](../../_assets/wiki/svg/wysiwyg/color.svg) ![](../../_assets/wiki/svg/wysiwyg/show.svg) | — | — |

- Old editor

   {{ wiki-name }} supports the [Markdown markup]({{ link-about-markdown }}) with additional formatting elements that are not present in the standard Markdown syntax.

   This section contains frequently used formatting elements. For a complete list of supported elements, see [{#T}](../static-markup.md).

   | Element | Markup | Result |
   --- | --- | ---
   | Header | `# First-level heading`<br/>`## Second-level heading`<br/>`### Third-level heading` | ![](../../_assets/wiki/h1-h3.png) |
   | Bold text | `**Bold text**` | ![](../../_assets/wiki/bold.png) |
   | Italic | `*Italic*` | ![](../../_assets/wiki/italic.png) |
   | Strikethrough text | `~~Strikethrough text~~` | ![](../../_assets/wiki/crossed.png) |

{% endlist %}

## Lists {#lists-wysiwyg}

{% list tabs %}

- New editor

   To add a list, select one or more paragraphs and use the following toolbar buttons or keyboard shortcuts:

   | List | Toolbar button | Windows shortcuts | Mac OS shortcuts |
   --- | --- | --- | ---
   | Bulleted list | ![](../../_assets/wiki/svg/wysiwyg/ul.svg) | **Ctrl** + **Shift** + **L** | **⌘** + **Shift** + **L** |
   | Numbered list | ![](../../_assets/wiki/svg/wysiwyg/ol.svg) | **Ctrl** + **Shift** + **M** | **⌘** + **Shift** + **M** |
   | Decrease indent | ![](../../_assets/wiki/svg/wysiwyg/nested-list-up.svg) | **Shift** + **⇥** | **Shift** + **⇥** |
   | Increase indent | ![](../../_assets/wiki/svg/wysiwyg/nested-list-down.svg) | **⇥** | **⇥** |
   | Checklist (checkbox) | ![](../../_assets/wiki/svg/wysiwyg/checkbox.svg) | — | — |

- Old editor

   To add a list, select one or more paragraphs and use the following toolbar buttons:

   | List | Toolbar button |
   --- | ---
   | Bulleted list | ![](../../_assets/wiki/svg/wysiwyg/ul.svg) |
   | Numbered list | ![](../../_assets/wiki/svg/wysiwyg/ol.svg) |
   | Decrease indent | ![](../../_assets/wiki/svg/wysiwyg/nested-list-up.svg) |
   | Increase indent | ![](../../_assets/wiki/svg/wysiwyg/nested-list-down.svg) |

{% endlist %}

## Links and anchors {#links-wysiwyg}

{% list tabs %}

- New editor

   To add a link:

   1. Select a text fragment or click the area to add a link to.
   1. On the toolbar, click ![](../../_assets/wiki/svg/wysiwyg/link.svg).
   1. Enter a direct or [relative](../static-markup/links.md#wiki-ref) link. If you have not selected a text fragment, enter the text to display as a link.
   1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.

   To change or delete a link:

   1. Click the link.
   1. Make your changes and click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.

   To add an anchor:

   1. Place the cursor at the appropriate location on the page and click ![](../../_assets/console-icons/hashtag.svg) on the toolbar.
   1. On the page that appears, click the `#` icon, and in the window that opens, specify:
      * **Link**: Anchor ID to use in links to navigate to the anchor on the page. The ID must start with `#` and consist of numbers, symbols, and Latin letters.
      * **Hint**: Hint text that should appear when you hover over the anchor.

   The `#` created element is visible only in markup mode.

- Old editor

   To add a link:

   1. Select a text fragment or click the area to add a link to.
   1. On the toolbar, click ![](../../_assets/wiki/svg/wysiwyg/link.svg).
   1. Enter a direct or [relative](../static-markup/links.md#wiki-ref) link. If you have not selected a text fragment, enter the text to display as a link.
   1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.

   To change or delete a link:

   1. Click the link.
   1. Make your changes and click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.

   You cannot add an anchor using the toolbar in the old editor; use the [markup](../static-markup/links.md#place-link) instead.

{% endlist %}

## Code formatting {#src-wysiwyg}

{% list tabs %}

- New editor

   To add a code block, select a line or paragraph and use the following toolbar buttons or keyboard shortcuts:

   | Block | Toolbar button | Windows shortcuts | Mac OS shortcuts |
   --- | --- | --- | ---
   | Code block | ![](../../_assets/wiki/svg/wysiwyg/code-block.svg) | **Ctrl** + **Alt** + **E** | **⌘** + **⌥** + **E** |
   | Line of code in text | ![](../../_assets/wiki/svg/wysiwyg/inline-code.svg) | **Ctrl** + **E** | **⌘** + **E** |

- Old editor

   To add a code block, select a line or paragraph and use the ![](../../_assets/wiki/svg/wysiwyg/inline-code.svg) toolbar button.

{% endlist %}

## Formulas {#equation}

{% list tabs %}

- New editor

   To add a formula, click ![](../../_assets/wiki/svg/wysiwyg/equation.svg) on the toolbar and select a design option:

    * **Formula in text** to place your formula in the page text.

    * **Block with formula** to place your formula in a separate block.

   To create formulas, use the [Katex](https://katex.org/) library that supports TeX/LaTeX format.

- Old editor

   You can insert [formulas](../static-markup/formulas.md) in {{ wiki-name }} using the [TeX]({{ link-about-tex }}) markup.

{% endlist %}

## Users {#user}

{% list tabs %}

- New editor

   To mention a user from your organization on your page, press `@` or `/` to open the list of commands and select ![](../../_assets/wiki/svg/wysiwyg/user.svg) **{{ ui-key.yacloud.common.user }}**. Start typing the user's name or login.

- Old editor

   {% note alert %}

   This function is not supported in this type of editor.

   {% endnote %}

{% endlist %}

## Separator {#divider}

{% list tabs %}

- New editor

   To add a paragraph separator, press `/` to open the list of commands and select ![](../../_assets/wiki/svg/wysiwyg/divider.svg) **Separator**.

- Old editor

   {% note alert %}

   This function is not supported in the visual form of this editor, but you can add it using the markup. Check out the markup guide.

   {% endnote %}

{% endlist %}

## Emoji {#emoji}

{% list tabs %}

- New editor

   To add an emoji to the page:

   1. Make sure that the cursor is at the beginning of the line or after a space.
   1. Click `:`.
   1. Select the emoji you want to add.

- Old editor

   {% note alert %}

   This function is not supported in this type of editor.

   {% endnote %}

{% endlist %}

## Comments {#comments}

{% list tabs %}

- New editor

   To add comments to the page:

   1. Switch to page editing mode by clicking **Edit**.
   1. Highlight the part of the page content you want to comment on. In the toolbar that appears, click ![](../../_assets/console-icons/comment.svg) and enter your comment text.

- Old editor

   {% note alert %}

   This function is not supported in this type of editor.

   {% endnote %}

{% endlist %}
