---
title: '{{ datalens-full-name }} error ERR.DS_API.AVATAR.TITLE.CONFLICT'
description: This page describes the Source avatar title conflicts with another avatar {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Source avatar title conflicts with another avatar

`ERR.DS_API.AVATAR.TITLE.CONFLICT`

The error occurs when adding multiple tables with the same name to the dataset.

To fix this error:

* If the error points to a source table, try removing it from the dataset and adding again.
* If the error points to a subquery as a source, modify the subquery header so that the source names in the dataset do not match.
