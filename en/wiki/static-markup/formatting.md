# Formatting text

## Decorating text {#inline}

{% note alert %}

To properly decorate text, don't leave any spaces between the markup symbols and the text.

{% endnote %}

| Markup | Result |
| --- | --- |
| `**Bold text**` | ![](../../_assets/wiki/bold.png) |
| `*Italic text*` | ![](../../_assets/wiki/italic.png) |
| `_Italic text_` | ![](../../_assets/wiki/italic.png) |
| `__Underlined text__` | ![](../../_assets/wiki/underlined.png) |
| `~~Strikethrough text~~` | ![](../../_assets/wiki/crossed.png) |
| `??Highlighted text??` | ![](../../_assets/wiki/red-background.png) |
| `!!(blu)Blue text!!`<br>Supported colors:<ul><li>`red`</li><li>`green`</li><li>`blue`</li><li>`grey`/`gray`</li><li>`yellow`</li><li>`cyan`</li><li>`orang`</li><li>`violet`</li></ul> | ![](../../_assets/wiki/colored.png) |

## Combining formatting types {#sec_combine}

You can apply several types of formatting to a single text fragment simultaneously:

| Markup | Result |
| --- | --- |
| `_**Bold italic**_` | ![](../../_assets/wiki/bold-italic.png) |
| `*!!Red italic!!*` | ![](../../_assets/wiki/red-italic.png) |

Text formatting can be used together with other markup elements:

| Markup | Result |
| --- | --- |
| `**[Bold link](http://example.com)**` | ![](../../_assets/wiki/bold-link.png) |
| `>Quote with *italic* text` | ![](../../_assets/wiki/quote-italic.png) |

## Bubbles {#other-formatting}

You can add a bubble with a tip to your text (for example, a definition for a term from the text) using the markup:

| Markup | Result |
| --- | --- |
| `(?Term Definition of the term?)` | ![](../../_assets/wiki/Term-with-definition.png) |
| `(?Long term==Definition of the term?)` | ![](../../_assets/wiki/long-term-with-definition.png) |

