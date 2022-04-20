# Borders, width, and block alignment

For [blocks of text with special formatting](../formatter.md), you can add borders and adjust block width and position relative to the edges of the page. To do this, add additional parameters to the block markup.

## Formatting templates {#wrapper}

Use the `wrapper` parameter to apply one of the formatting templates. The body of the text wraps around this block.

| Parameter | Description |
| --- | --- |
| `box` | A block with green borders aligned to the right edge of the page. |
| `shade` | A block with green borders aligned to the left edge of the page. |
| `text` | A block without borders with text alignment to the right edge of the page. Text alignment can be adjusted using the ["align" parameter](#align). |
| `page` | A block without borders aligned to the left edge of the page. |

{% note tip %}

Along with the `wrapper` parameter, you can add other parameters to adjust the block's [position](#align) and [width](#width), as well as the color, type, and thickness of [borders](#border).

{% endnote %}

Example:

```
%%(wacko wrapper=box)
This text is wrapped in a box.
%%
```


## Adjust alignment {#align}

Use the `align` parameter to adjust the block's position on the page.

Combine `wrapper=text` and `align` parameters to adjust text alignment inside a block.

| Parameter | Description |
| --- | --- |
| `right` | Align to the right edge of the page. |
| `left` | Align to the left edge of the page. |
| `center` | Align to center. The value can only be applied when combined with the `wrapper=text` parameter. |

Example:

```
%%(css align=right)
.d { font-size:70% }
%%
```

## Adjust block width {#width}

Use the `width` parameter to adjust the width of the block in pixels.

Example:

```
%%(css wrapper=box width=400)
.d { font-size:70% }
%%
```


## Adjust borders {#border}

Use the `border` parameter to adjust borders around the block.

```
border="<thickness in pixels> <line type> <line color>"
```

| Parameter | Description |
| --- | --- |
| **Line types** |
| `solid` | Solid line. |
| `dashed` | Dashed line. |
| **Colors** |
| `red` | Red line. |
| `green` | Green line. |
| `blue` | Blue line. |
| `grey` | Grey line. |
| `yellow` | Yellow line. |

Example:

```
%%(math wrapper=shade border="2px dashed red") X^{a+b}_{i-j} %%
```

## Examples {#example}

| Markup | Result |
| --- | --- |
| ```%%(wacko wrapper=text align=center) text centered %%``` | ![](../../_assets/wiki/formatter-wrapper-text-result.png) |
| ```%%(wacko wrapper=page width=200)```<br/>```This text cannot be wider than two hundred pixels.```<br/>```%%``` | ![](../../_assets/wiki/formatter-wrapper-page-result.png) |
| ```%%(wacko wrapper=box align=left width=170 border="5px dashed red")```<br/>```Text inside the block```<br/>```%%```<br/>```This text will wrap around the block. This text will wrap around the block.``` | ![](../../_assets/wiki/wrapper_box.png) |
| ```%%(javascript nomark wrapper=box border="5px dashed red")```<br/>```alert("horay!");```<br/>```%%``` | ![](../../_assets/wiki/formatter-wrapper-box-red-result.png) |
| ```%%(css wrapper=shade)```<br/>```.d2 { font-size:70% }```<br/>```%%``` | ![](../../_assets/wiki/formatter-wrapper-shade-result.png) |

