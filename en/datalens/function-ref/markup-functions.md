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


