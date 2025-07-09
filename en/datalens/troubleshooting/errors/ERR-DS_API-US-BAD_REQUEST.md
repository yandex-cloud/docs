---
title: ERR.DS_API.US.BAD_REQUEST error
description: This page describes the ERR.DS_API.US.BAD_REQUEST error.
---

# Object request error

`ERR.DS_API.US.BAD_REQUEST`

This is the server response to an invalid object request.

This error may occur when attempting to use forbidden characters in the object name. The name must meet these requirements:

* Starts and ends with an upper-case or lower-case Latin or Russian letter, number, or one of these characters: `_`, `@`, `(`, `)`, or`%`.

* The other characters must be upper-case or lower-case Latin or Russian letters, numbers, acceptable characters, or spaces.

  {% cut "Acceptable characters" %}
  
  * Underscore: `_`
  * At: `@`
  * Parentheses: `(`, `)`
  * Percent: `%`
  * Comma: `,`
  * Colon: `:`
  * Semicolon: `;`
  * Apostrophe: `'`
  * Vertical bar: `|`
  * Hyphen: `-`
  * En dash: `–`
  * Em dash: `—`
  * Minus: `−`
  * Dollar: `$`
  * Asterisk: `*`
  * Ampersand: `&`
  
  {% endcut %}

Examples of incorrect names:

* `Line chart: "Sales by categories"`: Name contains a forbidden character, `"`.
* `Line chart. Sales by product categories.`: Name ends with a forbidden character, `.`.

To fix this error, specify the object name using only the acceptable characters, e.g.: `Line chart: Sales by categories`.
