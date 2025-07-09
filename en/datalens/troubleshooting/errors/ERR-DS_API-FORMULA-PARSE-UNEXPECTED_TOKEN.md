---
title: ERR.DS_API.FORMULA.PARSE.UNEXPECTED_TOKEN error
description: This page describes the ERR.DS_API.FORMULA.PARSE.UNEXPECTED_TOKEN error.
---

# Formula syntax error

`ERR.DS_API.FORMULA.PARSE.UNEXPECTED_TOKEN`

This error occurs when a [calculated field](../../concepts/calculations/index.md) contains a formula with incorrect [syntax](../../concepts/calculations/formula-syntax.md). In the chart or dataset editing interface, such fields are highlighted in red. To fix this error, check all red marked fields and revise the formulas in them.

Here is an example:

* Invalid value list provided:

  * Incorrect formula: `[field] NOT IN {'value1', 'value2'}`.
  * Correct formula: `[field] NOT IN ('value1', 'value2')`.

* Unbalanced quotes:

  * Incorrect formula: `[field] = 'value`.
  * Correct formula: `[field] = 'value'`.

* Invalid comparison syntax:

  * Incorrect formula: `[field] == 'value'`.
  * Correct formula: `[field] = 'value'`.
