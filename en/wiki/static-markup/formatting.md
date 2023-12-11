---
title: "How to work with text layout in {{ wiki-full-name }}"
description: "In this tutorial, you will learn about using text layout in {{ wiki-name }}."
---

# Text formatting

{% include [static-markdown-alert](../../_includes/wiki/static-markdown-alert.md) %}

## Highlighting text {#inline}

{% note alert %}

Highlighting only works correctly if the markup characters are adjacent to the text.

{% endnote %}

| Markup | Result |
--- | ---
| `**Bold text**` | ![](../../_assets/wiki/bold.png) |
| `*Italic*` | ![](../../_assets/wiki/italic.png) |
| `_Italic_` | ![](../../_assets/wiki/italic.png) |
| `//Italic//` | ![](../../_assets/wiki/italic.png) |
| `__Underlined text__` | ![](../../_assets/wiki/underlined.png) |
| `~~Strikethrough text~~` | ![](../../_assets/wiki/crossed.png) |
| `--Strikethrough text--` | ![](../../_assets/wiki/crossed.png) |
| `##Monospaced text##` | ![](../../_assets/wiki/monospaced.png) |
| `++Small font++` | ![](../../_assets/wiki/small.png) |
| Superscript: `E=mc^^2^^` | ![](../../_assets/wiki/sup.png) |
| Subscript: `Hvv2vvO` | ![](../../_assets/wiki/sub-no-spaces.png) |
| `??Highlighted text??` | ![](../../_assets/wiki/red-background.png) |
| `!!Red text!!` | ![](../../_assets/wiki/red-colored.png) |
| `!!(blue)Blue text!!`<br>Supported colors:<ul><li>`red`</li><li>`green`</li><li>`blue`</li><li>`grey`/`gray`</li><li>`yellow`</li><li>`cyan`</li><li>`orange`</li><li>`violet`</li></ul> | ![](../../_assets/wiki/colored.png) |

## Combining formatting types {#sec_combine}

You can apply several types of formatting to a single text fragment at the same time:

| Markup | Result |
--- | ---
| `_**Bold italic**_` | ![](../../_assets/wiki/bold-italic.png) |
| `*!!Red italic!!*` | ![](../../_assets/wiki/red-italic.png) |

Text formatting can be used together with other markup elements:

| Markup | Result |
--- | ---
| `**[Bold link](http://example.com)**` | ![](../../_assets/wiki/bold-link.png) |
| `>Quote with *italic text*` | ![](../../_assets/wiki/quote-italic.png) |

## Other markup {#other-formatting}

| Element | Markup | Result |
--- | --- | ---
| Line break | `first line---second line` | ![](../../_assets/wiki/line-break.png) |
| Pop-up hint | `(?Term Definition of the term?)` | ![](../../_assets/wiki/Term-with-definition.png) |
| Pop-up (term with spaces) | `(?Term with spaces==Term definition?)` | ![](../../_assets/wiki/long-term-with-definition.png) |
| Color code (long) | `#ff0000` | ![](../../_assets/wiki/color-code-long.png) |
| Color code (short) | `#F00` | ![](../../_assets/wiki/color-code-short.png) |
| Hidden comment | `%%(comments) Hidden text%% ` |