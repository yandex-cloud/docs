---
title: Text markup functions
description: Markup functions are used for creating marked up text (hypertext) from string values and/or other marked up text.
editable: false
sourcePath: en/_api-ref/datalens/function-ref/markup-functions.md
---

# Text markup functions
Markup functions are used for creating marked up text (hypertext) from string values and/or other marked up text.

## Usage notes {#usage-notes}

There are the following features of using markup:
1. These functions return `NULL` when any argument is `NULL`. To get a non-NULL value, wrap argumens in `IFNULL()`. Example: `bold(ifnull([value], 'NULL'))`.
1. Converting markup to a normal string is not currently possible.
1. Markup functions can be used within logic functions. Example: `IF(STARTSWITH([value], 'n'), BOLD([value]), MARKUP([value]))`.



## [BOLD](BOLD.md)

**Syntax:**`BOLD( text )`

Stylizes the passed text in bold font.



## [BR](BR.md)

**Syntax:**`BR()`

Adds a line break.



## [COLOR](COLOR.md)

**Syntax:**`COLOR( text, color )`

Enables specifying the color for the provided text.

We recommend using the [color variables](https://preview.gravity-ui.com/uikit/iframe.html?args=&id=colors--texts&viewMode=story) from the [Gravity UI](https://gravity-ui.com/) palette to specify colors. Such colors are easily discernible with both the light and dark theme.

You can also specify the color in any web format, such as HEX, keyword (e.g., `green`), RGB, etc. In this case, however, we cannot guarantee that the colors will be discernible.



## [IMAGE](IMAGE.md)

**Syntax:**`IMAGE( src [ , width [ , height [ , alt ] ] ] )`

Enables inserting an image located at the `src` address to the table. The `width` and `height` values are provided in pixels. If one of the dimensions is `NULL`, it will be calculated automatically in proportion to the other. If both dimensions are `NULL`, the image will be inserted with the original width and height. In case there are issues when uploading the image, the function will display the `alt` text.

Images can be added from the `*.yandex.ru`, `*.yandex.net`, `yastat.net`, `yastatic.net`, or `storage.yandexcloud.net` domains. The easiest way is to upload and publish the image in [Yandex Object Storage](../../storage/quickstart.md) (see the pricing [here](../../storage/pricing.md#prices-storage)).






## [ITALIC](ITALIC.md)

**Syntax:**`ITALIC( text )`

Stylizes the passed text in cursive font.



## [MARKUP](MARKUP.md)

**Syntax:**`MARKUP( arg_1, arg_2, arg_3 [ , ... ] )`

Merges marked up text pieces. Can also be used for converting strings to marked up text.



## [SIZE](SIZE.md)

**Syntax:**`SIZE( text, size )`

Enables specifying the size (in pixels) for the provided text.



## [URL](URL.md)

**Syntax:**`URL( address, text )`

Wraps `text` into a hyperlink to URL `address`. When you click on the link, the page opens in a new browser tab.


