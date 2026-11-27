---
title: '{{ datalens-full-name }} error ERR.DS_API.FORMULA.VALIDATION.WIN_FUNC.NO_AGG'
description: This page describes the Window function has no aggregated expressions among its arguments {{ datalens-full-name }} error.
alternate:
  - href: en/datalens/troubleshooting/errors/ERR-DS_API-FORMULA-VALIDATION-WIN_FUNC-NO_AGG.md
    type: text/markdown
    title: Markdown version
---

# [{{ datalens-full-name }}] Window function has no aggregated expressions among its arguments

`ERR.DS_API.FORMULA.VALIDATION.WIN_FUNC.NO_AGG`

Make sure to use an [aggregated expression](../../concepts/aggregation-tutorial.md#datalens-aggregation) as an argument of your [window function](../../../datalens/function-ref/window-functions.md) (window functions must accept measures as arguments).